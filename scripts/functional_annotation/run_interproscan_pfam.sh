#!/bin/bash
#SBATCH --job-name=InterPro_Pfam
#SBATCH --partition=pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

set -euo pipefail

SIF=/data/courses/genome_annotation_resources/2026/containers/InterProScan_5.70.sif
FINAL="$SLURM_SUBMIT_DIR/output/MAKER/final"
PROTEINS=Qar8a.bp.p_ctg.all.all.maker.proteins.fasta
RESULT=Qar8a.bp.p_ctg.all.all.maker.proteins.iprscan.tsv

cd "$FINAL"

if [[ ! -s "$PROTEINS" ]]; then
    echo "ERROR: Protein FASTA is missing or empty."
    exit 1
fi

if [[ -e "$RESULT" ]]; then
    echo "ERROR: $RESULT already exists; refusing to overwrite."
    exit 1
fi

echo "Starting InterProScan Pfam analysis..."
date

apptainer exec "$SIF" /opt/interproscan/interproscan.sh \
    -appl pfam \
    --disable-precalc \
    -f TSV \
    --goterms \
    --iprlookup \
    --seqtype p \
    -i "$PROTEINS" \
    -o "$RESULT" \
    -cpu 8

echo "InterProScan finished."
date
ls -lh "$RESULT"

