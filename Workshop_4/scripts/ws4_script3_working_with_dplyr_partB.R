####################################################################
#                     The tidyverse and beyond 
#                           Workshop 4
#              It's the end of base R as you know it
#                         6th March 2018
#                 3: working with dplyr: Part B
####################################################################
# NOTE: For this script we will place the data outside the function
# and use the magrittr operator ("%>%")

# The summarise() function can collapse data down to a single row
# Consider the following code
# What is the mean departure delay time?

flights %>%
    summarise(delay = mean(dep_delay, na.rm = TRUE))

# If we re-run this code, but first group the data, 
# the information returned is much more useful

flights %>%
    group_by(month) %>%
    summarise(dep_delay = mean(dep_delay, na.rm = TRUE))

# This returns the mean for each month

# 1. Complete the code below to give a mean departure delay
# for each day of each month

gp_day <- flights %>%
    group_by()

# Take note of the change to the type of data you have just created in
# the environment tab

# Check the output

gp_day %>%
    summarise()

# 2. Now, lets extend this to group by airport and month
# This information might influence where you depart from next time!

gp_mth_origin <- flights %>%
    group_by()%>%
    summarise()

# Let take a closer look at the flights that have no departure information

no_departure_plot <- flights %>%
    filter(is.na(dep_time)) %>%
    ggplot() +
        geom_bar(mapping = aes(x = time_hour))

# Here we just piped the data straight to ggplot2 but the plot is now
# stored as a new object, so it hasn't displayed automatically

no_departure_plot
 
# It looks as though February wasn't a great month for flight departures
# Lets filter the data for February and group the information
# What day had the most cancelled flights?
    
worst_day_feb <- flights %>%
    filter(month == 2, is.na(dep_time)) %>%
    group_by(day, origin) %>%
    count(day) %>%
    arrange(desc(n)) # Re-arrange the rows to give the highest value first

ggplot(data = worst_day_feb) +
    geom_point(mapping = aes(x = day, y = n, colour = origin)) +
    theme_classic()
    
head(worst_day_feb, n = 10) # Default head() output is the first 6 entries

# What happened on the 8th and 9th February?
weather <- nycflights13::weather

# Lets examine the rainfall for February
# First, we need to group the data

feb_weather <- weather %>% 
    filter(month == 2) %>%
    select(-year) %>%
    group_by(origin, day)

# Then we want to build our summaries

feb_daily <- summarise(feb_weather, avg_rainfall = mean(precip, na.rm = TRUE),
                       # Gives us the average rainfall each day
                       max_wind = max(wind_speed), # Maximum windspeeds by day
                       min_viz = min(visib)) # Minimums daily visibilities

ggplot(feb_daily) +
    geom_jitter(aes(x = as.factor(day), 
                   y = avg_rainfall, colour = origin)) +
    theme_classic()

# Looks like the worst rainfall was on the 27th of February
# No real clues there

ggplot(feb_daily) +
    geom_jitter(aes(x = as.factor(day), 
                   y = min_viz, colour = origin)) +
    theme_classic()

# Visibility wasn't great on the 8th or 9th, but again, it wasn't the worst
# What's going on here??????

