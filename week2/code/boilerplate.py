#~!/usr/bin/env python3

"""
    a python program formate
    """

__appname__ = '[boilerplate]'
__author__ = 'Zongyi (zh2720@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = 'License for this program/code'

## imports ##
import sys # module to interface out program with the operating system

## constants ##


"""functions""" 
def main(argv):
    """
    main entry point of the program
    """
    print("This is a boilerplate") # NOTE: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """
    Makes sure the "main" function is called from command line
    """
    status = main(sys.argv)
    sys.exit(status)