#### Plotting data and model fits, analyse model fit results ####
rm(list = ls())

library(ggplot2)
library(reshape2)

# Random select two fit model results
set.seed(61)
sample(1:61, 2, replace = FALSE) # Choose from fit results from 61 datasets

# Read data
fit_12 <- read.csv("../results/FitResults/12_Fit.csv")
fit_7 <- read.csv("../results/FitResults/7_Fit.csv")
AICc <- read.csv("../results/Criterion/Aicc.csv")
BIC <- read.csv("../results/Criterion/Bic.csv")
Rsq <- read.csv("../results/Criterion/R2.csv")
AICc_weight <- read.csv("../results/Criterion/AkaikeWeight.csv")
BIC_weight <- read.csv("../results/Criterion/SchwarzWeight.csv")

# Model fitting plot
data_12 <- melt(fit_12, id = "Time")
colnames(data_12)
ggplot(data = data_12, aes(x = Time, y = value, group = variable, color=variable,shape=variable)) +
  geom_point()+
  geom_line() +
  xlab("Time") +
  ylab("PopBio") +
  theme_bw() +
  theme(panel.grid.major=element_line(colour=NA),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor = element_blank(),# remove the grid but keep the axis line
        legend.position = "bottom",# legend setting
        legend.box.background = element_rect(color="black"))+
  scale_x_continuous(limits = c(0,700),breaks = seq(0,700,100)) # set for x-axis
ggsave("../results/plot1.pdf", width = 6, height = 6)

data_7 <- melt(fit_7, id = "Time")
colnames(data_7)
ggplot(data = data_7, aes(x = Time, y = value, group = variable, color=variable,shape=variable)) +
  geom_point()+
  geom_line() +
  xlab("Time") +
  ylab("PopBio") +
  theme_bw() +
  theme(panel.grid.major=element_line(colour=NA),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor = element_blank(),# remove the grid but keep the axis line
        legend.position = "bottom",# legend setting
        legend.box.background = element_rect(color="black"))+
  scale_x_continuous(limits = c(0,700),breaks = seq(0,700,100)) # set for x-axis
ggsave("../results/plot2.pdf", width = 6, height = 6)

# results analysis

# Using the AICc and BIC counts results from main.py printed in the terminal
df <- data.frame(Model_name = c('Cubic','Logistic','GenLogistic', 'Gompetza', 'Hybrid'),'AICc' = c(12, 25, 2, 0, 22),'BIC' = c(11, 28, 1, 0, 21),check.names = FALSE)
head(df)
dataframe <- melt(df, id = "Model_name")
ggplot(dataframe, aes(x = Model_name, y = value, fill = variable)) + 
  geom_bar(position = "dodge",stat = "identity", width = 0.5) +   # change the histogram width
  geom_text(aes(label = value, vjust = -1.2, hjust = 0.5, color = variable), show_guide = FALSE) + # show the counts
  labs(x = NULL, y = "Count") +
  ylim(min(dataframe$value, 0)*1.1, max(dataframe$value)*1.1)
ggsave("../results/AICc_BIC_count.pdf", width = 6, height = 4)

# AICc and BIC weight comparison
pdf("../results/AIC_c_weight.pdf")
boxplot(AICc_weight, ylab = "Akaike weight (AICc)")
dev.off()

pdf("../results/BIC_weight.pdf")
boxplot(BIC_weight, ylab = "Schwarz Weight (BIC)")
dev.off()

# R^2 result
pdf("../results/R^2.pdf")
boxplot(Rsq, ylab = "R Square", ylim = c(-1, 1))
dev.off()
