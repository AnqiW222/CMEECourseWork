#!/bin/bash
# Author: Anqi Wang aw222@ic.ac.uk
# Script: CompileReport.sh
# Description: Bash script to run the miniproject codes and compile LaTeX, pdf output saved to ../results

# Run python scripts for data analysis
echo "Analysing the data..."
python main.py
echo "Data is ready to plot"

# Run R scripts for plotting
Rscript PlotAnalysis.R
rm Rplots.pdf

# Compile Report
echo "Compiling the report..."
pdflatex MiniProject.tex
bibtex MiniProject
pdflatex MiniProject.tex
pdflatex MiniProject.tex

# save output pdf to results
cp MiniProject.pdf ../results
rm MiniProject.pdf
echo "DONE! MINIPROJECT IS READY TO BE CHECKED IN RESULTS"

texcount MiniProject.tex

# evince ../results/BacterialGrowthModelling.pdf &

rm *.aux
rm *.log
rm *.bbl
rm *.blg
rm *.out
rm -rf ./__pycache__
