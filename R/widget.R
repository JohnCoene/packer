#' Scaffold Widget
#' 
#' Creates basic structure for a widget.
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' @param edit Automatically open pertinent files.
#' 
#' @details Internally runs [htmlwidgets::scaffoldWidget()] do not run it prior to this function.
#' 
#' @examples \dontrun{scaffold_widget()}
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @importFrom assertthat assert_that
#' 
#' @export
scaffold_widget <- function(name, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name))

  cli::cli_h1("Scaffolding widget")

  # build original scaffold
  scaffold_bare_widget(name)

  # create srcjs
  create_directory(SRC)

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # create config file
  widget_config(name)

  # copy original file
  widget_files(name)

  # edit package.json
  npm_add_scripts()

  # ignore files and directories
  ignore_files()

  # open files
  widget_edit(name, edit) 

  # use htmlwidgets
  usethis::use_package("htmlwidgets")

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `bundle` to bundle the JavaScript")

  invisible(TRUE)
}
