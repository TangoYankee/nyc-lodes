library(tidyverse)
library(stplanr)
library(tmap)

options(scipen = 999)
ny_origin_dest <- read_csv("./data/ny_od_main_JT00_2019.csv")
county_codes = c("005", "047", "061", "081")

boros_od_jobs <- ny_origin_dest %>%
  select(w_geocode, h_geocode, S000) %>%
  mutate(w_geocode = as.character(w_geocode)) %>%
  mutate(h_geocode = as.character(h_geocode)) %>%
  mutate(w_county = str_sub(w_geocode, 3, 5)) %>%
  mutate(h_county = str_sub(h_geocode, 3, 5)) %>%
  filter(h_county %in% county_codes & w_county %in% county_codes)

tract_nta_equiv <- readxl::read_xlsx('./data/nyc_2010_census_tract_nta_equiv.xlsx')
county_tract_nta_equiv <- tract_nta_equiv %>%
  mutate(county_tract = str_c(`county_code`, `census_tract`)) %>%
  select("county_tract", "nta_code", "nta_name")

ntas_od_jobs <- boros_od_jobs %>%
  mutate(w_county_tract = str_sub(w_geocode, 3, 11)) %>%
  mutate(h_county_tract = str_sub(h_geocode, 3, 11)) %>%
  select(w_county_tract, h_county_tract, S000) %>%
  left_join(county_tract_nta_equiv, c("w_county_tract" = "county_tract")) %>%
  rename(w_nta_code = nta_code) %>%
  rename(w_nta_name = nta_name) %>%
  left_join(county_tract_nta_equiv, c("h_county_tract" = "county_tract")) %>%
  rename(h_nta_code = nta_code) %>%
  rename(h_nta_name = nta_name) %>%
  filter(h_nta_code != w_nta_code) %>%
  select(!c(w_county_tract, h_county_tract)) %>%
  mutate(trip = str_c(h_nta_code, w_nta_code))

ntas_od_summary <- ntas_od_jobs %>%
  group_by(trip) %>%
  summarise(
    S000 = sum(S000),
    )

ntas_unique_trips <- ntas_od_jobs %>% 
  select(!S000) %>%
  unique()
  
nta_commutes <- ntas_od_summary %>%
  left_join(ntas_unique_trips)

## filter out parks
parks <- c("BX10", "BX99", "BK99", "MN99", "QN99")
nta_parkless_commutes <- nta_commutes %>%
  filter(!(w_nta_code %in% parks | h_nta_code %in% parks))

## Boros_nta_point is created by nta_desire_lines.R
nta_points <- boros_nta_point %>%
  select(NTACode, geometry) %>%
  rename(nta_code = NTACode)

nta_commutes_geog <- nta_parkless_commutes %>%
  left_join(nta_points, c("w_nta_code" = "nta_code")) %>%
  rename(w_geometry = geometry) %>%
  left_join(nta_points, c("h_nta_code" = "nta_code")) %>%
  rename(h_geometry = geometry)

nta_commutes_lines <- nta_commutes_geog %>%
  mutate(geometry = st_union(h_geometry, w_geometry)) %>%
  mutate(geometry = st_cast(geometry, "LINESTRING")) %>%
  select(S000, geometry) %>%
  mutate(S000 = as.integer(S000)) %>%
  st_as_sf

tm_shape(boros_nta_poly) +
  tm_polygons(
    col = "BoroName",
  ) +
  tm_shape(sf_nta_commute_lines) +
    tm_lines(
      col = "#212121",
      lwd = "S000",
      )

ggplot() +
  geom_sf(data = boros_nta_poly, aes(color = BoroName)) +
  geom_sf(data = nta_commutes_lines$geometry, aes(color = "#212121"))
