library(ggmap)

maps_key = Sys.getenv("GOOGLE_MAPS_API_KEY")
register_google(maps_key, "standard")

od <- read.csv("./data/ny_od_cw_tract_coord.csv")
