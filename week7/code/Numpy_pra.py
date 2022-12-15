#!/usr/bin/env python3

"""Introduction for Numpy package"""
__appname__ = 'numpy-pra'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import numpy as np

# A one-dimensional array
a = np.array(range(5))
a
print(type(a))
print(type(a[0]))

# Specify the data type of the array
a = np.array(range(5), float)
a
a.dtype #Check type

# A 1-D arrays
x = np.arange(5)
x
# Directly specify float using decimal
x = np.arange(5.)
x
# to see dimensions of x
x.shape

# Convert to and from Python lists
b = np.array([i for i in range(10) if i%2 == 1]) #odd numbers between 1 and 10
b

c = b.tolist() #convert back to list
c

# A 2-D numpy array to make a matrix
mat = np.array([[0,1],[2,3]])
mat
mat.shape

# Indexing and accessing arrays
mat[1] #accessing whole 2nd row, remember starts at 0
mat[:,1] #accessing whole second colum
mat[0,0] # 1st row, 1st colum element
mat[1,0] # 2nd row, 1st colum element
mat[:,0] #accessing whole first colum
# Python indexing acceps negative values for going back to the start from the end of an array
mat[0,1]
mat[0,-1]
mat[-1,0]
mat[0,-2]

# Manipulating arrays
# Replacing, adding or deleting elements
mat[0,0] = -1 # replace a single element
mat
mat[:,0] = [12,12] #replace whole column
mat
np.append(mat, [[12,12]], axis = 0) #append row, note axis specification
np.append(mat, [[12],[12]], axis = 1) #append column
newRow = [[12,12]] #create new row
mat = np.append(mat, newRow, axis = 0) #append that existing row
mat
np.delete(mat, 2, 0) #Delete 3rd row
#concatenation
mat = np.array([[0,1],[2,3]])
mat0 = np.array([[0,10],[-1,3]])
np.concatenate((mat, mat0), axis = 0)

# Flattening or reshaping arrays
mat.ravel()
mat.reshape((4,1))
mat.reshape((1,4))
mat.reshape((3,1)) # the total elements must remain the same

# Pre-allocating arrays
np.ones((4,2)) #(4,2) are the (row,col) array dimensions
np.zeros((4,2)) # oe zeros
m = np. identity(4)
m
m.fill(16) # fill the matrix with 16
m

# numpy matrices
# Matrix-vector operations
mm = np.arange(16)
mm = mm.reshape(4,4) #Convert to matrix
mm
mm.transpose()
mm + mm.transpose()
mm - mm.transpose()
mm * mm.transpose() # an element-wise multiplication
mm // mm.transpose() # warning of zero division
mm // (mm + 1).transpose()
mm * np.pi
mm.dot(mm) # No this is matric multiplication, or the dot product
mm = np.matrix(mm) # Convert to scipy/numpy matrix class
mm
print(type(mm))
mm * mm #instead of mm.dot(mm)
