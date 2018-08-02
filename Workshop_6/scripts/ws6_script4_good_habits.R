####################################################################
#                     The tidyverse and beyond 
#                            Workshop 6
#                     Don't look back in anger
#                          27th March 2018
#                          4: Good habits
####################################################################
# 1. Organisation ---- 
# Using "----" allows for long scripts to be broken up into sections

# 2. Assignment ----
# Always use <-, not =, for assignment
# Good

x <- 5

#Bad

x = 5

# 3. Variable names ----
# Variable and function names should be lowercase
# Use an underscore (_) to separate words within a name
# They should be descriptive and succint

strwrs_df # here "_df" identifies the object as a data frame
strwrs_mx # here "_mx" indicates thee object is a matrix
strwrs_lm # here "_lm" the object stores the output of a linear model

# Good

day_one
day_1

# Bad

first_day_of_the_month
DayOne
dayone

# 4. Object names ----
# Must start with a letter and can only contain letters, numbers, "_" and "."
# Good

this_is_recommended <- 5 #Although it should be shortened
so.is.this <- 5

#Bad
1.not.this <- 5
notthiseither <- 5

c <- 5 # This is problematic as the concatenate function is c()

# In functions T == TRUE and F == FALSE, so best avoid

T == TRUE
F == FALSE
T <- TRUE
T == 5
T == TRUE

# 5. Syntax ----
# Place spaces around all infix operators (=, +, -, <-, etc.)
# The same rule applies when using = in function calls
# Always put a space after a comma, and never before 
# Good

average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad

average<-mean(feet/12+inches,na.rm=TRUE)

# Important exeception
# Double colons (:) don't need spaces around them

x <- c(1:10, 15, 20, 25:30)

# Use extra spacing if it improves alignment
# Spread text over multiple lines to improve readability
# Good

x <- list(
     total = a + b + c, 
     mean  = (a + b + c) / n,
     places = c("Baltimore", "Youghal", "Fermoy", "Kanturk")
     )

# Bad

x <- list(total = a + b + c, mean  = (a + b + c) / n, places = c("Baltimore", "Youghal", "Fermoy", "Kanturk"))
