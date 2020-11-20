#~!/usr/bin/env python3

import sys
print(sys.argv)

# importing packages will be needed later
import scipy as sc
import scipy.integrate as intergrate
import matplotlib.pylab as p





# define function
def dCR_dt(pops, t = 0):
    R = pops[0]
    C = pops[1]
    dRdt = r*R*(1-R/K) - a*R*C
    dCdt = e*a*R*C - z*C

    return sc.array([dRdt, dCdt])

def integ(dCR_dt,t):
    R0 = 10
    C0 = 5
    RC0 = sc.array([R0, C0])
    # import ipdb; ipdb.set_trace()
    
    pops, infodict = intergrate.odeint(dCR_dt, RC0, t, full_output=True)
    pops
    type(infodict)
    infodict.keys()
    infodict['message']
    print(pops[-1,0], pops[-1,1])
    return pops

# # assign some parameter values:
# r = 1.
# a = 0.1
# z = 1.5
# e = 0.75

    # Plotting in Python 
    # 1. Population density VS. Time
def f1(pops, t):
     
    f1 = p.figure(figsize=(7, 6)) # open an empty figure object(analogous to an R graphics object)
    p.plot(t, pops[:,0], 'g-', label = 'Resource density') #plot
    p.plot(t, pops[:,1], 'b-', label = 'Consumer density')
    p.grid()
    p.legend(loc='best')
    p.text(15, 3, 'r = %r, a = %r, z = %r, e = %r' % (r, a, z, e))
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resourse population dynamics')
    # p.show()
    # save the figure as a pdf:
    f1.savefig("../results/LV2_model1.pdf")


    # 2. Consumer-Resource population dynamics (Consumer density VS. Resource density)
def f2(pops, t):
    f2 = p.figure(figsize=(7, 6)) # open an empty figure object(analogous to an R graphics object)
    p.plot(pops[:,0], pops[:,1],'-r')
    p.grid()
    p.text(8, 2.5, 'r = %r, a = %r, z = %r, e = %r' % (r, a, z, e))
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resourse population dynamics')
    # save the figure as a pdf:
    f2.savefig("../results/LV2_model2.pdf")

    

def main(argv):
    global r
    global a
    global z
    global e
    global K
    r = float(argv[1])
    a = float(argv[2])
    z = float(argv[3])
    e = float(argv[4])
    K = 10000.0

    t = sc.linspace(0, 30, 1000)
    pops= integ(dCR_dt,t)
    f1(pops, t)
    f2(pops, t)

    
    



if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)
