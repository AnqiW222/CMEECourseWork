# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "ANQI WANG"
preferred_name <- "Anqi"
email <- "aw222@imperial.ac.uk"
username <- "aw222"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Set a community vector to test the function
#community <- c(1,1,2,3,4,1,1,2,3,2,3,3,4,2,1,1,1)

# Question 1
species_richness <- function(community){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size){
  return(seq(size))
}

# Question 3
init_community_min <- function(size){
  return(rep(1, size))
}

# Question 4
choose_two <- function(max_value){
  return(sample(c(1:max_value), 2, replace = FALSE))
}

# Question 5
neutral_step <- function(community){
  indices <- choose_two(length(community)) # randomly choose two individual species from community
  individual_dies <- indices[1]
  first_offspring <- indices[2]
  community[individual_dies] <- community[first_offspring] # dies replaced by first offspring
  return(community)
}

# Question 6
# generation = the amount of time expected between birth and reproduction
# when length(community) = x, generation = x/2(neutral_step)
# if x != 2n, randomly round up/down
# e.g. length(community) = 10, neutral_step(community) = 5, generation = 1
neutral_generation <- function(community){
  generation_nums <- round(length(community)/2 + sample(c(0,-0.1)), 1) # sample + 0 will be round up, -0.1 will round down
  for (step in generation_nums) {
    community <- neutral_step(community)
  }
  return(community)
} # floor() can also be used for round down

# Question 7
neutral_time_series <- function(community,duration){
  time_series_richness <- species_richness(community)
  for (gen in 2:(duration + 1)) {
    time_series_richness <- c(time_series_richness, species_richness(community))
    community <- neutral_generation(community)
  }
  return(time_series_richness)
}

# Question 8
# plot and save neutral_time_series
# init_community_max(100)
# neutral_generation = 200
# no inputs require 
# return to answer "What state will the system always converge to if you wait long enough? Why is this?"
question_8 <- function() {
  richness_t_series <- neutral_time_series(community = init_community_max(100), duration = 200)
  # create a .png file in the path to save the plot
  png(filename="question_8.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  # set plot parameters
  par(mfrow=c(1,1), bty = "]")
  plot(x = 1:length(richness_t_series), y= richness_t_series, type = "l", lwd = 2,
       xlab = "Time in generations",
       ylab = "Species richness",
       main = "Neutral Model Time Series")
  dev.off()
  return("The system always converge to a point where the species richness is equal to 1. 
         Because there is no new species add in, therefore the species richness can't increase, but the species can be lost through extinction. 
         The extinct species cannot re-enter the community, therefore, due to the stochasticity of the system, the community will eventually randomly lose all species but one.")
}

# Question 9
# perform a step of a neutral model with speciation
# speciation_rate = the died individual replaced by a new species
# 1-speciation_rate = neutral generation(replaced by the 1st offspring)
# speciation_rate = c(0,1) _>input parameter

neutral_step_speciation <- function(community,speciation_rate)  {
  indices <- choose_two(length(community))
  individual_dies <- indices[1]
  
  # speciation will replace the dead individuals with a new species
  # otherwise still be replace with first offspring 
  new_speciation <- runif(1, 0, 1)
  if (new_speciation <= speciation_rate){ # speciation
    # the new species is excludes the community, therefore, add 1 in unique(community)
    new_individual <-max(unique(community)) + 1
    community[individual_dies] <- new_individual
  } else { #replace by the offspring
    indivual_reporduction <-indices[2]
    community[individual_dies] <-community[indivual_reporduction]
    }
    return(community)
}

# Question 10
# new generation speciation
# with speciation and advances an initial community one generation
neutral_generation_speciation <- function(community,speciation_rate)  {
  generation_nums <- (length(community)/2) # determines the death and birth numbers for one generation
  val <- runif(1,0,1) # produces a random number bwtween 0 and 1
  if (val >= 0.5){
    generation_nums <- ceiling(generation_nums) # round up
  }
  else { # else round down
    generation_nums <- floor(generation_nums)
  }
  for (i in 1:generation_nums){
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  vec <- (species_richness(community)) # records the initial species richness
  for (gen in 2:(duration+1)){
    community <- neutral_generation_speciation(community, speciation_rate) # #replaces community each generation
    vec <- c(vec, species_richness(community))
  }
  return(vec)
}

# Question 12
# Explain what you found from this plot about the effect of initial conditions. 
# Why does the neutral model simulation give you those particular results
question_12 <- function()  {
  graphics.off()  # clear any existing graphs 
  
  png(filename="question_12.png", width = 600, height = 400) # save the .png file
  # plot your graph here
  Sys.sleep(0.1)
  
  y_max <- neutral_time_series_speciation(community = init_community_max(100), 0.1, 200)
  y_min <- neutral_time_series_speciation(community = init_community_min(100), 0.1, 200)
  x <- c(1:201)
  plot(x, y_max, main="Time Series Graph of Neutral Model", ylab="Species Richness", xlab="Generations", type="l", col="red")
  lines(x, y_min, col="blue", type="l")
  legend(x = 120, y = 100, legend = c("Initial Maximum Population", "Initial Minimum Population"), col = c("red","blue"),lty=1:2, cex=0.8)
  dev.off()
  return("When a community is simulated by the neutral model with the same rate of speciation, there is likely to have a dynamic equilibrium. 
         There is no obvious impact of the initial states of richness, because the chances of extinction and speciation are the same in both populations. 
         However, the model with speciations prevents the mono-dominance from persisting as new species can occur in both scenarios. 
         Regardless of initial values, evaluate the speciation rate and numbers of individuals, and they would converge to a dynamic equilibrium with similar pattern.")
}

# Question 13
species_abundance <- function(community)  {
  abundance <- as.numeric(sort(table(community), decreasing = TRUE))
  return(abundance)
}

# Question 14
octaves <- function(abundance_vector) {
  OctVet <- tabulate(floor(log2(abundance_vector))+1) # +1 ensures that 0's are read while log groups them
  return(OctVet)
}

# Question 15
# return the sum of x and y
# correct the zero length
sum_vect <- function(x, y) {
  length_diff <- length(x) - length(y)
  if (length_diff > 0){
    y <- c(y, rep(0, length_diff))
  }
  if (length_diff < 0){
    x <- c(x, rep(0, abs(length_diff)))
  }
  x_y_sum <- x + y
  return(x_y_sum)
}

# Question 16 
# bar plot of species abundance distributions
# speciation rate = 0.1, community size =100, period = 200 generation
# continue the simulation from where left off for 2000 generations
# for every 20 generations, record the species abundance octave vector
# no input requires
question_16 <- function() {
  graphics.off()  # clear any existing graphs
  # initial parameters
  Max_com <- init_community_max(100)
  Min_com <- init_community_min(100)
  for (i in 1:200){ # burn-in period
    #returning the species at the end of each generation
    burn_in_max <- neutral_generation_speciation(Max_com, speciation_rate = 0.1)
    burn_in_min <- neutral_generation_speciation(Min_com, speciation_rate = 0.1)
    # the next iteration should be based of t-1 generation -- replace comm
    Max_com <- burn_in_max
    Min_com <- burn_in_min
  }
  # record the species abundance octave vector
  Max_oct <- octaves(species_abundance(Max_com))
  Min_oct <- octaves(species_abundance(Min_com))
  for (i in 1:2000){ # continues the simulation for further 2000 generations
    # for each run of the loop, add the current octave to the octave previously recorded 
    Max_com <- neutral_generation_speciation(Max_com, speciation_rate = 0.1)
    Min_com <- neutral_generation_speciation(Min_com, speciation_rate = 0.1)
    if (i %% 20 == 0){ # every 20 generation
      Max_oct <- sum_vect(Max_oct, octaves(species_abundance(Max_com)))
      Min_oct <- sum_vect(Min_oct, octaves(species_abundance(Min_com)))
    }
  }
  # calculate the mean
  Max_oct_vect <- Max_oct/100
  Min_oct_vect <- Min_oct/100
  
  # plot for min
  png(filename="question_16_min.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  barplot(Min_oct_vect,
          main="Species Abundance Octave Vector of Min", 
          xlab = "Species Abundance Octave",
          ylab = "Mean Species Abundance Distribution", # mean octaves
          cex.main=0.8)
  dev.off()
  
  # plot for max
  png(filename="question_16_max.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  barplot(Max_oct_vect,
          main="Species Abundance Octave Vector of Max", 
          xlab = "Species Abundance Octave",
          ylab = "Mean Species Abundance Distribution", # mean octaves
          cex.main=0.8)
  dev.off()
  
  return("The initial richness of the system does not affect the final results. 
  As the speciation rate is equal to all the simulated community in the neutral model, the species abundance follows a Poisson distribution shape. 
         Therefore, no matter the initial richness is, the system tends to have the same trends and get a dynamic equilibrium.")
}

# Question 17
# input: init_community_min
# wall_time <- proc.time(speciation_rate)
# interval_rich <- burn_in period (burn_in_generations)
# species richness recorded in a vector -> time_series (%% + loop)
# (list) -> interval_oct generation
# save results in output_file_name <- time_seies of species richness recorded during burn_in_generations
# abundance_list <- the list of species abundance octaves
# test with: neutral_cluster_run(speciation_rate = 0.1, size = 100, wall_time = 10, interval_rich = 1, interval_oct = 10, burn_in_generations = 200, output_file_name = "my_test_file_1.rda")
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
  community <- init_community_min(size) # set initial community size
  start_timer <- as.numeric(proc.time()[3]) # function will run until wall_time has elapsed, measured in minutes
  time_series <- c() # species richness in vector
  SpAbd_octaves <- list() # empty list to store the entire simulated octave
  #final_com <- c() # vector for final community constitute
  
  count = 1 #count from the first generation
  while ((as.numeric(proc.time()[3]) - start_timer) <= (wall_time*60)) { # run the loop and convert the time unit
    community <- neutral_generation_speciation(community, speciation_rate)
    if (count <= burn_in_generations){
      if(count %% interval_rich == 0 ) { # only record during the burn_in_generation
      time_series <- c(species_richness(community), time_series)
      }
    }
    if (count %% interval_oct == 0) { # record species abundances as octaves
      o_vect <- octaves(species_abundance(community))
      SpAbd_octaves <- append(SpAbd_octaves, list(o_vect)) # adds into list
    }
    count <- count + 1
  }
  save(time_series, SpAbd_octaves, community, speciation_rate, 
       size, wall_time, interval_rich, interval_oct, burn_in_generations,
       file = output_file_name)
  return(paste(output_file_name, "done!", sep=" "))
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20 
# read and process the output files
# only use the data of the abundance octaves after the burn-in time
# calculate a mean value across all the saved data for each abundance octaves and for each community size
# save all results in .rda file as a list of four vectors 
process_neutral_cluster_results <- function() {
  # clear all exist graphs
  graphics.off()
  
  files <- list.files(pattern = "Simulation_*") # creates list of files output from HPC
  
  Com_size_500 <- list() # generates empty lists for each different community size used in the HPC cluster
  Com_size_1000 <- list()
  Com_size_2500 <- list()
  Com_size_5000 <- list()
  
  Com_size_500_length <- c(0) # creates empty vectors to count the total number of octaves recorded for each community size during HPC run
  Com_size_1000_length <- c(0)
  Com_size_2500_length <- c(0)
  Com_size_5000_length <- c(0)
  
  for(i in 1:length(files)){ #loop through all files
    load(files[i]) # load each file one by one 
    if (size == 500){ # if the community size is 500;
      Com_size_500 <- c(Com_size_500, SpAbd_octaves[81:length(SpAbd_octaves)]) # add all the octaves from this file, apart from those recorded during burn in, to the octave vector created for community sizes of 500  
      Com_size_500_length <- (Com_size_500_length + (length(SpAbd_octaves)-80)) # sums the amount of octaves recorded for all runs for community sizes of 500 
    } # below code does same as above for different community sizes
    if (size == 1000){
      Com_size_1000 <- c(Com_size_1000, SpAbd_octaves[81:length(SpAbd_octaves)])
      Com_size_1000_length <- (Com_size_1000_length + (length(SpAbd_octaves)-80))
    }
    if (size == 2500){
      Com_size_2500 <- c(Com_size_2500, SpAbd_octaves[81:length(SpAbd_octaves)])
      Com_size_2500_length <- (Com_size_2500_length + (length(SpAbd_octaves)-80))
    }
    if (size == 5000){
      Com_size_5000 <- c(Com_size_5000, SpAbd_octaves[81:length(SpAbd_octaves)])
      Com_size_5000_length <- (Com_size_5000_length + (length(SpAbd_octaves)-80))
    }
  }
  
  Mean_size_500 <- Com_size_500[[1]]
  for (i in 1:length(Com_size_500)){
    Mean_size_500 <- sum_vect(Mean_size_500, Com_size_500[[i]])
  } # iterates through octaves list and sums all items 
  Mean_size_500 <- Mean_size_500/Com_size_500_length # finds mean abundance octaves for all simulations with community size of 500
  
  Mean_size_1000 <- Com_size_1000[[1]]
  for (i in 1:length(Com_size_1000)){
    Mean_size_1000 <- sum_vect(Mean_size_1000, Com_size_1000[[i]])
  } 
  Mean_size_1000 <- Mean_size_1000/Com_size_1000_length
  
  Mean_size_2500 <- Com_size_2500[[1]]
  for (i in 1:length(Com_size_2500)){
    Mean_size_2500 <- sum_vect(Mean_size_2500, Com_size_2500[[i]])
  } 
  Mean_size_2500 <- Mean_size_2500/Com_size_2500_length
  
  Mean_size_5000 <- Com_size_5000[[1]]
  for (i in 1:length(Com_size_5000)){
    Mean_size_5000 <- sum_vect(Mean_size_5000, Com_size_5000[[i]])
  } # iterates through octaves list and sums all items 
  Mean_size_5000 <- Mean_size_5000/Com_size_5000_length
  
  combined_results <- list(Mean_size_500, Mean_size_1000, Mean_size_2500, Mean_size_5000) #create your list output here to return
  save(combined_results, file = "process_neutral_cluster_results.rda")# save results to an .rda file
  
  return("TOTAL OUTPUT FILE IS DONE!!!")
}


plot_neutral_cluster_results <- function(){
    # load combined_results from your .rda file
  load("process_neutral_cluster_results.rda")
  
  Com500 <- combined_results[[1]]
  Com1000 <- combined_results[[2]]
  Com2500 <- combined_results[[3]]
  Com5000 <- combined_results[[4]]
  
  # Plot
  png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
    # plot your graph here
  Sys.sleep(0.1)
  par(mfrow = c(2,2), las = 2) # 2 columns and 2 rows of graphs to be plotted
  # plot mean abundance octaves for each community size
  barplot(Com500, main = "Community size = 500", xlab = "Species Abundance Octave", ylab = "Frequency")
  barplot(Com1000, main = "Community size = 1000", xlab = "Species Abundance Octave", ylab = "Frequency")
  barplot(Com2500, main = "Community size = 2500", xlab = "Species Abundance Octave", ylab = "Frequency")
  barplot(Com5000, main = "Community size = 5000", xlab = "Species Abundance Octave", ylab = "Frequency")
  title("Mean Species Abundance Octaves for Neutral Model Simulated on HPC (Speciation_rate = 0.64)", outer = T, line = -1)
  dev.off()
  
  return("THE PLOT IS DONE!!!")
}


# Question 21
state_initialise_adult <- function(num_stages,initial_size){
  # Number of individuals in adult stages and total number of life stages in the model
  return(c(rep(0,num_stages-1),initial_size))
  # Create a 0 vector concatenating with the initial adult population size to create the final state vector
}

# Question 22
state_initialise_spread <- function(num_stages, initial_size) {
  # Create a 0 vector with length(num_stages)
  state_spread <- rep(0, num_stages)
  for (index in seq(num_stages)) {
    state_spread[index] <- floor(initial_size / num_stages)
  }
  rest_pop <- initial_size %% num_stages
  if (rest_pop == 0) {
    # if this can be evenly disvisible, then just return the state
    return(state_spread)
  }
  for (index in seq(rest_pop)) {
    state_spread[index] <- state_spread[index] +1
  }
  
  return(state_spread)
}

# Question 23
deterministic_step <- function(state, projection_matrix){ 
  # Calculate the new state by performing a matrix multiplication 
  # between the projection matrix and the state vector
  new_state <- projection_matrix %*% state
  return(new_state)
}

# Question 24
deterministic_simulation <- function(initial_state, projection_matrix, simulation_length) {
  
  # Create a vector to store the population size at each time step
  population_size <- rep(NA, simulation_length+1)
  population_size[1] <- sum(initial_state)
  
  # Loop through the time steps and apply the deterministic model
  for (t in 1:simulation_length) {
    state <- deterministic_step(initial_state, projection_matrix)
    initial_state <- state
    population_size[t+1] <- sum(state)
  }
  
  # Return the population size vector
  return(population_size)
}

# Question 25
# Model a population with four life stages and to plot a time series of population size
question_25 <- function(){
  
  # Set the simulation length and projection matrix
  simulation_length <- 24
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  
  # Initial conditions
  initial_state_1 <- state_initialise_adult(4, 100)
  initial_state_2 <- state_initialise_spread(4, 100)
  
  # Simulate the time series of population size
  population_size_1 <- deterministic_simulation(initial_state_1, projection_matrix, simulation_length)
  population_size_2 <- deterministic_simulation(initial_state_2, projection_matrix, simulation_length)
  
  # Plot
  png(filename="question_25.png", width = 600, height = 400)
  plot(1:length(population_size_1), population_size_1, type = "l", col = "red", xlab = "Time", ylab = "Population Size")
  lines(1:length(population_size_2), population_size_2, col = "blue")
  legend("topright", c("Initial conditions with 100 adults in four stages", "Initial conditions with evenly spread population in four stages"), col=c("red", "blue"), lwd=1)
  Sys.sleep(0.1)
  dev.off()
  return("The initial distribution of the population in different life stages can affect the initial and eventual population growth. 
  For example, a population with a large proportion of individuals in the reproductive age range is more likely to have a higher growth rate 
  than a population with a smaller proportion of individuals in this age range.")
  
}


# Question 26
#library(stats)
trinomial <- function(pool, probs) { # Test whether all individuals are guaranteed to be assigned to the first event
  if (probs[1] == 1) { # Returns a vector of all individuals assigned to the first event
    return(c(pool, 0, 0))
  }
  
  # Using the binomial distribution to determine the number of first events
  first_event = rbinom(1, pool, probs[1])
  
  # Calculate the number of individuals remaining in the pool
  remaining_pool = pool - first_event
  
  # Calculate the conditional probability of the second event if the first event does not occur
  prob_event_2 = probs[2] / (1 - probs[1])
  
  # Use binomial distribution to determine how many individuals are assigned to the second event
  second_event = rbinom(1, remaining_pool, prob_event_2)
  
  # Number of third events
  third_event = remaining_pool - second_event
  
  return(c(first_event, second_event, third_event))
}

# Question 27
# state: a vector of population states representing the number of individuals at each life stage
# projection_matrix: a matrix containing the probability of survival and maturity at each life stage
# It returns a new population state vector representing the number of individuals at each life stage after random application of survival and maturity
survival_maturation <- function(state, projection_matrix) { # Initialize the new population state vector with 0
  new_state <- rep(0, length(state))
  new_additions_to_stage_i <- rep(0, length(state))
  
  # 'for' loop of all life stages except the final stage
  for (i in 1:(length(state)-1)) {
    # Find the number of individuals in the current stage
    current_stage_pop <- state[i]
    
    # Generation of the number of individuals to remain in the current stage and transition to the next stage
    N_total <- trinomial(current_stage_pop, c(projection_matrix[i, i], projection_matrix[i+1, i]))
    
    N_stay <- N_total[1]
    N_mature <- N_total[2]
    
    new_additions_to_stage_i[i+1]<- N_mature
#    print(new_additions_to_stage_i)
    new_state[i] <- N_stay + new_additions_to_stage_i[i]
  }
  
  # Generate the number of individuals that survived the final life stage
  # add these individuals to the new_state
  new_state[length(state)] <- rbinom(1, state[length(state)], projection_matrix[length(state), length(state)]) + new_additions_to_stage_i[length(state)]
  
  return(new_state)
}

# Question 28
random_draw <- function(probability_distribution) {
  sample <- runif(1, min = 0, max = 1)
  cumulative_distribution <- cumsum(probability_distribution)
  
  # Determine what is the cumulative probability corresponding to the sample
  for (i in 1:length(cumulative_distribution)) {
    if (sample <= cumulative_distribution[i]) {
      return(i)
    }
  }
}

# Question 29
stochastic_recruitment <- function(projection_matrix, clutch_distribution) {
  ncol <- ncol(projection_matrix)
  recruitment_rate <- projection_matrix[1, ncol]
  clutch_size <- length(clutch_distribution)
  
  # Calculate clutch_size expectations
  expected_clutch_size <- sum(clutch_distribution * 1:clutch_size)
  
  # Calculate recruitment_probability
  recruitment_probability <- recruitment_rate / expected_clutch_size
  
  return(recruitment_probability)
}

# Question 30
offspring_calc <- function(state, clutch_distribution, recruitment_probability) {
  adults <- state[length(state)] # the number of adults
  clutches <- rbinom(1, adults, recruitment_probability) # the number of clutches
#  clutches
  # initialized offspring
  total_offspring <- 0
  if (clutches > 0) {
    for (i in 1:clutches) {
      clutch_size <- random_draw(clutch_distribution) # clutch size from distribution
      total_offspring <- total_offspring + clutch_size # add clutch size into total number
    }
  }
  return(total_offspring)
}

# Question 31
stochastic_step <- function(state, projection_matrix, clutch_distribution, recruitment_probability) {
  new_state <- survival_maturation(state, projection_matrix) 
#  print(new_state)
  num_offspring <- offspring_calc(state, clutch_distribution, recruitment_probability)
#  print(num_offspring)
  # Calculate the number of offspring
  new_state[1] <- new_state[1] + num_offspring 
  # Add offspring to the first stage
  return(new_state)
}

# Question 32
stochastic_simulation <- function(initial_state, projection_matrix, clutch_distribution, simulation_length) {
  population_size = rep(0, simulation_length +1) # preallocation
  population_size[1] <- sum(initial_state) # Adding the initial state to the population size vector
  
  # Calculate recruitment probability
  recruitment_probability <- stochastic_recruitment(projection_matrix, clutch_distribution) 
  
  for (i in 1:simulation_length) {
    #  If the population size is 0, the simulation stops
    if (population_size[i] == 0) {
      return(population_size)
    }
    
    # Randomly sampling
    new_state <- stochastic_step(initial_state, projection_matrix, clutch_distribution, recruitment_probability)
    initial_state <- new_state
    # state <- population_size[i] #??
    
    population_size[i+1] <- sum(new_state) 
    # Adding a new state to the population size vector
  }
  return(population_size)
}

# Question 33
question_33 <- function() {
  simulation_length <- 24
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  
  initial_state_1 <- c(0, 0, 0, 100)
  initial_state_2 <- c(25, 25, 25, 25)
  
  population_size_1 <- stochastic_simulation(initial_state_1, projection_matrix, clutch_distribution, simulation_length)
  population_size_2 <- stochastic_simulation(initial_state_2, projection_matrix, clutch_distribution, simulation_length)

  
  # Plot
  png(filename="question_33.png", width = 600, height = 400)
  plot(1:length(population_size_1), population_size_1, type = "l", col = "red", xlab = "Time", ylab = "Population Size",ylim = c(0, 1000))
  lines(1:length(population_size_2), population_size_2, col = "blue")
  legend("topright", c("Initial conditions with 100 adults in four stages", "Initial conditions with evenly spread population in four stages"), col=c("red", "blue"), lwd=1)
  Sys.sleep(0.1)
  dev.off()
  
  return("The earlier deterministic simulations were smooth, while the stochastic simulations are more jagged.
         This is because the deterministic simulations assumed a fixed number of clutches each time step,
         while the stochastic simulations randomly selected the number of clutches from a given distribution.")
}

# Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

# Question 36
question_36 <- function(){
  
  extinct_250 <- 0
  extinct_500 <- 0
  extinct_750 <- 0
  extinct_1000 <- 0
  
  
  files <- list.files(pattern = "stochastic_model_HPC_results_*")
  
  for(i in 1:length(files)){
    load(files[i]) 
    # load each file one by one
    
    #分别计算各个种群有多少灭绝
    if(i <= 250){
      if(tail(results, n = 1) == 0) {
        extinct_250 <- extinct_250 + 1
      }
    }
    else if (i <= 500){
      if(tail(results, n = 1) == 0) {
        extinct_500 <- extinct_500 + 1
      }
    }
    else if (i <= 750){
      if(tail(results, n = 1) == 0) {
        extinct_750 <- extinct_750 + 1
      }
    }
    else{
      if(tail(results, n = 1) == 0) {
        extinct_1000 <- extinct_1000 + 1
      }
    }
    
  } 
  
  extinct_250 <- extinct_250 / 250
  extinct_500 <- extinct_500 / 250
  extinct_750 <- extinct_750 / 250
  extinct_1000 <- extinct_1000 / 250
  
  
  
  png(filename="question_36.png", width = 600, height = 400)
  # plot your graph here
  barplot(c(extinct_250, extinct_500, extinct_750, extinct_1000),
          xlab = "Initial Condition", ylab = "Proportion of Populations Extinct",
          names.arg = c("large adults P","small adult P", "large spread P", "small spread P"))
  
  Sys.sleep(0.1)
  dev.off()

  return("A small population spread across the life stages are the most likely to extinct, then comes to a large population of 100 adults. 
         Overall a small population shows a more likely to extinct, both evenly spread or adults large population have relatively lower extinct rate. 
         This may because the small population would produce less offsprings, stage by stage, they are more likely to be extinct.")
}

# Question 37
question_37 <- function(){
  
  files <- list.files(pattern = "stochastic_model_HPC_results_*")
  load(files[1])
  total_population_size_large <- data.frame(rep(NA,length(results)))
  total_population_size_small <- data.frame(rep(NA,length(results)))
  
  # For initial condition with a large population spread across the life stage
  for(i in 501:750){
    load(files[i]) 
    # Calculate the total population size for each
    total_population_size_large <- data.frame(total_population_size_large,results)
  }
  # For initial condition with a small population spread across the life stages
  for(i in 751:1000){
    load(files[i]) 
    # Calculate the total population size for each
    total_population_size_small <- data.frame(total_population_size_small,results)
  }
  
  total_population_size_large <- total_population_size_large[, -1]
  total_population_size_small <- total_population_size_small[, -1]
  
  # Calculate the population trend
  population_trend_large <- apply(total_population_size_large, 1, mean)
  population_trend_small <- apply(total_population_size_small, 1, mean)
  
  
  # Set the simulation length and projection matrix
  simulation_length <- 24
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  
  # Set the initial conditions
  initial_state_3 <- state_initialise_spread(initial_size=100,num_stages=4)
  initial_state_4 <- state_initialise_spread(initial_size=10,num_stages=4)
  
  # The deterministic population size
  large_size_deterministic <- deterministic_simulation(initial_state_3, projection_matrix, simulation_length)
  small_size_deterministic <- deterministic_simulation(initial_state_4, projection_matrix, simulation_length)
  
  # Plot
  png(filename="question_37_small.png", width = 600, height = 400)
  plot(small_size_deterministic, type = "l", col = "red", ylim = c(0, 200),
       xlab = "Time step", ylab = "Population size", main = "Small evenly spread population")
  lines(population_trend_small, col = "blue")
  legend("topright", c("small stochastic trend", "small deterministic model"), lty = 1, col = c("red", "blue"))
  Sys.sleep(0.1)
  dev.off()
  
  
  png(filename="question_37_large.png", width = 600, height = 400)
  plot(large_size_deterministic, type = "l", col = "red", ylim = c(0, 600),
       xlab = "Time step", ylab = "Population size", main = "Large evenly spread population")
  lines(population_trend_large, col = "blue")
  legend("topright", c("large stochastic trend", "large deterministic model"), lty = 1, col = c("red", "blue"))
  Sys.sleep(0.1)
  dev.off()
  
  
  return("Depends on the population size, the large evenly spread population shows a more appropriate simulation. 
         As in the large evenly spread population, the expected and deterministic trend lines nearly lapped.
         However, in the small evenly spread population, there are differences but still follows at the similar increasing trends. 
         This might because of the recruitment and clutch probability used in this deterministic is the most idea expected, although took the randomly sampling into count, there is still the 'idea' condition. 
         Therefore, in a small evenly spread population, shows obvious.") 
}


# Challenge questions - these are optional, substantially harder, and a maximum
# of 14% is available for doing them. 

# Challenge question A
# repeated simulation: mean species richness vs time(measured in generations) 
# 97.2% confidence interval on species richness
# repeat for both initial max & min
# no input requires
Challenge_A <- function() {
  graphics.off() # Clear all exist graphs in R
  
  speciation_rate = 0.1
  MaxRch_df = as.data.frame(matrix(NaN, nr = 50, nc = 201)) #Creating a dataframe for saving all richness values
  MinRch_df = as.data.frame(matrix(NaN, nr = 50, nc = 201))
  for(i in 1:50){
    set.seed(i)
    Max_com = init_community_max(100) # Community with 100 individuals
    Min_com = init_community_min(100)
    Max_Rch = species_richness(Max_com)
    Min_Rch = species_richness(Min_com)
    for(j in 1:200){
      Max_com = neutral_generation_speciation(community = Max_com, speciation_rate = speciation_rate)
      Min_com = neutral_generation_speciation(community = Min_com, speciation_rate = speciation_rate)
      Max_Rch = c(Max_Rch, species_richness(neutral_generation_speciation(Max_com, speciation_rate)))
      Min_Rch = c(Min_Rch, species_richness(neutral_generation_speciation(Min_com, speciation_rate)))
    }
    MaxRch_df[i,] = Max_Rch
    MinRch_df[i,] = Min_Rch
  }
  Max_Rch_mean = colMeans(MaxRch_df) # Calculating mean values
  Min_Rch_mean = colMeans(MinRch_df)
  Max_Rch_sd = apply(MaxRch_df,2,sd) # Calculating standard deviations
  Min_Rch_sd = apply(MinRch_df,2,sd)
  Max_Rch_ci = qnorm(0.972)*Max_Rch_sd/sqrt(50) # Calculating confidence intervals
  Min_Rch_ci = qnorm(0.972)*Min_Rch_sd/sqrt(50)
  
  Max_Rch_upper = Max_Rch_mean + Max_Rch_ci
  Max_Rch_lower = Max_Rch_mean - Max_Rch_ci
  Min_Rch_upper = Min_Rch_mean + Min_Rch_ci
  Min_Rch_lower = Min_Rch_mean - Min_Rch_ci
  
  png(filename="Challenge_A_min.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  plot(Min_Rch, frame.plot = F, type = "l", pch = 1, cex = 0.75, col = 1, ylim = c(0,100), ylab = "Diversity", xlab = "Generation", main = "Minmun Time Series of repeated Neutral Model Simulations")
  suppressWarnings(for(i in 1:201){
    # Plotting confidence intervals
    arrows(x0 = i, y0 = as.numeric(Min_Rch_lower[i]), x1 = i, y1 = as.numeric(Min_Rch_upper[i]), code = 3, length = 0.01, col = 1)
    diff = try(t.test(MinRch_df[,i]$p.value), silent = T)
    if(class(diff) != "try-error" && diff > 0.05){
      print(i)
    }
  })
  dev.off()
  
  png(filename="Challenge_A_max.png", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  plot(Max_Rch, frame.plot = F, type = "l", pch = 1, cex = 0.75, col = 1, ylim = c(0,100), ylab = "Diversity", xlab = "Generation", main = "Maximun Time Series of repeated Neutral Model Simulations")
  suppressWarnings(for(i in 1:201){
    # Plotting confidence intervals
    arrows(x0 = i, y0 = as.numeric(Max_Rch_lower[i]), x1 = i, y1 = as.numeric(Max_Rch_upper[i]), code = 3, length = 0.01, col = 1)
    diff = try(t.test(MaxRch_df[,i]$p.value), silent = T)
    if(class(diff) != "try-error" && diff > 0.05){
      print(i)
    }
  })
  dev.off()

}

# Challenge question B

initialise_community <- function(size, SpRch) { # creates community of set size and species richness
  community <- sample.int(SpRch, SpRch, replace = F)
  for (i in 1:(size-SpRch)) {
    ran <- sample.int(SpRch, 1, replace = T)
    community[SpRch + i] <- ran
  }
  return(community)
}
Challenge_B <- function() { # plots mean time series for many communities of various species richnesses
  TimeSeries25 <- data.frame(c(1:1001)) # create data frames to add time series to
  TimeSeries50 <- data.frame(c(1:1001))
  TimeSeries75 <- data.frame(c(1:1001))
  TimeSeries100 <- data.frame(c(1:1001))
  
  for (i in 1:5){ # repeat 5 times for each species richness
    community <- initialise_community(100, 25) 
    TimeSeries25[i] <- neutral_time_series_speciation(community, 0.1, 1000)
  }
  
  for (i in 1:5){ 
    community <- initialise_community(100, 50) 
    TimeSeries50[i] <- neutral_time_series_speciation(community, 0.1, 1000)
  }

  for (i in 1:5){ 
    community <- initialise_community(100, 75) 
    TimeSeries75[i] <- neutral_time_series_speciation(community, 0.1, 1000)
  }
  
  for (i in 1:5){ 
    community <- initialise_community(100, 100) 
    TimeSeries100[i] <- neutral_time_series_speciation(community, 0.1, 1000)
  }
  
  mean25 <- rowMeans(TimeSeries25) # finds mean species richness at each generation
  mean50 <- rowMeans(TimeSeries50)
  mean75 <- rowMeans(TimeSeries75)
  mean100 <- rowMeans(TimeSeries100)
  
  png(filename="Challenge_B.png", width = 600, height = 400)
  par(mfrow = c(2,2))
  # plot your graph here
  Sys.sleep(0.1)
  plot(mean25, type = "l", main = "Initial Richness = 25", xlab = "Generations", ylab = "Species Richness")
  plot(mean50, type = "l", main = "Initial Richness = 50", xlab = "Generations", ylab = "Species Richness")
  plot(mean75, type = "l", main = "Initial Richness = 75", xlab = "Generations", ylab = "Species Richness")
  plot(mean100, type = "l", main = "Initial Richness = 100", xlab = "Generations", ylab = "Species Richness")
  title("Mean Species Richness Over Time for Neutral Model", outer = T, line = -1)
  dev.off()

}

# Challenge question C
save_results_files_for_challenge_C <- function() {
  
  simulation <- 1
  ComSize <- c(500, 1000, 2500, 5000)
  
  means <- list()
  
  for (size in ComSize) {
    
    # running total of richness for each community size
    Rch_series_total <- c()
    
    # for each simulation of each community size (25 each)
    for (i in 1:25) {
      
      load(paste("simulation_", simulation, ".rda", sep=""))
      
      Rch_series_total <- sum_vect(Rch_series_total, time_series)
      
      simulation <- simulation + 1
    }
    
    mean_Rch_series <- Rch_series_total / 25
    means <- c(means, list(mean_Rch_series))
  }
  save(means, ComSize, file="Challenge_C_data.rda")
}

Challenge_C <- function() {
  load("Challenge_C_data.rda")
  
  png(filename="Challenge_C.png", width = 600, height = 400)
  par(mfrow = c(2,2), font.main = 12)
  # plot your graph here
  Sys.sleep(0.1)
  plot(means[[1]], type = "l", main = "Community Size = 500", xlab = "generations", ylab = "Species Richness")
  grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted", lwd = par("lwd"), equilogs = T)
  plot(means[[2]], type = "l", main = "Community Size = 1000", xlab = "generations", ylab = "Species Richness")
  grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted", lwd = par("lwd"), equilogs = T)
  plot(means[[3]], type = "l", main = "Community Size = 2500", xlab = "generations", ylab = "Species Richness")
  grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted", lwd = par("lwd"), equilogs = T)
  plot(means[[4]], type = "l", main = "Community Size = 5000", xlab = "generations", ylab = "Species Richness")
  grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted", lwd = par("lwd"), equilogs = T)
  title("Mean Species Richness for 25 Simulations of Neutral Model for Various Community Sizes", outer = T, line = -1)
  dev.off()

}

# Challenge question D
coalescence_results <- function(J = 500, v = 0.1) { # runs coalesence simulation for given community size and speciation rate
  lineages <- c(rep(1, J)) #initialise vector of 1's, and length J
  abundances <- c() #create empty abundance vector
  N <- J # create number N, set as equal to J
  theta <- v * ((J-1)/(1-v)) # create theta using equation
  while(N > 1){ 
    j <- ceiling(runif(1, 0, N)) # choose number between 1 and N to use as index
    randnum <- runif(1, 0, 1) # chose random number between 0 to 1
    if (randnum < (theta / (theta + N - 1))){ 
      abundances <- c(abundances, lineages[j]) # append lineage[j] to abundances vector
    } else { 
      repeat{ # repeat loop until below if statement is fulfilled
        i <- ceiling(runif(1, 0, N)) # create another index
        if (i != j){ # if i is not equal to j;
          break # break out of repeat loop
        }
      }
      lineages[i] <- lineages[i] + lineages[j] # add lineages[j] to lineages[i]
    }
    lineages <- lineages[-j] #remove lineages[j] from lineages
    N <- N - 1 # minus 1 from N, then go back to top of while loop
  }
  abundances <- c(abundances, lineages) # append lineages to abundances
  return(abundances) # returns abundances of community
}

Challenge_D <- function() { # runs 25 coalesence simulations using coalescence_results, times the process and draws graphs of mean octaves
  ptm <- proc.time()[3] # starts timer
  
  Oct500 <- list() # creates empty lists to store octaves
  Oct1000 <- list()
  Oct2500 <- list()
  Oct5000 <- list()
  
  for (i in 1:200){ # runs 2500 simulations for J = 500, my_speciation_rate = 0.64
    Oct500[[i]] <- octaves(sort(coalescence_results(500, 0.64), decreasing = T))
  }
  for (i in 1:200){
    Oct1000[[i]] <- octaves(sort(coalescence_results(1000, 0.64), decreasing = T))
  }
  for (i in 1:200){
    Oct2500[[i]] <- octaves(sort(coalescence_results(2500, 0.64), decreasing = T))
  }
  for (i in 1:200){
    Oct5000[[i]] <- octaves(sort(coalescence_results(5000, 0.64), decreasing = T))
  }
  
  plotOct500 <- Oct500[[i]] # creates vector to plot
  for (i in 1:(length(Oct500)-1)){
    plotOct500 <- sum_vect(plotOct500, Oct500[[i + 1]])
  }
  
  plotOct1000 <- Oct1000[[i]]
  for (i in 1:(length(Oct500)-1)){
    plotOct1000 <- sum_vect(plotOct1000, Oct1000[[i + 1]])
  }
  
  plotOct2500 <- Oct2500[[i]]
  for (i in 1:(length(Oct2500)-1)){
    plotOct2500 <- sum_vect(plotOct2500, Oct2500[[i + 1]])
  }
  
  plotOct5000 <- Oct5000[[i]]
  for (i in 1:(length(Oct5000)-1)){
    plotOct5000 <- sum_vect(plotOct5000, Oct5000[[i + 1]])
  }
  
  plotOct500 <- plotOct500/length(Oct500) # finds mean octaves
  plotOct1000 <- plotOct1000/length(Oct1000)
  plotOct2500 <- plotOct2500/length(Oct2500)
  plotOct5000 <- plotOct5000/length(Oct5000)
  
  
  png(filename="Challenge_D.png", width = 600, height = 400)
  par(mfrow = c(2,2), las = 2)
  # plot your graph here
  Sys.sleep(0.1)
  barplot(plotOct500, main = "size = 500", ylab = "Number of species", xlab = "Octave Classes")
  barplot(plotOct1000, main = "size = 1000", ylab = "Number of species", xlab = "Octave Classes")
  barplot(plotOct2500, main = "size = 2500", ylab = "Number of species", xlab = "Octave Classes")
  barplot(plotOct5000, main = "size = 5000", ylab = "Number of species", xlab = "Octave Classes")
  dev.off()
  
#  running_time <- as.numeric(proc.time()[3] - ptm) # prints time taken for function to run
  
  return(paste(as.numeric(proc.time()[3] - ptm),"seconds were taken for  Coalescence simulations (200 repeats), but an analogous set of simulations on the cluster required a total of 11.5 hours to run (11.5 hrs for each of 100 simulations). Only those lineages that are present in the final community are simulated, which makes the coalescence simulations so much faster. However, the conclusions from the two approaches are comparable and with no obvious differences.", sep=" "))
}

# Challenge question E
# New function similar to stochastic_simulation but calculates the average stage during simulation and outputs the average stage instead of the population size
sto_simu_mean <- function(initial_state, projection_matrix, clutch_distribution, simulation_length) {
  # A weighted average function to calculate the mean stage
  # Define function
  mean_stage_cal <- function(stage) {
    # Calculate the mean
    weighted_mean <- sum(1:length(stage) * stage) / sum(stage)

    return(weighted_mean)
  }
  
  mean_stage <- c()
  mean_stage[1] <- mean_stage_cal(initial_state) # Adding the initial state to the stage_mean vector
  
  # Calculate recruitment probability
  recruitment_probability <- stochastic_recruitment(projection_matrix, clutch_distribution) 
  
  for (i in 1:simulation_length) {
    # Random sampling
    new_state <- stochastic_step(initial_state, projection_matrix, clutch_distribution, recruitment_probability)
    initial_state <- new_state
    mean_stage[i+1] <- mean_stage_cal(new_state) 
    
  }
  return(mean_stage)
}

Challenge_E <- function(simulation_length, clutch_distribution, projection_matrix, initial_state_1, initial_state_2) {
  # Default
  simulation_length <- 24
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  
  initial_state_1 <- state_initialise_adult(4, 100)
  initial_state_2 <- state_initialise_spread(4, 100)
  
  # Use sto_simu_mean to calculate the average stage level of the simulation
  mean_stage_1 <- sto_simu_mean(initial_state_1, projection_matrix, clutch_distribution, simulation_length)
  mean_stage_2 <- sto_simu_mean(initial_state_2, projection_matrix, clutch_distribution, simulation_length)
  
  # Plot
  png(filename="Challenge_E.png", width = 600, height = 400)
  plot(1:length(mean_stage_1), mean_stage_1, type = "l", col = "red", xlab = "Time", ylab = "Mean Life Stage", ylim = c(0, 5))
  lines(1:length(mean_stage_2), mean_stage_2, col = "blue")
  legend("topright", c("Initial conditions 1 with 100 adults in four stages", "Initial conditions 2 with evenly spread population in four stages"), col=c("red", "blue"), lwd=1)
  Sys.sleep(0.1)
  dev.off()
  
  return("Initial conditions 1 which contains 100 adults has been maintained at a stable level, but Initial conditions 2 which evenly spread has experienced an increasing trend.
         In the first condition, with a population of 100 adults, the mean life stage will initially be at the final life stage (adulthood) 
         because there are no individuals in any of the other life stages. The graph of mean life stage against time will start at 
         a constant value of the final life stage and remain there unless there is a change in the population size or life stage distribution.
         In the second condition with a population of 100 individuals spread across the four life stages, the mean life stage 
         will be a weighted average of the proportions of individuals in each life stage. The graph of mean life stage against time will depend on 
         how the proportions of individuals in each life stage change over time. ")
  
}

# Challenge question F
Challenge_F <- function() {
  
  files <- list.files(pattern = "stochastic_model_HPC_results_*")
  
  simulation_number <- c()
  initial_condition <- c()
  time_step <- c()
  population_size <- c()
  
  population_size_df <- data.frame(simulation_number, initial_condition, time_step, population_size, 
                                   stringsAsFactors = FALSE)
  population_size_df1 <- data.frame(simulation_number, initial_condition, time_step, population_size, 
                                    stringsAsFactors = FALSE)
  population_size_df2 <- data.frame(simulation_number, initial_condition, time_step, population_size, 
                                    stringsAsFactors = FALSE)
  population_size_df3 <- data.frame(simulation_number, initial_condition, time_step, population_size, 
                                    stringsAsFactors = FALSE)
  population_size_df4 <- data.frame(simulation_number, initial_condition, time_step, population_size, 
                                    stringsAsFactors = FALSE)
  
  # Generate all data frames
  for(i in 1:length(files)){
    load(files[i]) 
    
    # Calculate each survival condition separately
    if(i <= 250){
      for(j in 1:length(results)){
        population_size_df[j,1] <- i  # Fill simulation_number
        population_size_df[j,2] <- "small adult"  # Fill initial_condition
        population_size_df[j,3] <- j-1  # Fill time_step
        population_size_df[j,4] <- results[j] # Fill population_size
      }
      population_size_df1 <- rbind(population_size_df1,population_size_df)
      
    }
    
    else if (i <= 500){
      for(j in 1:length(results)){
        population_size_df[j,1] <- i  # Fill simulation_number
        population_size_df[j,2] <- "large adult"  # FIll initial_condition
        population_size_df[j,3] <- j-1  # Fill time_step
        population_size_df[j,4] <- results[j] # Fill population_size
      }
      population_size_df2 <- rbind(population_size_df2,population_size_df)
    }
    
    else if (i <= 750){
      for(j in 1:length(results)){
        population_size_df[j,1] <- i  # Fill simulation_number
        population_size_df[j,2] <- "small evenly spread"  # Fill initial_condition
        population_size_df[j,3] <- j-1  # Fill time_step
        population_size_df[j,4] <- results[j] # Fill population_size
      }
      population_size_df3 <- rbind(population_size_df3,population_size_df)
    }
    
    else{
      for(j in 1:length(results)){
        population_size_df[j,1] <- i  # Fill simulation_number
        population_size_df[j,2] <- "large evenly spread "  # Fill initial_condition
        population_size_df[j,3] <- j-1  # Fill time_step
        population_size_df[j,4] <- results[j] # Fill population_size
      }
      population_size_df4 <- rbind(population_size_df4,population_size_df)
    }
  }
  # Aggregate the results of all four simulations into population_size_df
  population_size_df <- data.frame()
  population_size_df <- rbind(population_size_df1,population_size_df2,population_size_df3,population_size_df4)
  colnames(population_size_df) <- c("simulation_number", "initial_condition", "time_step", "population_size")
  
  # Plot
  library(ggplot2)
  ggplot(data = population_size_df, aes(x = time_step, y = population_size, group = simulation_number, 
                                        colour = initial_condition)) +
    geom_line(alpha = 0.1) +
    xlab("Time step") +
    ylab("Population size") +
    ggtitle("Population size time series for all simulations")
  
  
  ggsave("Challenge_F.png")
}

