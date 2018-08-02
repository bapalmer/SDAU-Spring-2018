# Title ---------------------------------------------------------------
# Analysis of the WHO TB data set
# R tidyverse workshop 6: Don't look back in anger
# 27th March 2016

# Load the required packages
library(tidyverse)

# Section 1: Load the data ---------------------------------------------
# This data frame has 2 lines of meta data that must be skipped over
# Note: Change the path to the one on your computer

who_df <- read_csv("data/who.csv", skip = 2)

# Ensure the data is loaded correctly

View(who_df)

# Section 2: Data tidying steps using tidyr ----------------------------

# Section 3: Transformation of the data using dplyr --------------------

# Top tip: When writing code (e.g. selecting columns),
# pick the option that requires the least amount of text

# Check everything is still ok

# Some housekeeping:
# Remove unnecessary objects from the global environment using rm()

# rm(unwanted_object)

# Section 4: Data analysis --------------------------------------------
# Pick any question you'd like to ask of the data
# I'm from Ireland, so I might be interested in TB data for Ireland
# Draw a graphical output

# Section 5: Summary analysis ----------------------------------------

