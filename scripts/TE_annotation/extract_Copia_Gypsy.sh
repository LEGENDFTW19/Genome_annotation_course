#!/bin/bash
#SBATCH --job-name=extract_CG
#SBATCH --partition=pibu_el8
#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH --output=logs/extract_CG_%j.out
#SBATCH --error=logs/extract_CG_%j.err

WORKDIR="/data/users/tsingh/genome_annotation_course"
CONTAINER="/data/courses/genome_annotation_resources/2026/containers/Annotation_analysis_R4.4.sif"
LIB="$WORKDIR/output/EDTA/Qar8a.bp.p_ctg.fa.mod.EDTA.TElib.fa"
OUT="$WORKDIR/output/TEsorter_full_library"

mkdir -p "$WORKDIR/logs" "$OUT"

apptainer exec --bind "$WORKDIR" "$CONTAINER" \
    seqkit grep -r -p '#LTR/Copia$' "$LIB" \
    -o "$OUT/Copia.fa"

apptainer exec --bind "$WORKDIR" "$CONTAINER" \
    seqkit grep -r -p '#LTR/Gypsy$' "$LIB" \
    -o "$OUT/Gypsy.fa"

echo "Copia sequences:"
grep -c '^>' "$OUT/Copia.fa"

echo "Gypsy sequences:"
grep -c '^>' "$OUT/Gypsy.fa"
