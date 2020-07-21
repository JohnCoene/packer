#' Create Package
#' 
#' Create a package with 
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' @param edit Automatically open the widget's JavaScript source files after 
#' creating the scaffold.
#' @param verbose Whether to print every output (e.g.: npm console output),
#' if `FALSE` only print minimalistic messages.
#' 
#' @examples \dontrun{scaffold_widget()}
#' 
#' @return \code{TRUE} (invisibly) if successfully run.
#' 
#' @export
scaffold_widget <- function(name, edit = interactive(), verbose = FALSE){
  # checks
  stopif_no_npm()
  stopif_no_package()
  stopif_no_name(name)

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
  cli::cli_alert_success("Installing dependencies")
  webpack_install(verbose)

  # create config file
  cli::cli_alert_success("Creating webpack config file")
  webpack_create_config(name)

  # copy original file
  cli::cli_alert_success("Moving bare widget to `srcjs`")
  copy_js_files(name)

  # edit package.json
  cli::cli_alert_success("Adding npm scripts")
  npm_add_scripts()

  # ignore files and directories
  cli::cli_alert_success("Ignoring files")
  usethis::use_build_ignore(SRC)
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_git_ignore("node_modules")
  usethis::use_build_ignore(WEBPACK_CONFIG)

  # open files
  edit_files(edit, name) 

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build_widget` to bundle the JavaScript")

  invisible(TRUE)
}