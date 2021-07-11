#' Yarn Global
#' 
#' Installs or manage yarn _globally_.
#' 
#' @param version Version to set yarn
#' 
#' @section Functions:
#' 
#' - `engine_yarn_install`: Installs yarn globally.
#' - `engine_yarn_set`: Set yarn function.
#' 
#' @examples 
#' \dontrun{engine_yarn_install()}
#' 
#' @name yarn_global
#' @export 
engine_yarn_install <- function(){
  engine_set("npm")
  on.exit({
    engine_set("yarn")
  })

  engine_install("yarn", scope = "global") 
}

#' @rdname yarn_global
#' @export 
engine_yarn_set <- function(version = "latest"){
  engine_run(
    sprintf("set version %s", version)
  )
  usethis::use_build_ignore(".yarnrc")
}

#' Set yarn path
#' 
#' By default packer looks for the yarn installation using 
#' the `which` (or `where`) command.
#' This function lets you override that behaviour and 
#' force a specific yarn installation.
#' 
#' @param path Path to yarn installation to use.
#' 
#' @export
set_yarn <- function(path = NULL){
  engine_path(path)
}

#' Install and Uninstall yarn Packages
#' 
#' Install and uninstall yarn packages.
#' 
#' @param ... Packages to install or uninstall.
#' @param scope Scope of installation or uninstallation, see scopes.
#' 
#' @section Scopes:
#' 
#' * `prod` - Add/remove packages for project with no flag
#' * `dev` - Installs/Uninstalls dev packages for project with `--dev`
#' 
#' @examples 
#' \dontrun{yarn_add("browserify")}
#' 
#' @name yarn_install
#' @export 
yarn_add <- function(..., scope = c("dev", "prod")){
  assert_that(is_yarn())
  engine_install(..., scope = scope[1])
}

#' @name yarn_install
#' @export 
yarn_install <- function(){
  assert_that(is_yarn())
  engine_install()
}

#' @rdname yarn_install
#' @export 
yarn_remove <- function(..., scope = c("dev", "prod")){
  assert_that(is_yarn())
  engine_uninstall(..., scope = scope[1])
}

#' Yarn Output
#' 
#' Prints the output of the last command run, useful for debugging.
#' 
#' @export
yarn_console <- function(){
  assert_that(is_yarn())
  engine_console()
}

#' Yarn Command
#' 
#' Convenience function to run `yarn` commands.
#' 
#' @param ... Passed to [system2()].
#' 
#' @export 
yarn_run <- function(...){
  assert_that(is_yarn())
  engine_run(...)
}

#' Yarn Upgrade
#' 
#' Upgrade yarn dependencies.
#' 
#' @examples 
#' \dontrun{yarn_upgrade()}
#' 
#' @export
yarn_upgrade <- function(){
  assert_that(is_yarn())
  results <- engine_update()
  invisible(results)
}

#' Yarn Outdated
#' 
#' Find outdated dependencies
#' 
#' @examples 
#' \dontrun{yarn_outdated()}
#' 
#' @export
yarn_outdated <- function(){
  assert_that(is_yarn())
  engine_outdated()
}

#' Yarn version
#' 
#' Get the version of yarn.
#' 
#' @examples 
#' \dontrun{yarn_version()}
#' 
#' @return The semver as a string.
#' 
#' @export
yarn_version <- function(){
  assert_that(is_yarn())
  engine_version()
}

#' Yarn cache clean
#' 
#' Clean the cache
#' 
#' @examples 
#' \dontrun{yarn_clean()}
#' 
#' @return The semver as a string.
#' 
#' @export
yarn_clean <- function(){
  assert_that(is_yarn())
  output <- engine_run("cache", "clean")
  cli::cli_li(output$result) 
  invisible(output$result)
}