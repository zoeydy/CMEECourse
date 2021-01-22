#!/usr/bin/env python3

"""Align 2 seqs and find the best matched alignment.
The input files should be 2 fasta files.
The best alignment will be stored in ../result/seq_align_fasta.txt"""

__appname__ = 'align_seqs_fasta'
__author__ = 'Rui Zhang (rui.zhang20@imperial.ac.uk)'
__version__ = '0.0.1'

## import ##
import sys

## functions ##
def readfasta(filepath):
    """Read the sequence from a fasta file"""
    global seq
    global seqname
    with open(filepath, 'r') as fastafile:
        lines = fastafile.readlines()
        line = [line.replace('\n', '') for line in lines]
        linenumber = len(line)
        seq = ''
        for i in range(1, linenumber):
            seq = seq + line[i]

def readsequence(f1,f2):
    """Read 2 sequences from 2 fasta files as seq1 and seq2"""
    global seq1
    global seq2
    readfasta(f1)
    seq1 = seq
    readfasta(f2)
    seq2 = seq


# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

def sortseq(seq1, seq2):
    """Compare the length of 2 sequences, regard the longer one as s1, and the shorter one as s2"""
    global l1
    global l2
    global s1
    global s2
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1  # swap the two lengths


# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """Compute the matching score of 2 sequences starting from a given startpoint"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"
    return score

# now try to find the best match (highest score) for the two sequences

def find_best_align(s1, s2, l1, l2):
    """Find the best match for 2 sequences"""
    my_best_align = None
    my_best_score = -1
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    outputfile = open("../result/seq_align_fasta.txt","a")  # store best alignment in a txt file
    print(my_best_align, file = outputfile)
    print(s1, file = outputfile)
    print("Best score:", my_best_score, file = outputfile)
    outputfile.close()

def main(argv):
    """ Main entry point of the program """
    if len(argv) == 3:
        readsequence(argv[1],argv[2])
    elif len(argv) ==1:
        readsequence('../data/seq1.fasta', '../data/seq2.fasta')
    sortseq(seq1, seq2)
    find_best_align(s1, s2, l1, l2)
    print('There is an output file as ../result/seq_align_fasta.txt')
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)

