#!/usr/bin/env python3

__appname__ = 'align_seqs'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# Imports
import pandas as pd
import sys
import io

### Write and Read .csv files to get the two example sequence ###
# Write two sequence into a .csv file and save in /data
data = {'seq1':['CAATTCGGAT'],'seq2':['ATCGCCGGATTACGGG']}
data_df = pd.DataFrame(data)
data_df.to_csv('../data/align_seq.csv')

# Read .csv file
filename = '../data/align_seq.csv'
df = pd.read_csv(filename)
print(df)

# read the two example sequence to match from the .csv file
def file_input():
    seq1 = df.iloc[0,1]
    seq2 = df.iloc[0,2]
    return seq1, seq2

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
def swap_lengths(seq1, seq2):
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

    return s1, s2, l1, l2

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
def best_match(s1, s2, l1, l2):
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
        print(my_best_align)
        print(s1)
        print("Best score:", my_best_score)

    return my_best_align, my_best_score

### Output file ###
def file_output(my_best_align, my_best_score):
    OutputData = {'My best alignment is ':str(my_best_align),'My best score is ':str(my_best_score)}
    OutputData_df = pd.DataFrame(OutputData, index=[0])
    OutputData_df.to_csv('../results/output_align_seq.csv')

def main(argv): 
    """Main entry point of the program"""
    seq1, seq2 = file_input()
    s1, s2, l1, l2 = swap_lengths(seq1, seq2)
    my_best_align, my_best_score = best_match(s1, s2, l1, l2)
    file_output(my_best_align, my_best_score)
    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)