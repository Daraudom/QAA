#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=5:00:00
#SBATCH --job-name=campy_picard
#SBATCH --output=picard_output.log
#SBATCH --error=picard_error.log

# good for making it robust
set -euo pipefail

mamba activate QAA

files="SRR25630302 SRR25630376"
ex="campy_starAligned.out.sam"

for file in $files; do
  # Convert SAM to BAM
  samtools view -@ ${SLURM_CPUS_PER_TASK} -bS ${file}_${ex} \
    -o ${file}_starAligned.bam

  # Sort BAM
  samtools sort -@ ${SLURM_CPUS_PER_TASK} \
    -o ${file}_starAligned_sorted.bam \
    ${file}_starAligned.bam

  # Index BAM (useful for downstream)
  samtools index ${file}_starAligned_sorted.bam

  # Mark duplicates with Picard
  picard MarkDuplicates \
    INPUT=${file}_starAligned_sorted.bam \
    OUTPUT=${file}_picard.bam \
    METRICS_FILE=${file}_picard.metrics \
    REMOVE_DUPLICATES=true \
    VALIDATION_STRINGENCY=LENIENT
done
