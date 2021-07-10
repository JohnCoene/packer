#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' @param react Whether to include React, internally runs [apply_react()] 
#' and adapts the `srcjs/index.js` template for React.
#' @param vue Whether to include Vue, internally runs [apply_vue()] and 
#' adapts the `srcjs/index.js` template for Vue.
#' @param use_cdn Whether to use the CDN for react or vue dependencies, 
#' this is passed to [apply_react()] or [apply_vue()] if `react` or 
#' `vue` arguments are set to `TRUE` and ignored otherwise.
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
#' tmp <- tmp_golem()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold ambiorix
#' scaffold_golem()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_golem <- function(react = FALSE, vue = FALSE, use_cdn = TRUE, edit = interactive()){
  # checks
  assert_that(has_engine())
  assert_that(is_golem())
  assert_that(!has_scaffold(), msg = "Only a single golem scaffold is allowed")
  assert_that(!all(react, vue), msg = "Setup with either react or vue, not both")

  open_msg("golem")

  # init npm
  engine_init()

  # install dependencies
  webpack_install()

  # edit package.json
  engine_add_scripts()

  # set up dir for golem
  # only create dir if vue or react
  golem_files(react, vue)

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./inst/app/www", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

  # ignore files and directories
  ignore_files()

  if(react) apply_react(use_cdn)
  if(vue) apply_vue(use_cdn)

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}