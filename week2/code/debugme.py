#!/usr/bin/env python3

"""Testing the debugging: originally prodeced ZeroDivisionError;
using ipdb.set_trace() to debug and catch errors with 'try' and 'except' statement"""

__appname__ = 'debugme'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

# Using ipdb.set_trace() to identify the errors
def buggyfunc(x):
    """Original buggyfunction to test the bugs using %pdb"""
    y = x
    # import ipdb; ipdb.set_trace()
    # import pdb; pdb.set_trace()
    for i in range(x):
        y = y-1
        z = x/y
    return z

buggyfunc(20)

# in terminal run: %run debugme.py and expected a ZeroDivisionError

#%pdb
#run debugme.py

# Expand the function
def buggyfunc(x):
    """Expand the fuction by print the result of bugs, shown the bug within the program"""
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except:
            print(f"This didn't work;{x = };{y = }")
    return z

buggyfunc(20)

def buggyfunc(x):
    """catch specific types of errors using 'try' and 'except' block"""
    y = x
    for i in range(x):
        try: 
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z

buggyfunc(20)