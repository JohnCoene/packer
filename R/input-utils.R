input_config <- function(){
  # check if already initialised
  scaffold <- has_scaffold()
  if(scaffold) return()

  # copy config file
  config <- pkg_file("input/javascript/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

input_js_files <- function(name){
  pkgname <- get_pkg_name()

  # create srcjs
  modules_path <- sprintf("%s/modules", SRC)
  fs::dir_create(modules_path)

  # create input module
  input_in <- pkg_file("input/javascript/srcjs/modules/input.js")
  input <- readLines(input_in)
  input <- gsub("#name#", name, input)
  input <- gsub("#pkgname#", pkgname, input)
  input_out <- sprintf("%s/modules/%s.js", SRC, name)
  writeLines(input, input_out)

  cli::cli_alert_success("Created input module")

  # deal with input
  input_index_file(name)
}

input_index_file <- function(name){
  # read
  index_out <- sprintf("%s/index.js", SRC)

  # check if exists
  index_exists <- fs::file_exists(index_out)

  if(!index_exists){
    index_template <- pkg_file("input/javascript/srcjs/index.js")
    index <- readLines(index_template)
    index <- gsub("#name#", name, index)
    cli::cli_alert_success("Created input module")
  } else {
    index <- readLines(index_out)
    import <- sprintf("import './modules/%s.js'", name)
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
