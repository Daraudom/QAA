#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=5:00:00
#SBATCH --job-name=campy_star_alignment
#SBATCH --output=star_aln_output.log
#SBATCH --error=star_aln_error.log

files="SRR25630302 SRR25630376"
r1="output_forward_paired.fq.gz"
r2="output_reverse_paired.fq.gz"
  
mamba activate QAA

dir="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/campylomormyrus_STAR/"
trim="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/trimmomatic_outputs/"
  
for file in $files; do
/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads\
 --outFilterMultimapNmax 3 \
 --outSAMunmapped Within KeepPairs \
 --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
 --readFilesCommand zcat \
 --readFilesIn ${trim}${file}_$r1 ${trim}${file}_$r2 \
 --genomeDir ${dir} \
 --outFileNamePrefix ${file}_campy_star
done

exit
