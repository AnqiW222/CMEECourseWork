#!/usr/bin/env python3

"""
Use the subprocess.os module to get a list of files and directories 
in your ubuntu home directory
"""
__appname__ = 'using_os'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for f in files:
        if f.startswith("C"):
            FilesDirsStartingWithC.append(f)
    if dir.split("/")[-1].startswith("C"):
        FilesDirsStartingWithC.append(dir.split("/")[-1])
    for sub in subdir:
        if sub.startswith("C"):
            FilesDirsStartingWithC.append(sub)

print(FilesDirsStartingWithC)
    
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithCc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    for filename in files: 
        if filename.lower().startswith("c"):
            FilesDirsStartingWithCc.append(filename)
    if dir.split("/")[-1].lower().startswith("c"):
        FilesDirsStartingWithCc.append(dir.split("/")[-1])
    for subdirectory in subdir:
        if subdirectory.lower().startswith("c"):
            FilesDirsStartingWithCc.append(subdirectory)

print(FilesDirsStartingWithCc)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
DirsStartingWithc = []

for (dir, subdir, files) in subprocess.os.walk(home):
    if dir.split("/")[-1].lower().startswith("c"):
        DirsStartingWithc.append(dir.split("/")[-1])
    for subdirectory in subdir:
        if subdirectory.lower().startswith("c"):
            DirsStartingWithc.append(subdirectory)

print(DirsStartingWithc)
