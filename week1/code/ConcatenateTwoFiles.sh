#!/bin/bash
# Author: ANQI WANG aw222@ic.ac.uk
# Script: Concatenate.sh
# Desc: Concatenate two files
# Arguements: 1 + 2 > 3
# Date: Oct.2022

#####################################
#cat $1 > $3
#cat $2 >> $3
#echo "Merged File is"
#cat $3
#####################################

#Improve

if [ -z "$1" ] #Check whether the first file is entered, if not,
then
    echo "Oops, seems something went wrong, please enter a valid filename to start."
elif [ -z "$2" ] #If the first file is entered, check whether the secon file is entered, if not
then 
    echo "Please enter the other filename to start."
elif [ -z "$3" ] #Check whether the output file is named, if not
then
    echo "Please give the output filename to start."
else #If all the valid filename is entered
    cat $1 > $3 #Import the first file into the concatenate file
    cat $2 >> $3 #Append the second file into the output file
    echo "Merged File is"
    cat $3 #Give the result
fi

exit
