#!/bin/bash
#SBATCH --job-name=TE_circlize
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/tsingh/genome_annotation_course/logs/%x_%j.out
#SBATCH --error=/data/users/tsingh/genome_annotation_course/logs/%x_%j.err

set -euo pipefail

WORKDIR="/data/users/tsingh/genome_annotation_course"
COURSEDIR="/data/courses/genome_annotation_resources/2026"
CONTAINER="$COURSEDIR/containers/Annotation_analysis_R4.4.sif"
R_SCRIPT="$COURSEDIR/scripts/04-annotation_circlize.R"
OUTDIR="$WORKDIR/output/EDTA"

cd "$OUTDIR"

ln -sf Qar8a.bp.p_ctg.fa.mod.EDTA.TEanno.gff3 assembly.fasta.mod.EDTA.TEanno.gff3
ln -sf ../../data/assemblies/Qar8a.bp.p_ctg.fa.fai assembly.fasta.fai

echo "Starting circular TE-density plot"
echo "Working directory: $(pwd)"
echo "Start time: $(date)"

apptainer exec -C \
  --bind "$WORKDIR" \
  --bind "$COURSEDIR" \
  --pwd "$OUTDIR" \
  "$CONTAINER" \
  Rscript --vanilla "$R_SCRIPT"

echo "Finished at: $(date)"
echo "Checking plot:"
ls -lh 02-TE_density.pdf

