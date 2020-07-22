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

ignore_files <- function(){
  usethis::use_build_ignore(SRC)
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_build_ignore(WEBPACK_CONFIG)
  usethis::use_git_ignore("node_modules")
}