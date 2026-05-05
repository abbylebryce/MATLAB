#!/bin/bash

#SBATCH --job-name=Trial_Choosiness # CHANGED
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=0-3:00:00
#SBATCH --mem=200M
#SBATCH --account= bisc035324
#SBATCH --array 1-25 # CHANGED
#SBATCH --mail-user=os25298@bristol.ac.uk
#SBATCH --mail-type=ALL

#!/bin/bash

#SBATCH --job-name=Trial_Choosiness
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=0-3:00:00
#SBATCH --mem=200M
#SBATCH --account=bisc035324
#SBATCH --array=1-25
#SBATCH --mail-user=os25298@bristol.ac.uk
#SBATCH --mail-type=ALL

# -------------------------------------------------------------------
# ARRAY JOB SUBMISSION SCRIPT
# Runs the Trial_Choosiness MATLAB model across 25 parameter combinations
# CHANGED from before: rather than make a new MATLAB file for every job,
# now run the same MATLAB file 25 times, each time with different SLURM-provided ID
# Each array task corresponds to one SimID (1–25)
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# 1. SET WORKING DIRECTORY
# -------------------------------------------------------------------
cd /user/work/os25298/Trial_Choosiness_Simulation/

# -------------------------------------------------------------------
# 2. LOAD MATLAB MODULE
# -------------------------------------------------------------------
module load apps/matlab/r2023b

# -------------------------------------------------------------------
# 3. RUN MATLAB SCRIPT
# -------------------------------------------------------------------
# IMPORTANT CHANGE:
# Instead of copying scripts or using sed, MATLAB reads the SLURM array index directly.

matlab -nodisplay -nodesktop -nosplash -r "run('scripts/Trial_Choosiness_model_for_HPC.m'); exit"

# -------------------------------------------------------------------
# END OF SCRIPT
# -------------------------------------------------------------------

