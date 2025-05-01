Provinces <- c("Alberta", "British Columbia", "Manitoba", "New Brunswick", 
               "Newfoundland and Labrador", "Nova Scotia", 
               "Northwest Territories", "Ontario", "Prince Edward Island", 
               "Quebec", "Saskatchewan", "Yukon")

Population_in_1996 <- c(14940, 24300, 2950, 360, 265, 870, 175, 93895, 50,
                        18945, 1725, 35)

Population_in_2021 <- c(102820, 46395, 23555, 3820, 1365, 4800, 560, 220915, 
                        365, 118360, 13980, 135)

SSHA_Population <- data.frame(Provinces, Population_in_1996, 
                              Population_in_2021)

View(SSHA_Population)

library(tidyverse)

SSHA_Population_PercentageChange <- SSHA_Population %>% 
  mutate(Percentage_Change = # ((New Value - Old Value)/ Old Value) * 100
    ((Population_in_2021 - Population_in_1996) / Population_in_1996) 
         * 100)
View(SSHA_Population_PercentageChange)

SSHA_Population_PercentageChange_PopulationGrowth <- 
  SSHA_Population_PercentageChange %>% mutate(
    Population_Growth = # New Population - Old Population
      Population_in_2021 - Population_in_1996
    )

View(SSHA_Population_PercentageChange_PopulationGrowth)
