#!/usr/bin/env python3

"""Using python script runing R code"""
__appname__ = 'TestR'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import subprocess
p = subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait
subprocess.Popen("Rscript --verbose NonExistScript.R > ../results/outputFile.Rout 2> ../results/errorFile.Rout", shell=True).wait()

# Handling directory and file paths
subprocess.os.path.join('directory', 'subdirectory', 'file')
MyPath = subprocess.os.path.join('directory', 'subdirectory', 'file')
MyPath