#!/usr/bin/env python3

"""Using Subprocess to build workflow in python"""
__appname__ = 'WorkFlow_pra'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import subprocess

p = subprocess.Popen(["echo", "I'm talkin' to you, bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()
stderr

# check what in stdout
stdout
# encode and print
print(stdout.decode())

p = subprocess.Popen(["ls","-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
p = subprocess.Popen(["python3", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE) # A bit silly! 
stdout, stderr = p.communicate()

print(stdout.decode())