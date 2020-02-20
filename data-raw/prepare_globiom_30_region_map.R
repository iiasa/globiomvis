------------------------------------------
# Code to simplify globiom 30 region map.
------------------------------------------

############### PACKAGES ###############
library(sf)
library(rprojroot)
library(rworldmap)
library(readr)
library(dplyr)


############### SET ROOT ###############
root <- find_root(is_rstudio_project)


############### LOAD DATA ###############
# World map
# We take the map from rworldmap because rnaturalearth map lables French Guyana as France, which distorts the map
wld_raw <- getMap(resolution="low")
wld_raw <- st_as_sf(wld_raw)
plot(wld_raw$geometry)

# ANYREGION2iso3c with 244 countries
anyregion2iso3c <- read_csv("P:/globiom/Data/simu_luid_region_maps/Mappings/ANYREGION2iso3c.csv")


############### PROCESS ###############
# link mapping
region30 <- wld_raw %>%
  dplyr::mutate(iso3c = ISO_A3) %>%
  left_join(anyregion2iso3c) %>%
  dplyr::select(SOVEREIGNT, ADMIN, iso3c, ANYREGION, ALLCOUNTRY, country.name, GLOBIOM, REGION, continent, GEO3major, GEO3) %>%
  mutate(GLOBIOM = if_else(is.na(GLOBIOM), "N", GLOBIOM))

# Add as shapefile to package
write_sf(region30, file.path(root, "inst/shp/region30.shp"))
