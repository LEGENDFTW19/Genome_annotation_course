#!/bin/bash
#SBATCH --job-name=InterPro_Pfam
#SBATCH --partition=pibu_el8
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --account=class-sbl-30004-ws-2026
#SBATCH --reservation=class-sbl-30004-2026-10-28
#SBATCH --output=logs/%x_%j.out
#SBATCH --error=logs/%x_%j.err

set -euo pipefail

WORKDIR=/data/users/tsingh/genome_annotation_course
COURSEDIR=/data/courses/genome_annotation_resources/2026
FINAL="$WORKDIR/output/MAKER/final"
SIF="$COURSEDIR/containers/InterProScan_5.70.sif"
PROTEINS=Qar8a.bp.p_ctg.all.all.maker.proteins.fasta
RESULT=Qar8a.bp.p_ctg.all.all.maker.proteins.iprscan.tsv

mkdir -p "$FINAL/tmp"
cd "$FINAL"

if [[ ! -s "$PROTEINS" ]]; then
    echo "ERROR: Protein FASTA missing or empty: $PROTEINS"
    exit 1
fi

if [[ -e "$RESULT" ]]; then
    echo "ERROR: Output already exists: $RESULT"
    exit 1
fi

apptainer exec --cleanenv --pwd "$FINAL" \
    --bind "$COURSEDIR/data/interproscan-5.70-102.0/data":/opt/interproscan/data \
    --bind "$COURSEDIR" \
    --bind "$WORKDIR" \
    --bind "$FINAL/tmp":/temp \
    "$SIF" \
    /opt/interproscan/interproscan.sh \
    -appl pfam --disable-precalc -f TSV \
    --goterms --iprlookup --seqtype p \
    -i "$PROTEINS" \
    -o "$RESULT" \
    -cpu 8

echo "InterProScan finished."
date
ls -lh "$RESULT"
