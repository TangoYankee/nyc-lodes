library(tidyverse)

options(scipen = 999)
ny_od <- read.csv("./data/ny_od_cw_tract_coord.csv")

# New York State: Code 36
# Bronx County: Code 005
# Kings County: Code 047
# New York County: 061
# Queens County: 081
counties <- c("005", "047", "061", "081")

# filter data where home and work are both in area of interest
nyc_od <- ny_od %>%
  mutate(w_geocode_trct = as.character(w_geocode_trct)) %>%
  mutate(h_geocode_trct = as.character(h_geocode_trct)) %>%
  mutate(h_geocode_county = str_sub(h_geocode_trct, 3, 5)) %>%
  mutate(w_geocode_county = str_sub(w_geocode_trct, 3, 5)) %>%
  filter(w_geocode_county %in% counties & h_geocode_county %in% counties)
  
write.csv(nyc_od, "./data/nyc_od_cw_tract_coord.csv")
