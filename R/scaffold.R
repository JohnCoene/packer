#' Create Package
#' 
#' Create a package with 
#' 
#' @param name Name of widget, also passed to [htmlwidgets::scaffoldWidget()].
#' 
#' @export
scaffold_widget <- function(name){
  # checks
  stopifno_npm()

  # build original scaffold
  htmlwidgets::scaffoldWidget(name, bowerPkg = NULL, edit = FALSE)

  # create base npm webpack files
  fs::dir_create(SRC)

  # init npm
  npm_init()

  # install dev webpack + cli
  webpack_install()

  # create config file
  webpack_create_config(name)

  # copy original file
  copy_js_files(name)

  # edit package.json
  npm_add_scripts()

  usethis::use_build_ignore(SRC)
  usethis::use_build_ignore("node_modules")
  usethis::use_build_ignore("package.json")
  usethis::use_build_ignore("package-lock.json")
  usethis::use_git_ignore("node_modules")
  usethis::use_build_ignore(WEBPACK_CONFIG)
}