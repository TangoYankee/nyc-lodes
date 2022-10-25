library(tidyverse)
library(sf)
library(geojsonsf)
library(tmap)

boi_name = "Brooklyn"
boi_borders <- geojson_sf('./data/boro_boundaries.geojson')%>%
  filter(boro_name == boi_name)
boi_subway_lines <- geojson_sf('./data/subway_lines.geojson') %>%
  st_intersection(boi_borders)

tm_shape(boi_borders) +
  tm_polygons(
    col = "#e2e2e2",
  ) +
  tm_shape(boi_subway_lines) +
  tm_lines(
    col = "rt_symbol"
  )