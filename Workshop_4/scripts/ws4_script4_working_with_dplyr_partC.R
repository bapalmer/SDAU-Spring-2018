####################################################################
#                     The tidyverse and beyond 
#                           Workshop 4
#              It's the end of base R as you know it
#                         6th March 2018
#                 3: working with dplyr: Part B
####################################################################
# Clear your environment pane and we'll reload some of the nycflights13 data

flights <- nycflights13::flights

planes <- nycflights13::planes

airlines <- nycflights13::airlines

airports <- nycflights13::airports

# A useful way to identify primary keys in your data is to count them

planes %>% 
    count(tailnum) %>%
    filter(n > 1)

weather %>% 
    count(year, month, day, hour, origin) %>%
    filter(n > 1)
# In this second example a combination of variables provides a unique identifier

# Flights does not have any primary keys
# You can add a unique identifier using mutate()

flights_id <- flights %>%
    mutate(rows = 1:336776)

# Like mutate(), joins add columns to the right of your table
# There are many things to consider when joining your data
# For now, lets just try an example
# If you want to learn more, "R for Data Science" should be your next stop

flights_plane_info <- flights %>%
    left_join(planes, by = "tailnum")

# In that example "tailnum" was present in both
# In the airports data frame, "faa" denotes the three letter abbreviation
# In the flights data frame, "origin" is used
# We need to get around that as follows

flights_airport_info <- flights %>%
    select(-c(1:11, 15:19)) %>%  #This just removes unwanted columns for this example
    left_join(airports, c("origin" = "faa"))

# 1. Have a go at joining the flights and airlines data frames
 
    
    
