#!/bin/bash
#SBATCH --job-name=Maker_rename
#SBATCH --partition=pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12G
#SBATCH --time=02:00:00
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

set -euo pipefail

SIF=/data/courses/genome_annotation_resources/2026/containers/MAKER_3.01.03.sif
FINAL="$SLURM_SUBMIT_DIR/output/MAKER/final"

cd "$FINAL"

GFF=Qar8a.bp.p_ctg.noseq.gff
PROTEINS=Qar8a.bp.p_ctg.all.all.maker.proteins.fasta
TRANSCRIPTS=Qar8a.bp.p_ctg.all.all.maker.transcripts.fasta

for f in "$GFF" "$PROTEINS" "$TRANSCRIPTS" id.map; do
    [[ -s "$f" ]] || { echo "ERROR: Missing or empty file: $f"; exit 1; }
done

for f in "$GFF.renamed" "$PROTEINS.renamed.fasta" "$TRANSCRIPTS.renamed.fasta"; do
    [[ ! -e "$f" ]] || { echo "ERROR: Output already exists: $f"; exit 1; }
done

echo "Renaming GFF3 IDs..."
apptainer exec "$SIF" map_gff_ids id.map "$GFF" > "$GFF.renamed"

echo "Renaming protein FASTA IDs..."
apptainer exec "$SIF" map_fasta_ids id.map "$PROTEINS" > "$PROTEINS.renamed.fasta"

echo "Renaming transcript FASTA IDs..."
apptainer exec "$SIF" map_fasta_ids id.map "$TRANSCRIPTS" > "$TRANSCRIPTS.renamed.fasta"

echo "Checking output files..."
ls -lh "$GFF.renamed" "$PROTEINS.renamed.fasta" "$TRANSCRIPTS.renamed.fasta"

echo "ID renaming finished."

