#!/usr/bin/env python3

"""Examples of comprehensions"""
__appname__ = 'oaks'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

## Finds just those taxa that are oak trees  from a list of species

taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraes',
        ]

def is_an_oak(name):
    """returns only oak species, those that start with 'quercus'"""
    return name.lower().startswith('quercus ')

## Using fo loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

## Using List comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

## Get names in UPPER CASE using for loops
oaks_loops = set ()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

## get names in Upper CASe using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)