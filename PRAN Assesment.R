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

library(ggplot2)

# FIGURE 1
SSHA_Population_long <- SSHA_Population %>%
  pivot_longer(
    cols = c(Population_in_1996, Population_in_2021),
    names_to = "Year",
    values_to = "Population"
  ) %>%
  # Convert Year names to just the year values
  mutate(Year = ifelse(Year == "Population_in_1996", "1996", "2021"))

# Create the horizontal grouped bar chart
ggplot(SSHA_Population_long, aes(y = Provinces, x = Population, fill = Year)) +
  geom_col(position = position_dodge(width = 0.9)) +
  scale_fill_manual(values = c("1996" = "#FF7F50", "2021" = "#000080")) +  # Orange for 1996, Navy blue for 2021
  # Add labels directly on the bars for small values
  geom_text(aes(label = scales::comma(Population)), 
            position = position_dodge(width = 0.9),
            hjust = -0.1,  # Position text just outside the bars
            size = 3,      # Smaller text size
            color = "black",
            data = . %>% filter(Population < 5000)) +  # Only label small values
  # Increase x-axis limit to make room for labels
  scale_x_continuous(labels = scales::comma, limits = 
                       c(0, max(Population_in_2021)), breaks = 
                       seq(0, 250000, 20000)) +
  labs(
    title = "SSA immigrants' population distribution by province/territory (Census 1996 vs 2021)",
    y = "Province",
    x = "Population"
  ) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "top",
    axis.text.y = element_text(size = 10)
  )
