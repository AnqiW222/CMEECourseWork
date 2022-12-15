# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: TreeHeight.R
# Created: Oct 2020
# Description: Calculates tree heights for all trees in the data and save the results in .csv file

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

#################################### Original
#TreeHeight <- function(degrees, distance) {
#  radians <- degrees * pi / 180
#  height <- distance * tan(radians)
#  print(paste("Tree height is:", height))
#  
#  return (height)
#}
#
#TreeHeight(37, 40)
################################################

# Improvement
MyData <- read.csv ("../data/trees.csv", header = T)
Species = MyData$Species
Distance.m = MyData$Distance.m
Angle.degrees = MyData$Angle.degrees

TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("The $Species tree height is:", height))
  
  return (height)
}

Tree.Height.m = TreeHeight(Angle.degrees, Distance.m)
TreeHts = data.frame(Species, Distance.m, Angle.degrees, Tree.Height.m)
names(TreeHts) = c("Species", "Distance.m", "Angle.degrees", "Tree.Hight.m")
TreeHts

write.table(TreeHts, "../results/TreeHts.csv", row.names = F)