#'========================================================================================================================================
#' Project:  GLOBIOM_utils
#' Subject:  get data path 
#' Author:   Michiel van Dijk
#' Contact:  michiel.vandijk@wur.nl
#'========================================================================================================================================

# Use this file to set your path to the data
# check your computer username using
# Sys.info()["user"] and use this in the if
# statement. Then add your dataPath within 
# the {} brackets

# Michiel IIASA
if(Sys.info()["user"] == "vandijkm") {
  globiom_path <- "P:/globiom"
  gams_path <- "C:/GAMS/win64/25.0"
}

# Stefan IIASA
if(Sys.info()["user"] == "frank") {
  globiom_path <- "P:/globiom"
  gams_path <- "C:/GAMS/win64/24.2"
}

# Anybody else:
if(Sys.info()["user"] == "difulvi") {
  globiom_path <- "P:/globiom"
  gams_path <- "C:/GAMS/win64/26.1"
  }


