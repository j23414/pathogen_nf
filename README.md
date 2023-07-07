# pathogen_nf

Generic call to an existing nextstrain pathogen pipelines

```
export INPUT_SEQ="sequences.fasta"
export INPUT_MET="metadata.tsv"

# Example run with zika
nextflow run main.nf \
  --sequences ${INPUT_SEQ} \
  --metadata ${INPUT_MET} \
  --pathogen_giturl https://github.com/nextstrain/zika/archive/refs/heads/main.zip
```

To view final results

```
nextstrain view results/auspice
```

## Pathogen options

| pathogen | pathogen_giturl | checked |
|:--|:--|:--|
| zika | https://github.com/nextstrain/zika/archive/refs/heads/main.zip | Yes |
| dengue | https://github.com/nextstrain/dengue/archive/refs/heads/main.zip | |
| hepatitisB | https://github.com/nextstrain/hepatitisB/archive/refs/heads/master.zip | |
| monkeypox | https://github.com/nextstrain/monkeypox/archive/refs/heads/master.zip | |
| rsv | https://github.com/nextstrain/rsv/archive/refs/heads/master.zip | |
| ebola | https://github.com/nextstrain/ebola/archive/refs/heads/master.zip | |
| seasonal-flu | https://github.com/nextstrain/seasonal-flu/archive/refs/heads/master.zip | | 
| tb | https://github.com/nextstrain/tb/archive/refs/heads/master.zip | |
| mumps | https://github.com/nextstrain/mumps/archive/refs/heads/master.zip | |
| yellow fever | https://github.com/nextstrain/yellow-fever/archive/refs/heads/master.zip | |
| lassa | https://github.com/nextstrain/lassa/archive/refs/heads/consistent_inputs.zip | No metadata, only has lassa_l.fasta, lassa_s.fasta, and still hits multiple file problems |
| measles | https://github.com/nextstrain/measles/archive/refs/heads/main.zip | Yes |
| avian-flu | https://github.com/nextstrain/avian-flu/archive/refs/heads/master.zip | |
| enterovirus d68 | https://github.com/nextstrain/enterovirus_d68/archive/refs/heads/master.zip | |
| ncov | https://github.com/nextstrain/ncov/archive/refs/heads/master.zip | |
