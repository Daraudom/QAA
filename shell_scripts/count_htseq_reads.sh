#!usr/bin/env bash

# good for making it robust
set -euo pipefail

mamba activate QAA

dir="/projects/bgmp/dnhem/bioinfo/Bi623/PS/QAA/ht-seq_files/"
files="SRR25630302 SRR25630376"
rev="reverse_htseq.txt"
strand="stranded_htseq.txt"

for file in $files; do
# Grab every lines but the last 5 lines
echo "Processing ${file}_${rev}:"
head -n -5 ${dir}${file}_${rev} | awk '{sum += $2} END {print sum, "reads counted"}'

echo "Processing ${file}_${strand}:"
head -n -5 ${dir}${file}_${strand} | awk '{sum += $2} END {print sum, "reads counted"}'

done

exit