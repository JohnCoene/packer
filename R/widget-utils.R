#' Copy Original Widget Scaffold
#' 
#' Copy original scaffold into srcjs directory for webpack use.
#' 
#' @param name Name of widget.
#' 
#' @noRd 
#' @keywords internal
widget_files <- function(name){

  # index.js
  # source template
  path <- pkg_file("widget/index.js")
  template <- readLines(path)
  template <- gsub("#name#", name, template)

  # save template
  src_path <- sprintf("%s/index.js", SRC)
  writeLines(template, src_path)

  # remove existing file to avoid confusion
  existing_js <- sprintf("inst/htmlwidgets/%s.js", name)
  fs::file_delete(existing_js)

  # modules
  modules <- pkg_file("widget/modules")
  modules_path <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules, modules_path)

  cli::cli_alert_success("Moved bare widget to `srcjs`")
}

# open file in editor
widget_edit <- function(name, edit = FALSE){
  if(!edit) return()

  # r file
  r_file <- sprintf("R/%s.R", name)
  fs::file_show(r_file)

  # js file
  js_file <- sprintf("%s/index.js", SRC)
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
widget_config <- function(name = "index.js"){
  template_path <- pkg_file("widget/webpack.config.js")
  template <- readLines(template_path)

  file_name <- sprintf("%s.js", name)

  template <- gsub("#FILE#", file_name, template)
  writeLines(template, WEBPACK_CONFIG)
  cli::cli_alert_success("Created webpack config file")
}
