#!/usr/bin/env bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --job-name=trimmomatic.sh
#SBATCH --output=trimmomatic_output_fast.log
#SBATCH --error=trimmomatic_error_fast.log

mamba activate QAA

/usr/bin/time -v trimmomatic PE -phred33 -threads 10 SRR25630302_r1_trimmed.fq.gz SRR25630302_r2_trimmed.fq.gz SRR25630302_output_forward_paired.fq.gz SRR25630302_output_forward_unpaired.fq.gz SRR25630302_output_reverse_paired.fq.gz SRR25630302_output_reverse_unpaired.fq.gz HEADCROP:8 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

/usr/bin/time -v trimmomatic PE -phred33 -threads 10 SRR25630376_r1_trimmed.fq.gz SRR25630376_r2_trimmed.fq.gz SRR25630376_output_forward_paired.fq.gz SRR25630376_output_forward_unpaired.fq.gz SRR25630376_output_reverse_paired.fq.gz SRR25630376_output_reverse_unpaired.fq.gz HEADCROP:8 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
