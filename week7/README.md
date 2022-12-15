# CMEE Coursework - week 7:

This README file contains details about the scripts from in-classwork and practicals for the seventh week.

## Description
More information about the R scripts and programs for coursework in **Biological Computing in Python** section of the Computing Chapter and **Introduction to Jupyter** and **Data analyses with Python & Jupyter** sections of APPENDICES Chapter of [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/notebooks/06-Python_II.html)

## Language

Python, R, bash

_Using IDE: Jupyter Notebook/Lab_

## Dependencies
For some scripts in this directory, packages [SciPy](https://scipy.org), [NumPy](https://numpy.org), [matplotlib.pylab](https://matplotlib.org/stable/tutorials/introductory/pyplot.html), [csv](https://docs.python.org/3/library/csv.html), [networkx](https://networkx.org/documentation/stable/tutorial.html), [sys](https://docs.python.org/3/library/sys.html), [doctest](https://docs.python.org/3/library/doctest.html), [subprocess](https://docs.python.org/3/library/subprocess.html), [timeit](https://docs.python.org/3/library/timeit.html), and [time](https://docs.python.org/3/library/time.html) are required. 
Please run the following script in **python3/ipython** for package installation: 
```python3
pip3 install (c("SciPy", "NumPy", "matplotlib.pylab", "networkx", "csv", "sys", "doctest", "subprocess", "timeit", "time"))
```
*****NOTE***** *!!! Not all packages need to be install, variables in environmets!!!*

_The installation commands are used for MacOS, may varied with the different operating system._

## Individual Practicals 

### Python Scripts
-----------
#### DrawFW.py
<font size=2>**Summary:** Plot a food web network and save into .pdf file.<br />
**Input:** n/a <br />
**Dependencies:** NumPy, SciPy, matplotlib.pylab, networkx <br />
**Output:** Result shows as a figure.<br />
**Running Instructions:** 
```bash
python3 DrawFW.py 
```
</font><font size=1>
*****NOTE:***** *Might get a warning. In that case, try upgrading the networkx package.*
</font>


#### LV1.py
<font size=2>**Summary:** Numerical integration for solving classical models in biology. Return growth rate of consumer and resource population at any given time step and produce relevant figures.<br />
**Input:** n/a <br />
**Dependencies:** NumPy, SciPy, matplotlib.pylab <br />
**Output:** Result saves to */results/LV_model.pdf*.<br />
**Running Instructions:** 
```bash
python3 LV1.py 
```
</font>

#### LV2.py
<font size=2>**Summary:** The Consumer population C goes extinct in the Lotka-Volterra Model.<br />
**Input:** n/a <br />
**Dependencies:** NumPy, SciPy, matplotlib.pylab <br />
**Output:** Result saves to */results/LV_model2.pdf*.<br />
**Running Instructions:** 
```bash
python3 LV2.py 
```
</font>

#### Numpy_pra.py
<font size=2>**Summary:** Introduction and practical to basic NumPy package.<br />
**Input:** n/a <br />
**Dependencies:** NumPy <br />
**Running Instructions:** Running line by line in *ipython*</font>

#### profileme.py
<font size=2>**Summary:** An illustrstive program to slow down the code.<br />
**Input:** n/a <br />
**Output:** Result prints in terminal.<br />
**Running Instructions:** 
```bash
python3 profileme.py 
```
</font>

#### profileme2.py
<font size=2>**Summary:** Alternative approach to write an illustrstive program slowing down the code.<br />
**Input:** n/a <br />
**Output:** Result prints in terminal.<br />
**Running Instructions:** 
```bash
python3 profileme2.py 
```
</font>

#### run_fmr_R.py
<font size=2>**Summary:** Using subprocess to run a R script.<br />
**Input:** n/a <br />
**Dependencies:** subprocess <br />
**Output:** *fmr.R* contents prints in terminal.<br />
**Running Instructions:** 
```bash
python3 run_fmr_R.py 
```
</font>

#### runLV.py
<font size=2>**Summary:** Runs both LV1.py and LV2.py with appropriate arguments.<br />
**Input:** n/a <br />
**Dependencies:** SciPy, matplotlib.pylab <br />
**Output:** *LV1.py* and *LV2.py* results show as figures, timeconsuming for both scripts prints in terminal.<br />
**Running Instructions:** 
```bash
python3 runLV.py 
```
</font>

#### Scipy_pra.py
<font size=2>**Summary:** Introduction and practical to basic SciPy package.<br />
**Input:** n/a <br />
**Dependencies:** SciPy, matplotlib.pylab <br />
**Running Instructions:** Running line by line in *ipython*</font>

#### TestR.py
<font size=2>**Summary:** Using python script runing R code.<br />
**Input:** n/a <br />
**Dependencies:** subprocess <br />
**Output:** *TestR.R* contents prints in terminal.<br />
**Running Instructions:** 
```bash
python3 TestR.py 
```
</font>

#### timeitme.py
<font size=2>**Summary:** Using *timeit* module to test part of *profileme.py* and *profileme2.py*.<br />
**Input:** n/a <br />
**Dependencies:** timeit, time <br />
**Output:** *profileme.py* and *profileme2.py* results and timeconsuming for both scripts prints in terminal.<br />
**Running Instructions:** 
```bash
python3 timeitme.py 
```
</font>

#### using_os.py
<font size=2>**Summary:** Use the *subprocess.os* module to get a list of files and directories 
in a selected ubuntu home directory.<br />
**Input:** n/a <br />
**Dependencies:** subprocess <br />
**Output:** Results prints in terminal.<br />
**Running Instructions:** 
```bash
python3 using_os.py 
```
</font>

#### vect_example.py
<font size=2>**Summary:** Example of Vectorization revistied of calculating two simple 1D arrays.<br />
**Input:** n/a <br />
**Dependencies:** NumPy, matplotlib.pylab, timeit, ipdb <br />
**Running Instructions:** Running line by line in *ipython*</font>

#### workFlow_pra.py
<font size=2>**Summary:** Using Subprocess to build workflow in Python.<br />
**Input:** n/a <br />
**Dependencies:** subprocess <br />
**Running Instructions:** Running line by line in *ipython*</font>

### R Scripts
-----------
#### fmr.R
<font size=2>**Summary:** The R script contains ploting of log(field metabolic rate) against log(body mass) for the Nagy et al. Used as the tested R scirpt of *****run_fmr_R.py***** <br /></font>

#### testR.R
<font size=2>**Summary:** The tested R scirpt of *****TestR.py***** <br /></font>

### Jupyter Notebook
-----------
#### MyFirstJupyterNb.ipynb
<font size=2>**Summary:** The first practice of basic Jupyter Notebook key elements and Data analyses with Python & Jupyter. <br />
**Dependencies:** *****Python:***** NumPy, pandas, SciPy, matplotlib.pylab; *****R:***** ggplot2, repr <br /></font>

## Groupwork Practicals -- 02_Booming_Bonobos
Cover 1 groupwork practicals:
- [Compare R and Python vectorization](https://mhasoba.github.io/TheMulQuaBio/notebooks/06-Python_II.html#groupwork-practical-compare-r-and-python-vectorization)

#### Vectorize1.py
<font size=2>**Summary:** python version of Vectorize1.R. <br /></font>

#### Vectorize2.py
<font size=2>**Summary:** python version of Vectorize2.R. <br /></font>

#### compare_vectorization.sh
<font size=2>**Summary:** Compare the computational speed of four scripts(Vectorize1.R Vectorize2.R Vectorize1.py Vectorize1.py) <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
bash compare_vectorization.sh
```
</font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>







