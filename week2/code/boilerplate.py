#!/usr/bin/env python3

__appname__ = 'boilerplate'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

import sys

def main(argv):
    """ Main entry point of the program """
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """ Make sure the "main" function is called from command line """
    status = main(sys.argv)
    sys.exit(status)

if (__name__ == "__main__"):
    def main(argv):
    print('This is a boilerplate') # NOTE: indented using two tabs or four spaces
    sys.exit(status)
        