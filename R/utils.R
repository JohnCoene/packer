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

# install webpack as dev dependency
typescript_install <- function(){
  npm_install("typescript", "ts-loader", scope = "dev")
}
