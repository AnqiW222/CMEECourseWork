# CMEE Coursework - MiniProject:

This README file contains details about the Python, R and bash scripts for running model simulations and analysis for CMEE MiniProject.

## Description
More information about the MiniProject and Model Fitting in **The Computing Miniproject** section can be found in the Appendices and Advanced Data Ayalyses and Statistics Chapters of the book [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/notebooks/Appendix-MiniProj.html)

## Language

Python, R, Bash and LaTeX

## Dependencies
For some scripts in this directory requires [pandas](https://pandas.pydata.org), [numpy](https://numpy.org), [scipy](https://scipy.org) and [lmfit](https://lmfit.github.io/lmfit-py/), installation is required by:
```bash
pip3 install pandas, numpy, scipy, lmfit
```

For some scripts in this directory, packages [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
```R
install.packages(c("tidyverse", "ggplot2"))
```

[LaTeX](https://www.latex-project.org/) installation is required. Please run following **bash** script in Mac Terminal for installation:
```bash
brew install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```

_The installation commands are used for MacOS, may varied with the different operating system._

## Coding Scripts

### Python Scripts
#### dataPreprosessing.py
<font size=2>**Summary:** Pre-processing of 285 initial datasets.<br />
**Input:** LogisticGrowthData.csv and LogisticGrowthMetaData.csv <br />
**Dependencies:** pandas <br />
**Output:** splitData <br />

#### defineModel.py
<font size=2>**Summary:** Defining 5 models (Cubic, Logistic, Generalised Logistic, Gompetza and Hybrid Models) and calculating models AICc and BIC criterias and their weight.<br />
**Input:** NaN <br />
**Dependencies:** lmfit, pandas, numpy and scipy <br />
**Output:** fitResult and criterion <br />

#### analysisResults.py
<font size=2>**Summary:** Analysing the results of model fitting and criterions.<br />
**Input:** NaN <br />
**Dependencies:** pandas, numpy and os <br />


#### saveResults.py
<font size=2>**Summary:** Save model fitting results and critera into .csv file <br />
**Input:** NaN <br />
**Dependencies:** pandas, os <br />
**Output:** Criterion folder containing 5 .csv files for each model certerias, FitResults folder containing 61 datasets of model fitting results, and ModelPerformance results containing 5 .csv files of R^2, AICc and BIC criterias and their weight.<br />

#### main.py
<font size=2>**Summary:** Script running all python scripts and giving the final results.<br />
**Input:** NaN <br />
**Output:** Results printed in terminal and save all results into /results directory.<br />


### R Scripts
#### PlotAnalysis.R
<font size=2>**Summary:** Plotting data and model fits, visualising the analysis.<br />
**Input:** random selected .csv file from ../results/FitResults/ directory and files from results/Criterions/ directory <br />
**Dependencies:** ggplotw and reshape2 <br />
**Output:** .pdf files in /results directory <br />

#### data_preprocessing.R
<font size=2>**Summary:** Data pre-processing and initial data plotting as a start of miniproject, but not include in the final analysis.<br />
**Input:** LogisticGrowthData <br />
**Dependencies:** dplyr <br />
**Output:** ../data/modified_growth_data.csv <br />

## Writeup (LaTeX Scripts)
#### MiniProject.tex
<font size=2>**Summary:** Source code for write up PDF <br />

#### MiniProject.bib
<font size=2>**Summary:** Contains bibliography for write up  <br />

### Shell Scripts
#### CompileReport.sh
<font size=2>**Summary:** Run the project and compile the report.<br />
```bash
# run the entire miniproject
bash CompileReport.sh
```
**Output:** **"DONE! MINIPROJECT IS READY TO BE CHECKED IN RESULTS"** seen in the terminal and MiniProject.pdf<br />

## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>

