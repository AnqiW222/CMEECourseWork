# CMEE Coursework - week 3:

This README file contains details about the scripts from in-classwork and practicals for the third week.

## Description
More information about the R scripts and programs for coursework in **Biological Computing in R** section of the Computing Chapter and **Data Management and Visualization** section of Basic Data Analysis and Statistics Chapter of [The Mulitilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html)

## Language

R, LaTex

## Dependencies
For some scripts in this directory, packages [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [maps](https://cran.r-project.org/web/packages/maps/index.html), and [sqldf](https://cran.r-project.org/web/packages/sqldf/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("tidyverse", "ggplot2", "reshape2", "maps", "sqldf"))
```

[LaTeX](https://www.latex-project.org/) installation is also required. Please run following **bash** script in Terminal for installation:
```bash
brew install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```

_The installation commands are used for MacOS, may varied with the different operating system._

## R
### Biological Computing in R:

#### apply1.R:
<font size=2>**Summary:** Applying a function to the rows or columns of a matrix.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal.<br />
**Running Instructions:** Rscript apply1.R <br /><br /></font>

#### apply2.R:
<font size=2>**Summary:** Using apply to define own functions. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal <br />
**Running Instructions:** Rscript apply2.R <br /><br /></font>

#### basic_io.R:
<font size=2>**Summary:** A simple script to illustrate R input-output and the use of read() and write() functions. <br />
**Input:** n/a <br />
**Output:** MyData.csv in /results. <br />
**Running Instructions:** Rscript basic_io.R <br /><br /></font>

#### boilerplate.R:
<font size=2>**Summary:** boilerplate R script.<br />
**Input:** n/a <br />
**Output:** Results prints to terminal. <br />
**Running Instructions:** Rscript boilerplate.R </font>

#### break.R:
<font size=2>**Summary:** R loop demonstration. <br />
**Input:** n/a <br />
**Output:** Results prints to terminal. <br />
**Running Instructions:** Rscript break.R <br /><br /></font>

#### browse.R:
<font size=2>**Summary:** sing the browser() function to debug by examining local variables.<br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript browse.R <br /><br /></font>

#### control_flow.R:
<font size=2>**Summary:** Demonstrating control flow tools. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript control_flow.R <br /><br /></font>

#### Florida.R:
<font size=2>**Summary:** Calculates correlation coefficient between temperature and time for the 20th century in Key West, Florida and uses a permutation analysis to calculate the P-value.<br />
**Input:** KeyWestAnnualMeanTemperature.RData in /data. <br />
**Dependencies:** tidyverse <br />
**Output:** Result prints to terminal and saves figures in results.<br />
**Running Instructions:** Rscript Floria.R <br /><br /></font>

#### next.R:
<font size=2>**Summary:** using 'next' to skip to next iteration of for loop. Only prints odd numbers <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript next.R <br /><br /></font>

#### preallocation.R:
<font size=2>**Summary:** Compares times of pre-allocation to no pre-allocation. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript preallocation.R <br /><br /></font>

#### R_conditionals.R:
<font size=2>**Summary:** Functions with conditionals examples. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript R_conditionals.R <br /><br /></font>

#### Ricker.R:
<font size=2>**Summary:** Plots the ricker model. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript Ricker.R <br /><br /></font>

#### sample.R:
<font size=2>**Summary:** Explains sys.argv in a practical way. <br />
**Input:** n/a <br />
**Output:** n/a <br />
**Running Instructions:** Rscript sample.R <br /><br /></font>

#### TreeHeight.R:
<font size=2>**Summary:** alculating heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula. <br />
**Input:** trees.csv in /data <br />
**Output:** TreeHts.csv in /results.<br />
**Running Instructions:** Rscript TreeHeight.R <br /><br /></font>

#### try.R:
<font size=2>**Summary:** illustrates try. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript try.R <br /><br /></font>

#### Vectorize1.R:
<font size=2>**Summary:** Sums all elements of a matrix. Compares sum() and a sum function. <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript Vectorize1.R <br /><br /></font>

#### Vectorize2.R:
<font size=2>**Summary:** Vectorizes the ricker model and adds fluctuation <br />
**Input:** n/a <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript Vectorize2.R <br /><br /></font>


### Data Management and Visualization:

#### DataWrang.R:
<font size=2>**Summary:** Examples of loops and conditionals combined. <br />
**Input:** PoundHillData.csv, PoundHillMetaData.csv from /data. <br />
**Dependencies:** reshape2 <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript DataWrang.R <br /><br /></font>

#### DataWrangTidy.R:
<font size=2>**Summary:** Wrangling the pound hill dataset using tidyverse. <br />
**Input:** PoundHillData.csv, PoundHillMetaData.csv from /data. <br />
**Dependencies:** tidyverse <br />
**Output:** Result prints to terminal.<br />
**Running Instructions:** Rscript DataWrangTidy.R <br /><br /></font>

#### ggthemes.R:
<font size=2>**Summary:** Introduction of ggthemes which could provides some additional geoms, scales, and themes for ggplot. <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** MyBars.pdf figure in results. <br />
**Running Instructions:** Rscript ggthemes.R <br /><br /></font>

#### Girko.R:
<font size=2>**Summary:** Plotting two dataframes together. <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** Girko.pdf figure in results (plot print in the view window).<br />
**Running Instructions:** Rscript Girko.R <br /><br /></font>

#### GPDD_Data.R:
<font size=2>**Summary:** apping the Global Population Dynamics Database (GPDD) with [maps](https://cran.r-project.org/web/packages/maps/index.html). <br />
**Input:** GPDDFiltered.RData in /data <br />
**Dependencies:** maps, ggplot2, mapdata
**Output:** worldmap.pdf in results. <br />
**Running Instructions:** Rscript GPDD_Data.R <br /><br /></font>

#### MyBars.R:
<font size=2>**Summary:** Annotating a plot. <br />
**Input:** Results.txt from /data <br />
**Dependencies:** ggplot2 <br />
**Output:** MyBars.pdf figure in results. (plot print in the view window).<br />
**Running Instructions:** Rscript MyBars.R <br /><br /></font>

#### PlotLin.R:
<font size=2>**Summary:** Annotates a linear regression plot <br />
**Input:** n/a <br />
**Dependencies:** ggplot2 <br />
**Output:** Figure 'MyLinReg.pdf' in results. (plot print in the view window).<br />
**Running Instructions:** Rscript PlotLin.R <br /><br /></font>

#### PP_Dists.R:
<font size=2>**Summary:** Creating three figures, each containing subplots of distributions of predator mass, prey mass, and the size ratio of prey mass over predator mass by feeding interaction type. And calculating the mean and median log predator mass, prey mass, and predator-prey size ratio, by feeding type. <br />
**Input:** EcolArchives from /data <br />
**Dependencies:** ggplot2 <br />
**Output:** Pdf figures (Pred_Subplots.pdf, Prey_Subplots.pdf, SizeRatio_Subplots.R) and regression results (PP_Results.csv) in results <br />
**Running Instructions:** Rscript PP_Dists.R <br /><br /></font>

#### PP_Regress.R:
<font size=2>**Summary:** Plotting analysis subsetted by the Predator.lifestage, and calculate the regression results corresponding to the lines fitted. <br />
**Input:** EcolArchives from data <br />
**Dependencies:** ggplot2 <br />
**Output:** PP_Regress_Results.csv and PP_Regress.pdf in results. <br />
**Running Instructions:** Rscript PP_Regress.R <br /><br /></font>

#### SQLinR.R:
<font size=2>**Summary:** Plot with sqlite package. <br />
**Input:** Resource.csv from /data. <br />
**Dependencies:** sqlite, ggplot2 <br />
**Output:** Result prints to terminal and a table name "Resource" is wrote .<br />
**Running Instructions:** Rscript SQLinR.R <br /><br /></font>

## LaTeX

#### Florida_warming.tex:
<font size=2>**Summary:** LaTeX code writeup file for results and their interpretation from Florida.R <br />
**Input:** Florida.R output figures in /results <br />
**Output:** Can be compiled into LaTeX file. <br />
**Running Instructions:** To be compiled with LaTeX <br /><br /></font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>