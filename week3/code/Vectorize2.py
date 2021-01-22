#!/usr/bin/env python3

"""  A script that illustrates how vectorization works using the stochastic Ricker equation 
                        to model the recruitment of stock in fisheries  """

__appname__ = 'Vectorize2.py'
__author__ = 'Jane i.kotari20@imperial.co.uk'
__version__ = '0.0.1'
__date__ = 'Jan 2021'

#import libraries
import numpy as np
import sys
import time

def stochrick(p0 = np.random.uniform(low=0.5, high=1.5, size=(1000)), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """ Runs the stochastic Ricker equation with gaussian fluctuations """
    N = np.zeros((numyears, len(p0))) #initialize empty matrix
    N[0] = p0
    for pop in range(len(p0)): #loop through the populations
        for yr in range(1,numyears): #for each pop, loop through the years
            N[yr, pop] = N[yr - 1, pop] * np.exp(r * (1 - N[yr - 1, pop] / K) + np.random.normal(0, sigma, 1)) # add one fluctuation from normal distribution
    
    return(N)

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

def stochrickvect(p0 = np.random.uniform(low=0.5, high=1.5, size=(1000,)), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """ Runs the vectorised stochastic Ricker equation with gaussian fluctuations """
    N = np.zeros((numyears, len(p0))) #initialize empty matrix
    N[0] = p0
    for yr in range(1,numyears): #for each pop, loop through the years
        N[yr] = N[yr - 1] * np.exp(r * (1 - N[yr - 1] / K) + np.random.normal(0, sigma, 1)) # add one fluctuation from normal distribution
    
    return(N)

def main(argv):
    """ Main entry point of the program """
    start_rick = time.time()
    stochrick(p0 = np.random.uniform(low=0.5, high=1.5, size=(1000,)), r = 1.2, K = 1, sigma = 0.2, numyears = 100)
    print("The Stochastic Ricker in python3 takes:")
    print(time.time() - start_rick)
    start_vect = time.time()
    stochrickvect(p0 = np.random.uniform(low=0.5, high=1.5, size=(1000,)), r = 1.2, K = 1, sigma = 0.2, numyears = 100)
    print("The Vectorized Stochastic Ricker in python3 takes:")
    print(time.time() - start_vect)
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)