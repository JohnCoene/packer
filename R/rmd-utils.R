#' Golem JavaScript Files
#' 
#' Creates the necessary `srcjs` directory and children JavaScript files.
#' This is a simple copy of template files: no changes required.
#' 
#' @inheritParams scaffol_golem
#' 
#' @noRd 
#' @keywords internal
rmd_files <- function(react = FALSE, vue = FALSE){

  # define template to copy
  template_dir <- "javascript"
  if(react) template_dir <- "react"
  if(vue) template_dir <- "vue"

  # get full path to srcjs
  srcjs_path <- sprintf("rmd/%s/srcjs", template_dir)
  srcjs_base <- pkg_file(srcjs_path)

  # get full path to assets
  assets_path <- sprintf("rmd/%s/assets/", template_dir)
  assets_base <- pkg_file(assets_path)

  # Rmd file
  index_path <- pkg_file("rmd/index.Rmd")

  # copy templates
  fs::dir_copy(srcjs_base, "srcjs/rmd")
  fs::dir_copy(assets_base, "assets")
  fs::file_copy(index_path, "index.Rmd")

  cli::cli_alert_success("Created {.file assets} directory")
  cli::cli_alert_success("Created {.file index.Rmd}")
  cli::cli_alert_success("Created {.file srcjs} directory")
}
