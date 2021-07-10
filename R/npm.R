#' Set npm path
#' 
#' By default packer looks for the npm installation using 
#' the `which` (or `where`) command.
#' This function lets you override that behaviour and 
#' force a specific npm installation.
#' 
#' @param path Path to npm installation to use.
#' 
#' @export
set_npm <- function(path = NULL){
  engine_path(path)
}

#' Install and Uninstall Npm Packages
#' 
#' Install and uninstall npm packages.
#' 
#' @param ... Packages to install or uninstall.
#' @param scope Scope of installation or uninstallation, see scopes.
#' 
#' @section Scopes:
#' 
#' * `prod` - Installs/Uninstalls packages for project with `--save`
#' * `dev` - Installs/Uninstalls dev packages for project with `--save-dev`
#' * `global` - Installs/Uninstalls packages globally with `-g`
#' 
#' @name npm_install
#' @export 
npm_install <- function(..., scope = c("dev", "prod", "global")){
  assert_that(is_npm())
  engine_install(..., scope = scope)
}

#' @rdname npm_install
#' @export 
npm_uninstall <- function(..., scope = c("dev", "prod", "global")){
  assert_that(is_npm())
  engine_uninstall(..., scope = scope)
}

#' Audit Fix
#' 
#' Scan your project for vulnerabilities and automatically install 
#' any compatible updates to vulnerable dependencies.
#' 
#' @details Runs `npm audit fix`
#' 
#' @export 
npm_fix <- function(){
  assert_that(is_npm())
  npm <- engine_find()
  system2(npm, "audit fix")
}

#' Npm Output
#' 
#' Prints the output of the last npm command run, useful for debugging.
#' 
#' @export
npm_console <- function(){
  assert_that(is_npm())
  engine_console()
}


#' Npm Command
#' 
#' Convenience function to run `npm` commands.
#' 
#' @param ... Passed to [system2()].
#' 
#' @export 
npm_run <- function(...){
  assert_that(is_npm())
  engine_run(...)
}

#' Npm Update
#' 
#' Update npm dependencies.
#' 
#' @export
npm_update <- function(){
  assert_that(is_npm())
  results <- engine_update()
  invisible(results)
}

#' Npm Outdated
#' 
#' Find outdated dependencies
#' 
#' @export
npm_outdated <- function(){
  assert_that(is_npm())
  engine_outdated()
}

#' Npm version
#' 
#' Get the version of npm.
#' 
#' @return The semver as a string.
#' 
#' @export
yarn_version <- function(){
  assert_that(is_yarn())
  engine_version()
}
