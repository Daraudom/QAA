#!/usr/bin/env bash

files="SRR25630302 SRR25630376"

for file in $files; do
  echo "Processing ${file}"
  for mate in R1 R2; do
    in="${file}_${mate}_read_length.txt"          # one number (length) per line
    out="${file}_${mate}_len_dist.tsv"       # length \t count

    # Numeric sort, count duplicates, flip to length \t count
    sort -n "$in" | uniq -c | awk '{print $2 "\t" $1}' > "$out"
  done
done
