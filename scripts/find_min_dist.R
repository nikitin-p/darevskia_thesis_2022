#!/usr/bin/env Rscript

library(tidyverse)
library(utils)
library(tictoc)

tr.probes.all = read.delim("../data/results/tr_probes/tr_probes_all.tsv", header = T, sep = "\t", stringsAsFactors = F)

cat('Table loaded\n')

tic('Find min distances:') 

tr.probes.min.all = tr.probes.all %>%
  group_by(probe.seq.n) %>%
  mutate(min.dist.n = min(edit.dist)) %>%
  ungroup() %>%
  group_by(probe.seq.v) %>%
  mutate(min.dist.v = min(edit.dist)) %>%
  ungroup() %>%
  group_by(probe.seq.n) %>%
  mutate(min.n = (edit.dist == min.dist.n)) %>%
  ungroup() %>%
  group_by(probe.seq.v) %>%
  mutate(min.v = (edit.dist == min.dist.v)) %>%
  ungroup()

toc()
write.table(tr.probes.min.all,
            "../data/results/tr_probes_all_min_dist.tsv",
            quote = F,
            sep = "\t",
            row.names = F)
cat('Done\n')
