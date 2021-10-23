# is npm installed and can it be found?
has_engine <- function(){
  length(engine_find()) > 0
}

assertthat::on_failure(has_engine) <- function(call, env){
  stop(
    sprintf("Cannot find engine `%s`, are you sure it is installed?", engine_get()), 
    call. = FALSE
  )
}

# is npm installed and can it be found?
is_yarn <- function(){
  engine_get() == "yarn"
}

assertthat::on_failure(is_yarn) <- function(call, env){
  stop(
    "yarn is not your current engine, see `engine_set()`.", 
    call. = FALSE
  )
}

is_npm <- function(){
  engine_get() == "npm"
}

assertthat::on_failure(is_npm) <- function(call, env){
  stop(
    "npm is not your current engine, see `engine_set()`.",
    call. = FALSE
  )
}

# check that argument is not missing
not_missing <- function(x){
  !missing(x)
}

assertthat::on_failure(not_missing) <- function(call, env){
  sprintf("Missing `%s`", deparse(call$x))
}

# check that it is a package
is_package <- function(){
  desc <- fs::file_exists("DESCRIPTION")
  ns <- fs::file_exists("NAMESPACE")

  all(desc, ns)
}

assertthat::on_failure(is_package) <- function(call, env){
  stop("This function must be called from within an R package.")
}

# check that scaffold is present
has_scaffold <- function(){
  package_json <- fs::file_exists("package.json")
  src_dir <- fs::dir_exists("srcjs")
  config <- fs::file_exists("webpack.common.js")

  all(package_json, src_dir, config)
}

assertthat::on_failure(has_scaffold) <- function(call, env){
  stop("No scaffold found, see the `scaffold_*` family of functions", call. = FALSE)
}

# check that it is a golem package
is_golem <- function(){
  fs::file_exists("inst/golem-config.yml")
}

assertthat::on_failure(is_golem) <- function(call, env){
  stop("Not a golem app, see `golem::create_golem`", call. = FALSE)
}

is_project <- function(){
  path <- tryCatch(
    rprojroot::find_root(proj_crit()),
    error = function(e) NULL
  )

  !is.null(path)
}


assertthat::on_failure(is_project) <- function(call, env){
  stop("Not a valid R project", call. = FALSE)
}

#' Check if a package is installed
#' 
#' @param pkg Package name.
#' 
#' @noRd
#' @keywords internal
is_installed <- function(pkg){
  if(missing(pkg))
    stop("Missing `pkg`")

  requireNamespace(pkg, quietly = TRUE)
}

assertthat::on_failure(is_installed) <- function(call, env){
  msg <- sprintf(
    "{%s} is not installed",
    deparse(call$pkg)
  )
  stop(msg, call. = FALSE)
}

# file does not exist
not_exists <- function(path){
  !fs::file_exists(path)
}

assertthat::on_failure(not_exists) <- function(call, env){
  msg <- sprintf("`%s` already exists", deparse(call$path))
  stop(msg, call. = FALSE)
}

# check that scaffold name is valid
is_name_valid <- function(nm){
  !grepl("[[:space:]]", nm)
}

assertthat::on_failure(is_name_valid) <- function(call, env){
  sprintf("'%s' is not a valid name, includes space", deparse(call$nm))
}

# check .babelrc
has_no_babel <- function(){
  !file.exists(".babelrc")
}

assertthat::on_failure(has_no_babel) <- function(call, env){
  "Already setup"
}

# https://github.com/r-lib/usethis/blob/79ed2e96ea9ccb14251178f037afccd991405383/R/proj.R
# use same project definition as usethis or use_build_ignore will fail
proj_crit <- function() {
  rprojroot::has_file(".here") |
    rprojroot::is_rstudio_project |
    rprojroot::is_r_package |
    rprojroot::is_git_root |
    rprojroot::is_remake_project |
    rprojroot::is_projectile_project
}

# check that it is an ambiorix app
is_ambiorix <- function(){
  dev <- fs::dir_exists("templates")
  app <- fs::file_exists("app.R")

  all(dev, app)
}

assertthat::on_failure(is_ambiorix) <- function(call, env){
  stop("Not an ambiorix app, see `ambiorix.generator` package", call. = FALSE)
}

# check that it is a leprechaun package
is_leprechaun <- function(){
  fs::file_exists(".leprechaun")
}

assertthat::on_failure(is_leprechaun) <- function(call, env){
  stop("Not a leprechaun app, see `leprechaun::scaffold_leprechaun`", call. = FALSE)
}