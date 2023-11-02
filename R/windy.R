#' Windy
#'
#' Creates a scaffold for [windy](https://github.com/devOpifex/windy),
#' it's a modified version of [scaffold_bare()].
#'
#' @inheritParams scaffold_widget
#'
#' @return `TRUE` (invisibly) if successfully run.
#'
#' @examples
#' if (interactive()) {
#'   # current directory
#'   wd <- getwd()
#'
#'   # create a mock up ambiorix project
#'   tmp <- tmp_package()
#'
#'   # move to package
#'   setwd(tmp)
#'
#'   # scaffold bare
#'   scaffold_windy()
#'
#'   # clean up
#'   setwd(wd)
#'   tmp_delete(tmp)
#' }
#'
#' @export
scaffold_windy <- function(edit = NULL) {
  edit <- get_edit(edit)

  # checks
  assert_that(has_engine())
  assert_that(is_package())

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
    output_dir = "./inst/app/assets",
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
