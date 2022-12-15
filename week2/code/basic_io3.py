#!/usr/bin/env python3

"""Storing Objects for later use, write a binary file containing the contents of a dictionary, 
read the file and print its contents"""
__appname__ = 'basic_io3'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

#############################
# STORING OBJECTS
#############################
# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../sandbox/testp.p', 'wb')
pickle.dump(my_dictionary, f)
f.close()

# Load the data again
f = open('../sandbox/testp.p','rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)