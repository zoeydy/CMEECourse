# Fit the Lotka-Volterra with prey density dependence rR(1 - R/K), plot and save population dynamics between consumer and resource with input from command line

# import packages
import scipy as sc
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys

# define a function that returns the growth rate of consumer and resource population at any given time step
def dCR_dt(pops):
    R = pops[0]
    C = pops[1]
    w = np.random.normal(0, 0.1)
    Rnext = R * (1 + (r + w) * (1 - R / K) - a * C)
    Cnext = C * (1 - z + e * a * R)
    return np.array([Rnext, Cnext])


def plot1(pops, t): 
    """plot 2 lines showing consumer and resource population dynamic among time"""
    # create an empty figure object
    f1 = p.figure()
    # plot consumer density and resource density
    p.plot(t, pops[:,0], 'g-', label = 'Resource density')
    p.plot(t, pops[:,1], 'b-', label = 'Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    # save the figure as a pdf
    f1.savefig('../result/LV4_model.pdf')


def plot2(pops): 
    """ plot another figure whose x is resource density, y is consumer density"""
    # create an empty figure object
    f2 = p.figure()
    # plot consumer density and resource density in another way
    p.plot(pops[:,0], pops[:,1], 'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')
    # save the figure as a pdf
    f2.savefig('../result/LV4_model1.pdf')

def main(argv):
    """main function of the program"""
    # read parameters from command line
    global r, a, z, e, K
    r = 0.05
    a = 0.05
    z = 0.05
    e = 0.02
    # define K
    K = 10000
    # set the initial conditions for the two populations, convert the two into an array
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])
    # define population density array
    pops = np.array([[R0, C0]])
    # define starting point of time
    t = 0
    # creat 1000 density data of each population
    while t < 999:
        RC0 = dCR_dt(RC0)
        pops = np.append(pops, [[RC0[0], RC0[1]]], axis = 0)
        t = t + 1
    # define total t series
    t = np.array(range(1000))
    # plot population dynamic of consumer and resource and save pictures
    plot1(pops, t)
    plot2(pops)


if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)
