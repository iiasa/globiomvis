#' GLOBIOMtools_env specific environmental variables and paths
#'
#' Creates scenario plots by region for selected items
#'
#' Sets the environmental, package specific parameters and settings.
#'
#' @param search_path Character. Force a search in a specified directory. This directory should contain the gdalinfo(.exe) executable. If a valid GDAL install is found in this path, this will force gdalUtils to use this installation. Remember to set rescan=TRUE if you have already set an install.
#' @param rescan Logical. Force a rescan if neccessary (e.g. if you updated your GDAL install).
#' @param ignore.full_scan	Logical. If FALSE, perform a brute-force scan if other installs are not found. Default is TRUE.
#' @param verbose	Logical. Enable verbose execution? Default is FALSE.
#'
#' @return Location of folder where most recent version of gams.exe is stored.

#' @examples
#' search_gams()

# GLOBIOMtools_env <- function (search_path = NULL, rescan = FALSE, ignore.full_scan = TRUE,
#           verbose = FALSE){}
#
# globiomtools_set_env <- function (cmd = NULL, path = NULL, version = NA){
#   env = list(cmd = cmd, path = path, version = version)
#   return(env)
# }
# env = globiomtools_set_env(cmd = cmd, path = path, version = version)
# return(env)
# }


#' Search GAMS path
#'
#' Searches for the path where gams.exe is stored
#'
#' This is additional  information
#'

# Check: rsaga.env and plotKML.env
# Need to add function that reads version number from main gams folder and not from subfolder
# is it might happen it is not present
# Need to check unix part with Albert

search_gams <- function (path = NULL,
            cmd = ifelse(Sys.info()["sysname"] == "Windows", "gams.exe", "gams_cmd"),
            root = NULL)
  {
    if (is.null(root)) {
      if (Sys.info()["sysname"] == "Windows") {
        root = "C:/"
      }
      else if (Sys.info()["sysname"] == "Darwin") {
        root = "/usr/local/Cellar"
      }
      else {
        root = "/usr"
      }
    }
    if (!is.null(path)) {
      path = gsub(pattern = "\\/$", x = path, "")
    }
    if (!is.null(path)) {
      message("Verify specified path to GAMS command line program... \n")
      if (!file.exists(file.path(path, cmd))) {
        stop("GAMS command line program ", cmd, " not found in the specified path:\n",
             path)
      }
        message("Found GAMS command line program.\n")
        message("Done\n")
      }

  if (is.null(path)) {
      message("Search for GAMS command line program... \n")
    if (Sys.info()["sysname"] == "Windows") {
      windows_default_path <- file.path(root, "GAMS/win64/")
      path.list = list.files(path = windows_default_path, pattern = paste0("^", cmd, "$"),
                           recursive = TRUE, full.names = TRUE)
      path.list = dirname(path.list)
      versions <- lapply(file.path(path.list, "gamsstmp.txt"), function(x) readChar(x, file.info(x)$size))
      versions <- sapply(versions, function(x) strsplit(x, "[. ]")[[1]][c(2,3)], USE.NAMES = F)
      versionsx <- paste(versions, sep = ".")

      if (length(path.list) >= 2) {
        versions <- basename(path.list)
        path = path.list[which(versions == max(versions))]
        message(paste0("More than one GAMS version detected. Version ", max(versions), " is selected.\n"))
      } else {
        path = path.list
      }
        if (is.null(path)) {
          message("GAMS command line program not found in the following default paths:\n",
              paste0(windows_default_path, collapse = "\n"),
              "\nSearch on the entire hard drive...\n", sep = "")
          path.list = list.files(path = root, pattern = paste0("^", cmd, "$"),
                                 recursive = TRUE, full.names = TRUE)
          path.list = gsub(paste0(".{", nchar(cmd), "}$"),
                           "", path.list)
          if (length(path.list) == 0) {
            stop("GAMS command line program not found on ",
                 root, "\n")
          }
          if (length(path.list) >= 2) {
            message(paste0("More than one GAMS version detected. Version ", max(versions), " is selected.\n"))
            versions <- basename(path.list)
            path = path.list[which(versions == max(versions))]
          } else {
            path = path.list
          }
        }
      }
      else {
        unix.defaults.paths = c("/usr/bin", "/usr/local/bin",
                                "/usr/local/Cellar/saga-gis-lts/2.3.2/bin", sub(paste0("/",
                                                                                       cmd), "", system2("which", args = cmd, stdout = TRUE)))
        for (pa in unix.defaults.paths) {
          if (file.exists(file.path(pa, cmd))) {
            path = pa
          }
        }
        if (is.null(path)) {
          path = list.files(path = root, pattern = paste0(cmd,
                                                          "$"), recursive = TRUE, full.names = TRUE)[1]
          path = gsub(paste0(".{", nchar(cmd), "}$"), "",
                      path)
          if (is.na(path)) {
            stop("SAGA command line program not found on ",
                 root, "\n")
          }
        }
      }
    message("Done\n")
  }
  return(path)
}
