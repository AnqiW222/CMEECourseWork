#!/usr/bin/env python3

"""Using subprocess to run a R script"""
__appname__ = 'run_fmr_R'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

import subprocess

# Method 1
#p1 = subprocess.Popen("Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout", shell=True).wait
#subprocess.Popen("Rscript --verbose NonExistScript.R > ../results/outputFile.Rout 2> ../results/errorFile.Rout", shell=True).wait()
#return(p1)

# Method 2
subprocess.call(["Rscript", "fmr.R"])

p2 = subprocess.Popen(["Rscript", "fmr.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
output, error = p2.communicate()
if p2.returncode != 0: 
   print("\nUnsuccessful!\n %d Error occurred:\n %s" % (p2.returncode, error.decode()))