library(tidyverse)
library(rgdal)

maps_key = Sys.getenv("GOOGLE_MAPS_API_KEY")
register_google(maps_key, "standard")

origin_dest_full <- read.csv("./data/ny_od_main_JT00_2019.csv")
origin_dest <- subset(origin_dest_full, select = c("w_geocode", "h_geocode", "S000"))
cross_walk_full <- read.csv("./data/ny_xwalk.csv")
cross_walk <- subset(cross_walk_full, select=c("tabblk2010", "trct"))
options(scipen = 999)

# Merge onto the home block code
od_cw_home <- merge(origin_dest, cross_walk, by.x = "h_geocode", by.y = "tabblk2010", all.x= TRUE)
# Change column names
colnames(od_cw_home) <- c("h_geocode","w_geocode","S000","h_geocode_trct")

# Merge onto the work block code
od_cw <- merge(od_cw_home, cross_walk, by.x = "w_geocode", by.y = "tabblk2010", all.x= TRUE)
# Change column names
colnames(od_cw) <- c("h_geocode","w_geocode","S000","h_geocode_trct","w_geocode_trct")

# Aggregate flows into Tracts
od_cw_tract <- aggregate(data=od_cw, S000 ~ h_geocode_trct + w_geocode_trct, sum)

ny_spatial <- readOGR("./data/ny_tracts_2010/gz_2010_36_140_00_500k.geojson")
ny_wgs84 <- spTransform(ny_spatial, CRS("+init=epsg:4326"))
ny_geoid_centroids <- data.frame(ny_wgs84@data$GEO_ID, coordinates(ny_wgs84))
colnames(ny_geoid_centroids) <- c("Tract", "lon", "lat")

ny_tract_centroids <- ny_geoid_centroids %>%
  mutate(Tract = as.numeric(str_sub(Tract, 10, -1)))

od_cw_tract_home_coord <- merge(od_cw_tract, ny_tract_centroids, by.x = "h_geocode_trct", by.y = "Tract", all.x = TRUE)
colnames(od_cw_tract_home_coord) <- c("h_geocode_trct", "w_geocode_trct", "S000", "h_lon", "h_lat")

od_cw_tract_coord <- merge(od_cw_tract_home_coord, ny_tract_centroids, by.x = "w_geocode_trct", by.y = "Tract", all.x = TRUE)
colnames(od_cw_tract_coord) <- c("w_geocode_trct", "h_geocode_trct", "S000", "h_lon", "h_lat", "w_lon", "w_lat")

write.csv(od_cw_tract_coord, "./data/ny_od_cw_tract_coord.csv")
