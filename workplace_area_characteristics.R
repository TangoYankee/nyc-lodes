library(rgdal)
library(tidyverse)

options(scipen = 999)
wac <- read.csv('./data/ny_wac_S000_JT00_2019.csv')
rac <- read.csv('./data/ny_rac_S000_JT00_2019.csv')
ny_spatial <- readOGR("./data/ny_tracts_2010/gz_2010_36_140_00_500k.geojson")
ny_wgs84 <- spTransform(ny_spatial, CRS("+init=epsg:4326"))
counties <- c("005", "047", "061", "081")

ny_geoid_centroids <- data.frame(
  geo_id = ny_wgs84@data$GEO_ID,
  county_id = as.character(ny_wgs84@data$COUNTY),
  tract = as.character(ny_wgs84@data$TRACT),
  coordinates(ny_wgs84)
  )

nyc_geoid_centroids <- ny_geoid_centroids %>%
  filter(county_id %in% counties) %>%
  rename(lon = X1) %>%
  rename(lat = X2)
  