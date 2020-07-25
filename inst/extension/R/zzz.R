.onLoad <- function(libname, pkgname){
  path <- system.file("packer", package = "#pkgname#")
  shiny::addResourcePath('#pkgname#-assets', path)
}
