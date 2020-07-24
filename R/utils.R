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
  usethis::use_build_ignore(SRC)
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_build_ignore(WEBPACK_CONFIG)
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
