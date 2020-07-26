ext_js_files <- function(name){

  # index.js
  ext_index_file(name)

  # read and adapt
  ext_in <- pkg_file("extension/javascript/extension.js")
  ext <- readLines(ext_in)
  ext <- gsub("#name#", name, ext)

  # write
  ext_out <- sprintf("srcjs/exts/%s.js", name)
  writeLines(ext, ext_out)

  cli::cli_alert_success("Created JavaScript extension file")
}

ext_index_file <- function(name){

  # commons
  index <- sprintf("import './exts/%s.js';", name)

  index_exists <- fs::file_exists("srcjs/index.js")
  if(index_exists){
    existing <- readLines("srcjs/index.js")
    index <- c(index, existing)
    cli::cli_alert_success("Added input module import to `srcjs/index.js`")
  } else {
    cli::cli_alert_success("Created `srcjs/index.js` file")
  }

  cli::cli_alert_success("Created input module directory")

  # save
  writeLines(index, "srcjs/index.js")
}

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
