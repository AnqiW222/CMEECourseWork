#!/bin/bash
# Author: Anqi Wang aw222@ic.ac.uk
# Script: csvtospace.sh
# Description: Shell script exercise of converting a comma separated values.csv file to a space separated values.txt
#
# Arguments: comma delimited.csv file
# Date: Oct 10th 2022

if [ -e "$1" ] #if there is an input .csv file 
then
    echo "Converting the space separed version .txt file..."
    # output="../results/${1%.csv}.txt"
    output="../results/${1%.csv}.txt"
    cat $1 | tr -s "," " " >> $output
    mv $output ../results
    echo "Done!"
else
    echo "Please provide a file to process"
fi
    