####################################################################
#                     The tidyverse and beyond 
#                           Workshop 1
#           Take a parachute and jump (into the tidyverse)
#                        13th February 2018
#                   2: Stepwise Brauer analysis
####################################################################
# This is a modified version of that developed by David Robinson (@drob)
# For more go to http://varianceexplained.org/r/tidy-genomics/ 

# When you write an R script, always start off by loading the packages
# you'll need throughout
library(tidyverse)

# In this script we're going to examine some real life data
# Brauer et al,. 2008 examined yeast gene expression under different
# growth conditions

# The data we're using has already been through a rigorous cleaning process
# that is beyond the scope of this workshop

# 1. Open the data set using Notepad or another basic text editor
# What makes this data set untidy?

# Now, we will tidy the data step by step 
# Start off by importing the data and renaming the data frame "raw_gene_df"
raw_gene_df <- read_delim("http://varianceexplained.org/files/Brauer2008_DataSet1.tds",
                          delim = "\t")

# 2. Use the import button in RStudio to import the data
# How does the import view change if you select "Comma" instead of 
# "Tab" under the options for “Delimiter”? 
# What happens when you untick the “First Row as Names” box?

View(raw_gene_df)

# 3. Looking at the “NAME” column, can you suggest a strategy to 
# separate the information it contains?

# We will now separate the NAME column into four new columns
separated_gene_df <- separate(raw_gene_df, NAME,
                              c("name", "BP", "MF", "systematic_name", "number"),
                              sep = "\\|\\|"
                              )

# Examine the new data frame

# When we split by "|", we ended up with whitespace at the start and end
# of some of the columns
mutated_gene_df <- mutate_at(separated_gene_df, 
                             vars(name:systematic_name), 
                             funs(trimws)
                             )

# What changes were applied to the data when we used mutate_at() function?
# Clue: Type "head(mutated_gene_df$BP)" and compare it to 
# "head(separated_gene_df$BP)"
# Can you see the differences now?

# 4. View separated_gene_df and mutated_gene_df in the code editor window
# Can you see any differences?

# We identified some columns earlier that do not provide useful information
# It might be a good idea to remove these
selected_gene_df <- select(mutated_gene_df, -number, -GID, -YORF, -GWEIGHT)

# We still have column headers that are values rather than variables (e.g. G0.05)
# Gather takes multiple columns and collapses into key-value pairs, 
# duplicating all other columns as needed
# You use gather() when you notice that you have columns that are not variables
gathered_gene_df <- gather(selected_gene_df, sample, expression, G0.05:U0.3)

# 5. How many columns are in the selected_gene_df?
# How many rows and columns does the gathered_gene_df data set have?

# NOTE: The dataset no longer consists of one-row-per-gene: 
# It is now one-row-per-gene-per-sample
# The 36 columns containing nutrient and growth rate have been collapsed into two
# However, our new column "sample" contains two variables
# We need to call on the separate function again

nearly_there_df <- separate(gathered_gene_df, sample,
                            c("nutrient", "rate"), 
                            sep = 1, 
                            convert = TRUE)

# Examine nearly_there_df to view the new columns

# Time to finish up the cleaning process
# There were 6 conditions and we're going to define them in the object
# "nutrient_names"
nutrient_names <- c(G = "Glucose", L = "Leucine", P = "Phosphate",
                    S = "Sulfate", N = "Ammonia", U = "Uracil")

cleaned_genes_df <- mutate(nearly_there_df,
                           nutrient = plyr::revalue(nutrient, nutrient_names)
                           ) %>%
  filter(!is.na(expression), systematic_name != "")

# There were 6 conditions and we're going to identify them in the object
# that we name "nutrient_names"
nutrient_names <- c(G = "Glucose", L = "Leucine", P = "Phosphate",
                    S = "Sulfate", N = "Ammonia", U = "Uracil")

# Plot the data for a gene but first we'll make a new data set with the information

LEU1_df <- cleaned_genes_df %>%
  filter(name == "LEU1") 

# 6. What are the three main elements needed to generate a ggplot2 graph?
# Using the basic formula for graphs, lets create a plot
ggplot(data = LEU1_df, mapping = aes(x = rate, y = expression,
                                     colour = nutrient)
       ) + # Note the "+" for ggplot2
  # + allows us to add layers as we build up our plots
  geom_line() 

# For example, instead of a line plot, lets draw a XY scatter plot
ggplot(data = LEU1_df, mapping =  aes(x = rate, y = expression, 
                                      colour = nutrient)
       ) +
  geom_point() 

# 7. By examining the ggplot2 geoms, which will allow you to draw a histogram?
# Hint: type ggplot2:: into the RStudio console and scroll through the options

# Now, lets add in a layer of code, i.e. a best fit line to the data
ggplot(data = LEU1_df, mapping = aes(x = rate, y = expression, 
                                     colour = nutrient)
       ) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) 

# 8. Creat a new plot by replacing “LEU1” used to create LEU1_df
# in with any other gene name of your choice

# Instead of looking at one gene we can use the "systematic_name" column 
# to identify groups of genes involved in the same biological pathway
cleaned_genes_df %>%
  filter(BP == "leucine biosynthesis") %>%
  ggplot(mapping = aes(x = rate, y = expression, colour = nutrient)
         ) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  # using "facet_wrap" we can create subplots
  facet_wrap(~name)

# 7. Look at your workspace and note all the individual data sets we have created
# Now, clear your work space, and run ws1_script3_piped_Brauer_analysis
# Can you see any advantages to using the %>% operator and the tidyverse? 
