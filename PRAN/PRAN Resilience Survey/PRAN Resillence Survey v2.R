library(ggplot2)
library(tidyverse)

##########################
# By Country
##########################
country_data <- data.frame(
  Country = c("Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cameroon", "Cape Verde", 
              "Central African Republic", "Chad", "Comoros", "Congo (Brazzaville)", "Congo (Democratic)", 
              "Côte d’Ivoire", "Djibouti", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", 
              "The Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", "Liberia", 
              "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Mozambique", "Namibia", 
              "Niger", "Nigeria", "Réunion", "Rwanda", "Sao Tome", "Senegal", "Seychelles", 
              "Sierra Leone", "Somalia", "R. of South Africa", "Sudan", "South Sudan", "Swaziland/Eswatini", 
              "Tanzania", "Togo", "Uganda", "Western Sahara", "Zambia", "Zimbabwe"),
  Total = c(
    65, 40, 33, 28, 14, 147, 13, 5, 14, 0, 
    7, 84, 34, 1, 1, 100, 106, 9, 3, 173, 10, 
    0, 66, 7, 21, 2, 4, 13, 0, 1, 0, 2, 13, 209, 
    0, 11, 1, 26, 2, 12, 78, 33, 13, 43, 0, 14, 19, 
    32, 0, 1, 38
  ),
  Percentage = c(
    4.2, 2.6, 2.1, 1.8, 0.9, 9.5, 0.8, 0.3, 0.9, 0.0,
    0.5, 5.4, 2.2, 0.1, 0.1, 6.5, 6.8, 0.6, 0.2, 11.2,
    0.6, 0.0, 4.3, 0.5, 1.4, 0.1, 0.3, 0.8, 0.0, 0.1,
    0.0, 0.1, 0.8, 13.5, 0.0, 0.7, 0.1, 1.7, 0.1, 0.8,
    5.0, 2.1, 0.8, 2.8, 0.0, 0.9, 1.2, 2.1, 0.0, 0.1,
    2.5
  ),
  Regions = c("Central Africa", "Western Africa", "Southern Africa", "Western Africa", "Eastern Africa", 
              "Central Africa", "Western Africa", "Central Africa", "Central Africa", "Eastern Africa",
              "Central Africa", "Central Africa", "Western Africa", "Eastern Africa", "Central Africa",
              "Eastern Africa", "Eastern Africa", "Central Africa", "Western Africa", "Western Africa",
              "Western Africa", "Western Africa", "Eastern Africa", "Southern Africa", "Western Africa",
              "Eastern Africa", "Eastern Africa", "Western Africa", "Western Africa", "Eastern Africa",
              "Eastern Africa", "Southern Africa", "Western Africa", "Western Africa", "Eastern Africa",
              "Eastern Africa", "Central Africa", "Western Africa", "Eastern Africa", "Western Africa",
              "Eastern Africa", "Southern Africa", "Eastern Africa", "Eastern Africa", "Southern Africa",
              "Eastern Africa", "Western Africa", "Eastern Africa", "Northern Africa", "Eastern Africa",
              "Eastern Africa"
              )
)

# Top 20 countries by Total
top20 <- country_data %>%
  arrange(desc(Total)) %>%
  slice_head(n = 20)

# Top 25 countries by Total
top25 <- country_data %>%
  arrange(desc(Total)) %>%
  slice_head(n = 25)

# Top 30 countries by Total
top30 <- country_data %>%
  arrange(desc(Total)) %>%
  slice_head(n = 30)

# Region Colors
region_colors <- c(
  "Western Africa" = "#a96847",
  "Eastern Africa" = "#8bd6ec",
  "Central Africa" = "#88a73d",
  "Southern Africa" = "#ecdbc1"
)

#1 (top 20)
ggplot(top20, aes(x = reorder(Country, Total), y = Total, fill = Regions)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(values = region_colors) +
  labs(
    title = "PRAN Resilience Survey: Top 20 Countries of Origin",
    x = "Country of Origin",
    y = "Number of People",
    fill = "Region"
  ) +
  theme_minimal()

#2 (top 25)
ggplot(top25, aes(x = reorder(Country, Total), y = Total, fill = Regions)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(values = region_colors) +
  labs(
    title = "PRAN Resilience Survey: Top 25 Countries of Origin",
    x = "Country of Origin",
    y = "Number of People",
    fill = "Region"
  ) +
  theme_minimal()

#3 (top 30)
ggplot(top30, aes(x = reorder(Country, Total), y = Total, fill = Regions)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(values = region_colors) +
  labs(
    title = "PRAN Resilience Survey: Top 30 Countries of Origin",
    x = "Country of Origin",
    y = "Number of People",
    fill = "Region"
  ) +
  theme_minimal()



##########################
# By Gender
##########################
# Gender Data
gender_dataCount <- data.frame(
  Gender = c("Male", "Female"),
  Montreal = c(254, 246),
  Edmonton = c(217, 198),
  Toronto = c(234, 154),
  Halifax = c(90, 139),
  All_Cities = c(795, 737),
  stringsAsFactors = FALSE
)

# Reshape data to long format
gender_long <- gender_dataCount %>%
  pivot_longer(cols = -Gender, names_to = "City", values_to = "Count")

# Order based on Heidi's Instruction
gender_long$City <- factor(gender_long$City, 
                           levels = c("All_Cities", "Edmonton",
                                      "Toronto", "Montreal",
                                      "Halifax"))

# Stacked Bar Chart
ggplot(gender_long, aes(x = City, y = Count, fill = Gender)) +
  geom_bar(stat = "identity") +
  labs(title = "PRAN Survey on Resilience Gender Distribution By City",
       x = "City",
       y = "Number of People",
       fill = "Gender") +
  theme_minimal() +
  scale_fill_manual(values = c("Male" = "#8DD6EA", "Female" = "#d34e9c"))

gender_long <- gender_long %>%
  group_by(City) %>%
  mutate(
    Percentage = Count / sum(Count) * 100,
    Label = paste0(round(Percentage, 1), "%"),
    ypos = cumsum(Percentage) - 0.5 * Percentage  # for label position
  )

# Order based on Heidi's Instruction
gender_long$City <- factor(gender_long$City, 
                              levels = c("All_Cities", "Edmonton",
                                         "Toronto", "Montreal",
                                         "Halifax"))
# Pie Chart (messing around)
ggplot(gender_long, aes(x = "", y = Percentage, fill = Gender)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  geom_text(aes(y = ypos, label = Label), color = "black", size = 3) +
  coord_polar("y", start = 0) +
  facet_grid(. ~ City) +
  theme_void() +
  labs(title = "PRAN Survey on Resilience Gender Distribution By City\n", fill = "Gender") +
  scale_fill_manual(values = c("Male" = "#8DD6EA", "Female" = "#d34e9c")) +
  theme(
    strip.text = element_text(face = "bold"),
    legend.position = "bottom"
  )


##########################
# By Language
##########################
# Language Data
language_data <- data.frame(
  Language = c("English", "French"),
  Montreal = c(205, 301),
  Edmonton = c(366, 51),
  Toronto = c(390, 0),
  Halifax = c(234, 1),
  All_Cities = c(595, 301),
  stringsAsFactors = FALSE
)

# Reshape to long format
language_long <- pivot_longer(language_data, 
                              -Language, names_to = "City", 
                              values_to = "Count")

# Calculate percentages and label positions
language_long <- language_long %>%
  group_by(City) %>%
  arrange(desc(Language)) %>%
  mutate(
    Percentage = Count / sum(Count) * 100,
    Label = paste0(round(Percentage, 1), "%"),
    cumulative = cumsum(Percentage),
    midpoint = cumulative - Percentage / 2
  )

# Order based on Heidi's Instruction
language_long$City <- factor(language_long$City, 
                           levels = c("All_Cities", "Edmonton",
                                      "Toronto", "Montreal",
                                      "Halifax"))

# Language Pie Chart by City
ggplot(language_long, aes(x = "", y = Percentage, fill = Language)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  geom_text(aes(y = midpoint, label = Label), color = "black", size = 3.5) +
  coord_polar("y", start = 0) +
  facet_grid(. ~ City) +
  theme_void() +
  labs(title = "PRAN Survey on Resilience Completion Language by City\n", fill = "Language") +
  scale_fill_manual(values = c("English" = "#d1b899", "French" = "#445a80")) +
  theme(
    strip.text = element_text(face = "bold"),
    legend.position = "bottom"
  )

##########################
# By Region
##########################
West_Africa <- data.frame(
  Location = c("All_Cities", "Edmonton", "Toronto", "Montreal", "Halifax"),
  Completions = c(611, 163, 144, 217, 87),
  Percentage = c(39.47, 39.09, 36.92, 42.89, 37.02)
)

Central_Africa <- data.frame(
  Location = c("All_Cities", "Edmonton", "Toronto", "Montreal", "Halifax"),
  Completions = c(285, 72, 40, 140, 33),
  Percentage = c(18.41, 17.27, 10.26, 27.67, 14.04), 
  stringsAsFactors = FALSE
)

East_Africa <- data.frame(
  Location = c("All_Cities", "Edmonton", "Toronto", "Montreal", "Halifax"),
  Completions = c(501, 156, 190, 53, 102),
  Percentage = c(32.36, 37.41, 48.72, 10.47, 43.40)
)

South_Africa <- data.frame(
  Location = c("All_Cities", "Edmonton", "Toronto", "Montreal", "Halifax"),
  Completions = c(141, 25, 16, 95, 5),
  Percentage = c(9.11, 6.00, 4.10, 18.77, 2.13),
  stringsAsFactors = FALSE
)

# Order based on Heidi's Instruction
West_Africa$Location <- factor(West_Africa$Location, 
                             levels = c("All_Cities", "Edmonton",
                                        "Toronto", "Montreal",
                                        "Halifax"))
Central_Africa$Location <- factor(Central_Africa$Location, 
                               levels = c("All_Cities", "Edmonton",
                                          "Toronto", "Montreal",
                                          "Halifax"))
East_Africa$Location <- factor(East_Africa$Location, 
                               levels = c("All_Cities", "Edmonton",
                                          "Toronto", "Montreal",
                                          "Halifax"))
South_Africa$Location <- factor(South_Africa$Location, 
                               levels = c("All_Cities", "Edmonton",
                                          "Toronto", "Montreal",
                                          "Halifax"))

# West Africa
ggplot(West_Africa, aes(x = Location, y = Completions, fill = Location)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by City (West Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(West_Africa$Completions), 100))

# West Africa with Percentage
ggplot(West_Africa, aes(x = Location, y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  geom_text(aes(label = paste(Percentage, "%")), 
            vjust = -0.5, 
            color = "black", 
            size = 4) +
  labs(title = "PRAN Survey on Resilience Completions by City (West Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(
    breaks = seq(0, max(West_Africa$Completions) + 50, 100), 
    limits = c(0, max(West_Africa$Completions) + 20)
  )

# Central Africa
ggplot(Central_Africa, aes(x = Location, y = Completions, fill = Location)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by City (Central Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(Central_Africa$Completions), 50))

# Central Africa with Percentage
ggplot(Central_Africa, aes(x = Location, y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  geom_text(aes(label = paste(Percentage, "%")), 
            vjust = -0.5, 
            color = "black", 
            size = 4) +
  labs(title = "PRAN Survey on Resilience Completions by City (Central Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(
    breaks = seq(0, max(Central_Africa$Completions) + 50, 50), 
    limits = c(0, max(Central_Africa$Completions) + 10)
  )

# East Africa
ggplot(East_Africa, aes(x = Location, y = Completions, fill = Location)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by City (East Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(East_Africa$Completions), 100))

# East Africa with Percentage
ggplot(East_Africa, aes(x = Location, y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  geom_text(aes(label = paste(Percentage, "%")), 
            vjust = -0.5, 
            color = "black", 
            size = 4) +
  labs(title = "PRAN Survey on Resilience Completions by City (East Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(
    breaks = seq(0, max(East_Africa$Completions) + 20, 100), 
    limits = c(0, max(East_Africa$Completions) + 10)
  )

# South Africa
ggplot(South_Africa, aes(x = Location, y = Completions, fill = Location)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by City (South Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(South_Africa$Completions), 20))

# South Africa with Percentage
ggplot(South_Africa, aes(x = Location, y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  geom_text(aes(label = paste(Percentage, "%")), 
            vjust = -0.5, 
            color = "black", 
            size = 4) +
  labs(title = "PRAN Survey on Resilience Completions by City (South Africa)",
       x = "Location",
       y = "Number of Completions") +
  theme_minimal() +
  scale_y_continuous(
    breaks = seq(0, max(South_Africa$Completions) + 5, 20), 
    limits = c(0, max(South_Africa$Completions))
  )
