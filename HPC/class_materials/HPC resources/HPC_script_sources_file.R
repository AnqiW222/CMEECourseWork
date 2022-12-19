# Clear workspace and turn off graphics
rm(list=ls())
dev.off

# Source the function file we need
source("/rds/general/user/aw222/home/filename_to_source.R")

# Find out the job number:
seed_number <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))

# Do all the things we want it to do here (figure out the right parameters,
# set random seed, run the function which produces the output)
save(output,file=paste("output_",seed_number,".rda",sep=""))

rm(output,seed_number)
