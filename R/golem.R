#' Golem
#' 
#' Creates the basic structure for golem app with JavaScript.
#' 
#' @inheritParams scaffold_widget
#' @param react Whether to include React, internally runs [apply_react()] 
#' and adapts the `srcjs/index.js` template for React.
#' @param vue Whether to include Vue, internally runs [apply_vue()] and 
#' adapts the `srcjs/index.js` template for Vue.
#' @param framework7 Whether to include Framework7, internally runs [apply_framework7()] 
#' and adapts the `srcjs/index.js` template for Framework7.
#' @param use_cdn Whether to use the CDN for react, vue or Framework7 dependencies, 
#' this is passed to [apply_react()], [apply_vue()] or [apply_framework7()] if `react`, 
#' `vue` or `framework7` arguments are set to `TRUE` and ignored otherwise.
#' 
#' @details Only one of `react`, `vue` or `framework7` can be set to `TRUE`. `use_cdn` is 
#' not supported for Framework7.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @examples 
#' if(interactive()){
#' # current directory
#' wd <- getwd()
#' 
#' # create a mock up golem project
#' tmp <- tmp_golem()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold golem
#' scaffold_golem()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_golem <- function(
  react = FALSE, 
  vue = FALSE, 
  framework7 = FALSE, 
  use_cdn = TRUE, 
  edit = interactive()
){
  # checks
  assert_that(has_engine())
  assert_that(is_golem())
  assert_that(!has_scaffold(), msg = "Only a single golem scaffold is allowed")
  assert_that(
    !all(react, vue, framework7), 
    msg = "Setup with either react, vue or framework7."
  )

  open_msg("golem")

  # init npm
  engine_init()

  # install dependencies
  core_deps_install()

  # edit package.json
  engine_add_scripts()

  # set up dir for golem
  # only create dir if vue or react
  golem_files(react, vue, framework7)

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./inst/app/www", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

  # ignore files and directories
  ignore_files()

  if (react) apply_react(use_cdn)
  if (vue) apply_vue(use_cdn)
  if (framework7) apply_framework7()

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}