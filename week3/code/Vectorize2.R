# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: Vectorize2.R
# Created: Oct 2020
# Description: In-class vectorized function 2: Runs the stochastic Ricker equation with gaussian fluctuations

rm(list = ls()) # Clean the workplace

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}

print("Non-Vectorized Stochastic Ricker takes:")
print(system.time(res1<-stochrick()))

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 

stochrickvector1 <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N <- matrix(NA, numyears, length(p0))
  N[1, ] <- p0
  for (yr in 2:numyears){ #for each pop, loop through the years
    N[yr,] <- N[yr-1,] * exp(r * (1 - N[yr - 1,] / K) + rnorm(1,0,sigma)) # add one fluctuation from normal distribution
 }
return(N)
}
#print(stochrickvector1())

stochrickvector2 <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{
  N <- matrix(NA, numyears, 1000)
  N[1, ] <- p0
  for (pop in 2:1000){ #loop through the populations
    N[,pop] <- N[,pop-1] * exp(r * (1 - N[,pop-1] / K) + rnorm(1,0,sigma))
  }
return(N)
}
#print(stochrickvector2())

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))
print("Vectorized Stochastic Ricker1 takes:")
print(system.time(res21<-stochrickvector1()))
print("Vectorized Stochastic Ricker2 takes:")
print(system.time(res21<-stochrickvector2()))

