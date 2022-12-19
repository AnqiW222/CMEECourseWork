# CMEE 2022 HPC exercises R code pro forma
# For neutral model cluster run

rm(list=ls()) # good practice 
graphics.off() # remove all exist graphs
source("aw222_HPC_2022_main.R")

# Question 18
# personal speciation rate
my_speciation_rate = 0.64

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

# local test cluster
#for (iter in 1:3){# test the first three
set.seed(iter)

# 25 runs for each community size (500, 1000, 2500)
if (1 <= iter & iter <= 25) {
  size = 500
} else if (26 <= iter & iter <= 50) {
  size = 1000
} else if (51 <= iter & iter <= 75) {
  size = 2500
} else if (76 <= iter & iter <= 100) {
  size = 5000
}

output_file_name = paste("Simulation_", iter, ".rda", sep = "")

neutral_cluster_run(speciation_rate = my_speciation_rate, 
                    size,
                    wall_time = (11.5*60),
                    #wall_time = (1),
                    interval_rich = 1,
                    interval_oct = (size/10),
                    burn_in_generations = (8*size),
                    output_file_name)
#}
                    
                    
                    