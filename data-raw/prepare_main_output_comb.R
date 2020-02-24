-------------------------------------------------------------------------------------------------
# Code to process Excel sheet with main GLOBIOM output combinations
-------------------------------------------------------------------------------------------------

############### PACKAGES ###############
library(readxl)

############### LOAD DATA ###############
# Load data and combine scenario data
eu_nuts_pdf_raw <- bind_rows(
  read_excel("E:/OneDrive - IIASA/projects/rglobiom/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "BASE"),
  read_excel("E:/OneDrive - IIASA/projects/rglobiom/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "CONST"),
  read_excel("E:/OneDrive - IIASA/projects/rglobiom/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "EMIRED"))


############### PROCESS ###############
# Put in long format
eu_nuts_pdf <- eu_nuts_pdf_raw %>%
  gather(year, value, -NUTS2, -scenario) %>%
  mutate(year = as.integer(year))

# Add as data to package
usethis::use_data(eu_nuts_pdf, overwrite = T)
