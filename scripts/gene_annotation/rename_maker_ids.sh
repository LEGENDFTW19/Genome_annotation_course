#!/bin/bash
#SBATCH --job-name=Maker_IDmap
#SBATCH --partition=pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

set -euo pipefail

SIF=/data/courses/genome_annotation_resources/2026/containers/MAKER_3.01.03.sif
FINAL="$SLURM_SUBMIT_DIR/output/MAKER/final"

cd "$FINAL"

if [[ -e id.map ]]; then
    echo "ERROR: id.map already exists; refusing to overwrite."
    exit 1
fi

apptainer exec "$SIF" maker_map_ids \
    --prefix Qar8a \
    --justify 7 \
    Qar8a.bp.p_ctg.noseq.gff > id.map

echo "ID mapping file created:"
ls -lh id.map
head id.map

