# Store Provinces
Provinces <- c("Alberta", "British Columbia", "Manitoba", "New Brunswick", 
               "Newfoundland and Labrador", "Nova Scotia", 
               "Northwest Territories", "Ontario", "Prince Edward Island", 
               "Quebec", "Saskatchewan", "Yukon")

# Store 1996 Populations
Population_in_1996 <- c(14940, 24300, 2950, 360, 265, 870, 175, 93895, 50,
                        18945, 1725, 35)

# Store 2021 Populations
Population_in_2021 <- c(102820, 46395, 23555, 3820, 1365, 4800, 560, 220915, 
                        365, 118360, 13980, 135)

# Put populations in 1996 and 2021 in dataset based on PROVINCE
SSHA_Population <- data.frame(Provinces, Population_in_1996, 
                              Population_in_2021)

View(SSHA_Population)

library(tidyverse)

# Create Percentage Change Column
SSHA_Population_PercentageChange <- SSHA_Population %>% 
  mutate(Percentage_Change = # ((New Value - Old Value)/ Old Value) * 100
    ((Population_in_2021 - Population_in_1996) / Population_in_1996) 
         * 100)
View(SSHA_Population_PercentageChange)

# Create Population Growth Column
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

# Was trying to make 1996 come first but 
# on several attempts all i tried didn't work
SSHA_Population_long$Year <- 
  factor(SSHA_Population_long$Year, levels = c("1996", "2021"))

# Create the horizontal grouped bar chart
Figure_1 <- ggplot(SSHA_Population_long, aes(
  x = Population, 
  y = Provinces, 
  fill = Year
  )) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
  scale_fill_manual(
    values = c("1996" = "#FF7F50", "2021" = "#000080")
    ) +  # Orange for 1996, Navy blue for 2021
  # Add labels directly on the bars for small values
  geom_text(aes(label = scales::comma(Population)), 
            position = position_dodge(width = 0.9),
            hjust = -0.1,  # Position text just outside the bars
            size = 3,      # Smaller text size
            color = "black") +
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
    axis.text.y = element_text(size = 10),
    axis.title.x = element_text(margin = margin(t = 5))
  )

Figure_1


# FIGURE 1B
# First, make sure provinces are ordered by Population_Growth
ordered_data <- SSHA_Population_PercentageChange_PopulationGrowth %>%
  arrange(desc(Population_Growth)) %>%
  mutate(Provinces = factor(Provinces, levels = Provinces)) %>% 
  mutate(Percentage_Change = round(Percentage_Change))

# Create the improved bar chart
Figure_1b <- ggplot(ordered_data, aes(x = Provinces, y = Population_Growth)) +
  geom_col(fill = "#65AFFF") +  # Fill with blue colour
  labs(
    title = "Figure 1b. SSA immigrants' population growth by province/territory (Census 1996 vs. 2021)",
    x = "Province",
    y = "Population Growth"
  ) +
  # Wrap province names to multiple lines
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
  scale_y_continuous(
    labels = scales::comma,  # Add commas to numbers
    breaks = seq(0, max(ordered_data$Population_Growth), 10000)  # Create evenly spaced breaks
  ) +
  # Improve the theme
  theme_minimal() +
  theme(
    plot.title = element_text(size = 11, face = "bold"),
    axis.title.y = element_text(margin = margin(r = 10)),
    axis.title.x = element_text(margin = margin(t = 10)),
    panel.grid.major.x = element_blank(),  # Remove vertical grid lines
    panel.grid.minor = element_blank(),    # Remove minor grid lines
    axis.text.x = element_text(angle = 0)
  ) +
  geom_text(
    aes(label = paste(Percentage_Change, "%")),
    vjust = -0.5,
    size = 3.5,
    color = "#1B263B",
    fontface = "bold"
  ) + 
  annotate(
    "text", x = 5, y = 60000,  
    label = "Top percentage changes (1996 vs. 2021):\nNew Brunswick (961%), Saskatchewan (710%), Manitoba (698%)",
    hjust = 0,  # Left-align text
    size = 3.5,  # Text size
    fontface = "bold",
    color = "#1B263B"
  )

Figure_1b
