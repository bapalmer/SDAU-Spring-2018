####################################################################
#                     The tidyverse and beyond 
#                            Workshop 5
#                      Welcome to the ggungle
#                         13th March 2018
#                       1: ggplot2 vs. base R
####################################################################
# base R comes with the graphics package
# In certain instances it can generate a quick output with limited fuss

# 1. Check it out
# graphics::

x <- rnorm(1000, mean = 0, sd = 1) # Random generation for the normal distribution

hist(x) # Plot a histogram of x

library(tidyverse)

# qplot (quick plot) is analogous to plot in base R
qplot(x)

# If we are to implement ggplot2 code structure in full.....
ggplot(mapping = aes(x)) + 
    geom_histogram()

# ggplot2----
# It might seem like more work at first, but once you understand the structure
# Graphs are reproducible 
# The code is transferable
# The code is more readable
# It takes less code for your figures to be publication ready

# Example: ggplot2 vs. base R graphics
# Lets return to the Brauer data set from Workshop 1 for this demonstration
# Recall:

nutrient_names <- c(G = "Glucose", L = "Leucine", P = "Phosphate",
                    S = "Sulfate", N = "Ammonia", U = "Uracil")

cleaned_genes_df <- read_delim("data/Brauer2008_DataSet1.tds", delim = "\t") %>%
    separate(NAME, c("name", "BP", "MF", "systematic_name", "number"),
             sep = "\\|\\|")  %>%
    mutate_at(vars(name:systematic_name), funs(trimws)) %>%
    select(-number, -GID, -YORF, -GWEIGHT) %>%
    gather(sample, expression, G0.05:U0.3) %>%
    separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE) %>%
    mutate(nutrient = plyr::revalue(nutrient, nutrient_names)) %>%
    filter(!is.na(expression), systematic_name != "") %>%
    filter(BP == "leucine biosynthesis")

# 2. Lets generate the ggplot2 output

ggplot(cleaned_genes_df, aes(rate, expression, color = nutrient)) + # data, x-axis, y-axis
    geom_point() + # plot type
    geom_smooth(method = "lm", se = FALSE) + # second plot type with linear model
    facet_wrap(~name + systematic_name, scales = "free_y") # Note "free_y" # plot arrangement

# 3. What does it take to do this with base R

par(mar = c(2, 2, 2, 2)) # Set graphical parameters

colors <- 1:6 # Create vector to assign colours to treatment
names(colors) <- unique(cleaned_genes_df$nutrient)

m <- matrix(c(1:4, 3, 3, 3, 3), nrow = 2, ncol = 2, byrow = TRUE) # Create matricx of plots
layout(mat = m, heights = c(.18, .18, .18, .18, .18, .1))

# Prepare the data to be plotted

for (gene in unique(cleaned_genes_df$name)) { # For loop to prepare data by gene
    sub_data <- filter(cleaned_genes_df, name == gene)
    plot(expression ~ rate, sub_data, col = colors[sub_data$nutrient], main = gene)
    for (n in unique(sub_data$nutrient)) { # Once first plot is made, then apply linear model by nutrient
        plot_lm <- lm(expression ~ rate, filter(sub_data, nutrient == n)) 
        if (!is.na(plot_lm$coefficients[2])) { # If this condition is met, then...
            abline(plot_lm, col = colors[n]) # Plot the best fit line to the data
        } # Closes if statement
    } # Closes second for loop
} # Closes first for loop

