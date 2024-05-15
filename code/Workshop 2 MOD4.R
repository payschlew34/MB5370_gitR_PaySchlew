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
#some relationships are easier to see when the scale is transformed i.e. carat with price
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()

#Changing color scales
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")
#In case there are few colors, shapes can be used in conjunction to ensure correct interpretation even in black and white
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  scale_colour_brewer(palette = "Set1")
#ColorBrewer scales can be found at http://colorbrewer2.org/
#More on colors can be found in the ggplot2 cookbook: http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

#Predefined colors can be set using scale_color_manual()
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))
#A commonly used color scheme is the viridis color scheme, used with scale_color_viridis()
#install.packages('viridis') #Only need to run once
#install.packages('hexbin') #Only need to run once
library(viridis)
library(hexbin)

df <- tibble( # note we're just making a fake dataset so we can plot it
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() + #generates a hex plot. creates hexagonal points that form a mosaic
  coord_fixed()

ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis() +
  coord_fixed()
#Other color palettes like the Wes Anderson palette are also used frequently

#3.7 Themes
#ggplot2 has 8 themes by default that alter the entire theme of the plot
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_light()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_classic()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_dark()

#You can create your own theme as well using theme(). For example:
theme (panel.border = element_blank(),
       panel.grid.minor.x = element_blank(),
       panel.grid.minor.y = element_blank(),
       legend.position="bottom",
       legend.title=element_blank(),
       legend.text=element_text(size=8),
       panel.grid.major = element_blank(),
       legend.key = element_blank(),
       legend.background = element_blank(),
       axis.text.y=element_text(colour="black"),
       axis.text.x=element_text(colour="black"),
       text=element_text(family="Arial")) 

#3.8 Saving and exporting your plots
#You can save ggplots using ggsave("name_of_plot.pdf") and this will save it to your working directory
#The size of the saved plot can be altered using the 'height' and 'width' functions