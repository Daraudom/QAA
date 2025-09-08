#!/usr/bin/env bash

#SBATCH --time=2:00:00
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=5
#SBATCH --mem=16G
#SBATCH --nodes=1
#SBATCH --job-name=cut_adapt.sh
#SBATCH --output=cut_adapt_output.log
#SBATCH --error=cut_adapt_error.log

mamba activate QAA

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o SRR25630376_r1_trimmed.fq.gz -p SRR25630376_r2_trimmed.fq.gz SRR25630376_1.fastq.gz SRR25630376_2.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o SRR25630302_r1_trimmed.fq.gz -p SRR25630302_r2_trimmed.fq.gz SRR25630302_1.fastq.gz SRR25630302_2.fastq.gz
