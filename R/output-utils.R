output_js_files <- function(name){
  pkgname <- get_pkg_name()

  output_index_file(name)

  module_in <- pkg_file("output/javascript/output.js")
  module <- readLines(module_in)
  module <- gsub("#name#", name, module)
  module <- gsub("#pkgname#", pkgname, module)

  module_out <- sprintf("srcjs/outputs/%s.js", name)
  writeLines(module, module_out)
}

output_index_file <- function(name){

  # commons
  index <- sprintf("import './outputs/%s.js';", name)

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
