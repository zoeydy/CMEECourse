#!/usr/bin/env python3 

"""oaks_debugme.py loops over the rows in TestOaksData.csv and writes the oak trees with Genus 'Quercus'
into JustOaksData.csv. This script does not accept any other Genus other than/outside of  the specified 
string 'quercus'. The header rows are also excluded (if it exists) in its search for oaks and rather 
includes them in JustOaksData.csv.
"""

__appname__ = '[oaks_debugme.py]'
__author__ = 'Joshua James Holley (joshua.holley20@imperial.ac.uk)'
__version__ = '0.0.1'

## IMPORTS ##
import csv
import sys
import doctest # Import the doctest module

## CONSTANTS ##


## FUNCTIONS ##
#Define function
def is_an_oak(name):
    """ Returns True if name starts with 'quercus' 
    >>> is_an_oak('quercus petraea')
    True
    >>> is_an_oak('Quercus petraea')
    True
    >>> is_an_oak('Quercuss petraea')
    False
    >>> is_an_oak('Quercusquercus petraea')
    False
    >>> is_an_oak('Fraxinus excelsior')
    False
    >>> is_an_oak('Fagus sylvatica')
    False
    """
    return name.lower().split()[0] == 'quercus' # Does not accept anything other than/outside of specified string

def main(argv): 
    """Main"""
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    # oaks = set() # Local variable 'oaks' is assigned to but never used
    for row in taxa:
        if 'Genus' in row[0]:
            csvwrite.writerow([row[0], row[1]]) # include the column headers (“Genus”, “species”) in JustOaksData.csv
            continue # Excludes the header row (if it exists) in its search for oaks
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    
doctest.testmod()   # To run with embedded tests