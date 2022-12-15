#!/usr/bin/env python3

"""Docstring describes operation of the script, serves as documentation for the code"""
# use to access docstrings at run time
__appname__ = 'boilerplate'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import sys

def main(argv):
    """ Main entry point of the programm"""
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """ Make sure the "main" function is called from command line """
    status = main(sys.argv)
    sys.exit(status)
  # sys.exit("EXITING . . .")  

#if (__name__ == "__main__"):
#    def main(argv):
#    print('This is a boilerplate') # NOTE: indented using two tabs or four spaces
#    sys.exit(status)
        