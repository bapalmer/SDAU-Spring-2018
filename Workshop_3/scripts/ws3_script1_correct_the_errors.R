####################################################################
#                     The tidyverse and beyond 
#                           Workshop 3
#                     Send an SOS to the world
#                        27th February 2018
#                      1. Correct the errors
####################################################################
# Start by loading the readr package using the library() function

library(readr)
library(ggplot2)

# 1. 
# This code worked in Workshop 1, but won't work today
raw_gene_df <- read_delim("Brauer2008_DataSet1.tds", delim = "\t")

# The reason is that the data file is not in your current working directory

# Rather than having multiples if the same file in different locations
# lets try and direct R to the original Workshop_1 folder
# Use the import button and browse to the file location
# Copy the code identifying the path the file from the "Code Preview" box
# and use it to load the file

# Example: The path that directs to it on my computer is; 

raw_gene_df <- read_delim("~/R_Users_Workshop/6_weeks_Feb-Mar_18/2018_Feb_Workshop_1/data/Brauer2008_DataSet1.tds",
                          delim = "\t")

# 2. 
# As with base R, tidyverse packages come with data we can practise on
# These are loaded when the tidyverse is loaded as a 'promise'
# This means that the data is available for use but don't appear in our
# global environment unless we assign it to an object. Do this now;

diamonds <- diamonds

# The diamonds dataset comes in ggplot2 and contains information 
# about ~54,000 diamonds, including the price, carat, color, clarity, 
# and cut of each diamond 

# We're now to go through some examples and correct the errors as we go 
# 3.
# Inaccurate indexing can throw your code out
# Correct the following for the diamonds data set
# Remember when indexing data sets the syntax is [row number, column number]
# a. Return the first value in the last column

diamonds[1, 11]

# b. Return the last value in the first column

diamonds[53941, 1]

# c. Return the first four values for the last four columns

diamonds[1:4, 8:11]

# d. Return the first and last value of all columns

diamonds[c(1, 53941), ]

# In the first workshop we filtered our data
# Lets use the filter function of the dplyr package to create a data frame
# containing diamonds worth over $15,000  
# 4.

pricey <- diamonds %>%
  filter(price > 15000)

# It's very common to get an error message like to one that has appeared below
# It's due to the package containing the function not being loaded

# filter() is a function in the dplyr package which is part of the tidyverse,
# but we only loaded the packages readr and ggplot2 at the start of this session
# 5. load the "dplyr" package and re-run the previous block of code 

# 6. Import the tidy_house_reg.csv file
house_reg_df <- read_csv("data/house_reg_df.csv")

# 7. What is the problem with this code?
counties <- c("cork", "dublin",)

# 8. Correct the following code errors to yield a data
# frame containing information for counties Cork and Dublin

cork_dublin_df <- house_reg_df %>%
  filter(county %in% counties)

# Correct the errors in the basic ggplot2 code below
# 9.
# a.

ggplot(data = diamonds_df) +
  geom_bar(mapping = aes(x = cut))

# b.
 
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = Cut))

# Those first two examples only return errors when we run the code

# Something is wrong with this code also, but what?
# Hover over the X to find out
# c. 

ggplot(data = dia_df) +
  geom_bar(mapping = aes(x = cut)
           


