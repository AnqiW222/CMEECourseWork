# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: Florida.R
# Created: Oct 2020
# Description: R script to answer "Is Florida getting warmer?"

#################################
## Is Florida getting warmer? ##
#################################
# Calculate the correlation coefficients between temperature and time
# Use a permutation analysis to generate a distribution of random correlation coefficients 
# Compare the observed coefficient with this random distribution

rm(list = ls()) # Clear the workplace
# calculate the correlation coefficients between temperature and time
load("../data/KeyWestAnnualMeanTemperature.RData") # load the datast
ls()

class(ats) #return the values of the class attribute 
head(ats) # display the first n rows present in the input data frame
plot(ats) # plot the graph of ats

# Compute the appropriate correlation coefficient between years and Temperature and store it
library(tidyverse) # launch tidyverse
corcoeff <- cor(ats$Year, ats$Temp)#, method = "kendall") # Calculate the correlation coefficient
plot(ats, main = "The correlation coefficent between temperature and yeat")

print("Correlation coefficient for Year and Temp is:")
print (corcoeff)

# Repeat this calculation a sufficient number of times, and recalculating the correlation coefficient (and storing it)
# Each time randomly reshuffling the temperatures 

# create an empty vector to hold the coefficients of sampled populations
allcoeffs = c()
for (i in 1:1000){ #shuffles and calculates 1000 times
  tempsample = sample(ats$Temp) # creates a shuffled sample of the temperatures
  newcoeff <- cor(ats$Year, tempsample)#, method = "kendall") # calculates correlation coefficient of years and shuffled temperatures
  allcoeffs = c(allcoeffs, newcoeff) # stores all coefficients in a vector
}

# Calculate what fraction of the random correlation coefficients were greater than the observed one
# This is the approximate, asymptotic p-value
AsyPValue <- allcoeffs[allcoeffs>corcoeff]
print("The Approximate, asymptomatic p-value is:")
print(AsyPValue/allcoeffs)

# create figures
pdf("../results/atsplot.pdf")
plot(ats, main = "Temperature records by Year in Key West, Florida, USA")
dev.off()

pdf("../results/allcoeffs.pdf")
plot(allcoeffs, main = "Year vs. Temperature in Key West, Florida, USA", ylab = "Correlation coefficient")
dev.off()


pdf("../results/AsymptoticPValue.pdf")
hist(allcoeffs, main = "Permutation Analysis", xlab = "Correlation Coefficient")
dev.off()
# All values between 0.5.. and  -0.5.. were taken due to the hypothesis is:
# is Florida getting warmer? Which means the specified thing to considered is 
# whether there is a positive correlation
# If hypotheses is changed to whether Florida temperature is changing, 
# the value greater than |0.5..| (absolute value of 0.5..)should all be considered
# If hypothesis was is Florida getting colder, 
# the allcoeff may valued the all numbers below the observed ones

