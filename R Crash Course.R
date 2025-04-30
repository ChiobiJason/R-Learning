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

# Changing variable names
starwars %>% 
  rename("character" = "name") %>%
  head()

# Changing a variable type
class(starwars$hair_color)

starwars$hair_color <- as.factor(starwars$hair_color)

class(starwars$hair_color)

starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()

# Changing factor levels
df <- starwars
df$sex <- as.factor(df$sex)

levels(df$sex)

df <- df %>% 
  mutate(sex = factor(sex, 
                      levels = c("male", "female", "hermaphroditic", "none"
                                 )))

levels(df$sex)

# Filter rows
starwars %>% 
  select(mass, sex) %>% 
  filter(mass < 55 &
           sex == "male")

# Recode data
starwars %>%
  select(sex) %>% 
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "woman"))

# Dealing with missing data
mean(starwars$height, na.rm = TRUE)

# Dealing with duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends2 <- data.frame(Names, Age)

friends2

friends2 %>% 
  distinct()

distinct(friends2)

# Manipulate
###############
# Create or change a variable (mutate)
starwars %>% 
  mutate(height_m = height / 100) %>% 
  select(name, height, height_m)

# Conditional change (if_else)
starwars %>% 
  mutate(height_m = height / 100) %>%
  select(name, height, height_m) %>%
  mutate(tallness = 
           if_else(height_m < 1,
                   "short",
                   "tall"))

# Reshape your data with Pivot wider
library(gapminder)
View(gapminder)

data <- gapminder %>%
  select(country, year, lifeExp)

View(data)

wide_data <- data %>%
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

# Reshape data with pivot longer
long_data <- wide_data %>% 
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")

View(long_data)

# Describe
##################
View(msleep)

# Range / spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)

# Centrality
mean(msleep$awake)
median(msleep$awake)

# Variance
var(msleep$awake)

summary(msleep$awake)

msleep %>% 
  select(awake, sleep_total) %>%
  summary()

# Summarize your data
msleep %>%
  drop_na(vore) %>%
  group_by(vore) %>%
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference =
              max(sleep_total) - min(sleep_total)) %>% 
  arrange(Average) %>%
  View()

# Create tables
table(msleep$vore)

msleep %>% 
  select(vore, order) %>% 
  filter(order %in% c("Rodentia", "Primates")) %>% 
  table()


# Visualise
#################

plot(pressure)

# The grammar of graphics
    # data
    # mapping
    # geometry

# Bar plots
ggplot(data = starwars,
       mapping = aes(x = gender))+
  geom_bar()

# Histograms
starwars %>%
  drop_na(height) %>% 
  ggplot(mapping = aes(x = height))+
  geom_histogram()
 
# Box plots
starwars %>% 
  drop_na(height) %>% 
  ggplot(aes(height))+
  geom_boxplot(fill = "steelblue")+
  theme_bw()+
  labs(title = "Boxplot of height",
       x = "Height of characters")

# Density plots
starwars %>%
  drop_na(height) %>%
  filter(sex %in% c("male", "female")) %>%
  ggplot(mapping = aes(x = height,
                       color = sex,
                       fill = sex))+
  geom_density(alpha = 0.2)+
  theme_bw()

# Scatter plots
starwars %>% 
  filter(mass < 200) %>%
  ggplot(aes(height, mass, colour = sex))+
  geom_point(size = 5, alpha = 0.5)+
  theme_minimal()+
  labs(title = "Height and mass by sex")

# Smoothed model
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(height, mass, color = sex))+
  geom_point(size = 3, alpha = 0.8)+
  geom_smooth()+
  facet_wrap(~sex)+
  theme_bw()+
  labs(title = "Height and mass by sex")


# Analyze
###############
# Hypothesis testing
# T-test
library(gapminder)
View(gapminder)
t_test_plot

gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>%
  t.test(lifeExp ~ continent, data = .,
         alternative = "two.sided")

# ANOVA (Analysis of Variance)
gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>%
  summary()

gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>%
  TukeyHSD()

gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>%
  TukeyHSD() %>% 
  plot()

# Chi Squared
head(iris)

flowers <- iris %>%
  mutate(Size = cut(Sepal.Length,
                    breaks = 3,
                    labels = c("Small", "Medium", "Large"))) %>%
  select(Species, Size)

# Chi Squared goodness of fit test
flowers %>%
  select(Size) %>%
  table() %>% 
  chisq.test()

# Chi Squared test of independence
flowers %>% 
  table() %>%
  chisq.test()

# Linear Model
head(cars, 10)

cars %>% 
  lm(dist ~ speed, data = .) %>%
  summary()