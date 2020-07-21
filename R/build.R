#' Build & Develop
#' 
#' Build and develop the widget.
#' 
#' @param mode The configuration mode tells webpack to use 
#' its built-in optimizations accordingly.
#' 
#' @section Functions:
#' 
#' * [build_widget()] - builds the widget using webpack to produce the required JavaScript file in the `inst/htmlwidgets` directory.
#' * [watch_widget()] - watches for changes in the `srcjs` and rebuilds if necessary.
#' 
#' @examples \dontrun{watch_widget()}
#' 
#' @name build
#' @export 
build_widget <- function(mode = c("production", "development", "none")){
  mode <- match.arg(mode)
  args <- sprintf("run %s", mode)
  npm_run(args)
}

#' @rdname build
#' @export 
watch_widget <- function(){
  npm_run("run watch")
}
