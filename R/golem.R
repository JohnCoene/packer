#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' @param react Whether to include react, internally runs [apply_react()] and adapts the `srcjs/index.js` template for React.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_golem <- function(react = FALSE, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_golem())
  assert_that(!has_scaffold(), msg = "Only a single golem scaffold is allowed")

  open_msg("golem")

  # init npm
  npm_init()

  # install dependencies
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

  # ignore files and directories
  ignore_files()

  if(react) apply_react()

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}