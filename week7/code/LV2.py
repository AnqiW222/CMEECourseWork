#!/usr/bin/env python3

# The Lotka - Volterra model
"""
The Consumer population C goes extinct in the Lotka-Volterra Model
Fitting the Lotka-Volterra model and generating population dynamics graphs with input values from the command line
"""
__appname__ = 'LV2'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import sys
import numpy as np
import matplotlib.pylab as plt
from matplotlib.backends.backend_pdf import PdfPages
#import scipy as sc
from scipy import stats
import scipy.integrate as integrate

def plot_f1(pops, t, r, K, a, z, e): 
    """Generating the Consumer-Resource population dynamics graph with time"""

    f1 = plt.figure()
    plt.plot(t, pops[:,0], 'g-', label='Resourse density')
    plt.plot(t, pops[:,1], 'b-', label='Consumer density')
    plt.grid()
    plt.legend(loc='best')
    plt.xlabel('Time')
    plt.ylabel('Population density')
    plt.title('Consumer-Resource population dynamics')
    box = dict(boxstyle = "Round", facecolor = "white", alpha = 0.7)
    plt.text(15, max(pops[:, 0]), 'r=%s\nK=%s\na=%s\nz=%s\ne=%s' % (str(round(r,2)), str(round(K,2)), str(round(a,2)), str(round(z,2)), str(round(e,2))), horizontalalignment='right', verticalalignment = "top", bbox = box)
    return f1

def plot_f2(pops, r, K, a, z, e):
    """Generating the Consumer-Resource population dynamics graph"""

    f2 = plt.figure()
    plt.grid()
    plt.plot(pops[:,0], pops[:,1],'r-')
    plt.xlabel('Resource density')
    plt.ylabel('Consumer density')
    plt.title('Consumer-Resource population dynamics')
    box = dict(boxstyle = "Round", facecolor = "white", alpha = 0.7)
    plt.text(max(pops[:, 0]), max(pops[:, 1]), 'r=%s\nK=%s\na=%s\nz=%s\ne=%s' % (str(round(r,2)), str(round(K,2)), str(round(a,2)), str(round(z,2)), str(round(e,2))), horizontalalignment='right', verticalalignment = "top", bbox = box)
    return f2

def save_figs(f1, f2): 
    """Saving figures """
    figs = PdfPages('../results/LV_model2.pdf')
    figs.savefig(f1)
    figs.savefig(f2)
    figs.close()
    return 0

def main(argv): 
    """Main entry point of the program"""
    try:
        r = float(sys.argv[1])
        K = float(sys.argv[2])
        a = float(sys.argv[3])
        z = float(sys.argv[4])
        e = float(sys.argv[5])
    except:
        r = 1
        K = 100
        a = 0.5 
        z = 1.5
        e = 0.75
    
    def dCR_dt(pops, t=0):
        """Returns the growth rate of consumer and resource population at any given time step"""
        R = pops[0]
        C = pops[1]
        dRdt = r * R * (1 - R / K) - a * R * C
        dCdt = -z * C + e * a * R * C
        return np.array([dRdt, dCdt])

    t = np.linspace(0, 15, 1000)
    R0 = 10
    C0 = 5
    RC0 = np.array([R0, C0])
    
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    f1 = plot_f1(pops, t, r, K, a, z, e)
    f2 = plot_f2(pops, r, K, a, z, e)
    save_figs(f1, f2)
    return 0


if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)

# Define parameters:
#if len(sys.argv) == 5: # If correct number of arguments entered, take users arguments
#		r = float(sys.argv[1]) # Resource growth rate
#		a = float(sys.argv[2]) # Consumer search rate (determines consumption rate) 
#		z = float(sys.argv[3]) # Consumer mortality rate
#		e = float(sys.argv[4]) # Consumer production efficiency
#		K = float(sys.argv[5]) # (1 - R/K) is the density dependence to the resource population, K is the machanism of competitation
#	else: # Default arguments if user eters inccorect arguments
#		r = 1.3 # Resource growth rate
#		a = 0.4 # Consuption rate
#		z = 0.3 # Consumer mortality rate
#		e = 0.2 # Consumer production efficiency
#		K = 7 # K is the machanism of competitation rate

# Define timefrom 0 to 15, using 1000points:
#t = np.linspace(0, 15, 1000)
#R0 = 10
#C0 = 5 
#RC0 = np.array([R0, C0])
# initial conditions: 10 consumer and 5 recource per unit area
# numerically integrate this system forward from starting conditions:
#pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

#infodict['message']

#prey, predictor = pops.T # transposes arrays

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

##f1.savefig('../results/LV2_model_f1.pdf') #Save figure
#f2.savefig('../results/LV2_model_f2.pdf')