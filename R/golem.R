#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_golem <- function(edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_golem())

  cli::cli_h1("Scaffolding for golem")

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # set up dir for golem
  golem_files()

  # create config file
  golem_config()  

  # edit
  golem_edit(edit)

  # ignore files and directories
  ignore_files()

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build` to bundle the JavaScript")
  
  invisible(TRUE)
}