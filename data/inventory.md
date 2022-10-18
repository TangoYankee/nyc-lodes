## Provided Data files

The analysis is performed using the geojson nys tract file. This file is derived from the 2010 Census tract data available at the [Census Cartographic Boundary Files repository](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.2010.html#list-tab-40RKW26654EFTMARWW)
The shapes files were converted to geojson using the [MyGeoData Converter](https://mygeodata.cloud/converter/)

## Needed Data files

Analysis is based on LODES7 New York.
These data files are available at [LEHD Origin-Destination Employment Statistics (LODES)](https://lehd.ces.census.gov/data/).
They are omitted from the main repository to reduce project size.
- 2019 Main Origin and Destination, All Jobs [download ny_od_main_JT00_2019.csv.gz](https://lehd.ces.census.gov/data/lodes/LODES7/ny/od/ny_od_main_JT00_2019.csv.gz) 
- 2019 Residence Area Characteristics, All Jobs [download ny_rac_S000_JT00_2019.csv.gz](https://lehd.ces.census.gov/data/lodes/LODES7/ny/rac/ny_rac_S000_JT00_2019.csv.gz)
- 2019 Workplace Area Characteristics, All Jobs [download ny_wac_S000_JT00_2019.csv.gz](https://lehd.ces.census.gov/data/lodes/LODES7/ny/wac/ny_wac_S000_JT00_2019.csv.gz)
- 2019 Geography cross walk [download ny_xwalk.csv.gz](https://lehd.ces.census.gov/data/lodes/LODES7/ny/ny_xwalk.csv.gz)
- [2010 NYC NTA Data](https://www1.nyc.gov/site/planning/data-maps/open-data/census-download-metadata.page) (clipped to shoreline)
  - [Download Census tract equivalents](https://www1.nyc.gov/assets/planning/download/office/planning-level/nyc-population/census2020/nyc2020census_tract_nta_cdta_relationships.xlsx?r=092221)
  - [Download NTA GeoJSON](https://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/NYC_Neighborhood_Tabulation_Areas_2010/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=pgeojson)
- NYC subway line geographic data. [NYC Open Data Portal](https://data.cityofnewyork.us/Transportation/Subway-Lines/3qz8-muuu)
- NYC 2010 Census blocks [Download geojson](https://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/NYC_Census_Blocks_for_2010_US_Census/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=pgeojson)
- NYC 2010 Census Tracts [Download Geojson](https://services5.arcgis.com/GfwWNkhOj9bNBqoJ/arcgis/rest/services/NYC_Census_Tracts_for_2010_US_Census/FeatureServer/0/query?where=1=1&outFields=*&outSR=4326&f=pgeojson)

## Generated Data Files
The `create_origin_dest_data.R` script will use the census data to generate the custom `ny_od_cw_tract_coord.csv` file.
The custom file is used to generate the NY Lodes map.