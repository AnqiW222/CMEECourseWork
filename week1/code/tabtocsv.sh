#!/bin/sh
#Author: ANQI WANG. aw222@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas

# Saves the output into a .csv file
# Arguements: 1 -> tab delimited file
# Date: 5 Oct 2022

####################################################Origin
#echo "Creating a comma deimited version of $1 ..."
#cat $1 | tr -s "\t" "," >> $1.csv
#echo "Done!"
#exit
####################################################

#Improve

#################################################### Test example
#if [ -z $1 ]
#then 
#    echo " Oops, something goes wrong, please enter a file to begin "
#fi
#
#else
#    if [ -n $1 ]
#    then 
#    echo "Creating a comma demited version of $1 ..."
#    cat  $1 | tr -s "\t" "," >> $1.csv
#    fi
#
#echo "The file is ready to view"
#
#fi
##################### Run error due to the incorrect format of using elif


if [ -z $1 ]
then 
    echo " Oops, something goes wrong, please enter a file to begin "
else 
    echo "Creating a comma demited version of $1 ..."
    cat  $1 | tr -s "\t" "," >> ${1%txt}csv

echo "The file is ready to view"

fi