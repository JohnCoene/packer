#' Shiny Extension
#' 
#' Creates the basic structure for a shiny extension.
#' 
#' @param name Name of extension used to define file names and functions.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_extension <- function(name){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name), msg = "Missing `name`")

  path <- sprintf("srcjs/exts/%s.js", name)
  assert_that(!fs::file_exists(path), msg = "Extension already exists")

  cli::cli_h1("Scaffolding shiny extension")

  # init npm
  npm_init()

  # create base npm webpack files
  create_directory("srcjs/exts")

  # creating inst packge for assets
  create_directory("inst/packer", recurse = TRUE)

  # install dev webpack + cli
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # create config file
  ext_config(name)

  # create srcjs and files
  ext_js_files(name)

  # creating R files
  ext_r_files(name)

  # ignore files and directories
  ignore_files()

  # use shiny
  usethis::use_package("shiny")

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `bundle` to bundle the JavaScript")

  invisible(TRUE)
}