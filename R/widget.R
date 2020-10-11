#' Scaffold Widget
#' 
#' Creates basic structure for a widget.
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' @param edit Automatically open pertinent files.
#' 
#' @details Internally runs [htmlwidgets::scaffoldWidget()] do not run it prior to this function.
#' 
#' @return `TRUE` (invisibly) if successfully run.
#' 
#' @importFrom assertthat assert_that
#' 
#' @examples 
#' if(interactive()){
#' # current directory
#' wd <- getwd()
#' 
#' # create a mock up ambiorix project
#' tmp <- tmp_package()
#' 
#' # move to package
#' setwd(tmp)
#' 
#' # scaffold ambiorix
#' scaffold_widget()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_widget <- function(name, edit = interactive()){
  # checks
  assert_that(has_npm())
  assert_that(is_package())
  assert_that(not_missing(name))
  assert_that(is_name_valid(name))

  open_msg("widget", name)

  # build original scaffold
  scaffold_bare_widget(name)

  # create srcjs
  create_directory("srcjs")

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # create config file
  configure(
    name = name, 
    entry_dir = "widgets/", 
    output_dir = "./inst/htmlwidgets", 
    externals = list(widgets = "HTMLWidgets", "Shiny", "jQuery")
  )

  # copy original file
  widget_files(name)

  # edit package.json
  npm_add_scripts()

  # ignore files and directories
  ignore_files()

  # open files
  widget_edit(name, edit) 

  # use htmlwidgets
  use_pkgs("htmlwidgets")

  # edit
  edit_files(edit, sprintf("srcjs/widgets/%s.js", name), sprintf("R/%s.R", name))

  # wrap up
  end_msg()

  invisible(TRUE)
}
