#' Shiny Extension
#' 
#' Creates the basic structure for a shiny extension.
#' 
#' @param name Name of extension used to define file names and functions.
#' @inheritParams scaffold_widget
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @export
scaffold_extension <- function(name, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name))
  assert_that(is_name_valid(name))

  path <- sprintf("srcjs/exts/%s.js", name)
  assert_that(!fs::file_exists(path), msg = "Extension already exists")

  open_msg("shiny extension", name)

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
  config_io(name, "extension/javascript", "exts")

  # create srcjs and files
  ext_js_files(name)

  # creating R files
  ext_r_files(name)

  # ignore files and directories
  ignore_files()

  # use shiny
  use_pkgs("shiny")

  # edit
  edit_files(edit, sprintf("srcjs/exts/%s.js", name), sprintf("R/%s.R", name))

  # wrap up
  end_msg()

  invisible(TRUE)
}