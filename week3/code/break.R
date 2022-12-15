# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: break.R
# Created: Oct 2020
# Description: In-class practical using 'break'.

i <- 0
while (i < Inf) {
  if (i == 10){
    break
  } else {
    cat("i equals ", i, "\n")
    i <- i + 1
  }
}

