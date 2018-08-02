####################################################################
#                     The tidyverse and beyond 
#                            Workshop 5
#                      Welcome to the ggungle
#                         13th March 2018
#                     2: Building simple plots
####################################################################
# In this part of the workshop we will take some first steps creating
# simple graphs and asking some questions of the data

# Further basic examples are on the ggplot2 cheatsheet
# More information can be found by visiting;
# http://ggplot2.tidyverse.org/reference/index.html

# For this section we will use the mpg data set that comes with ggplot2

mpg <- mpg
?mpg

# Q: Do cars with big engines use more fuel than cars with smaller engines?
# The first part of building a plot is the data 

plot_a <- ggplot(data = mpg) # Creates a coordinate system for adding layers to
plot_a # i.e. an empty graph

# The second part is defining the coordinate system;
# displ is the car engine size
# hwy is the miles per gallon on the highway
# geoms are geometric objects that represent the data
# bar charts use bar geoms, line charts use line geoms etc.

plot_b <- plot_a + # In ggplot2 we add layers to develop the plot
  geom_point(mapping = aes(x = displ, y = hwy)) 
plot_b

# This can also be written as;
plot_c <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point()
plot_c

# What's the difference between these?
# Well lets try adding another geom....

plot_b +
    geom_smooth()

plot_c + 
    geom_smooth()

# If you are adding layers to a plot, make sure the + is at the end of
# the line, not at the beginning

# Lets add a little colour

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = class)) +
    geom_point()

# The alpha aesthetic controls transparency

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, alpha = class)) +
    geom_point()

# Perhaps you want to identify the type of car by a different shape

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = class)) +
    geom_point()

# If you have more than six groups you will need to define the shapes 
# R has 25 built in shapes that are identified by numbers

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = class)) +
    geom_point() +
    scale_shape_manual(values = c(1:7))

# It is often useful to split you plots into subgroups or facets

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, shape = class)) +
    geom_point() +
    scale_shape_manual(values = c(1:7)) +
    facet_wrap(~ class, nrow = 2)

# Note: Not every aesthetic will work with every geom
# You can't define the shape of a line graph, but you can define the linetype
# It is possible to define different aesthetics in different layers

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(aes(colour = class)) +
    geom_smooth(aes(linetype = drv), se = FALSE)

# You can also specify different data for each layer
# The local argument for the geom overrides the global argument from ggplot
# for that layer only

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(aes(colour = class)) +
    geom_smooth(
        data = filter(mpg, class == "subcompact"),
        se = FALSE)

# Modifying other elements of the output using themes

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_jitter(aes(colour = class)) + # Add a small amount of random variation
    labs(x = "Displacement in litres", y = "Miles per gallon", # Define labels
     title = "Initial analysis") +
    theme(axis.line.x = element_line(color="black", size = 0.5), # Format x axis
          axis.line.y = element_line(color="black", size = 0.5),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          # Format gridlines
          panel.background = element_blank(), axis.line = element_line(colour = "black"),
          # Format background
          axis.title = element_text(face = "bold", size = 12),
          axis.text = element_text(face = "bold", size = 10),
          plot.title = element_text(hjust = 0.5))

# Visit #http://ggplot2.tidyverse.org/reference/index.html and find out more 
# about geom_jitter()

# ggsave conveniently saves your plots
# It defaults to saving the last plot you can also specify which plot to save

ggsave("outputs/my_last_plot.png", width = 10, height = 10, units = c("cm"))
