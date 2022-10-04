library(ggmap)

maps_key = Sys.getenv("GOOGLE_MAPS_API_KEY")
register_google(maps_key, "standard")

options(scipen = 999)
od <- read.csv("./data/nyc_od_cw_tract_coord.csv")
same_borough_od <- od %>%
  filter(h_geocode_county == w_geocode_county)
exclude_manhattan_work_od <- od %>%
  filter(w_geocode_county != 61)

nyc <- get_map(location = "New York, NY", zoom = 11, color = "bw")
ggmap(nyc, darken = 0.8) +
  geom_segment(
    data = exclude_manhattan_work_od[exclude_manhattan_work_od$S000 > 4,],
    aes(y = h_lat, x = h_lon, yend = w_lat, xend = w_lon, alpha = S000),
    color = "white",
    size = 0.3
  ) +
  scale_alpha_continuous(range = c(0.004, 0.3)) +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
  )
