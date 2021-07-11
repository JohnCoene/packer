#' Packge File
#' 
#' Get path to packge file.
#' 
#' @return Path to inst/ file
#' 
#' @noRd
#' @keywords internal
pkg_file <- function(file){
  system.file(file, package = "packer")
}

# ignore files
ignore_files <- function(){
  cli::cli_h2("Adding files to {.file .gitignore} and {.file .Rbuildignore}")
  
  usethis::use_build_ignore("srcjs")
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_build_ignore("webpack.dev.js")
  usethis::use_build_ignore("webpack.prod.js")
  usethis::use_build_ignore("webpack.common.js")
  usethis::use_git_ignore("node_modules")
  
  if(engine_get() == "yarn"){
    usethis::use_build_ignore("yarn.lock")
    usethis::use_build_ignore("yarn-error.log")
    usethis::use_build_ignore(".yarn/")
  }

  cat("\n")
}

# prints error and warnings from system2
print_results <- function(results){
  if(length(results$warnings))
    engine_console()
}

# get name of package
get_pkg_name <- function(){
  desc <- readLines("DESCRIPTION")
  pkg <- desc[grepl("^Package:", desc)]
  pkg <- gsub("^Package: ", "", pkg)
  trimws(pkg)
}

# install webpack as dev dependency
webpack_install <- function(){
  scaffolded <- has_scaffold()
  if(scaffolded) return()
  engine_install("webpack", "webpack-cli", "webpack-merge", scope = "dev")
}

# create directory
create_directory <- function(path, ...){
  exists <- fs::dir_exists(path)

  if(exists){
    cli::cli_alert_info("Directory {.file {path}} already exists")
    return()
  }

  fs::dir_create(path, ...)
  cli::cli_alert_success("Created {.file {path}} directory")
}

#' Use Packages
#' 
#' Wrapper for [usethis::use_package()] to add multiple packages.
#' 
#' @param ... Names of packages to add to Imports.
#' 
#' @noRd 
#' @keywords internal
use_pkgs <- function(...){
  cli::cli_h2("Adding packages to Imports")
  lapply(c(...), usethis::use_package)
  cat("\n")
  invisible()
}

#' Messages
#' 
#' Simple wrappers for scaffold messages, on start and end.
#' 
#' @param what What is being scaffolded.
#' @param name Name of scaffold.
#' 
#' @noRd 
#' @keywords internal
end_msg <- function(){
  cli::cli_h2("Scaffold built")
  cli::cli_alert_info("Run `bundle` to build the JavaScript files")
}

#' @noRd 
#' @keywords internal
open_msg <- function(what, name = ""){
  lefty <- sprintf("Scaffolding %s", what)
  cat(cli::rule(left = lefty, right = name, line_col = "blue"), "\n")
}

#' Edit files
#' 
#' Opens relevant files in browser or RStudio if available.
#' 
#' @param edit Whether to open the files.
#' 
#' @noRd 
#' @keywords internal
edit_files <- function(edit = FALSE, ...){
  if(!edit) return()

  if(rstudioapi::isAvailable())
    lapply(c(...), rstudioapi::navigateToFile)
  else
    lapply(c(...), utils::file.edit)

  invisible()
}

#' Save JSON
#' 
#' `jsonlite` wrapper to unbox and pretty write.
#' 
#' @noRd 
#' @keywords internal
save_json <- function(...){
  jsonlite::write_json(..., auto_unbox = TRUE, pretty = TRUE)
}

#' Handle babel config
#' 
#' Convenience to handle `.babelrc` files.
#' 
#' @param path Path to template `.babelrc` file.
#' 
#' @noRd 
#' @keywords internal
babel_config <- function(path){
  if(fs::file_exists(".babelrc")){
    cli::cli_alert_warning("{.file .babelrc} file already exists, add the following")
    print_babel_config(path)
    return()
  }

  path <- pkg_file(path)
  fs::file_copy(path, ".babelrc")
  cli::cli_alert_success("Created {.file .babelrc}")
  usethis::use_build_ignore(".babelrc")
}

#' @noRd
#' @keywords internal
print_babel_config <- function(path){
  path <- pkg_file(path)
  content <- readLines(path)
  cli::cli_code(content)
}

#' Creates or Updates index.js File
#' 
#' Creates or updates the `index.js` file with import of new scaffod.
#' 
#' @param name Name of scaffold.
#' @param dir Directory where to place files in `srcjs`.
#' 
#' @noRd 
#' @keywords internal
creup_index <- function(name, dir = c("exts", "inputs", "outputs")){

  dir <- match.arg(dir)
  type <- dir2type(dir)

  # commons
  index <- sprintf("import './%s/%s.js';", dir, name)

  if(fs::file_exists("srcjs/index.js")){
    existing <- readLines("srcjs/index.js")
    index <- c(index, existing)
    cli::cli_alert_success("Added {.val {type}} module import to {.file srcjs/index.js}")
  } else {
    cli::cli_alert_success("Created {.file srcjs/index.js}")
  }

  # save
  writeLines(index, "srcjs/index.js")
}

#' @noRd 
#' @keywords internal
dir2type <- function(dir){
  switch(
    dir,
    exts = "extension",
    inputs = "input",
    outputs = "output"
  )
}

#' Generates Template R file
#' 
#' @param name Name of scaffold.
#' @param template_path Path to template R file.
#' 
#' @noRd
#' @keywords internal
template_r_function <- function(name, template_path){
  # get package name
  pkgname <- get_pkg_name()

  # read and replace
  output_in <- pkg_file(template_path)
  output <- readLines(output_in)
  output <- gsub("#name#", name, output)
  output <- gsub("#Name#", tools::toTitleCase(name), output)
  output <- gsub("#pkgname#", pkgname, output)

  # save
  output_out <- sprintf("R/%s.R", name)
  if(file.exists(output_out)){
    cli::cli_alert_warning(
      sprintf(
        "Could not create `%s`, already exists.",
        output_out
      )
    )
    output_out <- sprintf("R/%s-packer.R", name)
  }
  writeLines(output, output_out) 

  cli::cli_alert_success("Created R file and function")
}

#' Generates Template R file
#' 
#' @param name Name of scaffold.
#' @param template_path Path to template R file.
#' 
#' @noRd
#' @keywords internal
template_js_module <- function(name, output_dir = c("exts", "inputs", "outputs")){
  pkgname <- get_pkg_name()
  output_dir <- match.arg(output_dir)
  type <- dir2type(output_dir)

  # create input module
  # read
  path <- sprintf("%s/javascript/%s.js", type, type)
  template_in <- pkg_file(path)

  # replace
  template <- readLines(template_in)
  template <- gsub("#name#", name, template)
  template <- gsub("#pkgname#", pkgname, template)
  template <- gsub("#Name#", tools::toTitleCase(name), template)

  # save
  template_out <- sprintf("srcjs/%s/%s.js", output_dir, name)
  writeLines(template, template_out)

  cli::cli_alert_success("Created {.val {type}} module")
}

#' OS Helpers
#' 
#' OS helpers for commands that differ based on the system.
#' 
#' @noRd 
#' @keywords internal
get_os <- function(){
  unname(Sys.info()["sysname"])
}

#' @noRd 
#' @keywords internal
is_windows <- function(){
  get_os() == "Windows"
}

#' @noRd 
#' @keywords internal
which_or_where <- function(){
  if(is_windows())
    return("where")

  return("which")
}