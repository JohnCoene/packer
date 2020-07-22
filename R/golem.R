#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_golem <- function(edit = interactive(), verbose = FALSE){
  # checks
  assert_that(has_npm())
  assert_that(is_golem())

  cli::cli_h1("Scaffolding for golem")

  # init npm
  cli::cli_alert_success("Initialiasing npm")
  npm_init(verbose)

  # install dev webpack + cli
  cli::cli_alert_success("Installing webpack")
  webpack_install(verbose)

  # edit package.json
  cli::cli_alert_success("Adding npm scripts")
  npm_add_scripts()

  # set up dir for golem
  cli::cli_alert_success("Creating `srcjs`")
  golem_files()

  # create config file
  cli::cli_alert_success("Creating webpack config file")
  golem_config()

  # edit
  golem_edit(edit)

  # ignore files and directories
  cli::cli_alert_success("Ignoring files")
  ignore_files()

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build_packer` to bundle the JavaScript")
  
  invisible(TRUE)
}