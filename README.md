# Genome_annotation_course
# Genome Annotation of *Arabidopsis thaliana* (Qar8a)

This repository contains the scripts and configuration files used for the genome annotation of the *Arabidopsis thaliana* accession Qar8a. The project was carried out as part of the MSc Bioinformatics and Computational Biology programme at the University of Fribourg and the University of Bern.

The project focuses on transposable element annotation, protein-coding gene prediction, functional annotation and comparative genomics.

## Project overview

The Qar8a genome assembly generated using Hifiasm was used as the input for the annotation workflow.

The main analyses include:

1. Transposable element annotation using EDTA.
2. Classification of full-length LTR retrotransposons using TEsorter.
3. LTR analysis, divergence estimation and age estimation.
4. Protein-coding gene prediction using MAKER.
5. Functional annotation using BLASTP and InterProScan.
6. Comparative genomics and pangenome analysis using GENESPACE.


## Workflow

### 1. Transposable element annotation

Scripts are located in `scripts/TE_annotation/`.

- EDTA was used to identify and annotate transposable elements.
- TEsorter was used to classify full-length LTR retrotransposons into Copia and Gypsy groups.
- Additional scripts were used for LTR analysis, divergence estimation and age estimation.

### 2. Gene annotation

Scripts are located in `scripts/gene_annotation/`.

- MAKER was used for protein-coding gene prediction.
- Transcript and protein sequences were used as evidence.
- Additional scripts were used to finalise the MAKER annotation and process gene identifiers.

The MAKER configuration files are available in `configuration/`.

### 3. Functional annotation

Scripts are located in `scripts/functional_annotation/`.

- BLASTP was used to compare predicted proteins against reference protein databases.
- InterProScan was used for protein domain and functional annotation.
- Additional scripts were used to integrate InterProScan results into the annotation.

### 4. Comparative genomics

Scripts are located in `scripts/comparative_genomics/`.

- GENESPACE was used to compare Qar8a with TAIR10, Altai_5, Are_6 and Est_0.
- Additional R scripts were used to process pangenome results and count Qar8a gene categories.

### 5. Additional analysis

Scripts are located in `scripts/analysis/`.

These include assembly indexing and scripts for visualising genome annotation results.

## Software and tools

The workflow uses the following tools and packages:

- EDTA
- TEsorter
- MAKER
- BLASTP
- InterProScan
- GENESPACE
- Samtools
- Apptainer
- R and relevant R packages

The scripts were developed and executed in the University of Bern HPC environment using Slurm and Apptainer containers.

## Running the scripts

The scripts were configured for the University of Bern HPC environment.

Before running them on another system, update the paths to:

- The project working directory.
- The genome assembly and other input files.
- Course or reference databases.
- Apptainer container files.
- Output and log directories.

The paths in `configuration/maker_opts.ctl` are placeholders and must be replaced with the appropriate input file paths before running MAKER.

Most shell scripts use Slurm directives and can be submitted using:

```bash
sbatch script_name.sh
```

R scripts should be run in an environment containing the required R packages.

## Data availability

Large input files, genome assemblies, reference databases, intermediate files and analysis outputs are not included in this repository.

This repository contains the scripts and configuration files used to perform the analyses. Plot images and generated results are not included.

## Key Results

The genome annotation workflow produced the following results:

- **Genome assembly:** 152.4 Mb assembly comprising 517 contigs, with an N50 of 9.63 Mb.
- **Transposable elements:** 34.43 Mb of the assembly annotated as transposable elements, representing approximately 22.59% of the genome.
- **Gene prediction:** 34,792 protein-coding genes predicted using MAKER.
- **Annotation completeness:** 95.0% complete BUSCOs for the predicted protein set.
- **Functional annotation:** 97.34% of predicted proteins had BLASTP matches against the TAIR10 reference protein database.
- **Comparative genomics:** Pangenome analysis performed across five *Arabidopsis thaliana* accessions: Qar8a, TAIR10, Altai_5, Are_6 and Est_0.

## Author

Tushar Singh

MSc Bioinformatics and Computational Biology  
University of Fribourg and University of Bern
