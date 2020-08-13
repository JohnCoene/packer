#' Extension R Files
#' 
#' @param name Name of widget as passed from [scaffold_extension()].
#' 
#' @details Creates `R/zzz.R` file if it does not already exist.
#' 
#' @noRd 
#' @keywords internal
ext_zzz_file <- function(name){
  pkgname <- get_pkg_name()

  if(fs::file_exists("R/zzz.R")){
    cli::cli_alert_info("{.file R/zzz.R} already exists: assumes path to shiny resource already exists")
    return()
  }

  # create file
  zzz_in <- pkg_file("extension/R/zzz.R")
  zzz <- readLines(zzz_in)
  zzz <- gsub("#pkgname#", pkgname, zzz)
  writeLines(zzz, "R/zzz.R")
  cli::cli_alert_success("Added path to shiny resource")

}
