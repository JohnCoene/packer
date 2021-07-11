#' bundle & Watch
#' 
#' Bundle and watch the JavaScript.
#' 
#' @param mode The configuration mode tells webpack to use 
#' its built-in optimisations accordingly.
#' 
#' @section Functions:
#' 
#' * [bundle()] - bundle the project.
#' * [bundle_prod()] - bundle the project optimising production, equivalent to `bundle("production")` and `npm run production`.
#' * [bundle_dev()] - bundle the project including debugging developer tools, equivalent to `bundle("development")` and `npm run development`.
#' * [watch()] - watches for changes in the `srcjs` and rebuilds if necessary, equivalent to `npm run watch`.
#' 
#' @name bundle
#' @export 
bundle <- function(mode = c("production", "development", "none")){
  bundle_(mode)
}

#' @rdname bundle
#' @export 
bundle_prod <- function(){
  bundle_("production")
}

#' @rdname bundle
#' @export 
bundle_dev <- function(){
  bundle_("development")
}

#' @rdname bundle
#' @export 
watch <- function(){
  assert_that(has_scaffold())
  cli::cli_alert_warning("Watching for changes")
  system2("npm", c("run", "watch"))
}

bundle_ <- function(mode = c("production", "development", "none")){
  assert_that(has_scaffold())
  
  cli::cli_process_start("Bundling files", "Bundled", "Failed to bundle files")
  
  mode <- match.arg(mode)
  args <- c("run", mode)

  results <- engine_run(args)

  if(length(results$warnings) > 0){
    cli::cli_process_failed()
  } else {
    cli::cli_process_done()
  }

  invisible(results)
}