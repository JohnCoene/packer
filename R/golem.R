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
  assert_that(!has_scaffold(), msg = "Only a single golem scaffold is allowed")

  open_msg("golem")

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # set up dir for golem
  golem_files()

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./inst/app/www", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

  # edit
  golem_edit(edit)

  # ignore files and directories
  ignore_files()

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}