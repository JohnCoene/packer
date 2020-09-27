#' Golem JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' 
#' @inheritParams scaffol_golem
#' 
#' @noRd 
#' @keywords internal
ambiorix_files <- function(vue = FALSE){
  base <- pkg_file("ambiorix/javascript")

  if(vue)
    fs::dir_create("srcjs")
  else 
    fs::dir_copy(base, "srcjs")

  cli::cli_alert_success("Created {.file srcjs} directory")
}
