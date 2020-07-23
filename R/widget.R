#' Scaffold Widget
#' 
#' Creates basic structure for a widget.
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' @param edit Automatically open pertinent files.
#' @param ts Set to `TRUE` to use typescript.
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
scaffold_widget <- function(name, ts = FALSE, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name))

  cli::cli_h1("Scaffolding widget")

  # build original scaffold
  scaffold_bare_widget(name)

  # create srcjs
  fs::dir_create(SRC)
  cli::cli_alert_success("Created `srcjs` directory")

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # install typescript
  if(ts) typescript_install()

  # create config file
  widget_config(name, ts)

  # copy original file
  widget_files(name, ts)

  # edit package.json
  npm_add_scripts()

  # ignore files and directories
  ignore_files(ts)

  # open files
  widget_edit(name, edit, ts) 

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `bundle` to bundle the JavaScript")

  invisible(TRUE)
}
