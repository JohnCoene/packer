#' Bare JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' 
#' @noRd 
#' @keywords internal
bare_files <- function(){
  base <- pkg_file("bare")
  fs::dir_copy(base, "srcjs")
  cli::cli_alert_success("Created {.file srcjs} directory")
}
