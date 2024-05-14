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

#Creating title
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")
#Can add subtitles and captions
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(itle = "Fuel efficiency generally decreases with engine size",
subtitle = "Two seaters (sports cars) are an exception because of their light weight",
caption = "Data from fueleconomy.gov"
)
             
  