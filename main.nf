#! /usr/bin/env nextflow
nextflow.enable.dsl=2

include {build as nextstrain_build;
         build_config as nextstrain_build_config;
         deploy as nextstrain_deploy } from "./modules/nextstrain.nf" 

workflow {
      // Basic input
      sequences_ch = Channel.fromPath(params.sequences, checkIfExists:true)
      metadata_ch = Channel.fromPath(params.metadata, checkIfExists:true)

      // Pathogen snakemake pipeline
      pathogen_giturl_ch = channel.from(params.pathogen_giturl)

      // Run analysis
      input_ch = pathogen_giturl_ch
      | combine(sequences_ch)
      | combine(metadata_ch)

      if(params.config_file){
        config_file_ch = Channel.fromPath(params.config_file, checkIfExists:true)
        built_ch = input_ch
        | combine(config_file_ch)
        | nextstrain_build_config
      } else {
        built_ch = input_ch
        | nextstrain_build
      }

      if (params.s3url){
        s3url_ch = Channel.from(params.s3url)
        
        built_ch
        | combine(s3url_ch)
        | nextstrain_deploy
      }
}
