# Title ---------------------------------------------------------------
# Analysis of the WHO TB data set
# R tidyverse workshop 6: Don't look back in anger
# 27th March 2016

# Load the required packages
library(tidyverse)

# Section 1: Load the data ---------------------------------------------
# This data frame has 2 lines of meta data that must be skipped over
# Note: Change the path to the one on your computer

who_df <- read_csv(
  "data/who.csv",
                   skip = 2)

# Ensure the data is loaded correctly

View(who_df)

# Section 2: Data tidying steps using tidyr ----------------------------

who_df_tr <- who_df %>%
  gather(new_ep_f014:new_sp_m65, # columns to be collapsed
         key = "key", 
         value = "cases", na.rm = TRUE) # Remove all cases with NA's

# Note: if we used drop_na(), ALL rows with NA's would have been removed
# Valuable data would be lost as some countries have no iso2/iso3 data,
# yet do have case data by country and year

View(who_df_tr)

# Check the tidied data for any more NA's using is.na()
# Data contains 76046 rows
# If no NA's present in a column, you should get FALSE 76046 times

table(is.na(who_df_tr$country))
table(is.na(who_df_tr$iso2))
table(is.na(who_df_tr$iso3))
table(is.na(who_df_tr$year))
table(is.na(who_df_tr$key))
table(is.na(who_df_tr$cases))

# iso2 contains NA's, but these will be removed in the next stage

#Section 3: Transformation of the data using dplyr ----

who_df_dr <- who_df_tr %>%
  # Two separate steps required to process the "key" column
  separate(key, c("new", "type", "sexage"), sep = "_") %>%
  separate(sexage, c("sex", "age"), sep = 1) %>%
  select(-iso2, -iso3, -new) %>%# Removes the redundant columns 
  spread(sex, cases) %>% # Places males and females in separate columns 
  mutate(total = m + f) %>% # Combined total of male and female cases
  # Caution, this process may introduce NA's again
  replace_na(list(m = 0, f = 0, total = 0))

# Top tip: When writing code (e.g. selecting columns),
# Pick the option that requires the least amount of text
# Above we used select(-iso2, -iso3, -new) rather than,
# select(country, year, key, cases)

# Check everything is still ok

View(who_df_dr)

# Some housekeeping:
# Remove unnecessary objects from our global environment

rm(who_df)
rm(who_df_tr)

# Section 4: Data analysis --------------------------------------------
# Pick any question you'd like to ask of the data
# I'm from Ireland, so I might be interested in TB data for Ireland

who_df_ire <- who_df_dr %>%
  filter(country == "Ireland") 

# Basic barplot with data by age shown

ggplot(who_df_ire) +
  geom_bar(mapping = aes(x = year, y = total, fill = age),
           stat = "identity") 

# 2007 looked like a bad year
# Your own area of interest may be paediatrics
# What is the breakdown for the type of TB in the youngest cohort?

who_df_ire %>%
  filter(age == "014") %>% #Feed this data directly to ggplot
  # Layered plot
  ggplot() +
  geom_point(mapping = aes(x = as.character(year), y = total, 
                  colour = type, shape = type)) + 
  # Assigns colours and shapes by the variable specified 
  scale_color_manual(values = c("black", "red", "green", "blue")) +
  # Manually assign the colour
  # ggplot2 accepts hexadecimal colours, e.g. "#000000" == "black"
  # "#FF0000" == "red"
  labs(x = "Year", y = "Total number of cases by type", # Label axes
       title = "TB cases by type in Irish 0 - 14 years olds",
       colour = "TB Type", # Rename your colour
       shape = "TB Type") + # Also, must specify the name of shape legend
  theme(axis.text.x = element_text(angle = 90),
        # Rotate the x-axis labels
        panel.background = element_blank(), #Remove grey background
        panel.grid.major = element_blank(), #Remove gridlines
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.5)) # Centres the plot title

# This plot has a number of extra layers added to improve the quality
# You can save it by clicking on the "Export" button
# Or

ggsave("outputs/Plot_of_TB_cases_2007.pdf")
ggsave("outputs/Plot_of_TB_cases_2007.png")

# This will save to your current working directory
# You can specify plot dimensions as another layer
# You can also create a figures folder and save it to that

# Some points on the plot are zero
# To avoid them being shown, change the limts of your y-axis

who_df_ire %>%
  filter(age == "014") %>%
  ggplot() +
  geom_point(mapping = aes(x = as.character(year), y = total, 
                           colour = type, shape = type)) + 
  scale_color_manual(values = c("black", "red", "green", "blue")) +
  ylim(y = c(0.1, 82)) + # This sets the limits
  
  # Note the error message whe you run the code
  # Compare this plot with the last one
  
  labs(x = "Year", y = "Total number of cases by type", # Label axes
     title = "TB cases by type in Irish 0 - 14 years olds",
     colour = "TB Type",
     shape = "TB Type") +
  theme(axis.text.x = element_text(angle = 90),
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.5))
 
# Section 5: Summary analysis ----------------------------------------

ctry_comp <- who_df_dr %>% # Lets compare TB cases in the youngest
  # cohort between countries with similarly sized populations
  # Perform summary on full dataframe
  filter(age == "014") %>%
  group_by(country, year) %>%
  summarise(most = sum(total)) %>% # Get total number of cases
  filter(country %in% c("Ireland", "New Zealand", "Costa Rica",
                        "Norway")) %>% 
  arrange(desc(most)) # Arrange the results in the table by highest
  # to lowest number of cases recorded per year per country 

head(ctry_comp)
# Certainly a bad year by international standards for the 0-14 year
# old cohort

# We might save this information to be view later
write_csv(ctry_comp, 
          "Path_to_your_file/filename.csv")

# Note that this file was sent an the output folder
# It can be recreated anytime you run this script
