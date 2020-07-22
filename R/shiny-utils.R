shiny_config <- function(){
  # copy config file
  config <- pkg_file("shiny/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

shiny_js_files <- function(){
  name <- get_pkg_name()

  # read and adapt
  index_in <- pkg_file("shiny/srcjs/index.js")
  index <- readLines(index_in)
  index <- gsub("#name#", name, index)

  # write
  index_out <- sprintf("%s/index.js", SRC)
  writeLines(index, index_out)

  # coypy module
  modules_in <- pkg_file("shiny/srcjs/modules")
  modules_out <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules_in, SRC)

  cli::cli_alert_success("Created `srcjs` directory")
}

shiny_r_files <- function(){
  name <- get_pkg_name()

  # zzz.R
  zzz_in <- pkg_file("shiny/R/zzz.R")
  zzz <- readLines(zzz_in)
  zzz <- gsub("#name#", name, zzz)
  writeLines(zzz, "R/zzz.R")

  # dependencies
  deps_in <- pkg_file("shiny/R/dependencies.R")
  deps <- readLines(deps_in)
  deps <- gsub("#name#", name, deps)
  use_fun <- sprintf("use%s", tools::toTitleCase(name))
  deps <- gsub("^use_name", use_fun, deps)
  writeLines(deps, "R/dependencies.R")

  # function
  alert_in <- pkg_file("shiny/R/alert.R")
  alert <- readLines(alert_in)
  alert <- gsub("#name#", name, alert)
  writeLines(alert, "R/alert.R") 

  cli::cli_alert_success("Created R files and functions")
}
