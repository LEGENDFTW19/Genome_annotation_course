#!/bin/bash
#SBATCH --job-name=TEsorter_full
#SBATCH --partition=pibu_el8
#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --output=logs/TEsorter_full_%j.out
#SBATCH --error=logs/TEsorter_full_%j.err

WORKDIR="/data/users/tsingh/genome_annotation_course"
CONTAINER="/data/courses/genome_annotation_resources/2026/containers/TEsorter_1.3.0.sif"
OUT="$WORKDIR/output/TEsorter_full_library"

mkdir -p "$WORKDIR/logs" "$OUT"

cd "$OUT" || exit 1

echo "Starting TEsorter on Copia..."
apptainer exec --bind "$WORKDIR" "$CONTAINER" \
    TEsorter "$OUT/Copia.fa" -db rexdb-plant

echo "Starting TEsorter on Gypsy..."
apptainer exec --bind "$WORKDIR" "$CONTAINER" \
    TEsorter "$OUT/Gypsy.fa" -db rexdb-plant

echo "TEsorter runs finished."
