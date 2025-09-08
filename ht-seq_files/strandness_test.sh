#!/usr/bin/env bash
set -euo pipefail

# If you prefer not to hardcode, you could read these from ${s}.mapcount.txt instead.
declare -A mapped_by_sample=(
  [rhy51_EO_6cm]=38760798
  [comrhy114_EO_adult]=21541128
)

for s in rhy51_EO_6cm comrhy114_EO_adult; do
  rev_file="${s}_rev_stranded_htseq.txt"
  yes_file="${s}_yes_stranded_htseq.txt"

  # Sum assigned (exclude __ summary lines)
  rev_assigned=$(awk '!/^__/ {sum+=$2} END{print sum+0}' "$rev_file")
  yes_assigned=$(awk '!/^__/ {sum+=$2} END{print sum+0}' "$yes_file")

  # Pull __no_feature for context
  rev_nofeat=$(awk '$1=="__no_feature"{print $2+0}' "$rev_file")
  yes_nofeat=$(awk '$1=="__no_feature"{print $2+0}' "$yes_file")

  echo -e "${s}\treverse_assigned\t${rev_assigned}\tno_feature=${rev_nofeat}"
  echo -e "${s}\tyes_assigned\t${yes_assigned}\tno_feature=${yes_nofeat}"

  mapped="${mapped_by_sample[$s]}"

  printf "%s\treverse_assigned_pct\t%.2f\n" "$s" \
    "$(awk -v a="$rev_assigned" -v m="$mapped" 'BEGIN{print (m>0?100*a/m:0)}')"
  printf "%s\tyes_assigned_pct\t%.2f\n" "$s" \
    "$(awk -v a="$yes_assigned" -v m="$mapped" 'BEGIN{print (m>0?100*a/m:0)}')"
done
