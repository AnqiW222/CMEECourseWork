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

as_tibble(MyData) # ≈ head(MyData)
# tidyverse equivalent to head(MyData) as it displays the first 10 lines, but head is better
dim_desc(MyData) # ≈ dim()
# dimensions 
dplyr::glimpse(MyData) 
# compactly display the structure
# like str(), but nicer!
# dbl means double precision floating point number
utils::View(MyData) # ≈ fix()
# you can also do this
utils::View(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) #Swaps rows and columns around
head(MyData)
dim(MyData)
# no viable way to do it in tidyverse

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

#TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
#colnames(TempData) <- MyData[1,] # assign column names from original data

TempData <- tibble::as_tibble(MyData[-1,],stringsAsFactors = FALSE) 
colnames(TempData) <- MyData[1,] # assign column names as actual column names from original data
# tidyverse works in this case with rename but the origin method is better

############# Convert from wide to long format  ###############
#require(reshape2) # load the reshape2 package
#
#?melt #check out the melt function
#
#MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

#tidyr gather
MyWrangledData2=gather(TempData,key = "Species", value = "Count", 5:ncol(TempData))
# or
MyWrangledData <- tidyr::pivot_longer(TempData, cols=5:45,names_to="Species",values_to="Count")

#dplyr mutate
MyWrangledData2 = MyWrangledData2 %>% mutate(Cultivation = as.factor(Cultivation), Block=as.factor(Block), Plot=as.factor(Plot), Quadrat=as.factor(Quadrat), Count= as.numeric(Count))


#MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
#MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
#MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
#MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
#MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

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

############ Coerce column types ####################

# It is necessary because the stringsAsFactors are set to false at the beginning to avoid it converting unwanted sections
# this means we must specify which parts we do want as factors

MyWrangledData <- MyWrangledData %>%
  mutate(across(c(Cultivation, Block, Plot, Quadrat, Species), as.factor))
# uses across to apply the same function (as.factor) to mutate multiple columns

MyWrangledData <- MyWrangledData %>%
  mutate(across(c(Count), as.integer))

############# Exploring the data (extend the script below)  ###############
##################################### 
#require(tidyverse)
#tidyverse_packages(include_self = T)
#tibble::as_tibble(MyWrangledData)
#dplyr::glimpse(MyWrangledData) # dbl means double precision floating point number
#dplyr::filter(MyWrangledData, Count>100)
#dplyr::slice(MyWrangledData,10:15)

MyWrangledData <- tibble::as_tibble(MyWrangledData)
# a tibble in tidyverse is equivalent to R's traditional dataframe
# recommend but not need to convert dataframe to tibble to use tidyverse
# tibbles are lazy data frames that do less
# tibbles don't change variable types or names
# tibbles complain more (e.g. when a variable doesn't exist)
# tibble displays data along with data type while displaying 
# whereas data frames do not

MyWrangledData

dplyr::glimpse(MyWrangledData) 

dplyr::filter(MyWrangledData, Count>100) # ≈ subset(), but nicer!

dplyr::slice(MyWrangledData, 10:15) # Look at an arbitrary set of data rows
