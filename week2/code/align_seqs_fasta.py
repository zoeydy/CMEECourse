#~!/usr/bin/env python3

"""align the sequences in .fasta """

__appname__ = 'align_seqs_fasta'
__author__ = 'Zongyi Hu (zh2720@ic.ac.uk)'
__version__ = '0.0.1'

import sys

def read_seq(file):
    with open(file, "r") as f:
        lines = f.readlines()
        seq_list = lines[1:len(lines)]
        new_list = []
        for i in seq_list:
            new_list.append(i.rstrip('\n'))
        seq_str = ''.join(new_list)
    return seq_str
        
# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
def longer_seq(seq1, seq2):
    global l1
    global l2
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        global s1
        global s2
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

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
    for i in range(l1):
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 
            my_best_score = z 
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)

def main(argv):
    if len(sys.argv) == 3: 
        seq1 = read_seq(argv[1])
        seq2 = read_seq(argv[2]) 
    else: #if there are no input from the user, define a function to get to the default data
        seq1 = read_seq("../data/fasta/407228326.fasta")
        seq2 = read_seq("../data/fasta/407228412.fasta")
    longer_seq(seq1, seq2)
    best_match(s1, s2, l1, l2)
    return 0

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)