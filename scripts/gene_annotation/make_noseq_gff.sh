#!/bin/bash
#SBATCH --job-name=Maker_noseq
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
OUTDIR="$SLURM_SUBMIT_DIR/output/MAKER/Qar8a.bp.p_ctg.maker.output"
INDEX=Qar8a.bp.p_ctg_master_datastore_index.log
OUTPUT=Qar8a.bp.p_ctg.noseq.gff

cd "$OUTDIR"

if [[ -e "$OUTPUT" ]]; then
    echo "ERROR: $OUTPUT already exists; refusing to overwrite."
    exit 1
fi

echo "Creating GFF3 without embedded sequences..."
apptainer exec "$SIF" gff3_merge \
    -n \
    -d "$INDEX" \
    -o "$OUTPUT"

echo "Checking output..."
ls -lh "$OUTPUT"
head -n 3 "$OUTPUT"

echo "No-sequence GFF3 generation finished."

