options(scipen = 999)
ny_origin_dest <- read.csv("./data/ny_od_main_JT00_2019.csv")
ny_od_jobs <- ny_origin_dest %>%
  select(w_geocode, h_geocode, S000) %>%
  mutate(w_geocode = as.character(w_geocode)) %>%
  mutate(h_geocode = as.character(h_geocode))
  
