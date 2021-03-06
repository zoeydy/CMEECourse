##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################

"""loops vs. list comprehensions: which is faster?"""


import timeit
import time
import sys

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join


"""define main function"""
def main(argv):

    iters = 1000000


    start = time.time()
    my_squares_loops(iters)
    print("my_squares_loops takes %f s to run." % (time.time() - start))

    start = time.time()
    my_squares_lc(iters)
    print("my_squares_lc takes %f s to run." % (time.time() - start))

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
    