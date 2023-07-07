#! /usr/bin/env bash

set -eu

export nextstrain_base='https://raw.githubusercontent.com/nextstrain'

for pathogen in zika measles
do
  echo $pathogen
  if [ -d results/${pathogen} ]; then
    echo "Skipping ${pathogen} as results already exist"
    continue
  fi

  # Fetch example data
  mkdir -p data/${pathogen}
  wget -O data/${pathogen}/sequences.fasta ${nextstrain_base}/${pathogen}/main/example_data/sequences.fasta
  wget -O data/${pathogen}/metadata.tsv ${nextstrain_base}/${pathogen}/main/example_data/metadata.tsv
  
  # Run the pipeline
  nextflow run main.nf \
    --sequences data/${pathogen}/*.fasta \
    --metadata data/${pathogen}/*.tsv \
    --pathogen_giturl https://github.com/nextstrain/${pathogen}/archive/refs/heads/main.zip \
    --outdir results/${pathogen}
done

# Failing on this one... multiple input files
export pathogen='lassa'
if [ ! -d "results/${pathogen}" ]; then
  mkdir -p data/${pathogen}

  wget -O data/${pathogen}/sequences_l.fasta ${nextstrain_base}/${pathogen}/consistent_inputs/example_data/sequences_l.fasta
  wget -O data/${pathogen}/metadata_l.tsv ${nextstrain_base}/${pathogen}/consistent_inputs/example_data/metadata_l.tsv 
  wget -O data/${pathogen}/sequences_s.fasta ${nextstrain_base}/${pathogen}/consistent_inputs/example_data/sequences_s.fasta
  wget -O data/${pathogen}/metadata_s.tsv ${nextstrain_base}/${pathogen}/consistent_inputs/example_data/metadata_s.tsv

  nextflow run main.nf \
    --sequences data/${pathogen}/*.fasta \
    --metadata data/${pathogen}/*.tsv \
    --pathogen_giturl https://github.com/nextstrain/${pathogen}/archive/refs/heads/consistent_inputs.zip \
    --outdir results/${pathogen}

  nextflow run main.nf \
    --sequences data/${pathogen}/*.fasta \
    --metadata data/${pathogen}/*.tsv \
    --pathogen_giturl https://github.com/nextstrain/${pathogen}/archive/refs/heads/consistent_inputs.zip \
    --outdir results/${pathogen}
else 
  echo "Skipping ${pathogen} as results already exist"
fi
