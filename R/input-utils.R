input_js_files <- function(name){
  pkgname <- get_pkg_name()

  # create srcjs
  create_directory("srcjs/inputs")

  # create input module
  input_in <- pkg_file("input/javascript/input.js")
  input <- readLines(input_in)
  input <- gsub("#name#", name, input)
  input <- gsub("#pkgname#", pkgname, input)
  input_out <- sprintf("srcjs/inputs/%s.js", name)
  writeLines(input, input_out)

  cli::cli_alert_success("Created input file in `srcjs/inputs`")

  # deal with input
  creup_index(name, "inputs")
}

input_r_files <- function(name){
  pkgname <- get_pkg_name()

  # function
  input_in <- pkg_file("input/R/input.R")
  input <- readLines(input_in)
  input <- gsub("#name#", name, input)
  input <- gsub("#pkgname#", pkgname, input)
  input_out <- sprintf("R/%s.R", name)
  writeLines(input, input_out) 

  cli::cli_alert_success("Created R file and function")
}
