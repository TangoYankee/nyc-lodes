library(ggmap)

maps_key = Sys.getenv("GOOGLE_MAPS_API_KEY")
register_google(maps_key, "standard")

od <- read.csv("./data/ny_od_cw_tract_coord.csv")

nyc <- get_map(location = "Bronx, NY", zoom = 10, color = "bw")
ggmap(nyc, darken = 0.8) +
  geom_segment(
    data = od[od$S000 > 25,],
    aes(y = h_lat, x = h_lon, yend = w_lat, xend = w_lon, alph = S000),
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
