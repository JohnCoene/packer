output_config <- function(){
  # if exists don't create
  scaffolded <- has_scaffold()
  if(scaffolded) return()

  # copy config file
  config <- pkg_file("output/javascript/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

output_js_files <- function(name){
  pkgname <- get_pkg_name()

  output_index_file(name)

  module_in <- pkg_file("output/javascript/module.js")
  module <- readLines(module_in)
  module <- gsub("#name#", name, module)
  module <- gsub("#pkgname#", pkgname, module)

  module_out <- sprintf("%s/modules/%s.js", SRC, name)
  writeLines(module, module_out)
}

output_index_file <- function(name){

  # commons
  index <- sprintf("import './modules/%s.js';", name)
  index_out <- sprintf("%s/index.js", SRC)

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
  writeLines(index, index_out)
}

output_r_files <- function(name){
  pkgname <- get_pkg_name()

  # function
  output_in <- pkg_file("output/R/output.R")
  output <- readLines(output_in)
  output <- gsub("#name#", name, output)
  output <- gsub("#Name#", tools::toTitleCase(name), output)
  output <- gsub("#pkgname#", pkgname, output)

  output_out <- sprintf("R/%s.R", name)
  writeLines(output, output_out) 

  cli::cli_alert_success("Created R file and function")
}
