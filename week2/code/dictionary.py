#!/usr/bin/env python3

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia'),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocßephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. OR, 'Chiroptera': {'Myotis
#  lucifugus'} ... etc

#### Your solution here #### 
#del(dict)
#taxa_dic = dict(taxa)


# Method 1
taxa_dic = {}
# j = 0
for i in taxa:
        taxa_dic.setdefault(i[1],set()).add(i[0])
        # print(j)
        # j += 1
        # print(taxa_dic)
print(taxa_dic)

# Method 2
taxa_dic_dc = {x[1]: set([y[0] for y in taxa if y[1] == x[1]]) for x in taxa}

    

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
#{x[1]: [[y[0] for y in taxa if ] for x in taxa} 

#### Your solution here #### 
