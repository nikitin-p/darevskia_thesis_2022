#!/bin/bash
#PBS -l walltime=100:00:00,mem=32gb
#PBS -d .
module load R/R-3.6.3
./calc_probes_all.R
