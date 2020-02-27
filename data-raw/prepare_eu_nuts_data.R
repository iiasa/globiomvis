-------------------------------------------------------------------------------------------------
# Code to process eu nuts example data obtained from Fulvio di Fulvio.
#
# Data is taken from Di Fulvio et al. (2019), Spatially explicit LCA analysis of biodiversity
# losses due to different bioenergy policies in the European Union, Science of the
# Total Environment, 651, 1505-1516.
#
# Data represents potentially disappeared fraction of global species (PDF/ha) per EU Nuts region.
  -------------------------------------------------------------------------------------------------

############### PACKAGES ###############
library(readxl)

############### LOAD DATA ###############
# Load data and combine scenario data
eu_nuts_pdf_raw <- bind_rows(
  read_excel("E:/OneDrive - IIASA/projects/globiomvis/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "BASE"),
  read_excel("E:/OneDrive - IIASA/projects/globiomvis/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "CONST"),
  read_excel("E:/OneDrive - IIASA/projects/globiomvis/data/PDF_ha_10-12.xlsx", sheet = "BASE") %>%
    mutate(scenario = "EMIRED"))


############### PROCESS ###############
# Put in long format
eu_nuts_pdf <- eu_nuts_pdf_raw %>%
  gather(year, value, -NUTS2, -scenario) %>%
  mutate(year = as.integer(year))

# Add as data to package
usethis::use_data(eu_nuts_pdf, overwrite = T)
