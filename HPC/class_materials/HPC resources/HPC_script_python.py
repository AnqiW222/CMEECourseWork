# Find out the job number:
seed_number = int(os.getenv("PBS_ARRAY_INDEX"))

# Set this as the random seed so that all runs have a unique seed:
seed(seed_number)

# Run whatever simulation we want:
output = numpy.random.uniform(0,1,1000) # this is just an example "simulation"

# Save this to a file, ensuring each output has a unique filename:
with open(print("output_",str(seed_number),".data",sep=""),"w") as f:
  f.write(output)
# You could also do this saving part inside another function which you call
  
# Remove our objects from the environment:
del seed_number
del output
