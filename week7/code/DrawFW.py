#!/usr/bin/env python3

"""
Plot a food web network and save into .pdf file

Needs: Adjacency list of who eats whom (consumer name/id in 1st 
	column, resource name/id in 2nd column), and list of species 
	names/ids and properties such as biomass (node abundance), or average 
	body mass. 
"""
__appname__ = 'DrawFW'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

# The best way to store a food web dataset is as an “adjacency list” of who eats whom: 
# a matrix with consumer name/id in 1st column, and resource name/id in 2nd column, 
# and a separate matrix of species names/ids and properties such as biomass (node’s abundance), or average body mass. 

# Import the required packages
import networkx as nx
import scipy as sc
import numpy as np
import matplotlib.pylab as plt

# generate a “synthetic” food web
def GenRdmAdjList(N = 2, C = 0.5):
    """ 
    A random adjaceny list of a N-species food web with 'connectance probability'
    C: the probability of having a link between any pair of species in the food web
    to calculate the 'synthenic' food web
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if np.random.uniform(0,1,1) < C:
            Lnk = np.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
                ALst.append(Lnk)
    return ALst


# Assign number of species(MaxN) and connectance (C)
MaxN = 30
C = 0.75

# Generate an adjacency list representing a random food web
AdjL = np.array(GenRdmAdjList(MaxN, C))
#AdjL

# Generate species (node) data
Sps = np.unique(AdjL) # get species ids

# Generate body sizes for the species, species body sizes tend to be log-normally distributed,
# log-transformation is required
SizRan = ([-10,10]) #use log10 scale
Sizs = np.random.uniform(SizRan[0],SizRan[1],MaxN)
#Sizs

# Visualize the size distribution we have generated
plt.hist(Sizs) #log10 scale
#plt.show()

plt.hist(10 ** Sizs) #raw scale
#plt.show()

# Plot the network, with node sizes proportional to (log) body size
plt.close('all') # close all open plot objects

# use a circular configuration with netwoekx
pos = nx.circular_layout(Sps)

# Generate a networkx graph object
G = nx.Graph()
# Add the nodes and links (edges) to it
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))

# Generate node sizes that are proportional to (log) body sizes
NodSizs= 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) 
# Render (plot) the graph
nx.draw_networkx(G, pos, node_size = NodSizs)

# Or
#NodSizs= 10**-32 + (Sizs-min(Sizs))/(max(Sizs)-min(Sizs)) #node sizes in proportion to body sizes
#nx.draw(G, pos, node_size = NodSizs*1000)