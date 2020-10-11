#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' @param react Whether to include React, internally runs [apply_react()] 
#' and adapts the `srcjs/index.js` template for React.
#' @param vue Whether to include Vue, internally runs [apply_vue()] and 
#' adapts the `srcjs/index.js` template for Vue.
#' 
#' @details Only one of `react` or `vue` can be set to `TRUE`.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @examples 
#' if(interactive()){
#' # current directory
#' wd <- getwd()
#' 
#' # create a mock up ambiorix project
#' tmp <- tmp_project()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold ambiorix
#' scaffold_rmd()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_rmd <- function(react = FALSE, vue = FALSE, edit = interactive()){
  # checks
  assert_that(has_npm())
  is_project()
  assert_that(!has_scaffold(), msg = "Only a single rmd scaffold is allowed")
  assert_that(!all(react, vue), msg = "Setup with either react or vue, not both")

  open_msg("rmd")

  # init npm
  npm_init()

  # install dependencies
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # set up dir for golem
  # only create dir if vue or react
  rmd_files(react, vue)

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./assets", 
    externals = list()
  )

  # ignore files and directories
  ignore_files()

  if(react) apply_react(use_cdn = TRUE)
  if(vue) apply_vue(use_cdn = TRUE)

  # edit
  edit_files(edit, "index.Rmd")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}