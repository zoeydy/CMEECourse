#!/usr/bin/env python3
"""using_name"""

__author__ = 'Zongyi Hu (zh2720@ic.ac.uk)'
__version__ = '0.0.1'

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is: " + __name__)