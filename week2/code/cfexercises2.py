#!/usr/bin/env python3

"""Examples of loops and conditionals combined"""
__appname__ = 'cfexercises2'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import sys

###########################
def hello_1(x):
    """For each number from 0, prints hello for numbers up to x which are divisible by 3"""
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ') 
#hello_1(12)

###########################
def hello_2(x):
    """for each number from 0 to x-1, if meet the requirement, print 'hello'"""
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

#hello_2(12)

###########################
def hello_3(x,y):
    """Print hello when the number is in range (x, y)"""
    for i in range(x,y):
        print('hello')
    print(' ')

#hello_3(3,17)

##########################
def hello_4(x):
    """For each number from 0 to x-1, print hello, and add 3 until it reached 15"""
    while x != 15:
        print('hello')
        x = x +3
    print('')

#hello_4(0)

#########################
def hello_5(x):
    """for each number from 0 to x-1, print 'hello' under conditions"""
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print ('hello')
        x = x +1
    print('')

#hello_5(12)

###########################
# WHILE loop with BREAK
def hello_6(x,y):
    """for each number form x to y, print 'hello + str(y), and add 1 into y until y=6"""
    while x: # while x is True
        print("hello!" + str(y))
        y += 1 # increment y by 1
        if y == 6:
            break
    print('')

#hello_6 (True, 0)

##################################
def main(argv):
    """Main entry point of the program"""
    hello_1(12)
    hello_2(12)
    hello_3(3, 17)
    hello_4(0)
    hello_5(12)
    hello_6(True, 0)
    return 0

if __name__ == "__main__":
    status = main(sys.argv) 
    sys.exit(status) 