#' Extension JavaScript Files
#' 
#' @param name Name of widget as passed to [scaffold_extension()].
#' 
#' @details Creates `srcjs/exts/name.js` file.
#' 
#' @noRd 
#' @keywords internal
ext_js_files <- function(name){

  # index.js
  creup_index(name, "exts")

  # read and adapt
  ext_in <- pkg_file("extension/javascript/extension.js")
  ext <- readLines(ext_in)
  ext <- gsub("#name#", name, ext)

  # write
  ext_out <- sprintf("srcjs/exts/%s.js", name)
  writeLines(ext, ext_out)

  cli::cli_alert_success("Created JavaScript extension file")
}

#' Extension R Files
#' 
#' @param name Name of widget as passed to [scaffold_extension()].
#' 
#' @details Creates `R/name.R` file and `R/zzz.R` file if it does not already exist.
#' 
#' @noRd 
#' @keywords internal
ext_r_files <- function(name){
  pkgname <- get_pkg_name()

  # zzz.R
  if(!fs::file_exists("R/zzz.R")){
    zzz_in <- pkg_file("extension/R/zzz.R")
    zzz <- readLines(zzz_in)
    zzz <- gsub("#pkgname#", pkgname, zzz)
    writeLines(zzz, "R/zzz.R")
    cli::cli_alert_success("Added path to shiny resource")
  }

  # dependencies
  ext_in <- pkg_file("extension/R/extension.R")
  ext <- readLines(ext_in)
  ext <- gsub("#name#", name, ext)
  ext <- gsub("#pkgname#", pkgname, ext)
  use_fun <- sprintf("use%s", tools::toTitleCase(name))
  ext <- gsub("use_name", use_fun, ext)

  ext_out <- sprintf("R/%s.R", name)
  writeLines(ext, ext_out) 

  cli::cli_alert_success("Created R functions")
}
