#' Scaffold a Custom Input
#' 
#' Sets basic structure for a shiny input.
#' 
#' @param name Name of input, will define internal name binding and CSS class.
#' @inheritParams scaffold_widget
#' 
#' @examples 
#' \dontrun{scaffold_input("increment")}
#' 
#' @export
scaffold_input <- function(name, edit = interactive()){
  # checks
  assert_that(not_missing(name))
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(is_name_valid(name))

  # check that input does not already exist
  file_path <- sprintf("srcjs/inputs/%s.js", name)
  assert_that(not_exists(file_path))

  cli::cli_h1("Scaffolding shiny input")
  cat("\n")

  # init npm
  npm_init()

  # create base npm webpack files
  create_directory("srcjs")

  # creating inst packge for assets
  create_directory("inst/packer", recurse = TRUE)

  # install dev webpack + cli
  webpack_install()

  # create config file
  config_io(name, "input/javascript", "inputs")

  # create srcjs and files
  input_js_files(name)

  # creating R files
  input_r_files(name)

  # edit package.json
  npm_add_scripts()

  # ignore files and directories
  ignore_files()

  # use shiny
  use_pkgs("shiny", "htmltools")

  # edit
  edit_files(edit, sprintf("srcs/inputs/%.js", name), sprintf("R/%.R", name))

  # wrap up
  end_msg()

  invisible(TRUE)
}
