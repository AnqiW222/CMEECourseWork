# Author: Anqi Wang (aw222@ic.ac.uk)
# Script: PP_Regress.R
# Created: Oct 2020

# clean environment and remove all the previous plots
rm(list=ls())
graphics.off()

# load the required package
library(ggplot2)

# launch R and read in these data to a data frame (note the relative path):
MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
# change the type of certain columns to factor because we will want to use them as grouping variables:
MyDF$Type.of.feeding.interaction = as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location = as.factor(MyDF$Location)

# plot the graph and save as .pdf
p = qplot(Prey.mass, Predator.mass, data=MyDF, facets = Type.of.feeding.interaction ~., colour = Predator.lifestage, log="xy", geom="point", shape=I(3), xlab = "Prey Mass in grams", ylab = "Predator Mass in grams") 
p + geom_smooth(method="lm", fullrange=T) +
  theme_bw() +
  theme(legend.position = "bottom") + 
  guides(col = guide_legend(nrow = 1))
graphics.off()
# save the plot
ggsave("PP_Regress.pdf", path = "../results/")

# calculate the regression results corresponding to the lines fitted in the figure
output = data.frame()
for(i in unique(MyDF$Predator.lifestage)){ # remove the duplicate rows
  life = subset(MyDF, Predator.lifestage == i)
  for(n in unique(life$Type.of.feeding.interaction)){ # remove the duplicate rows
    feed = subset(life, Type.of.feeding.interaction == n)
    # concatenate the two string values by separating with delimiters with paste()
    print(paste(feed$Predator.lifestage[1], feed$Type.of.feeding.interaction[1])) 
    # summarize the values in the dataframe
    Summ = summary(lm(log(Predator.mass)~log(Prey.mass), data = feed))
    if(is.null(Summ$fstatistic[1])){
      fvalue = "NA" # using 'NA' to value the empty 
    }else{fvalue = as.numeric(Summ$fstatistic[1])}
    dataframe = data.frame(
      n,
      i,
      r2 = Summ$r.squared,
      inter = Summ$coefficients[1],
      slope = Summ$coefficients[2],
      pvalue = Summ$coefficients[8],
      fvalue = fvalue)
    output = rbind(output, dataframe)
  }
}
names(output) = c("Type of Feeding Interaction", "Predator Lifestage", "R2", "intercept", "slope", "p-value", "F-value")

# save the results as .csv
write.csv(output, "../results/PP_Regress_Results.csv", row.names = F)

