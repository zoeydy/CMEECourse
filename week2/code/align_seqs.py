#~!/usr/bin/env python3

"""save the best alignment along with the sequence's corresponding score. """

__appname__ = 'align_seqs'
__author__ = 'Zongyi Hu (zh2720@ic.ac.uk)'
__version__ = '0.0.1'

import sys

"""Two example sequences to match"""
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"

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

"""A function that computes a score by returning the number of matches starting from arbitrary startpoint (chosen by user)"""
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

"""now try to find the best match (highest score) for the two sequences"""
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
    #store a best alignment in a .txt file
    g = open("../results/fasta_result.txt","w")
    g.write("The best align is:" + "\n")
    g.write(my_best_align + "\n")
    g.write(s1)
    g.write(f"The best score is: {my_best_score}" + "\n")
    g.close()

"""main function"""
def main(argv):
    with open("../data/sequence.csv") as f:
        seq1 = f.readline()
        seq2 = f.readline()
    longer_seq(seq1, seq2)
    best_match(s1, s2, l1, l2)
    return 0


if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)
