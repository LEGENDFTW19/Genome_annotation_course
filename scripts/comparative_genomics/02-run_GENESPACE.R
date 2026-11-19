
library(GENESPACE)

wd <- "/data/users/tsingh/genome_annotation_course/output/GENESPACE"

gpar <- init_genespace(
  wd = wd,
  genomeIDs = c("Qar8a", "TAIR10", "Altai_5", "Are_6", "Est_0"),
  path2mcscanx = "/usr/local/bin",
  nCores = 20
)

out <- run_genespace(gpar)

saveRDS(out, file = file.path(wd, "genespace_output.rds"))

