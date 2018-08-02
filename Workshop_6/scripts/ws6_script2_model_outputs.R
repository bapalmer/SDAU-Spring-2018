####################################################################
#                     The tidyverse and beyond 
#                            Workshop 6
#                     Don't look back in anger
#                          27th March 2018
#                          2: Model outputs
####################################################################
# Forbes (1857) measured the boiling point of water and atmospheric 
# pressure at 17 locations
# The data suggests a linear relationship between the boiling point
# of water in degrees Fahrenheit (x) and 100*log(Pressure) (y) 
# Recall: y = mx + c

# Here the response variable (y) is Pressure
# The predictor variable (x) is boiling point of water

# Load packages

library(tidyverse)
library(broom)

# Load the Forbes data set

bp_df <- read_delim("data/forbes.txt", delim = "\t", trim_ws = TRUE)

# 1. Plot the data

ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
    geom_point() 

# We are testing null hypothesis that there is no relationship between
# boiling point and pressure, i.e. the slope equals zero
# The alternative hypothesis is that there is a relationship

# 2. Build the linear model using the "lm()" function
# In this model the relationship appears when we log transform Pressure

forbes_lm <- lm(100*log10(Pressure) ~ Boilingpt, data = bp_df)

# 3. Plot the data with the fitted line from the model

ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE)

summary(forbes_lm)

# 4. Using the tidy() function from the broom package we can 
# collect the important outputs in a data frame 

forbes_lm_df <- tidy(forbes_lm)
View(forbes_lm_df)

# Interpretation of the results
# The slope of the line = 0.8956178
# For every unit increase in boiling point of water there is a
# 0.8956178 unit increase in the corresponding 100*log(Pressure)

# Multiple R-squared: 0.995
# 99.5% of the variability in the 100*log(Pressure) data is explained
# by the change in boiling point

# F-statistic:  2962, p-value: < 2.2e-16
# We reject the null hypothesis that H0: slope = 0 and conclude that 
# boiling point can be used as a predictor of 100*log(Pressure)
