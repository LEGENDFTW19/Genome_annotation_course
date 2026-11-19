#!/bin/bash
#SBATCH --job-name=index_assembly
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:15:00
#SBATCH --output=/data/users/tsingh/genome_annotation_course/logs/%x_%j.out
#SBATCH --error=/data/users/tsingh/genome_annotation_course/logs/%x_%j.err

set -euo pipefail

WORKDIR="/data/users/tsingh/genome_annotation_course"
CONTAINER="/data/courses/genome_annotation_resources/2026/containers/Annotation_analysis_R4.4.sif"
ASSEMBLY="$WORKDIR/data/assemblies/Qar8a.bp.p_ctg.fa"

echo "Checking assembly link..."
ls -lh "$ASSEMBLY"
readlink -f "$ASSEMBLY"

echo "Building FASTA index..."
apptainer exec -C \
  --bind "$WORKDIR" \
  "$CONTAINER" \
  samtools faidx "$ASSEMBLY"

echo "Checking index..."
ls -lh "$ASSEMBLY.fai"

