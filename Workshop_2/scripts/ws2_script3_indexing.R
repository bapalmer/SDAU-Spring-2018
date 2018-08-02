####################################################################
#                     The tidyverse and beyond 
#                           Workshop 2
#           We built this software on base R cooooOOOODE
#                        20th February 2018
#                           3: Indexing
####################################################################
# 1. Indexing lists
# Lets first build a list using the examples in the lecture slides

this_is_a_list  <- list(1, TRUE, "Three", "4")

all_numbers     <- c(1, 2, 0.5, -0.5, 3.4)

all_characters  <- c("One", "too", "3")

all_logical     <- c(TRUE, FALSE) 

this_is_also_a_list <- list(nums = all_numbers,
                            chars = all_characters,
                            logi = all_logical)

# Note: Here we named the vectors that were used to build the list
# i.e. "nums", "chars", "logi"

# i: Selection of brackets is important
typeof(this_is_a_list[3]) # [ will just return the "list"
this_is_a_list[3]

typeof(this_is_a_list[[3]]) # However using [[ returns the element
this_is_a_list[[3]]

# ii: "this_is_also_a_list" contains named elements
# We can access them by their names using "$"
# Examine the following

this_is_also_a_list$nums
this_is_also_a_list$nums[[1]]
typeof(this_is_also_a_list$nums[[1]])

# iii: [[ is similar to $ but we need to use quotes

this_is_also_a_list[["nums"]]
this_is_also_a_list[["nums"]][[1]]
typeof(this_is_also_a_list[["nums"]][[1]])

# iv: Just to complicate things.......
# Examine and understand the following outputs

this_is_also_a_list[[1]]

this_is_also_a_list[[1]] + this_is_also_a_list[[1]]

this_is_also_a_list[[1]][[1]] + this_is_also_a_list[[1]][[1]]

this_is_also_a_list[[1]] + this_is_also_a_list[[1]][[1]]

# 2. Indexing data frames
# i: Similar to the earlier example, you can use $ for named columns
# e.g. a_data_frame$number
# To get the 1st of the column "number", type:

a_data_frame$number[1]

# To get the second its:

a_data_frame$number[2]
# and so on

# To perform the same operation you can type [row, column]
# In this example type:

a_data_frame[1, 1]

# NOTE: One of the big changes with tidyverse is movement away from the [ function

# ii: It's possible to select multiple elements
# e.g. Rows 1-3 of the first column
a_data_frame[1:3, 1]

# Or row one of the first 3 columns
a_data_frame[1, 1:3]

# iii: If you want to select specific, non-sequential numbers try using concatenate

a_data_frame[c(1, 3, 5:7), 1]

# iv: Maybe you want to select elements based on a condition

a_data_frame$number[a_data_frame$number > 7]
