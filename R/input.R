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

  open_msg("shiny input", name)

  # init npm
  npm_init()

  # create base npm webpack files
  create_directory("srcjs")

  # creating inst packge for assets
  create_directory("inst/packer", recurse = TRUE)

  # install dev webpack + cli
  webpack_install()

  # create config file
  configure(
    name = name, 
    entry_dir = "inputs/", 
    output_dir = "./inst/packer", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

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
  edit_files(edit, sprintf("srcjs/inputs/%s.js", name), sprintf("R/%s.R", name))

  # wrap up
  end_msg()

  invisible(TRUE)
}
