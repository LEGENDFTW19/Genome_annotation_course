#!/bin/bash
#SBATCH --job-name=ipr_update
#SBATCH --partition=pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

set -euo pipefail

SIF=/data/courses/genome_annotation_resources/2026/containers/MAKER_3.01.03.sif
FINAL="$SLURM_SUBMIT_DIR/output/MAKER/final"

GFF="$FINAL/Qar8a.bp.p_ctg.noseq.gff"
IPR="$FINAL/Qar8a.bp.p_ctg.all.all.maker.proteins.iprscan.tsv"
OUT="$FINAL/Qar8a.bp.p_ctg.ipr_updated.gff"

cd "$FINAL"

if [[ ! -s "$GFF" || ! -s "$IPR" ]]; then
    echo "ERROR: GFF3 or InterProScan TSV is missing or empty."
    exit 1
fi

if [[ -e "$OUT" ]]; then
    echo "ERROR: Output already exists: $OUT"
    exit 1
fi

echo "Starting ipr_update_gff..."
date

apptainer exec "$SIF" ipr_update_gff "$GFF" "$IPR" > "$OUT"

echo "ipr_update_gff finished."
ls -lh "$OUT"
date
