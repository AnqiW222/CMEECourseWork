# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: ggthemes.R
# Created: Oct 2020
# Description: In-class practical: Introduction to ggthemes.

## ggthemes ##

# clean environment and remove all the previous plots
rm(list=ls())
graphics.off()

# install the package
#install.packages("ggthemes")
# load the data
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")

# the try:
library(ggthemes)

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass),
                      colour = Type.of.feeding.interaction )) +
  geom_point(size=I(2), shape=I(10)) + theme_bw()

p + geom_rangeframe() + # now fine tune the geom to Tufte's range frame
  theme_tufte() # and theme to Tufte's minimal ink theme    
