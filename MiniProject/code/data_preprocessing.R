# Initial data import and plot
rm(list = ls())
require(dplyr)

# Load data ----
data <- read.csv("../data/LogisticGrowthData.csv")
print(paste("Loaded", length(colnames(data)), "columns."))

colnames(data) # head(data)

# meta data 
meta <- read.csv("../data/LogisticGrowthMetaData.csv")
print(meta)

print(unique(data$PopBio_units))  # diff units of the response variable

print(unique(data$Time_units))  # independent variable units

# Set ID column ----
# create ID based on unique combos of species, medium, temp and citation
data$full_ID <- paste(data$Species,"_",data$Temp,"_",data$Medium,"_",data$Citation,
                     sep="")
# change IDs to numbers
data <- data %>%
  mutate(ID = factor(full_ID, levels = unique(full_ID), 
                     labels = c(1:length(unique(full_ID)))),
         .before = X) %>% 
  select(-full_ID)
print(length(unique(data$ID)))  # num of unique data sets 

any(is.na(data))  # no NAs to remove
# delete the negative population
data <- subset(data, data$PopBio > 0)
# 
data$logN = log(data$PopBio)

# Remove all negative and 0 values of PopBio
data <- data[!(data$PopBio <= 0),]
min(data$PopBio)

# Remove all negative time
min(data$Time)
all_neg_times <- subset(data, data$Time < 0)

data <- data[!(data$Time < 0),]

# Log transformation ----
data$logPopBio <- log(data$PopBio)

any(is.na(data$logPopBio))  # no NAs to remove
any(is.infinite(data$logPopBio))  # and no infinite values

# Save the modified data
write.csv(data, "../data/modified_growth_data.csv", row.names = FALSE)

# Plot
PlotData <- read.csv("../data/modified_growth_data.csv")

pdf("../results/output_dataplot.pdf")
for (i in 1:length(unique(PlotData$ID))){
  subdata <- subset(PlotData, ID == i) 
  plot(subdata$PopBio ~ subdata$Time, main = paste(i), xlab = "Time", ylab = "PopBio")
 
}
graphics.off()