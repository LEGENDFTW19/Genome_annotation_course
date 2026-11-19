#!/bin/bash
#SBATCH --job-name=GENESPACE
#SBATCH --partition=pibu_el8
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=20
#SBATCH --output=logs/genespace_%j.out
#SBATCH --error=logs/genespace_%j.err

COURSEDIR=/data/courses/genome_annotation_resources/2026
PROJECT=/data/users/tsingh/genome_annotation_course

mkdir -p "$PROJECT/logs"

apptainer exec "$COURSEDIR/containers/genespace_latest.sif" \
    Rscript "$PROJECT/scripts/02-run_GENESPACE.R"

