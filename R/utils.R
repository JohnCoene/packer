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
ignore_files <- function(ts = FALSE){
  cat("\n")
  cli::cli_h2("Adding files to .gitignore and .Rbuildignore")
  usethis::use_build_ignore(SRC)
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_build_ignore(WEBPACK_CONFIG)
  usethis::use_git_ignore("node_modules")

  if(ts)
    usethis::use_build_ignore("tsconfig.json")

  cat("\n")
}

# prints error and warnings from system2
system_we <- function(results){

  if(inherits(results, "error"))
    cli::cli_alert_danger(results$message, call. = FALSE)
  
  if(inherits(results, "warning"))
    cli::cli_alert_warning(results$message)
  
}

get_pkg_name <- function(){
  desc <- readLines("DESCRIPTION")
  pkg <- desc[grepl("^Package:", desc)]
  pkg <- gsub("^Package: ", "", pkg)
  trimws(pkg)
}

# install webpack as dev dependency
webpack_install <- function(){
  cli::cli_process_start("Installing webpack", "Webpack installed", "Failed to install webpack")
  tryCatch(npm_run("install --save-dev webpack webpack-cli"), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
}

# install webpack as dev dependency
typescript_install <- function(){
  cli::cli_process_start("Installing typescript loader", "Typescript loader installed", "Failed to install typescript loader")
  tryCatch(npm_run("install --save-dev typescript ts-loader"), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
}
