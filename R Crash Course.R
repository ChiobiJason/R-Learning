?mean
?ChickWeight

# Objects and Functions
5 + 6

a <- 5
b <- 6

a + b
sum(a,b)

ages <- c(5, 6)
ages
sum(ages)

names <- c("John", "James")

friends <- data.frame(names, ages)
View(friends)
str(friends)

friends$ages
friends$names

friends[1, 1]
friends[1, ]
friends[ , 1]

#Built in data sets to practice with
data()
View(sleep)


# Installing and using packages
install.packages("tidyverse")
library(tidyverse)

View(starwars)

starwars %>%
  filter(height > 150 & mass < 200) %>% 
  mutate(height_in_meters = height / 100) %>% 
  select(height_in_meters, mass) %>% 
  arrange(mass) %>%
  #View()
  plot()

# Explore
##########

# Data structure and types of variables
View(msleep)

glimpse(msleep)

head(msleep)

class(msleep$name)

length(msleep)

length(msleep$name)

names(msleep)

unique(msleep$vore)

missing <- !complete.cases(msleep)

msleep[missing, ]


# Clean
#########
# Select variables
starwars %>% 
  select(name, height, mass)

starwars %>% 
  select(1:3)

starwars %>% 
  select(ends_with("color"))

# Changing variable order
starwars %>% 
  select(name, mass, height, everything()) %>% 
  View()
