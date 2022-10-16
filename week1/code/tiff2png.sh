#!/bin/bash
# Author: ANQI WANG aw222@ic.ac.uk
# Script: tiff2png.sh
# Desc: Convert tiff to png
# Arguements: none
# Date: Oct.2022

#################################################
#for f in *.tiff
#   do
#        echo "Converting $f";
#        convert "$f" "$(basename "$f".tif).png";
#   done
#################################################

#Improve

if [ -z "$1" ] #Check whether there is a input file, if not
then
    echo "Oops, seems something went wrong, please enter a valid file to start."
else
    for f in $1/*.tiff
        do
            echo "Converting $f";
            convert "$f" "$(basename "$f".tif).png";
        done
    
fi

exit