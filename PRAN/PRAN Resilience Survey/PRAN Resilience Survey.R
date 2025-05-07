library(ggplot2)
library(tidyverse)

##########################
# By Region
##########################
# Completions By Region Data
regional_data <- data.frame(
  Region = c("West Africa", "Central Africa", "East Africa", 
             "South Africa", "Sudan & W. Sahara"),
  Target = c(490, 266, 654, 84, 31),
  Completions = c(611, 285, 501, 141, 10),
  PercentTotalTarget = c(40.1, 18.7, 32.9, 9.2, 0.7),
  PercentRegionTarget = c(124.7, 107.1, 76.6, 167.9, 32.3)
)

#1
ggplot(regional_data, aes(x = Region, y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by Region",
       x = "Region", y = "Number Of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(regional_data$Completions), 100))

#2
ggplot(regional_data, aes(x = reorder(Region, Completions), y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  labs(title = "PRAN Survey on Resilience Completions by Region",
       x = "Region", y = "Number Of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(regional_data$Completions), 100))

#3
ggplot(regional_data, aes(x = reorder(Region, Completions), y = Completions)) +
  geom_bar(stat = "identity", fill = "#222d4d") +
  coord_flip() +
  labs(title = "PRAN Survey on Resilience Completions by Region",
       x = "Region", y = "Number Of Completions") +
  theme_minimal() +
  scale_y_continuous(breaks = seq(0, max(regional_data$Completions), 100))

# Reshape to long format
long_data <- pivot_longer(regional_data, cols = c(Target, Completions),
                          names_to = "Metric", values_to = "Value")

long_data$Metric <- factor(long_data$Metric, levels = c("Target", "Completions"))

#4 (Targets vs. Completions)
ggplot(long_data, aes(x = Region, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "PRAN Survey on Resilience (Targets vs. Completions) by Region",
       x = "Region", y = "Number of People") +
  theme_minimal() +
  scale_fill_manual(values = c("#0c162e", "#69bfd2")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  scale_y_continuous(breaks = seq(0, 800, 100))

#5 (Completion Rates)
ggplot(regional_data, aes(x = reorder(Region, PercentRegionTarget), y = PercentRegionTarget)) +
  geom_bar(stat = "identity", fill = "#5f3424") +
  coord_flip() +
  labs(title = "PRAN Survey on Resilience Completion Rates by Region", 
       x = "Region", y = "Completion Rate (%)") +
  geom_hline(yintercept = 100, linetype = "dashed", color = "red") +
  theme_minimal()

#6 (Completion Rates)
ggplot(regional_data, aes(x = Region, y = PercentRegionTarget)) +
  geom_bar(stat = "identity", fill = "#5f3424") +
  coord_flip() +
  labs(title = "PRAN Survey on Resilience Completion Rates by Region", 
       x = "Region", y = "Completion Rate (%)") +
  geom_hline(yintercept = 100, linetype = "solid", color = "red") +
  theme_minimal()

#7 (Completion Rates)
ggplot(regional_data, aes(x = reorder(Region, -PercentRegionTarget), 
                          y = PercentRegionTarget)) +
  geom_bar(stat = "identity", fill = "#5f3424") +
  labs(title = "PRAN Survey on Resilience Completion Rates by Region", 
       x = "Region", y = "Completion Rate (%)") +
  geom_hline(yintercept = 100, linetype = "solid", color = "red") +
  theme_minimal() +
  annotate(
    "text", x = 2.5, y = 140,  
    label = "Regions where we were able to achieve at least a 100% completion rate:\nSouth Africa (168%), West Africa (125%), Central Africa (107%)",
    hjust = 0,  # Left-align text
    size = 3.5,  # Text size
    fontface = "bold",
    color = "#1B263B"
  )



##########################
# By Gender
##########################
# Gender Data
gender_data <- data.frame(
  Gender = c("Male", "Female", "Nonbinary", "Other", 
             "Do not know", "Prefer not to answer"),
  Count = c(795, 737, 1, 2, 0, 13),
  Percent = c(51.4, 47.6, 0.1, 0.1, 0.0, 0.8)
)

# Gender Data (Male & Female only)
gender_data2 <- data.frame(
  Gender = c("Male", "Female"),
  Count = c(795, 737)
)

# Percentage Calculation and label
gender_data2$Percent <- round(gender_data2$Count / 
                                sum(gender_data2$Count) * 100, 1)

# Reorder Gender levels making Male come first
gender_data2$Gender <- factor(gender_data2$Gender, 
                              levels = c("Male", "Female"))

#1 Gender Data Pie chart (Male & Female)
ggplot(gender_data2, aes(x = "", y = Count, fill = Gender)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste(Percent, "%")), 
            position = position_stack(vjust = 0.5), size = 5) +
  scale_fill_manual(values = c("#8DD6EA", "#d34e9c")) +
  labs(title = "PRAN Survey on Resilience Gender Distribution (Male vs Female)", 
       x = NULL, y = NULL, fill = "Gender") +
  theme_void() +
  theme(legend.position = "right")

# Make three groups: Male, Female, Other
donut_data <- gender_data %>%
  mutate(Category = ifelse(Gender %in% c("Male", "Female"), 
                           Gender, "Other")) %>%
  group_by(Category) %>%
  summarise(Count = sum(Count)) %>%
  mutate(Fraction = Count / sum(Count),
         Ymax = cumsum(Fraction),
         Ymin = lag(Ymax, default = 0),
         LabelPosition = (Ymax + Ymin) / 2,
         Label = paste0(Category, ": ", round(Fraction * 100, 1), "%"))

donut_data$Gender <- factor(donut_data$Category, 
                              levels = c("Male", "Female"))

#2 Gender Data Donut chart (Male, Female & Other)
ggplot(donut_data) +
  geom_rect(aes(ymin = Ymin, ymax = Ymax, xmax = 4, 
                xmin = 3, fill = Category)) +
  coord_polar(theta = "y") +
  xlim(c(2, 4)) +  # Donut hole size
  theme_void() +
  geom_text(aes(x = 3.5, y = LabelPosition, label = Label), 
            color = "black", size = 5) +
  scale_fill_manual(values = c("Male" = "#8DD6EA", 
                               "Female" = "#d34e9c", "Other" = "#d1b899")) +
  ggtitle("PRAN Survey on Resilience Gender Distribution (Grouped)")



##########################
# By Language
##########################
# Language Data
language_data <- data.frame(
  Language = c("English", "French"),
  Count = c(1195, 353)
)

# Calculate percent and label
language_data$Percent <- round(language_data$Count / 
                                 sum(language_data$Count) * 100, 1)
language_data$Label <- paste(language_data$Percent, "%")

#1 Pie chart using ggplot2
ggplot(survey_language_data, aes(x = "", y = Count, fill = Language)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar(theta = "y") +
  geom_text(aes(label = Label), 
            position = position_stack(vjust = 0.5), size = 5) +
  scale_fill_manual(values = c("#d1b899", "#445a80")) +
  labs(title = "PRAN Resilience Survey: Language of Completion", 
       x = NULL, y = NULL, fill = "Language") +
  theme_void() +
  theme(legend.position = "right")



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
  )
)

ggplot(country_data, aes(x = reorder(Country, Total), y = Total)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() + # Flips the chart to make it horizontal
  labs(title = "Total Data by Country",
       x = "Country",
       y = "Total") +
  theme_minimal()

ggplot(country_data, aes(x = "", y = Percentage, fill = Country)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Percentage by Country") +
  theme_void() +
  theme(legend.position = "none")

# Top 10 countries by Total
top10 <- country_data %>%
  arrange(desc(Total)) %>%
  slice_head(n = 10)

#1 (top 10)
ggplot(top10, aes(x = Country, y = Total)) +
  geom_bar(stat = "identity", fill = "#5f3424") +
  coord_flip() +
  labs(title = "PRAN Resilience Survey: Top 10 Countries of Origin",
       x = "Country of Origin",
       y = "Number of People") +
  theme_minimal()

#2 (top 10 sorted)
ggplot(top10, aes(x = reorder(Country, Total), y = Total)) +
  geom_bar(stat = "identity", fill = "#5f3424") +
  coord_flip() +
  labs(title = "PRAN Resilience Survey: Top 10 Countries of Origin",
       x = "Country of Origin",
       y = "Number of People") +
  theme_minimal()

# Top 5 countries by Percentage
top5Percentage <- country_data %>%
  arrange(desc(Percentage)) %>%
  slice(1:5) %>%
  mutate(
    Country = factor(Country, levels = Country),
    ymax = cumsum(Percentage),
    ymin = lag(ymax, default = 0),
    label_pos = (ymin + ymax) / 2,
    label = paste0(Country, "\n", Percentage, "%")
  )

custom_colors <- c(
  "Nigeria" = "#c51f85",
  "Ghana" = "#a96847",
  "Cameroon" = "#8bd6ec",
  "Ethiopia" = "#88a73d",
  "Eritrea" = "#ecdbc1"
)


#3 (top 5 percentages)
ggplot(top5Percentage, aes(ymax = ymax, ymin = ymin, xmax = 4, 
                            xmin = 3, fill = Country)) +
  geom_rect(color = "white") +
  coord_polar(theta = "y") +
  xlim(c(2, 4)) +
  theme_void() +
  theme(legend.position = "none") +
  geom_text(aes(x = 3.5, y = label_pos, label = label), size = 4) +
  scale_fill_manual(values = custom_colors) +
  ggtitle("PRAN Resilience Survey: Top 5 Countries by Percentage")
