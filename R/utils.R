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
  path <- system.file("index.js", package = "packer")
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
