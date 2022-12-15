#!/usr/bin/env python3

"""Demonstrating how __name__ works"""

__appname__ = 'using_name'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from another script/program/module!')

print("This module's name is: " + __name__)