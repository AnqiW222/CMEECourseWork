# PG Life Sciences Core Skills Modules - week 5:

This README file contains details about the scripts from in-classwork and practicals for the fifth week.

## Description
More information about the R scripts and programs for practicals in [GIS and Spatial Methoods in R](https://davidorme.github.io/Masters_GIS/intro.html)

## Language

R

## Dependencies
For some scripts in this directory, packages [terra](https://cran.r-project.org/web/packages/terra/index.html), [sf](https://cran.r-project.org/web/packages/sf/index.html), [raster](https://cran.r-project.org/web/packages/raster/index.html), [geodata](https://cran.r-project.org/web/packages/geodata/index.html), [sp](https://cran.r-project.org/web/packages/sp/index.html), [rgeos](https://cran.r-project.org/web/packages/rgeos/index.html), [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html), [lwgeom](https://cran.r-project.org/web/packages/lwgeom/index.html), [openxlsx](https://cran.r-project.org/web/packages/openxlsx/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [gridExtra](https://cran.r-project.org/web/packages/gridExtra/index.html), [dismo](https://cran.r-project.org/web/packages/dismo/index.html), [ncf](https://cran.r-project.org/web/packages/ncf/index.html), [SpatialPack](https://cran.r-project.org/web/packages/SpatialPack/index.html), [spdep](https://cran.r-project.org/web/packages/spdep/index.html), [spatialreg](https://cran.r-project.org/web/packages/spatialreg/index.html), [nlme](https://cran.r-project.org/web/packages/nlme/index.html), [spgwr](https://cran.r-project.org/web/packages/spgwr/index.html),and [spmoran](https://cran.r-project.org/web/packages/spmoran/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("terra", "sf", "raster", "geodata", "sp", "rgeos", "rgdal", "lwgeom", "openxlsx", "ggplot2", "gridExtra", "dismo", "ncf", "SpatialPack", "spdep", "spatialreg", "nlme", "spgwr", "spmoran"))
```

_The installation commands are used for MacOS, may varied with the different operating system._

## R

#### GIS_prepare.R:
<font size=2>**Summary:** All the required packages for each practicals.<br />
**Input:** n/a <br />
**Output:** package installation <br />
**Running Instructions:** Rscript GIS_prepare.R <br /><br /></font>

#### GISPractical1.R:
<font size=2>**Summary:** GIS data and plotting.<br />
**Input:** ../data/*.* <br />
**Output:** Results prints in terminals. <br />
**Running Instructions:** Rscript GISPractical1.R <br /><br /></font>

#### GISPractical2.R:
<font size=2>**Summary:** Species Distribution Modelling.<br />
**Input:** ../data/*.* <br />
**Output:** Results prints in terminals. <br />
**Running Instructions:** Rscript GISPractical2.R <br /><br /></font>

#### GISPractical3.R:
<font size=2>**Summary:** Spatial modelling in R.<br />
**Input:** ../data/*.* <br />
**Output:** Results prints in terminals. <br />
**Running Instructions:** Rscript GISPractical3.R <br /><br /></font>


## Author & Contact

<font size=2>**Name:** ANQI WANG<br />
**Email:** aw222@ic.ac.uk</font>