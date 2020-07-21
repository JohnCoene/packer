#' Golem
#' 
#' @export
scaffold_golem <- function(verbose){
  stopif_no_golem()

  cli::cli_h1("Scaffolding for golem")

  # create base npm webpack files
  cli::cli_alert_success("Creating `srcjs` directory")
  fs::dir_create(SRC)

  # init npm
  cli::cli_alert_success("Initialiasing npm")
  npm_init(verbose)

  # install dev webpack + cli
  cli::cli_alert_success("Installing dependencies")
  webpack_install(verbose)

  # create config file
  cli::cli_alert_success("Creating webpack config file")
  webpack_create_config()

  # edit package.json
  cli::cli_alert_success("Adding npm scripts")
  npm_add_scripts()

  # copy golem js

}