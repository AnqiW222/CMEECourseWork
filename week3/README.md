# CMEE Coursework - week 3:

This README file contains details about the scripts from in-classwork and practicals for the third week.

## Description
More information about the R scripts and programs for coursework in **Biological Computing in R** section of the Computing Chapter and **Data Management and Visualization** section of Basic Data Analysis and Statistics Chapter of [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/notebooks/07-R.html)

## Language

R, LaTex, Bash, Python

## Dependencies
For some scripts in this directory, packages [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [maps](https://cran.r-project.org/web/packages/maps/index.html), [dplyr](https://cran.r-project.org/web/packages/dplyr/) and [sqldf](https://cran.r-project.org/web/packages/sqldf/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("tidyverse", "ggplot2", "reshape2", "maps", "dplyr", "sqldf"))
```

[LaTeX](https://www.latex-project.org/) installation is also required. Please run following **bash** script in Terminal for installation:
```bash
brew install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```

_The installation commands are used for MacOS, may varied with the different operating system._

## Individual Practicals 
### Biological Computing in R:

#### apply1.R:
<font size=2>**Summary:** Applying a function to the rows or columns of a matrix.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript apply1.R 
```
</font>

#### apply2.R:
<font size=2>**Summary:** Using apply to define own functions. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal <br />
**Running Instructions:** 
```bash
Rscript apply2.R 
```
</font>

#### basic_io.R:
<font size=2>**Summary:** A simple script to illustrate R input-output and the use of read() and write() functions. <br />
**Input:** n/a <br />
**Output:** Result saves to */results/MyData.csv*. <br />
**Running Instructions:** 
```bash
Rscript basic_io.R 
```
</font>

#### boilerplate.R:
<font size=2>**Summary:** boilerplate R script.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal. <br />
**Running Instructions:** 
```bash
Rscript boilerplate.R
``` 
</font>

#### break.R:
<font size=2>**Summary:** R loop demonstration. <br />
**Input:** n/a <br />
**Output:** Results prints to terminal. <br />
**Running Instructions:** 
```bash
Rscript break.R
```
</font>

#### browse.R:
<font size=2>**Summary:** sing the browser() function to debug by examining local variables.<br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript browse.R 
```
</font>

#### control_flow.R:
<font size=2>**Summary:** Demonstrating control flow tools. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript control_flow.R 
```
</font>

#### Florida.R:
<font size=2>**Summary:** Calculates correlation coefficient between temperature and time for the 20th century in Key West, Florida and uses a permutation analysis to calculate the P-value.<br />
**Input:** */data/KeyWestAnnualMeanTemperature.RData* <br />
**Dependencies:** tidyverse <br />
**Output:** Result prints to terminal and saves figures in */results*.<br />
**Running Instructions:** 
```bash
Rscript Floria.R 
```
</font>

#### next.R:
<font size=2>**Summary:** using 'next' to skip to next iteration of for loop. Only prints odd numbers <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript next.R 
```
</font>

#### preallocation.R:
<font size=2>**Summary:** Compares times of pre-allocation to no pre-allocation. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript preallocation.R 
```
</font>

#### R_conditionals.R:
<font size=2>**Summary:** Functions with conditionals examples. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript R_conditionals.R 
```
</font>

#### Ricker.R:
<font size=2>**Summary:** Plots the ricker model. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript Ricker.R 
```
</font>

#### sample.R:
<font size=2>**Summary:** Explains sys.argv in a practical way. <br />
**Input:** n/a <br />
**Output:** n/a <br />
**Running Instructions:** 
```bash
Rscript sample.R 
```
</font>

#### TreeHeight.R:
<font size=2>**Summary:** alculating heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula. <br />
**Input:** */data/trees.csv* <br />
**Output:** Result saves to */results/TreeHts.csv*.<br />
**Running Instructions:** 
```bash
Rscript TreeHeight.R 
```
</font>

#### try.R:
<font size=2>**Summary:** illustrates try. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript try.R 
```
</font>

#### Vectorize1.R:
<font size=2>**Summary:** Sums all elements of a matrix. Compares sum() and a sum function. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript Vectorize1.R 
```
</font>

#### Vectorize2.R:
<font size=2>**Summary:** Vectorizes the ricker model and adds fluctuation <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript Vectorize2.R 
```
</font>

#### *****LaTeX and its compile for Florida.R*****

#### Florida.tex:
<font size=2>**Summary:** LaTeX code writeup file for results and their interpretation from Florida.R <br /></font>

#### Compile_Florida.sh
<font size=2>**Summary:** Shell script to compile Florida.tex <br />
**Input:** n/a <br />
**Output:** Create a pdf document and saved in */code/Florida.pdf*.<br />
**Running Instructions:** 
```bash
bash Compile_Florida.sh
```
</font>

### Data Management and Visualization:

#### DataWrang.R:
<font size=2>**Summary:** Examples of loops and conditionals combined. <br />
**Input:** PoundHillData.csv, PoundHillMetaData.csv from /data. <br />
**Dependencies:** reshape2 <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript DataWrang.R 
```
</font>

#### DataWrangTidy.R:
<font size=2>**Summary:** Wrangling the pound hill dataset using tidyverse. <br />
**Input:** */data/PoundHillData.csv, PoundHillMetaData.csv* <br />
**Dependencies:** tidyverse <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** 
```bash
Rscript DataWrangTidy.R 
```
</font>

#### ggthemes.R:
<font size=2>**Summary:** Introduction of ggthemes which could provides some additional geoms, scales, and themes for ggplot. <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** Result saves to */results/MyBars.pdf* as a figure. <br />
**Running Instructions:** 
```bash
Rscript ggthemes.R 
```
</font>

#### Girko.R:
<font size=2>**Summary:** Plotting two dataframes together. <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** Result saves to */results/Girko.pdf* as a figure (the plot prints in the view window).<br />
**Running Instructions:** 
```bash
Rscript Girko.R 
```
</font>

#### GPDD_Data.R:
<font size=2>**Summary:** apping the Global Population Dynamics Database (GPDD) with [maps](https://cran.r-project.org/web/packages/maps/index.html). <br />
**Input:** */data/GPDDFiltered.RData* <br />
**Dependencies:** maps, ggplot2, mapdata
**Output:** Result saves to */results/worldmap.pdf*. <br />
**Running Instructions:** 
```bash
Rscript GPDD_Data.R 
```
</font>

#### MyBars.R:
<font size=2>**Summary:** Annotating a plot. <br />
**Input:** */data/Results.txt* <br />
**Dependencies:** ggplot2 <br />
**Output:** Result saves to */results/MyBars.pdf* as a figure (the plot prints in the view window).<br />
**Running Instructions:** 
```bash
Rscript MyBars.R 
```
</font>

#### PlotLin.R:
<font size=2>**Summary:** Annotates a linear regression plot <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** Result saves to */results/MyLinReg.pdf* as a figure (the plot prints in the view window). <br />
**Running Instructions:** 
```bash
Rscript PlotLin.R 
```
</font>

#### PP_Dists.R:
<font size=2>**Summary:** Creating three figures, each containing subplots of distributions of predator mass, prey mass, and the size ratio of prey mass over predator mass by feeding interaction type. And calculating the mean and median log predator mass, prey mass, and predator-prey size ratio, by feeding type. <br />
**Input:** */data/EcolArchives-E089-51-D1.csv* <br />
**Dependencies:** ggplot2 <br />
**Output:** Pdf figures *Pred_Subplots.pdf, Prey_Subplots.pdf, SizeRatio_Subplots.R* and regression results *PP_Results.csv* save to */results* <br />
**Running Instructions:** 
```bash
Rscript PP_Dists.R 
```
</font>

#### PP_Regress.R:
<font size=2>**Summary:** Plotting analysis subsetted by the Predator.lifestage, and calculate the regression results corresponding to the lines fitted. <br />
**Input:** */data/EcolArchives-E089-51-D1.csv* <br />
**Dependencies:** ggplot2 <br />
**Output:** Results save to */results/PP_Regress_Results.csv, PP_Regress.pdf*. <br />
**Running Instructions:** 
```bash
Rscript PP_Regress.R 
```
</font>

#### SQLinR.R:
<font size=2>**Summary:** Plot with sqlite package. <br />
**Input:** */data/Resource.csv* <br />
**Dependencies:** sqlite, ggplot2 <br />
**Output:** Result prints to terminal and a table name "Resource" is wrote .<br />
**Running Instructions:** 
```bash
Rscript SQLinR.R
```
</font>


## Groupwork Practicals -- 02_Booming_Bonobos
Cover 4 groupwork practicals:
1. [Tree heights](https://mhasoba.github.io/TheMulQuaBio/notebooks/07-R.html#groupwork-practical-on-tree-heights)
2. [Tree heights2](https://mhasoba.github.io/TheMulQuaBio/notebooks/07-R.html#groupwork-practical-on-tree-heights-2)
3. [Regression analysis](https://mhasoba.github.io/TheMulQuaBio/notebooks/08-Data_R.html#groupwork-practical-regression-analysis) 
4. [Autocorrelation in Florida weather](https://mhasoba.github.io/TheMulQuaBio/notebooks/07-R.html#groupwork-practical-autocorrelation-in-florida-weather)

#### get_TreeHeight.R:
<font size=2>**Summary:** This function calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula. <br />
**Input:**  */data/trees.csv* <br />
**Output:** Result saves to */results/trees_treeheights_R.csv*.<br />
**Running Instructions:** 
```bash
Rscript get_TreeHeight.R ../data/trees.csv
```
</font>

#### get_TreeHeight.py:
<font size=2>**Summary:** Python version of get_TreeHeight.R. <br />
**Input:**  */data/trees.csv* <br />
**Output:** Result saves to */results/trees_treeheights_py.csv*.<br />
**Running Instructions:** 
```bash
python3 get_TreeHeight.py ../data/trees.csv
```
</font>

#### run_get_TreeHeight.sh:
<font size=2>**Summary:** Shell script to run both get_TreeHeight.R and get_TreeHeight.py. <br />
**Input:**  n/a <br />
**Output:** Result saves to */results/trees_treeheights_R.csv, trees_treeheights_py.csv*.<br />
**Running Instructions:** 
```bash
bash run_get_TreeHeight.sh 
```
</font>

#### PP_Regress_loc.R:
<font size=2>**Summary:** Similar to PP_Regress.R, separated by the dataset’s Location. <br />
**Input:**  */data/EcolArchives-E089-51-D1.csv* <br />
**Dependencies:** ggplot2, plyr <br />
**Output:** Result saves to */results/PP_Regress_loc_Results.csv*. <br />
**Running Instructions:** 
```bash
Rscript PP_Regress_loc.R 
```
</font>

#### TAutoCorr.r
<font size=2>**Summary:** Calculates the autocorrelation of temperature between years. It then tests the significance of this using permutation testing. <br />
**Input:**  */data/KeyWestAnnualMeanTemperature.RData* <br />
**Output:** Result saves to */results/autocorr_histogram.pdf*. <br />
**Running Instructions:** 
```bash
Rscript TAutoCorr.r
```
</font>

#### *****LaTeX and its compile for Florida.R*****

#### AutoCorrFlorida.tex:
<font size=2>**Summary:** LaTeX code writeup file for results and their interpretation from TAutoCorr.r <br /></font>

#### AutoCorrFlorida.bib:
<font size=2>**Summary:** LaTeX Bibliography for AutoCorrFlorida.tex <br /></font>

#### CompileLaTeX.sh *(Optional, or simplily compile the LaTeX file via terminal)*
<font size=2>**Summary:** Required a shell script to compile AutoCorrFlorida.tex <br />
**Input:** n/a <br />
**Output:** Create a pdf document and saved in */code/AutoCorrFlorida.pdf*.<br />
**Running Instructions:** 
```bash
bash CompileLaTeX.sh
```
</font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>