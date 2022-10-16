#!/bin/bash
# Author: ANQI WANG aw222@ic.ac.uk
# Script: CountLines.sh
# Desc: Count the lines of the file

# Arguements: none
# Date: Oct.2022

##########################################
#NumLines=`wc -l < $1`
#echo "The file $1 has $NumLines lines"
#echo
###########################################

# Improving
if [ -!f "$1"] #if there is no input file
then
    echo "Please choose a valid file to start"
fi

if [ -f "$1" ] #if there is an input .csv file 
then
    echo "Counting..."
    NumLines=`wc -l < $1`
    echo "The file $1 has $NumLines lines"
    echo "Done!"
fi