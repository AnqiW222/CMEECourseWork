# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: next.R
# Created: Oct 2020
# Description: The 'next' statement in R

# prints odd numbers up to 10
for (i in 1:10) {
  if((i %% 2) == 0) # check if number odd
    next
  print(i) # skip to next iteration
}