# Find out the job number:
seed_number <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

# Set this as the random seed so that all runs have a unique seed:
set.seed(seed_number)

# Run whatever simulation we want:
output <- runif(n=10000,min=0,max=1) # this is just an example "simulation"

# Save this to a file, ensuring each output has a unique filename:
save(output,file=paste("output_",seed_number,".rda"))
# You could also do this part inside another R function which you call

# Remove our objects from the environment:
rm(output,seed_number)