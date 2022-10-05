library(geojsonio)
library(tidyverse)
library(broom)

nyc_nta_tract_equiv <- readxl::read_xlsx('./data/nyc_2010_census_tract_nta_equiv.xlsx')

# determine how many combinations of nta travel routes there are
choose(length(unique(nyc_nta_tract_equiv$`nta-code`)), 2)

# Map the NTAs
nyc_nta_geo <- geojson_read('./data/nyc_nta_2010.geojson', what = 'sp')
nyc_nta_geo_tidy <- tidy(nyc_nta_geo)
ggplot() +
  geom_polygon(data = nyc_nta_geo_tidy, aes(x = long, y = lat, group = group), fill='#69b3a2', color = 'white')
