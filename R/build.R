#' Build & Watch
#' 
#' Build and watch the JavaScript.
#' 
#' @param mode The configuration mode tells webpack to use 
#' its built-in optimisations accordingly.
#' 
#' @section Functions:
#' 
#' * [build_packer()] - builds the JavaScript using webpack to produce the bundle in the appropriate directory.
#' * [watch_packer()] - watches for changes in the `srcjs` and rebuilds if necessary.
#' 
#' @examples \dontrun{watch_widget()}
#' 
#' @name build
#' @export 
build_packer <- function(mode = c("production", "development", "none")){
  build(mode)
}

#' @rdname build
#' @export 
watch_packer <- function(){
  watch()
}
