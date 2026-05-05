#!/bin/bash

#SBATCH --job-name=Trial_Choosiness # CHANGED
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=0-3:00:00
#SBATCH --mem=200M
#SBATCH --account=bisc035324
#SBATCH --array 1-25 # CHANGED
#SBATCH --mail-user=os25298@bristol.ac.uk
#SBATCH --mail-type=ALL

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# ARRAY JOB SUBMISSION SCRIPT FOR RUNNING THE SIMULATION AT DIFFERENT LEVELS OF CLUTCH SIZE AND PROPORTION OF HQ AND LQ PATCHES
# This HPC submission script runs 
# ‘Trial_Choosiness_model_for_HPC.m' across 25 different combinations of clutch size and proportion of HQ/LQ

# -------------------------------------------------------------------
# START THE LOOP THROUGH THE DIFFERENT MATLAB SIMULATIONS:

# We run 25 simulations in total, i.e. across 5 combinations of clutch size and 5 combinations of proportion of HQ/LQ

# Set the simulation ID number:
SimID=${SLURM_ARRAY_TASK_ID}

# --------------------------------------------------------------------------------------------
# CREATE A MATLAB SCRIPT FOR THIS SPECIFIC SIMULATION RUN:

# Set working directory to the main Trial_Choosiness_Simulation folder: #NOTE: need to create
cd /user/work/os25298/2-Trial_Choosiness_Simulation/ 

# Create a new MATLAB script, using the standard 'Trial_Choosiness_model_for_HPC.m' script that we have already uploaded:
cp /user/work/os25298/2-Trial_Choosiness_Simulation/Trial_Choosiness_model_for_HPC.m Trial_Choosiness_model_for_HPC_${SimID}.m 

# --------------------------------------------------------------------------------------------
# FIND THE CLUTCH SIZE AND PROPORTION VALUE IN THIS SIMULATION RUN:  #CHANGED ALL BELOW BRINKMANSHIP TO TRIAL_CHOOSINESS

# Insert the SimID  into the MATLAB (.m) script file:
sed -i "s/SIMID_FROM_BLUEPEBBLE_ARRAY_JOB/${SimID}/g" Trial_Choosiness_model_for_HPC_${SimID}.m
# This is then used within the MATLAB script to find the value for clutch size and proportion of HQ/LQ.

# --------------------------------------------------------------------------------------------
# INITIALISE THIS SIMULATION RUN:

# Load MATLAB on BluePebble:
module load apps/matlab/r2023b

# Run this simulation in MATLAB on BluePebble:
matlab -batch "Trial_Choosiness_model_for_HPC_${SimID}"  # CHANGED

# --------------------------------------------------------------------------------------------
# MOVE THE RESULTS TO THE RESULTS FOLDER:

# The MATLAB script produces a MAT file containing the output variables, called 'MATLAB_Trial_Choosiness_Output_${SimID}.m'. 

# Ensure output directory exists (safe even if already created)
mkdir -p /user/work/os25298/2-Trial_Choosiness_Simulation/output

# MATLAB then automatically saves them there

# Now that this specific simulation run has completed, delete its corresponding MATLAB script from BluePebble:
rm Trial_Choosiness_model_for_HPC_${SimID}.m
# --------------------------------------------------------------------------------------------

