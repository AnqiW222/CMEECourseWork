#!/usr/bin/env python3

# The Lotka - Volterra model
"""Numerical integration for solving classical models in biology.
Return growth rate of consumer and resource population at any given time step
and produce relevant figures"""
__appname__ = 'LV1'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import numpy as np
import matplotlib.pylab as plt
from matplotlib.backends.backend_pdf import PdfPages
import scipy as sc
from scipy import stats
import scipy.integrate as integrate
import sys

def plot_f1(pops, t, r, a, z, e):
    """Generating the Consumer-Resource population dynamics graph with time"""
    f1 = plt.figure()
    plt.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    plt.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    plt.grid()
    plt.legend(loc='best')
    plt.xlabel('Time')
    plt.ylabel('Population density')
    plt.title('Consumer-Resource population dynamics')
    plt.show()# To display the figure
    return f1


def plot_f2(pops, r, a, z, e):
    """Generating the Consumer-Resource population dynamics graph"""
    f2 = plt.figure()
    plt.plot(pops[:,1], pops[:,0], 'r-') # Plot
    plt.show()
    plt.grid()
    plt.legend(loc='best')
    plt.xlabel('Resource density')
    plt.ylabel('Consumer density')
    plt.title('Consumer-Resource population dynamics')
    plt.show()# To display the figure
    return f2

def save_figs(f1, f2): 
    """Saving figures """
    figs = PdfPages('../results/LV_model.pdf')
    figs.savefig(f1)
    figs.savefig(f2)
    figs.close()
    return 0

# Define parameters:
def main(argv):
    """Main entry point of the program"""
    r = 1. # Resource growth rate
    a = 0.1 # Consuption rate
    z = 1.5 # Consumer mortality rate
    e = 0.75 # Consumer production efficiency
    
    def dCR_dt(pops, t=0):
        """Define a function that returns the growth rate of consumer and resource population"""
        
        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C 
        dCdt = -z * C + e * a * R * C
        
        return np.array([dRdt, dCdt])


    # Define timefrom 0 to 15, using 1000points:
    t = np.linspace(0, 15, 1000)

    R0 = 10
    C0 = 5 
    RC0 = np.array([R0, C0])
 # initial conditions: 10 consumer and 5 recource per unit area
# numerically integrate this system forward from starting conditions:
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    infodict['message']

    prey, predictor = pops.T # transposes arrays
    
    f1 = plot_f1(pops, t, r, a, z, e)
    f2 = plot_f2(pops, r, a, z, e)
    save_figs(f1, f2)
    return 0

# Original Practice
#f1 = plt.figure()
#plt.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
#plt.plot(t, pops[:,1]  , 'b-', label='Consumer density')
#plt.grid()
#plt.legend(loc='best')
#plt.xlabel('Time')
#plt.ylabel('Population density')
#plt.title('Consumer-Resource population dynamics')
#plt.show()# To display the figure

#f2 = plt.figure()
#plt.plot(pops[:,1], pops[:,0], 'r-') # Plot
#plt.show()
#plt.grid()
#plt.legend(loc='best')
#plt.xlabel('Resource density')
#plt.ylabel('Consumer density')
#plt.title('Consumer-Resource population dynamics')
#plt.show()# To display the figure

#f1.savefig('../results/LV1_model_f1.pdf') #Save figure
#f2.savefig('../results/LV1_model_f2.pdf')

if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)