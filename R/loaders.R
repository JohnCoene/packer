#' Use Styles
#' 
#' Installs loaders, creates `srcjs/styles` directory containing a CSS file and adds module rule to the configuration.
#' 
#' @details This will let you import styles much like any other modules.
#' 
#' @export
use_css <- function(){
  assert_that(has_scaffold())

  # install loaders
  npm_install("style-loader", "css-loader")

  # create styles dir
  create_directory("srcjs/styles")

  # create file
  file_path <- "srcjs/styles/style.css"
  if(!fs::file_exists(file_path))
    fs::file_create(file_path)
  
  msg <- sprintf("Created `%s` file and directory", file_path)
  cli::cli_alert_success(msg)

  # message modifications
  loader <- list(
    test = "\\.css$",
    use = list("style-loader", "css-loader")
  )
  loader_add(loader)
  cli::cli_alert_info("Added bundling rule")
}

loader_add <- function(loader){
  json_path <- "srcjs/config/loaders.json"

  if(!fs::file_exists(json_path))
    stop("Cannot find loader config file", call. = FALSE)

  loaders <- jsonlite::read_json(json_path)
  loaders <- append(loaders, list(loader))
  save_json(loaders, json_path)
}