####################################################################
#                     The tidyverse and beyond 
#                            Workshop 5
#                      Welcome to the ggungle
#                         13th March 2018
#                   4: Exploratory data analysis
####################################################################
# Clear your global environment, so that we are working from a clean slate
# We'll use the diamonds data frame for this section

diamonds <- diamonds
?diamonds # Get a sense of the variables

# Visualising distributions
# For categorical data, bar plots are recommended 

ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut))

# Continuous data is better served with histograms as the x-axis is 
# divided into equally spaced bins

ggplot(data = diamonds) +
    geom_histogram(mapping = aes(x = carat), binwidth = 0.1)

# Different binwidths can reveal different patterns
# 1. Change to binwidth to a smaller value (e.g. 0.01) and re-run
# Does this help you pose any questions of the data

# In general, clusters of similar values suggest that subgroups exist
# This might help you develop a hypothesis to test

# Outliers
# We saw a very obvious outlier in the nycflights13::weather data frame
# Sometimes the detection of outliers might lead to new discoveries
# Outliers might not always be easy to detect

ggplot(diamonds) +
    geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# Note: there's column in diamonds named "y"!!
# In this example the only evidence of an outlier is the unusually wide x-axis

# We can zoom in on specific areas of the graph

ggplot(diamonds) +
    geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
    coord_cartesian(ylim = c(0, 50))

# 2. Complete the following code to extract the information for these outliers

outlier <- diamonds %>%
    filter(y < 2 | y > 20) %>% # use logical operators to subset away these "y" outliers 
    arrange(y)

# Plots with two variables may reveal outliers that are not visible in plots
# with just one variable 

ggplot(data = diamonds) +
    geom_point(mapping = aes(x = x, y = y))

# The x and y values may be ok in isolation, but when combined are unusual

ggplot(data = diamonds) +
    geom_point(mapping = aes(x = x, y = y)) +
    coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

# If you omit these values and it has a minimal effect on the analysis, then
# it's reasonable to replace these missing values and move on
# If it has a big effect on the outcome of your analysis, you shouldn't drop
# them without providing justification

# Covariation
# A categorical versus a continuous variable can be viewed with boxplots
# The mpg data set is perhaps more useful for this example

mpg <- mpg
ggplot(data = mpg) +
    geom_boxplot(mapping = aes(x = class,
                               y = hwy)) 

# To make a trend easier to see we can reoder class based on the median value of hwy

ggplot(data = mpg) +
    geom_boxplot(
        mapping = aes(
            x = reorder(class, hwy, FUN = median),
            y= hwy
        )
     )

# Patterns
# Patterns in your data help reveal covariation
# The faithful data set contains data on waiting time between
# eruptions and the duration of the eruption for the Old Faithful
# geyser in Yellowstone National Park

ggplot(data = faithful) +
    geom_point(mapping = aes(x = eruptions, y = waiting))

# This might be easier to see if we "cut" the data

ggplot(data = faithful) +
    geom_point(mapping = aes(x = eruptions, y = waiting,
                             colour = cut(eruptions, c(0, 3, Inf))
                             )
    )

# You can make predictions about one variable based in the patterns of another
