#!/bin/bash
#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
# cp $HOME/aw222_HPC_2022_main.R $TMPDIR
R --vanilla < $HOME/aw222_HPC_2022_demographic_cluster.R
mv stochastic_model_HPC_results_* $HOME
# mv *_.rda /rds/general/user/aw222/home
echo "Completed! files are ready to be read"