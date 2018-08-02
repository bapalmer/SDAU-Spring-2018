####################################################################
#                     The tidyverse and beyond 
#                           Workshop 2
#           We built this software on base R cooooOOOODE
#                        20th February 2018
#                       2: Data structures II
####################################################################
# 1. Create a simple data frame using the following code and view it

a_data_frame <- data.frame(number = 1:10,
                           char   = sample(letters, 10),
                           this_is_a_col_name  = rep(c(TRUE, FALSE), 5))

# Do you understand all the elements in that line of code?

# 2. A useful base R function is str()
# It compactly displays the internal structure of an R object
# Use it now to get the structure of "a_data_frame"

# 3. Now try using the following functions to get information about your data 

length()
ncol()
nrow()
class()
typeof()

# 4. In the tidyverse, data frames are called tibbles
# The tidyverse package required is tibble

library(tibble)
a_tibble <- as.tibble(a_data_frame)

# Lets examine the main differences between a data frame and a tibble
# using the "iris" data set supplied in the "datasets" package

# 5. Bring the data into your global environment
iris_df <- datasets::iris

# 6. Convert this data frame to a tibble
iris_tbl <- as.tibble(iris_df)

# 7. View it in the console by running the following code and note
# any differences between the outputs
iris_df
iris_tbl

# So tibbles are designed not to overwhelm your console when you print 
# large data frames

# 8. Some older functions don't work with tibbles
# If you get into trouble, you can convert the tibble to a data frame
iris_back_to_a_df <- as.data.frame(iris_tbl)
