#-----Genome
genome=PATH_TO_QAR8A_ASSEMBLY
organism_type=eukaryotic

#-----Re-annotation
maker_gff=
est_pass=0
altest_pass=0
protein_pass=0
rm_pass=0
model_pass=0
pred_pass=0
other_pass=0

#-----EST Evidence
est=PATH_TO_TRANSCRIPT_FASTA
altest=
est_gff=
altest_gff=

#-----Protein Homology Evidence
protein=PATH_TO_TAIR10_PROTEINS,PATH_TO_UNIPROT_VIRIDIPLANTAE
protein_gff=

#-----Repeat Masking
model_org=
rmlib=PATH_TO_EDTA_REPEAT_LIBRARY
repeat_protein=PATH_TO_PTREP20
rm_gff=
prok_rm=0
softmask=1

#-----Gene Prediction
snaphmm=
gmhmm=
augustus_species=arabidopsis
fgenesh_par_file=
pred_gff=
model_gff=
run_evm=0
est2genome=1
protein2genome=1
trna=0
snoscan_rrna=
snoscan_meth=
unmask=0
allow_overlap=

#-----Other Annotation Features
other_gff=

#-----External Application Behaviour
alt_peptide=C
cpus=1

#-----MAKER Behaviour
max_dna_len=100000
min_contig=1
pred_flank=200
pred_stats=0
AED_threshold=1
min_protein=0
alt_splice=1
always_complete=0
map_forward=0
keep_preds=0
split_hit=10000
min_intron=20
single_exon=0
single_length=250
correct_est_fusion=0
tries=2
clean_try=0
clean_up=0
TMP=/TMP
