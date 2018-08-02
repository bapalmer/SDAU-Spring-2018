####################################################################
#                     The tidyverse and beyond 
#                            Workshop 6
#                     Don't look back in anger
#                          27th March 2018
#                         3: Too much choice
####################################################################
# There are many, many ways to do the same thing in R
# Run the code below for some examples

library(tidyverse)

# Lets load a data set containing info on Star Wars characters

starwars <- starwars

# Inconsistent function names
# Row names

row.names(starwars)
rownames(starwars)
row.names(starwars) == rownames(starwars)

# Variable selection

summary(starwars$name)
summary(starwars$"name")
summary(starwars["name"])
summary(starwars[,"name"])
summary(starwars[["name"]])
summary(starwars[1])
summary(starwars[,1])
summary(starwars[[1]])

# While the summary() function returned a result in each instance,
# the output structures differed
# How the information is fed to functions is important
# Consider the following when we try to find the mean height
# using the same basic code as above

mean(starwars$height, na.rm = TRUE)
mean(starwars$"height", na.rm = TRUE)
mean(starwars["height"], na.rm = TRUE)
mean(starwars[,"height"], na.rm = TRUE)
mean(starwars[["height"]], na.rm = TRUE)
mean(starwars[2], na.rm = TRUE)
mean(starwars[,2], na.rm = TRUE)
mean(starwars[[2]], na.rm = TRUE)

# Some insight
typeof(starwars$height)
typeof(starwars$"height")
typeof(starwars["height"])
typeof(starwars[,"height"])
