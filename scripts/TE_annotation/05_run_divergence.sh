#!/bin/bash
#SBATCH --job-name=TE_divergence
#SBATCH --partition=pibu_el8
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=/data/users/tsingh/genome_annotation_course/logs/%x_%j.out
#SBATCH --error=/data/users/tsingh/genome_annotation_course/logs/%x_%j.err

set -euo pipefail

WORKDIR="/data/users/tsingh/genome_annotation_course"
COURSEDIR="/data/courses/genome_annotation_resources/2026"
CONTAINER="$COURSEDIR/containers/Annotation_analysis_R4.4.sif"
PARSER="$COURSEDIR/scripts/05-parseRM.pl"
R_SCRIPT="$WORKDIR/scripts/06-plot_div_nonzero.R"
OUTDIR="$WORKDIR/output/EDTA"

cd "$OUTDIR"

mkdir -p assembly.fasta.mod.EDTA.anno plots

ln -sf ../Qar8a.bp.p_ctg.fa.mod.EDTA.anno/Qar8a.bp.p_ctg.fa.mod.out \
  assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out

# Remove RepeatMasker records with 0% divergence before parsing
awk 'NR == 1 || $2 != 0' \
  assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out \
  > assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.nonzero.out

echo "Starting RepeatMasker divergence parsing: $(date)"

apptainer exec -C \
  --bind "$WORKDIR" \
  --bind "$COURSEDIR" \
  --pwd "$OUTDIR" \
  "$CONTAINER" \
  perl "$PARSER" \
    -i assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.nonzero.out \
    -l 50,1 -v

TABLE="assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.nonzero.out.landscape.Div.Rname.tab"

if [ ! -s "$TABLE" ]; then
    echo "ERROR: Divergence landscape table was not generated."
    exit 1
fi

echo "Landscape table generated:"
ls -lh "$TABLE"

# echo "Generating divergence plot: $(date)"

apptainer exec -C \
  --bind "$WORKDIR" \
  --bind "$COURSEDIR" \
  --pwd "$OUTDIR" \
  "$CONTAINER" \
  Rscript --vanilla "$R_SCRIPT"

echo "Finished: $(date)"
ls -lh plots/output.pdf
