#' Copy Original Widget Scaffold
#' 
#' Copy original scaffold into srcjs directory for webpack use.
#' 
#' @inheritParams scaffold_widget
#' 
#' @noRd 
#' @keywords internal
widget_files <- function(name){
  # create dirs
  create_directory("srcjs/modules")
  create_directory("srcjs/widgets")

  # index.js
  # source template
  path <- pkg_file("widget/javascript/widget.js")
  template <- readLines(path)
  template <- gsub("#name#", name, template)

  # save template
  path_out <- sprintf("srcjs/widgets/%s.js", name)
  writeLines(template, path_out)

  # remove existing file to avoid confusion
  existing_js <- sprintf("inst/htmlwidgets/%s.js", name)
  fs::file_delete(existing_js)

  if(!fs::file_exists("srcjs/modules/header.js")){
    module_file <- pkg_file("widget/javascript/module.js")
    fs::file_copy(module_file, "srcjs/modules/header.js")
  }

  # index
  if(!fs::file_exists("srcs/index.js"))
    widget_create_index(name)
  else
    widget_update_index(name)

  cli::cli_alert_success("Moved bare widget to {.file srcjs}")

}

widget_create_index <- function(name){
  index <- sprintf("import './widgets/%s.js'", name)
  writeLines(index, "srcjs/index.js")
  cli::cli_alert_success("Created {.file srcjs/index.js}")
}

widget_update_index <- function(name){
  index <- readLines("srcjs/index.js")
  import <- sprintf("import './widgets/%s.js'", name)
  index <- c(import, index)
  writeLines(index, "srcjs/index.js")
  cli::cli_alert_success("Updated {.file srcjs/index.js}")
}

# open file in editor
widget_edit <- function(name, edit = FALSE){
  if(!edit) return()

  # r file
  r_file <- sprintf("R/%s.R", name)
  fs::file_show(r_file)

  # js file
  fs::file_show("srcjs/index.js")
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
