#' Use npm
#' 
#' By default packer looks for the npm installation using the `which` command.
#' This function lets you override that behaviour and force a specific npm installation.
#' 
#' @param path Path to npm installation to use.
#' 
#' @export
set_npm <- function(path = NULL){
  options(JS4R_NPM = path)
  invisible()
}

#' Install Npm Packges
#' 
#' Install npm packges.
#' 
#' @param ... Packages to install.
#' @param scope Scope of installation, see scopes.
#' 
#' @section Scopes:
#' 
#' * `prod` - Installs packages for project with `--save`
#' * `dev` - Installs dev packages for project with `--save-dev`
#' * `global` - Instals packages globally with `-g`
#' 
#' @export 
npm_install <- function(..., scope = c("dev", "prod", "global")){
  # check
  packages <- c(...) # capture
  scope <- match.arg(scope)

  if(length(packages) > 0){
    scope_arg <- scope2flag(scope)
    args <- c("install", scope_arg, packages)
    msgs <- pkg2msg(packages, scope)
  } else {
    args <- "install"
    msgs <- list(
      "Installing dependencies", 
      "Installed dependencies", 
      "Failed to install dependencies"
    )
  }
  
  do.call(cli::cli_process_start, msgs)
  tryCatch(npm_run(args), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
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
  npm <- npm_find()
  system2(npm, "audit fix")
}

#' Npm Output
#' 
#' Prints the output of the last npm command run, useful for debugging.
#' 
#' @export
npm_console <- function(){
  output <- tryCatch(get("npm_output", envir = storage), error = function(e) NULL)

  if(is.null(output)){
    cli::cli_alert_danger("No command previously run")
    return(invisible())
  }

  if(length(output$warnings)){
    cli::cli_alert_warning("Command raised the warning below")
    cli::cli_code(output$warnings)
  }
  
  if(length(output$result))
    cli::cli_code(output$result)
  
  invisible()
}

#' Scope Argument to Flags
#' 
#' Turns [npm_install()] `scope` argument to npm installation flags.
#' 
#' @inheritParams npm_install
#' 
#' @return Character string, `npm install` flag
#' 
#' @noRd
#' @keywords internal 
scope2flag <- function(scope =  c("prod", "dev", "global")){
  scope <- match.arg(scope)
  switch(
    scope,
    prod = "--save",
    dev = "--save-dev",
    global = "-g"
  )
}

#' Installation Process Messages
#' 
#' Makes messages for [cli::cli_process_start()].
#' 
#' @param packages Vector of packages to install
#' 
#' @return List of arguments for [cli::cli_process_start()].
#' 
#' @noRd
#' @keywords internal 
pkg2msg <- function(packages, scope){
  # collapse packages in one line
  packages <- paste0(packages, collapse = ", ")

  # messages
  started <- sprintf("Installing {.pkg %s} with scope {.val %s}", packages, scope)
  done <- sprintf("{.pkg %s} installed with scope {.val %s}", packages, scope)
  failed <- sprintf("Failed to install {.pkg %s}", packages)

  # arguments
  list(started, done, failed)
}

#' Finds NPM
#' 
#' Returns npm command to use, either [use_npm] or otherwise uses
#' `which` command to find installation.
#' 
#' @noRd
#' @keywords internal
npm_find <- function(){
  npm <- getOption("JS4R_NPM", NULL)
  if(is.null(npm))
    npm <- suppressWarnings(system2("which", "npm", stdout = TRUE))
  
  return(npm)
}

#' Npm Command
#' 
#' Convenience function to run `npm` commands.
#' 
#' @param ... Passed to [system2()].
#' 
#' @noRd 
#' @keywords internal
npm_run <- function(...){

  results <- system_2_quiet(...)

  assign("npm_output", results, envir = storage)

  # print warnings and errors
  print_results(results)

  invisible(results)
}

# wrapper for system2
system_2 <- function(...){
  npm <- npm_find()
  system2(npm, ..., stdout = TRUE, stderr = TRUE)
}

system_2_quiet <- purrr::quietly(system_2)

#' Initialise npm
#' 
#' Convenience to initialsie npm
#' 
#' @noRd 
#' @keywords internal
npm_init <- function(){
  scaffolded <- has_scaffold()
  if(scaffolded) return()
  
  npm_run(c("init", "-y"))
  cli::cli_alert_success("Initialiased npm")
}

#' Package Script
#' 
#' Adds scripts to `package.json` file.
#' 
#' @noRd 
#' @keywords internal
npm_add_scripts <- function(){
  package <- jsonlite::read_json("package.json")
  package$scripts$none <- "webpack --config webpack.dev.js --mode=none"
  package$scripts$development <- "webpack --config webpack.dev.js"
  package$scripts$production <- "webpack --config webpack.prod.js"
  package$scripts$watch <- "webpack --config webpack.config.js -d --watch"
  save_json(package, "package.json")
  cli::cli_alert_success("Added npm scripts")
}
