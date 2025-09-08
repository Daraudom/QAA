import numpy as np
import bioinfo
import matplotlib.pyplot as plt
import argparse

# define a new argparse

# Define qual array size
qual_arr = np.ndarray(shape=(read_length, records_num), dtype=int)

with open (file, 'r') as fin:
    j = 0 # read index
    while True:
        if j % 10000 == 0: print(j)
        header = fin.readline().strip()
        if header == "": break
        seq = fin.readline()
        plus = fin.readline()
        qual = fin.readline().strip()
        

        for i in range(len(qual)):
            phred_score = bioinfo.convert_phred(qual[i])
            qual_arr[i][j] = phred_score
         
        j += 1

# descriptive stats
mean = np.mean(qual_arr, axis=1)
var = np.var(qual_arr, axis=1, ddof=1)
stdev = np.std(qual_arr, axis=1, ddof=1)
median = np.median(qual_arr, axis=1)
p25 = np.percentile(qual_arr, axis =1 , q=25)
p75 = np.percentile(qual_arr, axis =1 , q=75)

# plot
plt.bar(range(0, 101),mean, width=0.5)
plt.errorbar(range(0, 101),mean, yerr=stdev, color='r', fmt='_')
plt.xlabel('Base Position')
plt.ylabel('Mean Quality Scores')
plt.title('Mean Plot of Quality Scores')
plt.show()
