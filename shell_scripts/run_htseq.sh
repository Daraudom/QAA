#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=5:00:00
#SBATCH --job-name=ht-seq
#SBATCH --output=htseq_output.log
#SBATCH --error=htseq_error.log

# good for making it robust
set -euo pipefail

mamba activate QAA

files="SRR25630302 SRR25630376"
ex="picard.bam"
gff_file="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/campy/campylomormyrus.gff"

for file in $files; do
htseq-count -f bam -s yes -i ID ${file}_${ex} ${gff_file} > ${file}_stranded_htseq.txt
htseq-count -f bam -s reverse -i ID ${file}_${ex} ${gff_file} > ${file}_reverse_htseq.txt
done
