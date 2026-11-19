#!/bin/bash
#SBATCH --job-name=Qar8a_BLAST
#SBATCH --partition=pibu_el8
#SBATCH --time=03:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=20
#SBATCH --output=output/comparisons/BLAST_%j.out
#SBATCH --error=output/comparisons/BLAST_%j.err

set -euo pipefail

WORKDIR=/data/users/tsingh/genome_annotation_course
COURSEDIR=/data/courses/genome_annotation_resources/2026
FINALDIR="$WORKDIR/output/MAKER/final"

PROTEINS="$FINALDIR/Qar8a.bp.p_ctg.all.all.maker.proteins.filtered.fasta"
UNIPROT="$COURSEDIR/data/uniprot_viridiplantae_reviewed.fa"
TAIR10="$COURSEDIR/data/TAIR10_pep_20110103_representative_gene_model"

OUTDIR="$WORKDIR/output/comparisons"

mkdir -p "$OUTDIR/tmp"
cd "$OUTDIR"

module load BLAST+/2.15.0-gompi-2021a

# Run both BLAST searches in parallel
blastp -query "$PROTEINS" \
    -db "$UNIPROT" \
    -num_threads 10 \
    -outfmt 6 \
    -evalue 1e-5 \
    -max_target_seqs 10 \
    -out "$OUTDIR/blastp_uniprot.tsv" &

uniprot_job=$!

blastp -query "$PROTEINS" \
    -db "$TAIR10" \
    -num_threads 10 \
    -outfmt 6 \
    -evalue 1e-5 \
    -max_target_seqs 10 \
    -out "$OUTDIR/blastp_TAIR10.tsv" &

tair_job=$!

# Wait for both searches
wait "$uniprot_job"
wait "$tair_job"

# Keep the highest-scoring hit for each query protein
for reference in uniprot TAIR10; do
    sort -k1,1 -k12,12gr -k11,11g \
        "$OUTDIR/blastp_${reference}.tsv" |
        awk -F '\t' '!seen[$1]++' \
        > "$OUTDIR/blastp_${reference}.besthits.tsv"
done

echo "Both BLAST searches completed successfully."

