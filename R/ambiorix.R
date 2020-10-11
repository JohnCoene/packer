#' Ambiorix
#' 
#' Creates the basic structure for an ambiorix application.
#' 
#' @inheritParams scaffold_widget
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
#' tmp <- tmp_ambiorix()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold ambiorix
#' scaffold_ambiorix()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_ambiorix <- function(vue = FALSE, use_cdn = TRUE, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_ambiorix())

  open_msg("ambiorix")

  # init npm
  npm_init()

  # install dependencies
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # set up dir for golem
  # only create dir if vue or react
  ambiorix_files(vue)

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./assets", 
    externals = list(ambiorix = "Ambiorix")
  )

  # ignore files and directories
  ignore_files()

  if(vue) apply_vue(use_cdn)

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}