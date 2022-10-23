#!/usr/bin/env python3

__appname__ = 'cfexercises1'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

import sys

def foo_1(x):
    """define a function that return the square root of x"""
    return x ** 0.5

def foo_2(x,y):
    """define a function contains two arguement x and y, and return the bigger number"""
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    """define a function contains three arguments x, y and z, and made the biggest number to end the sequence"""
    if x > y:
        tmp = y # tmp refers to the space to store the tuple during the swap
        y = x
        x = tmp
    if y > z:
        tmp = y
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    """define a function calculte the factorial of x"""
    result = 1
    for i in range(1, x+1):
        result = result * i
    return  result

def foo_5(x):
    """define a recursive function when x==1"""
    if x == 1:
        return 1
    return x * foo_5(x -1) # runs as a loop untile x=1, then return the value step by step back to the order

def foo_6(x):
    """define a factorial function"""
    facto =1 # Set the variables =1
    while x >= 1: # run the loops when x is greater and equal to 1
        facto = facto * x # multiplies the current iteration by the previous one
        x = x - 1 # Remove one from the x to continues down the loops
    return facto #Once the loop reached to 1, the value of facto will be returned 

def main(argv):
    print(f'The square root of 10 is: {foo_1(10)} ')
    print(f'The bigger number between 7 and 12 is: {foo_2(7, 12)}')
    print(f'The modified sequence of 77, 100 and 3 with the largest number at the end is: {foo_3(77, 100, 3)}')
    print(f'The factorial of 5 is:{foo_4(5)}')
    print(f'The factorial of 6 is:{foo_5(6)}')
    print(f'The factorial of 7 is:{foo_6(7)}')
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)