#!/usr/bin/env python3

# The Lotka - Volterra model running code
"""Runs both LV1.py and LV2.py with appropriate arguments"""
__appname__ = 'runLV'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

from LV1 import main as lv1run
from LV2 import main as lv2run
import cProfile
import pstats

lv1run([])
lv2run([1,5000,0.5,1.5,0.75])

prof = cProfile.Profile() #creating a new profile

prof.enable() #enabling the profile
lv1run([]) #run the program for profiling 
prof.disable() #disabling the profile
ps = pstats.Stats(prof)
ps.sort_stats('cumtime').print_stats(15)   # Sort by cumulative time spent in the function

prof.enable()
lv2run([])
prof.disable()
ps = pstats.Stats(prof)
ps.sort_stats('cumtime').print_stats(15)   # Sort by cumulative time spent in the function
