.onLoad <- function(libname, pkgname){
  path <- system.file("packer", package = "#name#")
  shiny::addResourcePath('#name#-assets', path)
}
