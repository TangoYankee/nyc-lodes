library(geojson)
nyc_nta_tract_equiv <- readxl::read_xlsx('./data/nyc_2010_census_tract_nta_equiv.xlsx')

# determine how many combinations of nta travel routes there are
choose(length(unique(nyc_nta_tract_equiv$`nta-code`)), 2)
