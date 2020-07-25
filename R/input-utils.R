input_config <- function(name){

  if(fs::file_exists("webpack.config.js"))
    input_config_update(name)
  else
    input_config_create(name)

}

input_config_create <- function(name){
  # copy config file
  path <- pkg_file("input/javascript/webpack.config.js")
  config <- readLines(path)
  config <- gsub("#name#", name, config)
  writeLines(config, "webpack.config.js") 
  cli::cli_alert_success("Created webpack config file")
}

input_config_update <- function(name){
  config <- readLines("webpack.config.js")
  entry_point <- sprintf("\n    '%s': './srcjs/inputs/%s.js',", name, name)
  entry <- config[grepl("entry", config)]
  config[grepl("entry", config)] <- sprintf("%s %s", entry, entry_point)

  writeLines(config, "webpack.config.js")

  cli::cli_alert_success("Updated webpack config file")
}

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
