#!/usr/bin/env python3

"""Introduction for Scipy package"""
__appname__ = 'scipy-pra'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import numpy as np
import matplotlib.pylab as plt
import scipy as sc
from scipy import stats
import scipy.integrate as integrate

# generate 10 samples from the normal distribution 
sc.stats.norm.rvs(size = 10)
np.random.seed(1234) # seed is used to locked the ramdom sequence number
sc.stats.norm.rvs(size = 10)
sc.stats.norm.rvs(size=5, random_state=1234)
# generating random integers between 0 and 10
sc.stats.randint.rvs(0, 10, size = 7)
sc.stats.randint.rvs(0, 10, size = 7, random_state=1234)
sc.stats.randint.rvs(0, 10, size = 7, random_state=3445) # a different seed

# Numerical integration using scipy

# Area under a curve
y = np.array([5, 20, 18, 19, 18, 7, 4]) # The y values; can also use a python list here
plt.plot(y)
plt.show()

# using composite trapezoidal rule to compute the area
area = integrate.trapz(y, dx = 2)
print("area =", area)

area = integrate.trapz(y, dx = 1) # dx defines the spacing between points of the cureve
print("area =", area)
area = integrate.trapz(y, dx = 3)
print("area =", area)

# using Simpson's rule to comulte the area
area = integrate.simps(y, dx = 2)
print("area =", area)
area = integrate.simps(y, dx = 1)
print("area =", area)
area = integrate.simps(y, dx = 3)
print("area =", area)

# The Lotka - Volterra model
def dCR_dt(pops, t=0):
    """Define a function that returns the growth rate of consumer and resource population"""
    
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

type(dCR_dt)

r = 1.
a = 0.1 
z = 1.5
e = 0.75

t = np.linspace(0, 15, 1000)
R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])
# numerically integrate this system forward from starting conditions:
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops

type(infodict)
infodict.keys()
infodict['message']

import matplotlib.pylab as p
f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

f1.savefig('../results/LV_model.pdf') #Save figure
