#' Leprechaun JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' 
#' @inheritParams scaffold_leprechaun
#' 
#' @noRd 
#' @keywords internal
leprechaun_files <- function(react = FALSE, vue = FALSE){
  base <- pkg_file("leprechaun")

  if(any(react, vue))
    fs::dir_create("srcjs")
  else 
    fs::dir_copy(base, "srcjs")

  cli::cli_alert_success("Created {.file srcjs} directory")
}
