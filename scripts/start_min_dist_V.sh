#!/bin/bash
#PBS -l walltime=1:00:00,mem=8gb
#PBS -d .
<../data/results/tr_probes_all_min_dist.tsv awk -F"\t" '{if (NR == 1) {print} else {if (($15 > 10) && ($17 == "TRUE")) print} }' > ../data/results/tr_probes_all_min_dist_V.tsv
