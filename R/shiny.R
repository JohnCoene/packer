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
  cli::cli_alert_success("Initialiasing npm")
  npm_init()

  # create base npm webpack files
  cli::cli_alert_success("Creating `srcjs` directory")
  fs::dir_create(SRC)

  # creating inst packge for assets
  cli::cli_alert_success("Creating `inst/packer` directory")
  fs::dir_create("inst/packer", recurse = TRUE)

  # install dev webpack + cli
  cli::cli_alert_success("Installing webpack")
  webpack_install()

  # edit package.json
  cli::cli_alert_success("Adding npm scripts")
  npm_add_scripts()

  # create config file
  cli::cli_alert_success("Creating webpack config file")
  shiny_config()

  # create srcjs and files
  cli::cli_alert_success("Creating `srcjs`")
  shiny_js_files()

  # creating R files
  cli::cli_alert_success("Creating R files")
  shiny_r_files()

  # use shiny
  usethis::use_package("shiny")

  # ignore files and directories
  cli::cli_alert_success("Ignoring files")
  ignore_files()

  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `build_packer` to bundle the JavaScript")
}