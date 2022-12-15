#!/usr/bin/env python3

# The Lotka - Volterra model
"""Example of Vectorization revistied of calculating two simple 1D arrays"""
__appname__ = 'Vect_example'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import numpy as np
import matplotlib.pylab as plt
import timeit

def loop_product(a, b):
    """Calculate the entrywise product of two 1D arrays of the same length"""
    N = len(a)
    c = np.zeros(N)
    for i in range(N):
        c[i] = a[i] * b[i]   
    return c

def vect_product(a, b):
    """A vectorized implementation of the elementwise product of the function loop_product"""
    return np.multiply(a, b)

# Comparing the runtimes of loop_product and vect_product

array_lengths = [1, 100, 10000, 1000000, 10000000]
t_loop = []
t_vect = []

for N in array_lengths:
    print(f"\nSet {N=}")
    #randomly generate our 1D arrays of length N
    a = np.random.rand(N)
    b = np.random.rand(N)
    
    # time loop_product 3 times and save the mean execution time.
    timer = timeit.repeat('loop_product(a, b)', globals=globals().copy(), number=3)
    t_loop.append(1000 * np.mean(timer))
    print(f"Loop method took {t_loop[-1]} ms on average.")
    
    # time vect_product 3 times and save the mean execution time.
    timer = timeit.repeat('vect_product(a, b)', globals=globals().copy(), number=3)
    t_vect.append(1000 * np.mean(timer))
    print(f"vectorized method took {t_vect[-1]} ms on average.")

#import ipdb; ipdb.set_trace()
plt.figure()
#breakpoint()
plt.plot(array_lengths, t_loop, label="loop method")
plt.plot(array_lengths, t_vect, label="vect method")
#breakpoint()
plt.xlabel("Array length")
plt.ylabel("Execution time (ms)")
plt.legend()
plt.show()

# When there is bigger memory errors:
N = 1000000000

a = np.random.rand(N)
b = np.random.rand(N)
c = vect_product(a, b)

# if no error, remove a, b, c from memory.
del a
del b
del c
