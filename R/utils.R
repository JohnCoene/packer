#' Copy Original Scaffold
#' 
#' Copy original scaffold into srcjs for webpack use.
#' 
#' @param name Name of widget.
#' 
#' @noRd 
#' @keywords internal
copy_js_files <- function(name){

  # index.js
  # source template
  path <- system.file("widgets/index.js", package = "packer")
  template <- readLines(path)
  template <- gsub("#name#", name, template)

  # save template
  src_path <- sprintf("%s/index.js", SRC)
  writeLines(template, src_path)

  # remove existing file to avoid confusion
  existing_js <- sprintf("inst/htmlwidgets/%s.js", name)
  fs::file_delete(existing_js)

  # modules
  modules <- system.file("modules", package = "packer")
  modules_path <- sprintf("%s/modules", SRC)
  fs::dir_copy(modules, modules_path)
}

edit_files <- function(edit, name){
  if(!edit)
    return()

  # r file
  r_file <- sprintf("R/%s.R", name)
  fs::file_show(r_file)

  # js file
  js_file <- sprintf("%s/index.js", SRC)
  fs::file_show(js_file)
}

scaffold_bare_widget <- function(name){
  suppressMessages(
    htmlwidgets::scaffoldWidget(name, bowerPkg = NULL, edit = FALSE)
  )
}