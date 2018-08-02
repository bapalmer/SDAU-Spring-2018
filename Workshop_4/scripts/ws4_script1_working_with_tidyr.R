####################################################################
#                     The tidyverse and beyond 
#                           Workshop 4
#              It's the end of base R as you know it
#                       6th March 2018
#                    1: working with tidyr
####################################################################
# Start by loading the tidyverse package using the library() function

library(tidyverse)

# As you go, look at some examples to help you on the way using "?" 

messy_data <- read_csv("data/messy_data.csv")

# As an example, lets start by converting "dob" into day, month and year
# The separate function will generate three new columns based on the input column

messy_data_v1 <- separate(messy_data, dob, c("day", "month", "year"), sep = "-")

# 1. Now do the same for the name column. What will your new columns be?
# What will the separator be?

messy_data_v2 <- separate()

# gather() takes multiple columns, and gathers them into key-value pairs: 
# the key would be the original column names with their associated values
# i.e. it makes "wide" data longer
# The original column names become values in the newly created column, A
# The original values are placed in newly created column, B
# e.g. long_data <- gather(wide_data, key = "new_column_A_name", 
#                                     value = "new_column_B_name", column_1:column_n)

# 2a. Use the example code in lines 31 and 32 to gather columns "work" to "play"
# Here we might view "work"/"play" as an activity or action and want the data to 
# represent this

new_object <- # write your code here

# 2b. Rather than naming the columns, you can call on them by their positional number
# Try it

new_object <- # write your code here
    
# This method is not recommended however
    # It is not self-documenting
        # It is fragile, i.e. if the columns are reordered by someone else

# To reverse some of the actions above, we can use the functions unite() and spread()
# unite() collapses cells across the columns selected to give a single column 
# 3. Lets reverse our "dob" action from part 1

messy_data_dob <- unite(data, columns_to_be_combined, col = "new_column_name", sep = "/")

# spread() will essentially make long data wide
# 4. Use spread() to reverse what you did in part 2

messy_data_wide <- spread(messy_data_v3_a, condition, value)

# 5. drop_na() will remove any row containing an NA value
# This is useful if your data does not contain much missing information
# but if there are a lot of NAs, you will remove a lot of useful data too

# Our original messy data had some NA
# Remove them now

new_object <- drop_na(data)

# Way back when in workshop 1 we looked at the functions in isolation
# This generated lots of intermediary data sets in our environment
# 6. Can you combine the commands from parts 1, 2 and 3 using %>%?

tidy_data <- messy_data %>%
    separate() %>%
    separate() %>%
    gather() %>%
    drop_na()
    