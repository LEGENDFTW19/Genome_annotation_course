#!/bin/bash
#SBATCH --job-name=TE_age
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --output=/data/users/tsingh/genome_annotation_course/logs/%x_%j.out
#SBATCH --error=/data/users/tsingh/genome_annotation_course/logs/%x_%j.err

set -euo pipefail

WORKDIR="/data/users/tsingh/genome_annotation_course"
COURSEDIR="/data/courses/genome_annotation_resources/2026"
CONTAINER="$COURSEDIR/containers/Annotation_analysis_R4.4.sif"
OUTDIR="$WORKDIR/output/EDTA"

cd "$OUTDIR"

apptainer exec -C \
  --bind "$WORKDIR" \
  --bind "$COURSEDIR" \
  --pwd "$OUTDIR" \
  "$CONTAINER" \
  Rscript --vanilla "$WORKDIR/scripts/06-plot_div_age.R"

ls -lh plots/output_with_age.pdf
