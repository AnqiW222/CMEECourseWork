#!/usr/bin/env python3

"""File input and improved using 'with' statement, 
print the lines of input lines and clear the blank lines."""

__appname__ = 'basic_io1'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

#############################
# FILE INPUT
#############################

## Simple sample ##
# Open a file for reading

#f = open('../sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
#for line in f:
#    print(line)

# close the file
#f.close()

#Same example, skip blank lines
#f = open('../sandbox/test.txt', 'r')
#for line in f:
#    if len(line.strip()) > 0:
#        print(line)

#f.close()
########################################################

# Rewritten using 'with' statement
with open('../sandbox/test.txt', 'r') as f:
    # use "implicit" for loop:
    # if the object is a file, python will cycle over lines 
    for line in f:
        print(line)

# Once you drop out of the with, the file is automatically closed

# Same example, skip blank lines
with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)
