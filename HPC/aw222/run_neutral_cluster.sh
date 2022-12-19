#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
cp $HOME/aw222_HPC_2022_main.R $TMPDIR
R --vanilla < $HOME/aw222_HPC_2022_neutral_cluster.R
mv Simulation_* $HOME
# mv *_.rda /rds/general/user/aw222/home
echo "Completed! files are ready to be read"