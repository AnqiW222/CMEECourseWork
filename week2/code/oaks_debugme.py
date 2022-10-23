#!/usr/bin/env python3

__appname__ = 'oaks_debugme'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

import csv
import sys
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak('Fraxinus excelsior')
    False
    >>> is_an_oak('Pinus sylvestris')
    False
    >>> is_an_oak('Quercus cerris')
    True
    >>> is_an_oak('Quercus petraea')
    True
    >>> is_an_oak('quercus petraea')
    True
    >>> is_an_oak('quercusss petraea')
    True
    >>> is_an_oak('QuercusPetraea')
    True
     """
    # use startswith() to catch bugs in spelling/spacing
    return name.lower().startswith('quercus')

def main(argv): 
    #import ipdb; ipdb.set_trace()
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

doctest.testmod()  # runs embedded doctests