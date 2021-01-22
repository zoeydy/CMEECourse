# numerical integration using scipy, like calculating the area under a curve
# a particularly useful application is solving ordinary differential equations
# there is an example about Lotka-Volterra model

# import packages
import scipy as sc
import numpy as np
import scipy.integrate as integrate

# define a function that returns the growth rate of consumer and resource population at any given time step
def dCR_dt(pops, t=0):
    """a function returns the growth rate of consumer and resource population at any given time step"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C

    return np.array([dRdt, dCdt])

# check dCR_dt type
type(dCR_dt)

# assign some parameter values
r = 1.
a = 0.1
z = 1.5
e = 0.75

# define the time vector, integrate from time point 0 to 15, using 1000 sub-divisions of time
t = np.linspace(0,15,1000)

# set the initial conditions for the two populations, convert the two into an array
R0 = 10
C0 = 5
RC0 = np.array([R0, C0])

# numerically integrate this system foward from those starting conditons
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

# check what's in infodict(it's a dintionary with additional information)
type(infodict)
infodict.keys()

# return a message to screen about whether the integration was successful
infodict['message']

# visualize the results using matplotlib package
# import package
import matplotlib.pylab as p

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
f1.savefig('../results/LV_model.pdf')

# plot another figure whose x is resource density, y is consumer density
# create an empty figure object
f2 = p.figure()

# plot consumer density and resource density in another way
p.plot(pops[:,0], pops[:,1], 'r-')
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')

# save the figure as a pdf
f2.savefig('../results/LV_model1.pdf')