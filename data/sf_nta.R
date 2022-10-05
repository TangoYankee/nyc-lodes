library(geojsonsf)
library(tidyverse)
library(sf)
library(tmap)

boros <- c("Bronx","Brooklyn","Manhattan", "Queens")

nyc_nta_sf <- geojson_sf('./data/nyc_nta_2010.geojson')

# Manhattan map
# The 99th NTA summarizes parks across the borough
man_nta_poly <- nyc_nta_sf %>%
  filter(BoroCode == 1)
man_nta_centroid <- man_nta_poly %>%
  mutate(geometry = st_centroid(geometry))
tm_shape(filter(man_nta_poly, NTACode == "MN99")) +
  tm_polygons(
    col = "NTAName"
  ) +
  tm_shape(filter(man_nta_centroid, NTACode == "MN99")) +
  tm_dots(
    col = "black"
  )

boros_nta_sf <- nyc_nta_sf %>%
  filter(BoroName %in% boros)

boros_nta_centroids <- boros_nta_sf %>%
  mutate(geometry = st_centroid(geometry))

ggplot() +
  geom_sf(boros_nta_sf, aes(color = BoroName)) +
  coord_sf(aes(datacolor = "black")) +
  theme_minimal()

tm_shape(boros_nta_sf) +
  tm_polygons(
    col = "NTACode"
  ) +
  tm_shape(boros_nta_centroids) +
    tm_dots(
      col = "black"
    )

man_ntas <- nyc