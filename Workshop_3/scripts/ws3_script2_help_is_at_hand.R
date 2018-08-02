####################################################################
#                     The tidyverse and beyond 
#                           Workshop 3
#                     Send an SOS to the world
#                        27th February 2018
#                        2. Help is at hand
####################################################################
# In this part of the workshop we will combine the dplyr cheatsheet 
# with the dplyr web resources 
# More information can be found by visiting;
# http://dplyr.tidyverse.org/reference/index.html

library(dplyr)

# For this section we will use the starwars data set that comes with dplyr

starwars <- starwars
View(starwars)

# Remember that (in general) the tidyverse code structure is;
#   a. the input data
#   b. the function
#   c. the arguments

# Write lines of code to complete the following tasks

# 1. Lets first attempt to filter the starwars data by species
# Create a new data frame that contains all the "human" Starwars characters

# 2. Now repeat using a second condition, e.g. eye colour, hair colour

# Which Starwars character has the highest Body Mass index (BMI)?
# Lets create a new data frame containing the characters column, together
# with height and weight columns

characters <- starwars %>%
  select(name, height, mass) %>% # height in cm, mass in kg
  drop_na() # drops rows containing missing data

# BMI = mass (kg) / height^2 (meters)

# Now we'll use mutate to generate a column containing BMI readings

BMI <- characters %>%
  mutate(BMI = mass / (height/100)^2)
  
# 3. Examine the data transformation cheatsheet
# Find a way to identify which Starwars character had the highest BMI


