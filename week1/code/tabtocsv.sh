#!/bin/sh
#Author: ANQI WANG. aw222@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas

# Saves the output into a .csv file
# Arguements: 1 -> tab delimited file
# Date: 5 Oct 2022

echo "Creating a comma deimited version of$1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit