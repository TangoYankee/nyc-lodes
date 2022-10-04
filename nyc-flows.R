library(ggmap)
library(rgdal)

maps_key = Sys.getenv("GOOGLE_MAPS_API_KEY")
register_google(maps_key, "standard")

origin_dest <- read.csv("./data/ny_od_main_JT00_2019.csv")
cross_walk <- read.csv("./data/ny_xwalk.csv")
options(scipen = 999)

od_cw_home <- merge(origin_dest, cross_walk, by.x = "h_geocode", by.y = "tabblk2010", all.x = TRUE)
colnames(od_cw_home) <- c("h_geocode", "w_geocode", "S000", "h_geocode_trct")

od_cw <- merge(od_cw_home, cross_walk, by.x = "w_geocode", by.y = "tabblk2010", all.x = TRUE)
colnames(od_cw) <- c("h_geocode", "w_geocode", "S000", "h_geocode_trct", "w_geocode_trct")
