#' Apply Framework7
#' 
#' Apply Framework7 to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, or updates, or replaces the `srcjs/index.js` file.
#' 
#' @details After running this function and bundling the JavaScript remember to place
#' `div(id = "app"), tags$script(src = "www/index.js")` at the bottom of your shiny UI.
#' 
#' @export 
apply_framework7 <- function(){
  assert_that(has_no_babel())
  assert_that(!fs::file_exists("srcjs/index.js"), msg = "`srcjs/index.js` already exists, delete or rename it")
  
  # loader
  # Framework7 loader + babel ...
  cli::cli_h2("Framework7 loader, plugin & dependency")
  use_loader_babel()
  engine_install("@babel/core", "@babel/preset-env", scope = "dev")
  engine_install("framework7", scope = "prod")
  use_loader_framework7()
  use_loader_css()
  
  cli::cli_h2("Babel config file")
  babel_config("templates/framework7/_babelrc")
  
  # template
  cli::cli_h2("Template files")
  index <- pkg_file("templates/framework7/framework7.js")
  fs::file_copy(index, "srcjs/index.js")
  fs::dir_copy(pkg_file("templates/framework7/components"), "srcjs/components")
  cli::cli_alert_success("Added template elements")
  
  # only print if project is golem app
  # otherwise Rmarkdown = no need
  if(is_golem()){
    ui_code <- framework7_ui_code_golem()
    cli::cli_alert_warning("Replace/edit your app_ui.R:")
    cli::cli_code(ui_code[["ui"]])
    cli::cli_alert_warning("Replace/edit golem_add_external_resources:")
    cli::cli_code(ui_code[["resources"]])
    cli::cli_alert_warning("Replace/edit your app_server.R:")
    cli::cli_code(ui_code[["server"]])
  }
  
  # not sure this will work
  #if(is_ambiorix()){
  #  cli::cli_alert_warning("Remember the following")
  #  cli::cli_ol()
  #  cli::cli_li("Import framework7")
  #  vue_ui_code_ambiorix()
  #  cli::cli_li("Source the bundle in the template")
  #  cli::cli_code('<script src="static/index.js"></script>')
  #  cli::cli_li("Create app root in the template")
  #  cli::cli_code('<div id="app"></div>')
  #}
}

#' Dependencies for Framework7 in Golem
#' 
#' Includes dependencies in a shiny application.
#' 
#' @noRd
#' @keywords internal
framework7_ui_code_golem <- function(){
  path <- system.file("templates/framework7", package = "packer")
  ui <- format_function_code(file.path(path, "app_ui.R"))
  resources <- format_function_code(
    file.path(path, "golem_add_external_resources.R")
  )
  server <- format_function_code(file.path(path, "app_server.R"))
  
  list(ui = ui, resources = resources, server = server)
}

#' Dependencies for Framework7 in Ambiorix
#' 
#' Includes dependencies in a shiny application.
#' 
#' @noRd
#' @keywords internal
framework7_ui_code_ambiorix <- function(){
  
  cli::cli_code("import Framework7 from 'framework7'")
  
  invisible()
  
}
