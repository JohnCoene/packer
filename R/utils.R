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
  usethis::use_build_ignore("webpack.dev.js")
  usethis::use_build_ignore("webpack.prod.js")
  usethis::use_build_ignore("webpack.common.js")
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
  npm_install("webpack", "webpack-cli", "webpack-merge", scope = "dev")
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
    cli::cli_alert_warning("`.babelrc` file already exists, add the following")
    print_babel_config(path)
    return()
  }

  path <- pkg_file(path)
  fs::file_copy(path, ".babelrc")
  cli::cli_alert_success("Created `.babelrc`")
  usethis::use_build_ignore(".babelrc")
}

#' @noRd
#' @keywords internal
print_babel_config <- function(path){
  path <- pkg_file(path)
  content <- readLines(path)
  cli::cli_code(content)
}