#!/usr/bin/env bash

files="SRR25630376  SRR25630302"

for file in $files;
do
echo "Processing ${file}"
zcat "${file}_output_forward_paired.fq.gz" | awk 'NR%4==2{print length($0)}' > ${file}_R1_read_length.txt
zcat "${file}_output_reverse_paired.fq.gz" | awk 'NR%4==2{print length($0)}'> ${file}_R2_read_length.txt
echo "Done processing"
done
