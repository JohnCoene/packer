#' Build widget
#' 
#' Builds the widget with webpack.
#' 
#' @export 
build_widget <- function(){
  npm_run("run build")
  #npm_run("run start")
}