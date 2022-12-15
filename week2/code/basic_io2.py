#!/usr/bin/env python3

"""File output, create a .txt file cotaining numbers from 0 to 99"""
__appname__ = 'basic_io2'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

####################################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()