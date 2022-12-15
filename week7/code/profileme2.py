#!/usr/bin/env python3

"""
Alternative approach to write an illustrstive program slowing down the code

Try: run -p profileme2.py or,
     run -s cumtime -p profileme2.py (to order by cumulative time)
"""
__appname__ = 'profileme2'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

def my_squares(iters):
    """Takes a number, returns the squares of the numbers up to this number in a list"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """
    Takes a number, iters, and a string; 
    returns a new string which contains the orginal string repeated iters times, 
    each spearated by a comma and space
    """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """
    Takes a number and string; passes these to my_squares() and my_join().
    When finished, returns 0
    """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")
