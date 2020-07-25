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
  input_index_file(name)
}

input_index_file <- function(name){

  # check if exists
  index_out <- "srcjs/index.js"
  index_exists <- fs::file_exists(index_out)

  # to import
  import <- sprintf("import './inputs/%s.js'", name)

  if(!index_exists){
    index <- import
    cli::cli_alert_success("Created input module and `index.js` file")
  } else {
    index <- readLines(index_out)
    index <- c(import, index)
    cli::cli_alert_success("Added input module import to `srcjs/index.js`")
  }
  
  writeLines(index, index_out)
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
