#' Build & Develop
#' 
#' Build and develop the widget.
#' 
#' @inheritParams scaffold_widget
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
build_widget <- function(mode = c("production", "development", "none"), verbose = interactive()){
  stopif_no_npm_init()
  
  mode <- match.arg(mode)
  args <- sprintf("run %s", mode)
  npm_run(args, verbose)
}

#' @rdname build
#' @export 
watch_widget <- function(){
  stopif_no_npm_init()
  npm_run("run watch")
}
