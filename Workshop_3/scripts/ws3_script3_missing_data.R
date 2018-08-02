####################################################################
#                     The tidyverse and beyond 
#                           Workshop 3
#                     Send an SOS to the world
#                        27th February 2018
#                         3. Missing data
####################################################################
# General notes on missing data ---- 

library(tidyverse)

# Missing data is represented as NA in R
# We have seen cases where filter() uses TRUE/FALSE results to 
# return the data to you

data <- tibble(x = c(1,2,3, NA, 5, NA, 7, 8))

filter(data, x > 5)

# In the last script we used the "drop_na()" function to remove whole rows
# However, it's probably a bad idea to remove whole rows from your data
# because of one missing value

# Better to explore the data and try to retain as much information as possible

# You can use logical operators to retain missing data

filter(data, is.na(x) | x > 5)

# i.e. is the data missing or is it greater than 5

# Some simple data to demonstrate tidyverse missing data functions

car_sales <- tibble(
  year = c(2001, 2001, 2001, 2001, 2002, 2002, 2002),
  qtr = c(1, 2, 3, 4, 2, 3, 4),
  number = c( 12, 12, NA, 5, 6, 10, 15)
) 

# The "complete()" function makes missing values explicit where necessary

car_sales %>%
  complete(year, qtr)

# Note the extra row added to the data frame

# Occasionally data can be missing where NA represents carryover of the
# information from the previous row, e.g. data entry

info <- read_csv("firstname, surname, reading, value
                  Jane, Jones, 1, 111
                  NA, NA, 2, 131
                  NA, NA, 3, 125
                  John, Smith, 1, 120
                  NA, NA, 2, 120")
View(info)

# Here we can fill in the NAs

info_update <- info %>%
  fill(firstname, surname)
View(info_update)

# Sophisticated packages have been developed to assist with imputation of 
# missing data from next generation sequencing data

# ggplot will not include missing data in the graph but it will tell you
# that they were dropped

ggplot(data = car_sales) +
  geom_point(mapping = aes(x = qtr, y = number))

# This message can be silenced
ggplot(data = car_sales) +
  geom_point(mapping = aes(x = qtr, y = number), na.rm = TRUE)

# Other useful resources ----
# The Visualization and Imputation of Missing values package (VIM) package
# for R has been developed to deal with missing values in data sets

install.packages("VIM")
library(VIM)

sleep <- VIM::sleep
View(sleep_data)

# The function "aggr()" aggregates missing data by column
# This is useful to get a quick overview of your missing data

aggr(sleep)

# Imputation of missing data is too broad a topic to cover here
# Often, depending on the data, the mean, median, 1 or 0 may be used
