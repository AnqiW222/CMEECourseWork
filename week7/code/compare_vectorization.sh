#!/bin/sh
# Author: Jooyoung Ser (jooyoung.ser19@imperial.ac.uk), Elliott Parnell (elliott.parnell22@imperial.ac.uk), Anqi Wang (anqi.wang22@imperial.ac.uk), Linke Feng (l.feng22@imperial.ac.uk)
# Script: compare_vectorization.sh
# Desc: A script that runs vectorize1.py, vectorize2.py, vectorize1.R and vectorize2.R, then compares speeds
# Arguments: none
# Date: 17/11/2022

#Running python scripts
echo "Running the python Vectorize 1  script"
python3 ../code/vectorize1.py

echo ""
echo "Running the python Vectorize 2  script"
python3 ../code/vectorize2.py
#python3 ../code/vectorize2.py

echo ""
#Running R scripts
echo "Running the R Vectorize 1  script"
Rscript ../code/vectorize1.r

echo ""
echo "Running the R Vectorize 2  script"
Rscript ../code/vectorize2.r

#!/usr/bin/env R

