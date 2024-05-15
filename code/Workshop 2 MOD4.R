# Module 4, Workshop 2 - "ggplot2 for communication"
# author: Payton Schlewitt
# date: 5/15/2024


#install.packages("usethis") ##nly need to run this line once
#credentials::git_credential_ask()
#usethis::git_sitrep()
## Check Personal Access Token

#install.packages("tidyverse") ## ONly need to run this line once
library("tidyverse") #run at the start to make sure correct package is loaded in

# Load the data (mpg is built into ggplot2)
data(mpg)

#Checking data
head(mpg)
glimpse(mpg)
summary(mpg)

#3.1 Labels
#Creating title
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")
#Can add subtitles and captions
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size",
subtitle = "Two seaters (sports cars) are an exception because of their light weight",
caption = "Data from fueleconomy.gov"
)
#labs() can also be used to change axis and legend titles
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )

#3.2 Annotations
best_in_class <- mpg %>%  #ranking from best to worst (row 1 = best)
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1) #selects only the top row, i.e. the best in each class

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_text(aes(label = model), data = best_in_class) #This line pulls the best_in_class values and displays it over the graph

#3.3 Scales
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous() +  #can change by adding numbers within bracket e.g. limits = c(0,12)
  scale_y_continuous() +
  scale_colour_discrete()
  
#3.4 Axis Ticks
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) #breaks controls the position of the ticks on the selected axis
# breaks = seq(start, end, by = space between visible values)
#Labels can also be set to labels = NULL to remove labels altogether
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

#3.5 Legends and color schemes
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))
#The following lines alter the position of the legend
base + theme(legend.position = "left")
base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
base + theme(legend.position = "right")
base + theme(legend.position = "none") #removes the legend

#3.6 Replacing Scale
#Load dataset
data("diamonds")
glimpse(diamonds)

ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()