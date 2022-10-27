library(tidyverse)
library(tmap)
library(geojsonsf)
library(sf)

boi_name = "Brooklyn" 
boi_borders <- geojson_sf('./data/boro_boundaries.geojson')%>%
  filter(boro_name == boi_name)
road_lines <- geojson_sf('./data/DCM_ArterialsMajorStreets.geojson') %>%
  filter(borough == boi_name & route_stat == "Existing") %>%
  st_intersection(boi_borders)

tm_shape(boi_borders) +
  tm_polygons(
    col = "#e2e2e2",
  ) +
  tm_shape(road_lines) +
  tm_lines(
    col = "route_type",
    title.col = "Route Type"
  ) + tm_layout(
    legend.outside = TRUE
  )

