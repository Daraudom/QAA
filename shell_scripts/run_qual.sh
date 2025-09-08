#!/usr/bin/env bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=5
#SBATCH --mem=8G
#SBATCH --time=5:00:00
#SBATCH --nodes=1
#SBATCH --job-name=qual_dist
#SBATCH --output=qual_dist_output.log
#SBATCH --error=qual_dist.log

mamba activate base

/usr/bin/time -v ./qual_dist.py -r1 SRR25630302_1.fastq.gz -r2 SRR25630302_2.fastq.gz -l 150 -n 181461512 -s SRR25630302
/usr/bin/time -v ./qual_dist.py -r1 SRR25630376_1.fastq.gz -r2 SRR25630376_2.fastq.gz -l 150 -n 143120352 -s SRR25630376

