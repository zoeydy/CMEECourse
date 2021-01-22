# Fit the Lotka-Volterra with prey density dependence rR(1 - R/K), plot and save population dynamics between consumer and resource with input from command line

# import packages
import scipy as sc
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys

# define a function that returns the growth rate of consumer and resource population at any given time step
def dCR_dt(pops, t=0):
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C
    dCdt = -z * C + e * a * R * C

    return np.array([dRdt, dCdt])


def plot1(pops, t): 
    """plot 2 lines showing consumer and resource population dynamic among time"""
    # create an empty figure object
    f1 = p.figure()
    # plot consumer density and resource density
    p.plot(t, pops[:,0], 'g-', label = 'Resource density')
    p.plot(t, pops[:,1], 'b-', label = 'Consumer density')
    p.grid()
    p.legend(loc='best')
    p.text(15, 12, 'r = %s\na = %s\nz = %s\ne = %s' % (r, a, z, e), horizontalalignment='right', verticalalignment = "top")
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    # save the figure as a pdf
    f1.savefig('../results/LV2_model.pdf')


def plot2(pops): 
    """ plot another figure whose x is resource density, y is consumer density"""
    # create an empty figure object
    f2 = p.figure()
    # plot consumer density and resource density in another way
    p.plot(pops[:,0], pops[:,1], 'r-')
    p.grid()
    p.text(12, 7, 'r = %s\na = %s\nz = %s\ne = %s' % (r, a, z, e), horizontalalignment='right', verticalalignment = "top")
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')
    # save the figure as a pdf
    f2.savefig('../results/LV2_model1.pdf')

def main(argv):
    """main function of the program"""
    # read parameters from command line
    global r, a, z, e, K
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
    # define K
    K = 10000
    # define the time vector, integrate from time point 0 to 15, using 1000 sub-divisions of time
    t = np.linspace(0,15,1000)
    # set the initial conditions for the two populations, convert the two into an array
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])
    # numerically integrate this system foward from those starting conditons
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    # plot population dynamic of consumer and resource and save pictures
    plot1(pops, t)
    plot2(pops)
    print("At time = 15, resource density is %s and comsumer density is %s." % (pops[-1,0], pops[-1,1]))
    return 0


if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)