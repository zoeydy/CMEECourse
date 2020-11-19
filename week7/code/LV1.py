
import sys

# importing packages will be needed later
import scipy as sc
import scipy.integrate as intergrate
import matplotlib.pylab as p

def main(argv):
    # the function returns the growth rate of consumer and resource population at any given time step
    def dCR_dt(pops, t = 0):
        R = pops[0]
        C = pops[1]
        dRdt = r*R - a*R*C
        dCdt = e*a*R*C - z*C

        return sc.array([dRdt, dCdt])


    ## assign some parameter values:
    r = 1.
    a = 0.1
    z = 1.5
    e = 0.75

    ## define the time vector
    t = sc.linspace(0, 15, 1000)
    ## set the initial conditions ofr the two populations, and convert them into an array(cause dCR_dt takes an array as input)
    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0])

    ## numerically integrate this system forward from those starting conditions:
    pops, infodict = intergrate.odeint(dCR_dt,RC0,t, full_output=True)
    pops
    type(infodict)
    infodict.keys()
    infodict['message']

    """ Plotting in Python """
    # 1. Population density VS. Time
    f1 = p.figure() # open an empty figure object(analogous to an R graphics object)
    p.plot(t, pops[:,0], 'g-', label = 'Resource density') #plot
    p.plot(t, pops[:,1], 'b-', label = 'Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resourse population dynamics')
    # p.show()
    # save the figure as a pdf:
    f1.savefig("../results/LV_model1.pdf")


    # 2. Consumer-Resource population dynamics (Consumer density VS. Resource density)
    f2 = p.figure() # open an empty figure object(analogous to an R graphics object)
    p.plot(pops[:,0], pops[:,1],'-r')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resourse population dynamics')
    # save the figure as a pdf:
    f2.savefig("../results/LV_model2.pdf")

    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)