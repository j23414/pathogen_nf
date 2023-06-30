#! /usr/bin/env nextflow

nextflow.enable.dsl=2

// https://github.com/nextstrain/ncov/blob/ce84df93c7774e092e16a55947a4756add80e615/workflow/wdl/tasks/nextstrain.wdl#L3-L142
process build {
  label 'nextstrain'
  publishDir "${params.outdir}", mode: 'copy'
  input: tuple val(pathogen_giturl), path(sequences), path(metadata)
  output: path("auspice")
  script:
  """
  #! /usr/bin/env bash
  # Example pathogen_giturl https://github.com/nextstrain/zika
  wget -O pathogen.zip ${pathogen_giturl}
  INDIR=`unzip -Z1 pathogen.zip | head -n1 | sed 's:/::g'`
  unzip pathogen.zip

  mkdir \$INDIR/data

  cp ${sequences} \${INDIR}/data/.
  cp ${metadata} \${INDIR}/data/.

  nextstrain build \
    --cpus $task.cpus \
    --native \
    \$INDIR

  mv \${INDIR}/auspice .
  """
}

process deploy {
  label 'nextstrain'
  publishDir "${params.outdir}", mode: 'copy'
  input: tuple path(auspice), val(s3url)
  output: path("*.log")
  when: params.s3url
  script:
  """
  #! /usr/bin/env bash
  # https://docs.nextstrain.org/projects/cli/en/stable/commands/remote/upload/
  ( nextstrain remote upload ${s3url} ${auspice}/*.json \
    || echo "No deployment credentials found" ) \
    &> deployment.log
  """
}