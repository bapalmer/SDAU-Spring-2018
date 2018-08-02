####################################################################
#                     The tidyverse and beyond 
#                           Workshop 2
#           We built this software on base R cooooOOOODE
#                        20th February 2018
#                       5: Working with readr
####################################################################
# You can load the core tidyverse packages using library(tidyverse)
# But you can also load each package individually just like any other package

library(readr)

# 1. Read in "irish_population.csv" using the readr function read_csv()
# You can get the correct code by using the import button and then
# copying the relevant code into this R script

# There are many additional arguments that can be fed into this function
# 2. Examine them by running the following line of code
?read_csv()

# 3. What about if the file header contains metadata (i.e. additional information)
# The skip argument can be used to pass over the first n lines of the file
# i: Import the "meta_tidy_house_reg.csv" and view the resultant data set

tidy_house <- read_csv("path to the file")
View(tidy_house)

# ii: Repeat this by including the skip argument (i.e. "path_to_file", skip = n)
# Again view the inputted data to see that you have the result you were after

# Similar to skip, you can also use a repeated term to skip lines
# In this instance the argument to be supplied is "comment = "

# 4. You can also provide inline data to the read_csv() function
# This is very useful when looking to provide reproducible examples
# e.g. when posting a question on a help forum such as stackoverflow

inline_eg_1 <- read_csv("col1, col2, col3 
                      cork, 1998, 120
                      dublin, 1999, 2200")

# Note the missing commas after "col3" and "120"
# This signifies the beginning of a new row

# What happens when you supply the argument col_names = FALSE as below?

inline_eg_2 <- inline_eg <- read_csv("col1, col2, col3 
                                    cork, 1998, 120
                                    dublin, 1999, 2200", 
                                    col_names = FALSE)

# 4. Complete the following code to produce 2 columns x 4 rows of data:

my_inline_eg <- read_csv("write your code here")

# 5. View the EAA13.px file downloaded from data.gov.ie
# This cannot be imported using readr 
# However packages have been developed for many obscure file formats 
# The pxR package allows us to import this .px file as a data frame
# It strips away the metadata and returns the column headings and values

# 6. Import this file using the following lines of code
# Once you have done this, examine it

install.packages("pxR")
library(pxR)
my.px.object <- read.px("data/EAA13.px")
eaa13_df <- as.data.frame(my.px.object)

# readr also allow you to write you data files back to disc
# write_csv(data_to_save, "filename.csv")
# 7. Create a file on your hard drive containing your tidy_house data

write_csv(eaa13_df, "imported_eaa13_df.csv")

# 8. A useful function to stop your active environment cluttering up is rm()
# This removes data structures from your workspace

rm(tidy_house)
rm(inline_eg_1)
