#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' @param react Whether to include React, internally runs [apply_react()] and adapts the `srcjs/index.js` template for React.
#' @param vue Whether to include Vue, internally runs [apply_vue()] and adapts the `srcjs/index.js` template for Vue.
#' 
#' @details Only one of `react` or `vue` can be set to `TRUE`.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_golem <- function(react = FALSE, vue = FALSE, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_golem())
  assert_that(!has_scaffold(), msg = "Only a single golem scaffold is allowed")
  assert_that(!all(react, vue), msg = "Setup with either react or vue, not both")

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
  if(vue){
    fs::file_delete("srcjs/index.js")
    apply_vue()
  }

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}