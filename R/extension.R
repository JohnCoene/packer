#' Shiny Extension
#' 
#' Creates the basic structure for a shiny extension.
#' 
#' @param name Name of extension used to define file names and functions.
#' @inheritParams scaffold_widget
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @examples 
#' if(interactive()){
#' # current directory
#' wd <- getwd()
#' 
#' # create a mock up ambiorix project
#' tmp <- tmp_package()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold ambiorix
#' scaffold_extension()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_extension <- function(name, edit = interactive()){
  # checks
  assert_that(has_engine())
  assert_that(is_package())
  assert_that(not_missing(name))
  assert_that(is_name_valid(name))

  path <- sprintf("srcjs/exts/%s.js", name)
  assert_that(!fs::file_exists(path), msg = "Extension already exists")

  open_msg("shiny extension", name)

  # init npm
  engine_init()

  # create base npm webpack files
  create_directory("srcjs/exts")

  # creating inst packge for assets
  create_directory("inst/packer", recurse = TRUE)

  # install dependencies
  core_deps_install()

  # edit package.json
  engine_add_scripts()

  # create config file
  configure(
    name = name, 
    entry_dir = "exts/", 
    output_dir = "./inst/packer", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

  # create srcjs and files
  template_js_module(name, "exts")
  creup_index(name, "exts")

  # creating R files
  ext_zzz_file(name)
  template_r_function(name, "extension/R/extension.R")

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