#! /usr/bin/env nextflow
nextflow.enable.dsl=2

include {build as nextstrain_build;
         deploy as nextstrain_deploy } from "./modules/nextstrain.nf" 

workflow {
      // Basic input
      sequences_ch = Channel.fromPath(params.sequences, checkIfExists:true)
      metadata_ch = Channel.fromPath(params.metadata, checkIfExists:true)

      // Pathogen snakemake pipeline
      pathogen_giturl_ch = channel.from(params.pathogen_giturl)

      // Run analysis
      pathogen_giturl_ch
      | combine(sequences_ch)
      | combine(metadata_ch)
      | nextstrain_build

      if (params.s3url){
        s3url_ch = Channel.from(params.s3url)
        
        nextstrain_build.out
        | combine(s3url_ch)
        | nextstrain_deploy
      }
}
