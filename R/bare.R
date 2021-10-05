#' Bare
#' 
#' Creates a bare scaffold for not specific use case, as
#' opposed to other scaffolds. This scaffold does not 
#' generate R code.
#' 
#' @inheritParams scaffold_widget
#' 
#' @return `TRUE` (invisibly) if successfully run.
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
#' # scaffold bare
#' scaffold_bare()
#' 
#' # clean up
#' setwd(wd)
#' tmp_delete(tmp)
#' }
#' 
#' @export
scaffold_bare <- function(edit = interactive()){
  # checks
  assert_that(has_engine())
  assert_that(is_package())
  assert_that(!has_scaffold(), msg = "Only a single bare scaffold is allowed")

  open_msg("bare")

  # init npm
  engine_init()

  # install dependencies
  core_deps_install()

  # edit package.json
  engine_add_scripts()

  # set up dir
  bare_files()

  # create config file
  configure(
    name = "index", 
    entry_dir = "", 
    output_dir = "./inst", 
    externals = list(shiny = "Shiny", jquery = "jQuery")
  )

  # ignore files and directories
  ignore_files()

  # edit
  edit_files(edit, "srcjs/index.js")

  # wrap up
  end_msg()
  
  invisible(TRUE)
}