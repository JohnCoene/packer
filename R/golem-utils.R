#' Creates Golem
#' 
#' Creates `webpack.config.js` file for golem.
#' 
#' @noRd 
#' @keywords internal
golem_config <- function(){
  config <- pkg_file("golem/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

#' Golem JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' SRC
#' @noRd 
#' @keywords internal
golem_files <- function(){
  base <- pkg_file("golem/javascript/srcjs")
  fs::dir_copy(base, "srcjs")
  cli::cli_alert_success("Created `srcjs` directory")
}

#' Edit Files
#' 
#' Opens pertinent files in browser.
#' 
#' @inheritParams scaffold_golem
#' 
#' @noRd 
#' @keywords internal
golem_edit <- function(edit = FALSE){
  fs::file_show("srcjs/index.js")
}