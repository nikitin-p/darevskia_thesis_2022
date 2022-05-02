#!/usr/bin/env Rscript

library(tidyverse)
library(utils)
library(tictoc)

tr.probes.n = read.delim("../data/results/tr_probes/tr_probes_n.tsv", header = T, sep = "\t", stringsAsFactors = F) 
tr.probes.v = read.delim("../data/results/tr_probes/tr_probes_v.tsv", header = T, sep = "\t", stringsAsFactors = F)

print("Loaded tables")
tic("Calculating the distance...")

names(tr.probes.n) = c("unit.seq.n", "probe.seq.n", "contig.n", "length.n", "mean.coverage.n", "repr.n")
names(tr.probes.v) = c("unit.seq.v", "probe.seq.v","contig.v", "length.v", "mean.coverage.v", "repr.v")
tr.probes.n$dummy.col = 1
tr.probes.v$dummy.col = 1
tr.probes.all = tr.probes.n %>%
  inner_join(tr.probes.v, by = ("dummy.col" = "dummy.col")) %>%
  group_by(unit.seq.n, contig.n, probe.seq.n, unit.seq.v, contig.v, probe.seq.v) %>%
  dplyr::mutate(edit.dist = utils::adist(probe.seq.n, probe.seq.v)) %>%
  ungroup() %>%
  dplyr::select(-dummy.col)

toc()

write.table(tr.probes.all, file="../data/results/tr_probes/tr_probes_all.tsv", quote = FALSE, sep = "\t", row.names = FALSE)

print("Table printing finished")
