#!/usr/bin/env python

import argparse

def get_args():
    parser = argparse.ArgumentParser(description="Count the number of reads that are (un)mapped \
                                     given an input SAM file.")
    parser.add_argument('-i', '--input', help='Input a SAM File', type=str, required=True)
    return parser.parse_args()

args = get_args()
input_file = args.input

with open(input_file, 'r') as fin:
    # Initialize a counter to keep track of maps and unmaps
    map_count, unmap_count, = 0,0

    for line in fin:
        # check if it's not a header:
        if line.startswith('@'): continue

        sam_line = line.split(sep='\t')

        # extract the flag
        flag = int(sam_line[1])

        # check if this is a primary alignment
        if ((flag & 256) != 256):
            # if it is then check the bitwise:
            if ((flag & 4) != 4) :
                map_count += 1
            else:
                unmap_count += 1

print(f'Number of Mapped Reads: {map_count}')
print(f'Number of Unmapped Reads: {unmap_count}')
