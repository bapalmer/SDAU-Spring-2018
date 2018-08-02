####################################################################
#                     The tidyverse and beyond 
#                           Workshop 2
#           We built this software on base R cooooOOOODE
#                        20th February 2018
#                       1: Data structures I
####################################################################
# 1. Objects obtain values in R by assignment (x gets a value)
# This is achieved using the assignment operator "<-"
# Type the following to create the object x with a value of five:

# x <- 5

# 2. Atomic vectors contain one type of data
# Using "<-" and the concatenate function ("c()"), 
# create a numeric, character and logical vector. Name them;
# all_numbers
# all_characters
# all_logical

all_characters <- c("Here", "we", "go!") # Example

# 3. Lists can contain more than one data type
# Using the "list()" function, create an object;
# (i) that is a list containing different data types
# (ii) that is another list comprised of "all_numbers",
#                                "all_chararacters" and
#                                "all_logical" created in Q2

# 4. It is possible to convert vectors from one type to another
# Try the following:

nums_as_characters <- as.character(all_numbers)
nums_as_characters
typeof(nums_as_characters)

back_to_numbers    <- as.numeric(nums_as_characters)
back_to_numbers
typeof(back_to_numbers)

# 5. Last week we used ":" to generate a sequence of numbers
# As a refresher, create a new object called y
# Assign a sequence of numbers to it (e.g. 1:10 or c(1:3, 15, 6:9, 18:30))

# 6. Are the following vectors a and b the same?

a <- c(1:3, 15, 6:9, 18:30)
b <- c(1:3, "15", 6:9, 18:30)

# What happens when you try to sum them?
sum(a)
sum(b)

# 7. Apply the functions as.character and as.integer to a and b from 
# Q6 above, respectively 

# 8. We can do something similar with letters
# Try the following and check the output:
first_10_letter <- letters[1:10]

# 9. You might want to get a random sample of letters
# Try the following code and view the output

random_letters <- sample(letters, 10, replace = FALSE)
# Do you understand all the elements of the code?

# 10. Create a simple matrix using the following code and view it
a_matrix <- matrix(1:16, 4, 4)

# 11. R can evaluate functions over entire vectors
# Try the following base R functions

max(a)

min(a)

mean(a)

median(a)

range(a)

sd(a)

sqrt(sd(a))

quantile(a)

rank(a)

length(a)

# Do the funtions used in Q10 also work for a_matrix?
