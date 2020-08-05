#' Render
#' 
#' Render document.
#' 
#' @param ... Additional arguments forwarded to [rmarkdown::render()].
#' 
#' @export
render_#name# <- function(...){
  file <- system.file("#name#.Rmd", package = "#pkgname#")
  rmarkdown::render(file, ...)
}
