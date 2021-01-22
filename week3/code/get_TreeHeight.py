#!/usr/bin/env python3

"""  A script that calculates heights of trees given distance of each tree from its base 
                and angle to its top, using the trigonometric formula  """

__appname__ = 'get_TreeHeight.py'
__author__ = 'Jane i.kotari20@imperial.co.uk'
__version__ = '0.0.1'
__date__ = 'Jan 2021'

#import libraries
import numpy as np
import sys
import csv
import pandas as pd
import os

def TreeHeight(degrees, distance):
    """ Calculates heights of trees using the trigonometric formula"""
    radians = degrees * np.pi / 180
    height = distance * np.tan(radians) 
    return height

def main(argv):
    """ Main entry point of the program """

    if len(sys.argv) == 1:
        print("You should input one file to run.")
    else:
        Trees = pd.read_csv(sys.argv[1])
        Trees['Tree.Height.m'] = TreeHeight(Trees['Angle.degrees'], Trees['Distance.m'])
        # Take only the filename without the relative paths and extensions and use it to name output file
        name = os.path.splitext(os.path.basename(sys.argv[1]))[0]
        filename = "../Results/%s_treeheights_py.csv" % name
        Trees.to_csv(filename, index=False)
    
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)