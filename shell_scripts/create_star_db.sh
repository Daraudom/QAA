#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=5:00:00
#SBATCH --job-name=campy_star_database
#SBATCH --output=star_db_output.log
#SBATCH --error=star_db_error.log

mamba activate QAA

dir="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/campylomormyrus_STAR/"

campy_dir="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/campy/"

mkdir -p $dir

# convert gff to gtf
echo "Converting GFF to GTF"

gffread ${campy_dir}campylomormyrus.gff -T -o ${campy_dir}campylomormyrus.gtf

echo "Running STAR"

/usr/bin/time -v STAR --runThreadN 8 \
 --runMode genomeGenerate \
 --genomeDir $dir \
 --genomeFastaFiles ${campy_dir}campylomormyrus.fasta \
 --sjdbGTFfile ${campy_dir}campylomormyrus.gtf
echo "Finished STAR"
exit
