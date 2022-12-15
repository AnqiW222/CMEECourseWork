# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: PP_Dists.R
# Created: Oct 2020
# Description: Body mass distributions

# clean environment and remove all the previous plots
rm(list=ls())
graphics.off()

require(tidyverse)

# launch R and read in these data to a data frame (note the relative path):
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
# use dplyr package to columns run down the page, and data runs across, ≈ str()
dplyr::glimpse(MyDF)

# change the type of certain columns to factor because we will want to use them as grouping variables:
MyDF$Type.of.feeding.interaction = as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location = as.factor(MyDF$Location)

# convert masses from mg to g
for (i in 1:nrow(MyDF)){
  if (MyDF$Prey.mass.unit[i] == "mg"){
    MyDF$Prey.mass.unit[i] = "g"
    MyDF$Prey.mass[i] = MyDF$Prey.mass[i] / 1000
 }
}

# Calculating size ratio
Size.ratio = log(MyDF$Prey.mass/MyDF$Predator.mass)
MyDF$Size.ratio <- Size.ratio # Create a new column for later results
MyDF$Size.ratio = as.numeric(MyDF$Size.ratio) # Creates or coerces objects of type "numeric". 

# calculating body size stats by feeding type
MyDFinsectivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "insectivorous")
MyDFpiscivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "piscivorous")
MyDFplanktivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "planktivorous")
MyDFpredacious <- subset(MyDF, MyDF$Type.of.feeding.interaction == "predacious")
MyDFpredaciouspiscivorous <- subset(MyDF, MyDF$Type.of.feeding.interaction == "predacious/piscivorous")

# creating predator mass histograms
pdf("../results/Pred_Subplots.pdf", 11.7, 8.3)

par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
hist(log10(MyDFinsectivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - insectivorous")
par(mfg=c(2,1)) # second sub-plot + 
hist(log10(MyDFpiscivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - piscivorous")
par(mfg=c(3,1)) # second sub-plot
hist(log10(MyDFplanktivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - planktivorous")
par(mfg=c(4,1)) # second sub-plot
hist(log10(MyDFpredacious$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - predacious")
par(mfg=c(5,1)) # second sub-plot
hist(log10(MyDFpredaciouspiscivorous$Predator.mass), xlab="log10(Predator mass(g))", ylab="Count", main="Predator mass histogram - predacious/piscivorous")

dev.off()

# creating prey mass histograms
pdf("../results/Prey_Subplots.pdf", 11.7, 8.3)

par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
hist(log10(MyDFinsectivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - insectivorous")
par(mfg=c(2,1)) # second sub-plot
hist(log10(MyDFpiscivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - piscivorous")
par(mfg=c(3,1)) # second sub-plot
hist(log10(MyDFplanktivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - planktivorous")
par(mfg=c(4,1)) # second sub-plot
hist(log10(MyDFpredacious$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - predacious")
par(mfg=c(5,1)) # second sub-plot
hist(log10(MyDFpredaciouspiscivorous$Prey.mass), xlab="log10(Prey mass(g))", ylab="Count", main="Prey mass histogram - predacious/piscivorous")

dev.off()

# creating size ratio histograms
pdf("../results/SizeRatio_Subplots.pdf", 11.7, 8.3)
par(mfcol=c(5,1)) # initialise multi-paneled plot

par(mfg=c(1,1)) # first sub-plot
plot(density(MyDFinsectivorous$Size.ratio), type = "l", xlab="log(Size ratio)", ylab="Density", main="Size ratio - insectivorous")
par(mfg=c(2,1)) # second sub-plot
plot(density(MyDFpiscivorous$Size.ratio), type = "l", xlab="log(Size ratio)", ylab="Density", main="Size ratio - piscivorous")
par(mfg=c(3,1)) # second sub-plot
plot(density(MyDFplanktivorous$Size.ratio), type = "l", xlab="log(Size ratio)", ylab="Density", main="Size ratio - planktivorous")
par(mfg=c(4,1)) # second sub-plot
plot(density(MyDFpredacious$Size.ratio), type = "l", xlab="log(Size ratio)", ylab="Density", main="Size ratio - predacious")
par(mfg=c(5,1)) # second sub-plot
plot(density(MyDFpredaciouspiscivorous$Size.ratio), type = "l", xlab="log(Size ratio)", ylab="Density", main="Size ratio - predacious/piscivorous")

dev.off()

# create the pp_results.csv
stats <- MyDF %>%
  group_by(Type.of.feeding.interaction) %>%
  summarise(mean(log(Predator.mass)),
            median(log(Predator.mass)),
            mean(log(Prey.mass)),
            median(log(Prey.mass)),
            mean(log(Prey.mass / Predator.mass)),
            median(log(Prey.mass / Predator.mass)))
# name the columns
names(stats) <- c("Type.of.feeding.interaction",
                  "Mean.log.predator.mass",
                  "Median.log.predator.mass",
                  "Mean.log.prey.mass",
                  "Median.log.prey.mass",
                  "Mean.log.ratio.prey.predator.mass",
                  "Median.log.ratio.prey.predator.mass")
# write to csv
write.csv(stats, "../Results/PP_Results.csv", row.names = F)
