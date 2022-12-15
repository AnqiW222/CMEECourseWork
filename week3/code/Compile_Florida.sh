#!/bin/bash
# Author: ANQI WANG aw222@ic.ac.uk
# Script: Compile_Florida.sh
# Description: Bash script to compile Florida.tex LaTeX, pdf output
# Arguments: 0 (specific for Florida.tex)

# run R script, graphics will be saved to results directory - used in .tex
Rscript Florida.R

# Compile the LaTeX
pdflatex Florida.tex
pdflatex Florida.tex
#pdflatex Florida.tex

# no required biblioraphy for this .tex

rm *.aux
rm *.log
rm *.synctex.gz