-------------------------------------------------------------------------------------------------
# Code to process Excel sheet with main GLOBIOM output combinations
-------------------------------------------------------------------------------------------------

############### PACKAGES ###############
library(readr)
library(globiomvis)

############### LOAD DATA ###############
main_output_comb <- read_csv(system.file("globiom", "main_output_comb.csv", package = "globiomvis"))

############### PROCESS ###############
# Add as data to package
usethis::use_data(main_output_comb, overwrite = T)
