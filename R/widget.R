#' Scaffold Widget
#' 
#' Creates basic structure for a widget.
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' @param edit Automatically open the widget's JavaScript source files after 
#' creating the scaffold.
#' @param verbose Whether to print every output (e.g.: npm console output),
#' if `FALSE` only print minimalistic messages.
#' 
#' @details Internally runs [htmlwidgets::scaffoldWidget()].
#' 
#' @examples \dontrun{scaffold_widget()}
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @importFrom assertthat assert_that
#' 
#' @export
scaffold_widget <- function(name, edit = interactive(), verbose = FALSE){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name))

  cli::cli_h1("Scaffolding widget")

  # build original scaffold
  cli::cli_alert_success("Scaffolding bare widget")
  scaffold_bare_widget(name)

  # create base npm webpack files
  cli::cli_alert_success("Creating `srcjs` directory")
  fs::dir_create(SRC)

  # init npm
  cli::cli_alert_success("Initialiasing npm")
  npm_init(verbose)

  # install dev webpack + cli
  cli::cli_alert_success("Installing webpack")
  webpack_install(verbose)

  # create config file
  cli::cli_alert_success("Creating webpack config file")
  widget_config(name)

  # copy original file
  cli::cli_alert_success("Moving bare widget to `srcjs`")
  widget_files(name)

  # edit package.json
  cli::cli_alert_success("Adding npm scripts")
  npm_add_scripts()

  # ignore files and directories
  cli::cli_alert_success("Ignoring files")
  ignore_files()

  # open files
  widget_edit(name, edit) 

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build_packer` to bundle the JavaScript")

  invisible(TRUE)
}