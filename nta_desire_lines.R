library(tidyverse)
library(geojsonsf)
library(sf)
library(tmap)

## All NYC NTA data in Simple features format
nyc_nta_sf <- geojson_sf('./data/nyc_nta_2010.geojson')

## Areas of interest NTA SF data
## Boroughs of interest
boros <- c("Bronx","Brooklyn","Manhattan", "Queens")

## Park and cemetary neighborhoods
parks <- c("BX10", "BX99", "BK99", "MN99", "QN99")

## filter down to areas of interest
boros_nta_poly <- nyc_nta_sf %>%
  filter(BoroName %in% boros) %>%
  filter(!(NTACode %in% parks))

boros_nta_point <- boros_nta_poly %>%
  mutate(geometry = st_point_on_surface(geometry))

## Map Boros of Interest
tm_shape(boros_nta_poly) +
  tm_polygons(
    col = "#dddddd"
  ) +
  tm_shape(boros_nta_point) +
    tm_dots(
      col = "#000000"
   )

## 