library(ggplot2)

ggplot() +
    borders("world", region = "Canada") +
    coord_fixed()

library(sf)
library(rnaturalearth)
library(ggplot2)

canada <- ne_states(country = "canada", returnclass = "sf")

ggplot(canada) +
    geom_sf()


library(canadamaps)
library(ggplot2)

ggplot(canada_prov_sf) +
    geom_sf()


library(choroplethr)
library(choroplethrMaps)

data(canada.map)

canada_choropleth(df = your_data_frame)


library(leaflet)

leaflet() %>%
    addTiles() %>%
    setView(lng = -100, lat = 60, zoom = 3)


#######################################################################
library(sf)
library(ggplot2)
library(rnaturalearth)
library(dplyr)

# Get Canadian provinces
canada <- ne_states(country = "Canada", returnclass = "sf")

class(df)

df <- data.frame(
    name = c("Quebec", "Ontario", "Alberta", "British Columbia"),
    value = c(23, 45, 12, 30)
)

# Join with your data (make sure `name` matches)
canada_data <- canada %>%
    left_join(df, by = "name")

# Plot
ggplot(canada_data) +
    geom_sf(aes(fill = value)) +
    scale_fill_viridis_c(option = "C") +
    labs(title = "Example Choropleth of Canadian Provinces", fill = "Value") +
    theme_minimal()
######################################################################################

# WEB BASED DASHBOARDS (Shiny)
library(leaflet)

leaflet() %>%
    addTiles() %>%
    setView(lng = -100, lat = 60, zoom = 3)


install.packages("mapcan")
library("mapcan")
library(tmap)
data("World")

tm_shape(World) +
    tm_borders() +
    tm_fill("continent")

pr_map <- mapcan(boundaries = province,
                 type = standard) %>%
    ggplot(aes(x = long, y = lat, group = group))
pr_map

pr_map <- pr_map +
    geom_polygon() +
    coord_fixed()
pr_map
