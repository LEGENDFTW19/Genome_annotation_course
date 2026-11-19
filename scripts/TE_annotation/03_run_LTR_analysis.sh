#!/bin/bash
#SBATCH --job-name=LTR_analysis
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/tsingh/genome_annotation_course/logs/%x_%j.out
#SBATCH --error=/data/users/tsingh/genome_annotation_course/logs/%x_%j.err

set -euo pipefail

WORKDIR="/data/users/tsingh/genome_annotation_course"
COURSEDIR="/data/courses/genome_annotation_resources/2026"
OUTDIR="$WORKDIR/output/LTR_full_length"
CONTAINER="$COURSEDIR/containers/Annotation_analysis_R4.4.sif"
SCRIPT="$COURSEDIR/scripts/03-full_length_LTRs_identity_copy.R"

mkdir -p "$OUTDIR/plots"
cd "$OUTDIR"

echo "Starting LTR identity analysis"
echo "Working directory: $(pwd)"
echo "Start time: $(date)"

apptainer exec -C \
    --bind "$WORKDIR" \
    --bind "$COURSEDIR" \
    --pwd "$OUTDIR" \
    "$CONTAINER" \
    Rscript --vanilla "$SCRIPT"

echo "Finished at: $(date)"

