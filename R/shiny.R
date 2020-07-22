#' Shiny Extension
#' 
#' Creates the basic structure for a shiny extension.
#' 
#' @export
scaffold_shiny_ext <- function(){
  # checks
  assert_that(has_npm())
  assert_that(is_package())

  cli::cli_h1("Scaffolding shiny extension")

  # init npm
  npm_init()

  # create base npm webpack files
  fs::dir_create(SRC)
  cli::cli_alert_success("Created `srcjs` directory")

  # creating inst packge for assets
  fs::dir_create("inst/packer", recurse = TRUE)
  cli::cli_alert_success("Created `inst/packer` directory")

  # install dev webpack + cli
  webpack_install()

  # edit package.json
  npm_add_scripts()

  # create config file
  shiny_config()

  # create srcjs and files
  shiny_js_files()

  # creating R files
  shiny_r_files()

  # ignore files and directories
  ignore_files()

  # use shiny
  usethis::use_package("shiny")

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build` to bundle the JavaScript")
}