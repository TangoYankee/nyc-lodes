library(geojsonsf)
library(tidyverse)

boros <- c("Bronx","Brooklyn","Manhattan", "Queens")

nyc_nta_sf <- geojson_sf('./data/nyc_nta_2010.geojson')
boros_nta_sf <- nyc_nta_sf %>%
  filter(BoroName %in% boros)

ggplot(boros_nta_sf) +
  geom_sf(aes(fill = BoroName))
