#' bundle & Watch
#' 
#' Bundle and watch the JavaScript.
#' 
#' @param mode The configuration mode tells webpack to use 
#' its built-in optimisations accordingly.
#' 
#' @section Functions:
#' 
#' * [bundle()] - bundle the JavaScript using webpack to produce the bundle in the appropriate directory.
#' * [watch()] - watches for changes in the `srcjs` and rebuilds if necessary.
#' 
#' @examples \dontrun{watch_widget()}
#' 
#' @name build
#' @export 
bundle <- function(mode = c("production", "development", "none")){
  assert_that(has_scaffold())

  cli::cli_process_start("Bundling files", "Bundled!", "Failed to bundle files")
  
  mode <- match.arg(mode)
  args <- c("run", mode)

  results <- npm_run(args)

  if(length(results$warnings) > 0)
    cli::cli_process_failed()
  else
    cli::cli_process_done()

  invisible(results)
}

#' @rdname build
#' @export 
watch <- function(){
  assert_that(has_scaffold())
  cli::cli_alert_warning("Watching for changes")
  system2("npm", c("run", "watch"))
}
