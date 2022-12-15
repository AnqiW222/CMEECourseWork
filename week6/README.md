# CMEE Coursework - week 4:

This README file contains details about the scripts from in-classwork and practicals for the forth week.

## Description
Genomics and Bioinformatics. Four R scripts exploring different aspects of genomics and bioinformatics; these scripts manipulate and analyse genomics data from the data directory. The results directory will be populated by running the code files. More information about the R scripts and Biological Satistics could be found in [Lecture_Material](https://github.com/AnqiW222/CMEECourseWork/tree/main/week6/Lecture_Material)

## Language

R

## Dependencies
For some scripts in this directory, packages [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [dplyr](https://cran.r-project.org/web/packages/dplyr/), and [vegan](https://cran.r-project.org/web/packages/vegan/index.html). 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("ggplot2", "dplyr", "vegan"))
```

_The installation commands are used for MacOS, may varied with the different operating system._

## In-class Practicals 

#### prac1_allele_genotype_freq.R
<font size=2>**Summary:** Allele and genotype frequencies: manually calculating allele and genotype frequencies, and testing for Hardy Weinberg equilibrium in R. Saves summary data to */results/bear_polymorphisms.csv*. <br /><br /></font>

#### prac2_drift_muti_divergence.R
<font size=2>**Summary:** Genetic drift, mutation and divergence: using the molecular clock concept to calculate time since divergence in gecko species. <br /><br /></font>

#### prac3_coalescence.R
<font size=2>**Summary:** Coalescence theory: estimating effective population size of killer whale populations using Watterson's and Tajima's estimators; calculating and plotting site frequency spectrum. <br /><br /></font>

#### prac4_demography.R
<font size=2>**Summary:** Population subdivision and demographic inferences: inferring population structure and assessing isolation by distance in sea turtle populations using FST, a PCA and a dendogram. <br /><br /></font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>