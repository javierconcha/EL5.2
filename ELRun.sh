#!/bin/bash -l
# NOTE the -l flag!
#

# This is an example job file for a multi-core MPI job.
# Note that all of the following statements below that begin
# with #SBATCH are actually commands to the SLURM scheduler.
# Please copy this file to your home directory and modify it
# to suit your needs.
# 
# If you need any help, please email rc-help@rit.edu
#

# Name of the job - You'll probably want to customize this.
#SBATCH -J ELRun

# Standard out and Standard Error output files
#SBATCH -o ELRun.output
#SBATCH -e ELRun.output

# Request 2 mins run time MAX, anything over will be KILLED
#SBATCH -t 0:2:0

# Put the job in the "work" partition and request FOUR cores
# "work" is the default partition so it can be omitted without issue.
#SBATCH -p work -n 1


#
# Your job script goes below this line.  
# 

#/home/jxc4005/ecolight52_install/Code/Ecolight/mainEL_stndg95.exe < ./input.txt

cd flag

/home/jxc4005/ecolight52_install/Code/Ecolight/mainEL_stnd.exe < ./input.txt

awk 'c&&!--c;/Rrs \= Lw\/Ed/{c=3}' POutputEL.txt |awk '{ print $8 }'>tempR.txt

mv tempR.txt ./ref/
rm ./* 2> /dev/null
#exit
