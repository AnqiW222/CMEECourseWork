# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: DataWrang.R
# Created: Oct 2020

################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
#head(MyWrangledData); tail(MyWrangledData)

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

########################################## In-class practical ##################
#require(tidyverse)
#tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 
#
## convert the dataframe to a "tibble"
#MyWrangledData <- dplyr::as_tibble(MyWrangledData) 
#MyWrangledData
#
## Same as:
#MyWrangledData <- as_tibble(MyWrangledData) 
#class(MyWrangledData)
#
## Without using ::
#glimpse(MyWrangledData) #like str(), but nicer!
#
## utils::View(MyWrangledData) #same as fix()
#filter(MyWrangledData, Count>100) #like subset(), but nicer!
#
#slice(MyWrangledData, 10:15) # Look at a particular range of data rows
#
##  using tidyverse is using the “pipe” %>% operator to create a compact sequence 
## of manipulations of dataset with dplyr:
#MyWrangledData %>%
#  group_by(Species) %>%
#  summarise(avg = mean(Count))
#
## the same as the following command using base R (not using dplyr at all):
#aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean) 
################################################################################


############# Exploring the data (extend the script below)  ###############
require(tidyverse)
tidyverse_packages(include_self = T)
tibble::as_tibble(MyWrangledData)
dplyr::glimpse(MyWrangledData) # dbl means double precision floating point number
dplyr::filter(MyWrangledData, Count>100)
dplyr::slice(MyWrangledData,10:15)

# In-class practical, all R script will first import required packages using library() or require()