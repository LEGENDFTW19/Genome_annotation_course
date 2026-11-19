#!/bin/bash
#SBATCH --job-name=Maker_finalize
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

cd "$OUTDIR"

# Refuse to overwrite existing final files.
for f in Qar8a.bp.p_ctg.all.gff \
         Qar8a.bp.p_ctg.all.maker.proteins.fasta \
         Qar8a.bp.p_ctg.all.maker.transcripts.fasta; do
    if [[ -e "$f" ]]; then
        echo "ERROR: $f already exists; stopping to protect existing results."
        exit 1
    fi
done

echo "Starting GFF3 merge..."
apptainer exec "$SIF" gff3_merge \
    -d Qar8a.bp.p_ctg_master_datastore_index.log \
    -o Qar8a.bp.p_ctg.all

echo "Starting FASTA merge..."
apptainer exec "$SIF" fasta_merge \
    -d Qar8a.bp.p_ctg_master_datastore_index.log \
    -o Qar8a.bp.p_ctg.all

echo "Checking generated files..."
ls -lh Qar8a.bp.p_ctg.all*
echo "MAKER finalization finished."
