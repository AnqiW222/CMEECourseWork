# CMEE Coursework - HPC:
This README file contains details about the R and bash scripts for High Performance Computing Programming (HPC) Exercises.

## Description
More information about the HPC Exercises could be found in *****HPC worksheet 2022.pdf***** in **class_material** folder. This exercise is build up with three R files and two shell script files, and analysis the set of files produced by the successful runs of code on the HPC system to simulate the ecological models. The **aw222** folder contains all FIVE code scripts ( 1 main R script of building up models, 2 R scripts for running cluster of each models, and 2 shell scripts for running the models cluster on the HPC system), 100 .rda output result files for the Individual-based ecological neutral theory simulation and their o/e files (300 files in total), 1000 .rda output result files for the Stochastic demographic population model and their o/e files (3000 files in total). 17 .png files for model analysis plots and A-F Challenge questions plots. In addition 2 .rda files for summarised results of neutral model and for Challenge E input data. 

## Language

R, and Bash

## HPC use guidance 
For some scripts running in HPC systems in this directory, use the university internal internet to get access the system.

To put/get the files on HPC systems, using
```bash
sftp username@login.hpc.imperial.ac.uk

put/get filename.R

```

To run the cluster on HPC systems, using
```bash
ssh –l username login.hpc.imperial.ac.uk

qsub -J 1-100 run_script.sh # 1-x is the number of runs for the cluster

qstat # check the status
```

## Coding Scripts

### aw222_HPC_2022_main.R
- Contains Functions of 37 Questions and A-F Challenge Questions for two models. All questions build on one another, step by step. <br />

#### aw222_HPC_2022_neutral_cluster.R
- R file for running neutral simulations on the cluster. <br />

#### aw222_HPC_2022_demographic_cluster.R
- R file for running Stochastic demographic population model on the cluster <br />

#### run_neutral_cluster.sh
- shell script (.sh) files for running on the cluster for Individual-based ecological neutral theory simulation. <br />

#### run_demographic_cluster.sh
- shell script (.sh) files for running on the cluster for Stochastic demographic population model.<br />

##### formative_automark_2022.R
<font size=2>- code automatically test answers to some questions *(for testing purpose)* </font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>