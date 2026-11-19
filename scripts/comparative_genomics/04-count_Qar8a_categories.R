
library(dplyr)
library(readr)
library(tidyr)

wd <- "/data/users/tsingh/genome_annotation_course/output/GENESPACE"

# Read the pangenome table using the same filtering as the course script
pg <- read_tsv(
  file.path(wd, "pangenes/TAIR10_pangenes.txt.gz"),
  show_col_types = FALSE
) %>%
  filter(!is.na(interpOrd))

# Unique gene associations
genes <- pg %>%
  filter(!is.na(id), nzchar(id)) %>%
  distinct(pgID, genome, id)

genomes <- sort(unique(pg$genome))

# Count genes in each pan-gene entry and genome
counts <- genes %>%
  count(pgID, genome, name = "copies")

all_combinations <- expand_grid(
  pgID = unique(pg$pgID),
  genome = genomes
)

counts <- all_combinations %>%
  left_join(counts, by = c("pgID", "genome")) %>%
  mutate(copies = replace_na(copies, 0L))

# Classify pan-gene entries
entries <- counts %>%
  group_by(pgID) %>%
  summarise(
    n_present = sum(copies > 0),
    .groups = "drop"
  ) %>%
  mutate(category = case_when(
    n_present == length(genomes) ~ "core",
    n_present == 1 ~ "accession_specific",
    TRUE ~ "accessory"
  ))

# Count distinct Qar8a genes associated with each category
qar8a_genes <- genes %>%
  filter(genome == "Qar8a") %>%
  inner_join(entries, by = "pgID") %>%
  distinct(category, id)

cat("\nQar8a unique genes by category:\n")

qar8a_genes %>%
  count(category, name = "unique_Qar8a_genes") %>%
  print()

cat("\nTotal distinct Qar8a genes represented:\n")
print(n_distinct(qar8a_genes$id))

# Save results
write_tsv(
  qar8a_genes,
  file.path(wd, "process_pangenome/tables/Qar8a_gene_categories.tsv")
)

