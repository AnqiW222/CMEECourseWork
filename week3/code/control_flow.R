# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: control_flow.R
# Created: Oct 2020
# Description: Using statement to give a finer control over the program’s “control flow”.

#########################################

## if statements
a <- TRUE
if (a == TRUE) {
  print ("a is TRUE")
} else {
  print ("a is FALSE")
}

## on a single line - BUT readability more important
z <- runif(1) ## Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}

#########################################

## for loops
for (i in 1:10) {
  j <- i * i
  print(paste(i, " squared is", j ))
}

#1:10

## loop over vector of strings
for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
  print(paste('The species is', species))
}

## loop using pre-existing vector
v1 <- c("a","bc","def")
for (i in v1) {
  print(i)
}

#########################################

## while loops
i <- 0
while (i < 10) {
  i <- i+1
  print(i^2)
}

