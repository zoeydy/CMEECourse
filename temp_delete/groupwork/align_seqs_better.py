#~!/usr/bin/env python3

"""save the best alignment along with the sequence's corresponding score."""

__author__ = 'Zongyi (zh2720@ic.ac.uk)'
__version__ = '0.0.1'

filename = "../data/sequence.csv"
f = open(filename,"r")
seq1 = f.readline()
seq2 = f.readline()

l1 = len(seq1)
l2 = len(seq2)
if l1 > l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1

def calculate_score(s1,s2,l1,l2,startpoint):
    match = ""
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:
                match = match + "*"
                score = score + 1
            else:
                match = match + "-"

    print("." * startpoint + match)
    print("." * startpoint + s2)
    print(s1)
    print(score)
    print(" ")

    return score

my_best_lign = None
my_best_score = -1

for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_lign = "." * i + s2
        my_best_score = z
    # elif z = my_best_score:
        


print(my_best_lign)
print(s1)
print("Best score: ", my_best_score)