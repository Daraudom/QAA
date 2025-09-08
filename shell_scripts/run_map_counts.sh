#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=5:00:00
#SBATCH --job-name=map_count
#SBATCH --output=map_count_output.log
#SBATCH --error=map_count_error.log

# good for making it robust
set -euo pipefail

mamba activate QAA

files="SRR25630302 SRR25630376"
ex="picard.bam"

for file in $files; do
  # Convert BAM to SAM
  samtools view -@ ${SLURM_CPUS_PER_TASK} -h \
    -o ${file}_picard.sam \
    ${file}_${ex} 
  
  echo "Processing ${file}_${ex}"
  
  ./genome_map_count.py -i ${file}_picard.sam

done
