#!/usr/bin/env python3

"""Print out lists cotaining infor of birds (latin names, common names, and body masses) from a tuple"""

__appname__ = 'tuple'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by
# species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis Common name: Savannah sparrow Mass: 18.7
# ... etc.

for x in birds:
    print("latin name:", x[0], "; common name:", x[1], "; mass:", x[2])