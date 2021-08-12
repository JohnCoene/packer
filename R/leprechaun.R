#' Leprechaun
#' 
#' Creates the basic structure for leprechaun app with JavaScript.
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
#' @importFrom cli cli_alert_info
#' 
#' @details Only one of `react` or `vue` can be set to `TRUE`.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_leprechaun <- function(react = FALSE, vue = FALSE, use_cdn = TRUE, edit = interactive()){
  # checks
  assert_that(has_engine())
  assert_that(is_leprechaun())
  assert_that(!has_scaffold(), msg = "Only a single leprechaun scaffold is allowed")
  assert_that(!all(react, vue), msg = "Setup with either react or vue, not both")

  open_msg("leprechaun")

  # init npm
  engine_init()

  # install dependencies
  core_deps_install()

  # edit package.json
  engine_add_scripts()

  # set up dir for leprechaun
  # only create dir if vue or react
  leprechaun_files(react, vue)

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./inst/assets", 
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
  cli_alert_info("Run {.code leprechaun::use_packer()}")
  
  invisible(TRUE)
}