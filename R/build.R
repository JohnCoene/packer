#' Build & Watch
#' 
#' Build and watch the JavaScript.
#' 
#' @param mode The configuration mode tells webpack to use 
#' its built-in optimisations accordingly.
#' 
#' @section Functions:
#' 
#' * [build()] - builds the JavaScript using webpack to produce the bundle in the appropriate directory.
#' * [watch()] - watches for changes in the `srcjs` and rebuilds if necessary.
#' 
#' @examples \dontrun{watch_widget()}
#' 
#' @name build
#' @export 
build <- function(mode = c("production", "development", "none")){
  assert_that(has_scaffold())

  cli::cli_process_start("Building bundle", "Bundle built", "Failed to build bundle")
  
  mode <- match.arg(mode)
  args <- sprintf("run %s", mode)
  npm_run(args)

  cli::cli_process_done()
}

#' @rdname build
#' @export 
watch <- function(){
  assert_that(has_scaffold())
  cli::cli_alert_warning("Watching for changes")
  npm_run("run watch")
}
