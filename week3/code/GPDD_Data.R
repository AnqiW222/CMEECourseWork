# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: GPDD_Data.R
# Created: Oct 2020
# Description: Mapping the Global Population Dynamics Database (GPDD)

# clean environment and remove all the previous plots
rm(list=ls())
graphics.off()

# install the maps package
#install.packages("maps")

# load the required package
library(maps)
library(ggplot2)
library(RColorBrewer)
library(tidyverse)

# load the data
load("../data/GPDDFiltered.RData")
#class(df) 

# create a world map
# Method 1:
world_map = map_data("world")
p = ggplot() + coord_fixed() + xlab("") + ylab("")
world = p + borders("world", colour = "grey 50", fill = "grey 100") +
  theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  geom_point(data = gpdd, aes(x = long, y = lat), color = "black", shape = I(3), alpha = I(0.5))

#world # Show the graph
#dev.off()

# Method 2:
#pdf("../sandbox/GPDD_map.pdf", 8, 10) # dave the results
#maps::map(database = "world", fill=TRUE, col="lightgrey", border="darkgray",
#          bg = "lightblue", xlim = c(-180, 180), ylim = c(-90, 90), wrap=c(-180,180))
# add species from gpdd
#points(x = gpdd$long, y = gpdd$lat, col=alpha("darkgreen", 0.6), lwd=2)
#dev.off()
# what biases might you expect in any analysis based on the data represented?
# # The data locations spreads more along the seaside, and not evenly distributed, 
# more focused on the northern temperate zone,
# therefore, for the terrestrial and freshwater habitats, or the other temperature zones may not accurate due to the lack of data

