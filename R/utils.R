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
  cli::cli_h2("Adding files to .gitignore and .Rbuildignore")
  usethis::use_build_ignore("srcjs")
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_build_ignore("webpack.config.js")
  usethis::use_git_ignore("node_modules")

  cat("\n")
}

# prints error and warnings from system2
print_results <- function(results){
  
  if(length(results$warnings))
    npm_console()
  
}

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
  npm_install("webpack", "webpack-cli", scope = "dev")
}

# create directory
create_directory <- function(path, ...){
  exists <- fs::dir_exists(path)

  if(exists){
    msg <- sprintf("Directory `%s` already exists", path)
    cli::cli_alert_info(msg)
    return()
  }

  fs::dir_create(path, ...)
  msg <- sprintf("Created `%s` directory", path)
  cli::cli_alert_success(msg)
}

#' Shiny Config
#' 
#' Creates or update `webpack.config.js` file for shiny extension.
#' 
#' @param name Name of extension.
#' @param dir_in Directory where to find config file, from `inst`, e.g.: `output/javascript`.
#' @param dir_out Output directory of modules related to that scaffold, e.g.: `outputs` or `widgets`.
#' This is used to define the entry path in the config file.
#' 
#' @noRd 
#' @keywords internal
config_io <- function(name, dir_in, dir_out){
  
  if(!fs::file_exists("webpack.config.js"))
    config_create(name, dir_in)
  else
    config_update(name, dir_out)
}

#' @noRd 
#' @keywords internal
config_create <- function(name, dir_in){
  dir_path <- sprintf("%s/webpack.config.js", dir_in)
  config_path <- pkg_file(dir_path)
  config <- readLines(config_path)
  config <- gsub("#name#", name, config)
  writeLines(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

#' @noRd 
#' @keywords internal
config_update <- function(name, dir_out){
  config <- readLines("webpack.config.js")
  entry_point <- sprintf("\n    '%s': './srcjs/%s/%s.js',", name, dir_out, name)
  entry <- config[grepl("entry", config)]
  config[grepl("entry", config)] <- sprintf("%s %s", entry, entry_point)
  writeLines(config, "webpack.config.js")

  cli::cli_alert_success("Added new entry point to webpack config file")
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
#' Opens relevant files in browser.
#' 
#' @param edit Whether to open the files.
#' 
#' @noRd 
#' @keywords internal
edit_files <- function(edit = FALSE, ...){
  if(!edit) return()

  lapply(c(...), fs::file_show)
}