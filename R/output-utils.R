output_config <- function(){
  # copy config file
  config <- pkg_file("output/javascript/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

output_js_files <- function(name){
  pkgname <- get_pkg_name()

  # read and adapt
  index_in <- pkg_file("output/javascript/index.js")
  index <- readLines(index_in)
  index <- gsub("#name#", name, index)
  index <- gsub("#pkgname#", pkgname, index)

  # write
  index_out <- sprintf("%s/index.js", SRC)
  writeLines(index, index_out)

  cli::cli_alert_success("Created `srcjs` directory")
}

output_r_files <- function(name){
  pkgname <- get_pkg_name()

  # function
  output_in <- pkg_file("output/R/output.R")
  output <- readLines(output_in)
  output <- gsub("#name#", name, output)
  output <- gsub("#Name#", tools::toTitleCase(name), output)
  output <- gsub("#pkgname#", pkgname, output)
  writeLines(output, "R/output.R") 

  cli::cli_alert_success("Created R file and function")
}
