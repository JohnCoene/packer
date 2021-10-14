#' Golem JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' 
#' @inheritParams scaffol_golem
#' 
#' @noRd 
#' @keywords internal
golem_files <- function(react = FALSE, vue = FALSE, framework7 = FALSE){
  base <- pkg_file("golem/javascript")

  if(any(react, vue, framework7))
    fs::dir_create("srcjs")
  else 
    fs::dir_copy(base, "srcjs")

  cli::cli_alert_success("Created {.file srcjs} directory")
}
