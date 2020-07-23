input_config <- function(){
  # copy config file
  config <- pkg_file("input/javascript/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

input_js_files <- function(name){
  pkgname <- get_pkg_name()

  # read and adapt
  index_in <- pkg_file("input/javascript/srcjs/index.js")
  index <- readLines(index_in)
  index <- gsub("#name#", name, index)
  index <- gsub("#pkgname#", pkgname, index)

  # write
  index_out <- sprintf("%s/index.js", SRC)
  writeLines(index, index_out)

  # coypy module
  modules_in <- pkg_file("input/javascript/srcjs/modules")
  modules_out <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules_in, SRC)

  cli::cli_alert_success("Created `srcjs` directory")
}

input_r_files <- function(name){
  pkgname <- get_pkg_name()

  # function
  input_in <- pkg_file("input/R/input.R")
  input <- readLines(input_in)
  input <- gsub("#name#", name, input)
  input <- gsub("#pkgname#", pkgname, input)
  writeLines(input, "R/input.R") 

  cli::cli_alert_success("Created R file and function")
}
