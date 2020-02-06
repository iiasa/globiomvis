# Code to process eu nuts example data obtained from Fulvio di Fulvio.
#
# Data is taken from Di Fulvio et al. (2019), Spatially explicit LCA analysis of biodiversity
# losses due to different bioenergy policies in the European Union, Science of the
# Total Environment, 651, 1505-1516.
#
# Data represents potentially disappeared fraction of global species (PDF/m2) per EU Nuts region.


# Load packages
library(tidyverse)

# Load data
# Use second row as header
eu_nuts_pdf_raw <- read_csv("E:/OneDrive - IIASA/rglobiom/data/Cropland_EU_NUTS_baseline_scenario.csv", skip = 1)

# Put in long format

eu_nuts_pdf <- eu_nuts_pdf_raw %>%
  gather(year, value, -NUTS2) %>%
  mutate(year = as.integer(year))

# Aggregate two nuts regions that have duplicates
eu_nuts_pdf <- eu_nuts_pdf %>%
  group_by(NUTS2, year) %>%
  summarize(value = sum(value))

# Add as data to package
usethis::use_data(eu_nuts_pdf)
