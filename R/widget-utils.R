#' Copy Original Widget Scaffold
#' 
#' Copy original scaffold into srcjs directory for webpack use.
#' 
#' @inheritParams scaffold_widget
#' 
#' @noRd 
#' @keywords internal
widget_files <- function(name, ts = FALSE){

  if(!ts)
    widget_js_files(name)
  else
    widget_ts_files(name)

}

# use javascript files
widget_js_files <- function(name){
  # index.js
  # source template
  path <- pkg_file("widget/javascript/index.js")
  template <- readLines(path)
  template <- gsub("#name#", name, template)

  # save template
  src_path <- sprintf("%s/index.js", SRC)
  writeLines(template, src_path)

  # remove existing file to avoid confusion
  existing_js <- sprintf("inst/htmlwidgets/%s.js", name)
  fs::file_delete(existing_js)

  # modules
  modules <- pkg_file("widget/javascript/modules")
  modules_path <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules, modules_path)

  cli::cli_alert_success("Moved bare widget to `srcjs`")
}

# use typescript files
widget_ts_files <- function(name){
  # index.js
  # source template
  path <- pkg_file("widget/typescript/index.ts")
  template <- readLines(path)
  template <- gsub("#name#", name, template)

  # save template
  src_path <- sprintf("%s/index.ts", SRC)
  writeLines(template, src_path)

  # remove existing file to avoid confusion
  existing_js <- sprintf("inst/htmlwidgets/%s.js", name)
  fs::file_delete(existing_js)

  # modules
  modules <- pkg_file("widget/typescript/modules")
  modules_path <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules, modules_path)

  # convert htmlwidgets to typescript
  htmlwidgets_as_module() 

  cli::cli_alert_success("Converted bare widget to to typescript")
}

htmlwidgets_as_module <- function(){
  path_in <- system.file("www/htmlwidgets.js", package = "htmlwidgets") 
  module <- readLines(path_in)

  # remove docuemnt ready function
  L <- length(module) - 2
  module <- module[2:L]

  # add declaration and export
  module <- c(module, "var HTMLWidgets = window.HTMLWidgets;")
  module <- c(module, "export { HTMLWidgets };")

  # remove first tab
  module <- gsub("^  ", "", module) 

  # save
  path_out <- sprintf("%s/modules/htmlwidgets.js", SRC)

  writeLines(module, path_out)
}

# open file in editor
widget_edit <- function(name, edit = FALSE, ts = FALSE){
  if(!edit) return()

  # r file
  r_file <- sprintf("R/%s.R", name)
  fs::file_show(r_file)

  # js file
  ext <- ifelse(ts, "ts", "js")
  js_file <- sprintf("%s/index.%s", SRC, ext)
  fs::file_show(js_file)
}

# run bare scaffol
scaffold_bare_widget <- function(name){
  cli::cli_process_start("Scaffolding bare widget", "Bare widget setup", "Failed to scaffold bare widget")
  tryCatch(widget_scaffold(name), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
}

# wrapper to suppress messages
widget_scaffold <- function(name){
  suppressMessages(
    htmlwidgets::scaffoldWidget(name, bowerPkg = NULL, edit = FALSE)
  )
}

# create webpack config
widget_config <- function(name = "index.js", ts = FALSE){

  # get & read template
  dir <- ifelse(ts, "typescript", "javascript")
  path <- sprintf("widget/%s/webpack.config.js", dir)
  template_path <- pkg_file(path)
  template <- readLines(template_path)

  # replace
  file_name <- sprintf("%s.js", name)
  template <- gsub("#name#", file_name, template)
  writeLines(template, WEBPACK_CONFIG)
  cli::cli_alert_success("Created webpack config file")

  if(ts)
    widget_config_typescript()
}

widget_config_typescript <- function(){
  path_in <- pkg_file("widget/typescript/tsconfig.json")
  fs::file_copy(path_in, "tsconfig.json")
  cli::cli_alert_success("Created typescript config file")
}
