#!/usr/bin/env python3

__appname__ = 'boilerplate'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

from re import I

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# Methods 1
birds_latin_names = [i[0] for i in birds]
birds_common_names = [i[1] for i in birds]
mean_body_masses = [i[2] for i in birds]

# Methods 2
BirdsLatinNames = [x for x, y, z in birds]
BirdsCommonNames = [y for x, y, z in birds]
MeanBodyMasses = [z for x, y, z in birds]

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
LatinNames = []
CommenNames = []
MeanBodyMasses_2 = []

for i in birds:
    LatinNames.append(i[0])
    CommenNames.append(i[1])
    MeanBodyMasses_2.append(i[2])

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 