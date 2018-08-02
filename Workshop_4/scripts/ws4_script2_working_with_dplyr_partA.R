####################################################################
#                     The tidyverse and beyond 
#                           Workshop 4
#              It's the end of base R as you know it
#                         6th March 2018
#                 2: working with dplyr: Part A
####################################################################
# Start by loading the tidyverse package using the library() function

library(tidyverse)

# A word of caution continued:
# Compare the following results?
1/49*49 == 1

near(1/49*49, 1)

# Take note of the conflicts message that gets printed
# dplyr overwrites some functions in base R
# Should you ever want to use the base function, call on it by its full name
# e.g. stats::filter()

# In this session we'll use at the nycflights13 data
# This contains data for all flights departing NYC in 2013
# New York airports are JFK, LGA and EWR

# NOTE: For this script we will place the data inside the function

# REMINDER:
# If you are supplying a character string to the function, put it in "quotes"

install.packages("nycflights13")
library(nycflights13)

flights <- nycflights13::flights

planes <- nycflights13::planes

airlines <- nycflights13::airlines

# filter() lets you perform subsetting of your data based on the conditions you provide
# It won't alter the input data when performs this operation
# But if you want to save the result, use the assignment operator 
# For example, which planes manufactured in 1999 have more than 150 seats?

seats_150 <- filter(planes, year == 1999, seats > 150)

# Note the use of the logical operators

# Check the result
nrow(seats_150)
table(seats_150$year)
table(seats_150$seats)

# Another way to write this is...

seats_150_b <- filter(planes, year == 1999 & seats > 150 )

# 1. Find all the flights that departed JFK airport on the 24th December
# Make sure you check your spelling, is it "JFK", "jfk", "Jfk"!

christmas_jfk <- filter()

# 2. Using a logical operator from the lecture notes
# Select flights that departed on 24th day of every month except December

not_dec <- filter()

# Check the result

unique(not_dec$month)
unique(not_dec$day)

# Missing values are denoted by NA
# Filter will pass over NAs in the data unless we explicitly ask for them
# using the function is.na() 

no_tail_number <- filter(flights, is.na(tailnum))

# 3. Get all the flights that have no departure information

no_departure <- filter(flights, is.na(dep_time))

# Lets remove some columns from the no_departure data set using select
# By placing a minus in front of the column name, it is removed
# A double colon between two column names, selects these columns and the columns in between

e.g.1 <- select(no_departure, -(year:day))

# You can be more explicit but it requires more typing

e.g.2 <- select(no_departure, -year, -month, -day) 

# The order in which the columns are listed, is the order that they
# will be returned in the new data set
# Have a look at the output of the following;

e.g.3 <- select(no_departure, day, month, year, 
                sched_dep_time, sched_arr_time, everything())

# Note the use of the helper function "everything()"

# 4. Create a new dataset from no_departures without the following columns;
# dep_time, dep_delay, arr_time, arr_delay, air_time, dist, hour, minute 

no_departure_v2 <- select()

# It's often easier to have more understandable columns names
# These can easily be changed using rename
# 5. Rename some of your columns in no_departures_v2
# rename(no_departure_v2, dist = distance)

delays <- select(flights, contains("delay"))

# Note: The "contains()" helper function

?contains()

# mutate() will add new columns to the end of your data set 
# e.g. calculate the total flight delay

delays <- mutate(delays, delay_min = dep_delay + arr_delay)

# 6. Create a new column in delays called delay_hours
# To divide in R use "/"

# 7. Use "?" to understand the use of arrange() and desc()
# Re-arrange delay_hours to display the flights with the longest delays

