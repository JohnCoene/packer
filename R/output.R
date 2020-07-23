#' Scaffold Shiny Output
#' 
#' Sets basic structure for a shiny input.
#' 
#' @param name Name of output, will define internal name binding and CSS class.
#' 
#' @examples 
#' \dontrun{scaffold_output("display")}
#' 
#' @export 
scaffold_shiny_output <- function(name){
  # checks
  assert_that(not_missing(name))
  assert_that(has_npm())
  assert_that(is_package())

  cli::cli_h1("Scaffolding shiny output")
  cat("\n")

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
  output_config()

  # create srcjs and files
  output_js_files(name)

  # creating R files
  output_r_files(name)

  # ignore files and directories
  ignore_files()

  # use shiny
  cli::cli_h2("Adding Packages")
  usethis::use_package("shiny")
  usethis::use_package("htmltools")

  cat("\n")
  cli::cli_h2("Wrapping up")
  cli::cli_alert_success("Scaffold built")
  cli::cli_alert_info("See `bundle` to bundle the JavaScript")

  invisible(TRUE)
}