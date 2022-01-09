#' Set Engine
#' 
#' Defines the engine to use with packer.
#' One can pick between npm and yarn.
#' 
#' @details Generally one would want to define
#' the engine prior to scaffolding. 
#' For convenience you can instead set the environment
#' variable `PACKER_ENGINE` to your engine of choice.
#' Packer reads this variable, all subsequent use
#' of packer will use the defined engine.
#' You can use the function `usethis::edit_r_environ`
#' to do so.
#' 
#' @section Functions:
#' 
#' - `engine_set`: Define the engine to use for the project.
#' - `engine_get`: Retrieve the default engine.
#' - `engine_which`: Retrieve which engine the project is set
#' to use-.
#' - `engine_adapt`: Change the engine to match that of the
#' poject.
#' 
#' @param engine The engine to use, npm or yarn.
#' 
#' @name engine
#' @export 
engine_set <- function(engine = c("npm", "yarn")){
	engine <- match.arg(engine)

	cli::cli_alert_info("Temporarily setting {.envvar PACKER_ENGINE} environment variable to {.field {engine}}")
  
  if(engine == "yarn"){
    cli::cli_alert_danger(
      "Consider setting the environment variable {.envvar PACKER_ENGINE} in your ${.file .Renviron} to make this permanent"
    )
  }

	Sys.setenv(PACKER_ENGINE = engine)
}

#' @rdname engine
#' @export 
engine_get <- function(){
	engine <- Sys.getenv("PACKER_ENGINE", "npm")

	# invalid engine was defined => override
	if(!engine %in% c("npm", "yarn")){
    cli::cli_alert_warning(
      "Invalid engine set (`{.strong {engine}}`), switching to {.strong npm}"
    )
		engine <- "npm"
  }
	
	invisible(engine)
}

#' @rdname engine
#' @export 
engine_adapt <- function(){

  # get engine of project 
  engine <- engine_which()

  # this is not a packer project
  if(is.null(engine))
    return(invisible())
  
  # compare set engine to default
  # return specific message if those differs
  global_default_engine <- Sys.getenv("PACKER_ENGINE", "npm")
  if(engine == global_default_engine){
    return(invisible())
  }
	
  # force change the engine
  Sys.setenv(PACKER_ENGINE = engine)

  cli::cli_alert_warning(
    "Setting engine to {.strong {engine}} to match project."
  )
  cli::cli_alert_info(
    "Use functions starting in {.var {engine}}, e.g.: {.fn {engine}_install}"
  )
}

#' @rdname engine
#' @export 
engine_which <- function(){
  # no need to go further
  if(!file.exists("package.json")){
    cli::cli_alert_danger("Not a packer project")
    return(invisible())
  }

  engine <- "npm"
  if(file.exists("yarn.lock") || file.exists("yarn-error.log"))
    engine <- "yarn"

  return(engine)
}

#' Set engine
#' 
#' By default packer looks for the installation of 
#' the engine using the `which` command.
#' This function lets you override that behaviour 
#' and force a specific installation of the engine
#' you have set (npm or yarn), see [engine_set]
#' 
#' @param path Path to npm installation to use.
#' 
#' @keywords internal
#' @noRd 
engine_path <- function(path = NULL){
  options(PACKER_ENGINE_PATH = path)
  invisible()
}

#' Install and Uninstall Packages
#' 
#' Install and uninstall packages using defined engine.
#' 
#' @param ... Packages to install or uninstall.
#' For `engine_install` if nothing is passed `scope` is
#' ignored.
#' @param scope Scope of installation or uninstallation, see scopes.
#' 
#' @section Scopes:
#' 
#' * `prod` - Installs/Uninstalls packages for project with `--save`
#' * `dev` - Installs/Uninstalls dev packages for project with `--save-dev`
#' * `global` - Installs/Uninstalls packages globally with `-g`
#' 
#' @name engine_install
#' 
#' @keywords internal
#' @noRd 
engine_install <- function(..., scope = c("dev", "prod", "global")){
  # check
  packages <- c(...) # capture
  scope <- match.arg(scope)

  if(length(packages) > 0){
    scope_arg <- scope2flag(scope)
    args <- c(engine_install_cmd(), scope_arg, packages)
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
  tryCatch(engine_run(args), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
}

engine_uninstall <- function(..., scope = c("dev", "prod", "global")){
  # check
  packages <- c(...) # capture
  scope <- match.arg(scope)

  if(length(packages) == 0)
    stop("Must pass packages names to `...`", call. = FALSE)

	cmd <- engine_uninstall_cmd()
  scope_arg <- scope2flag(scope)
  args <- c(cmd, scope_arg, packages)
  msgs <- pkg2msg(packages, scope, method = "uninstall")
  
  do.call(cli::cli_process_start, msgs)
  tryCatch(engine_run(args), error = function(e) cli::cli_process_failed())
  cli::cli_process_done()
}

#' Commands
#' 
#' Switch between commands for CLI tools
#' dependending on set engine.
#' 
#' @name engine_cmd
#' 
#' @keywords internal
#' @noRd 
engine_install_cmd <- function(){
	switch(engine_get(),
		npm = "install",
		yarn = "add"
	)
}

engine_uninstall_cmd <- function(){
	switch(engine_get(),
		npm = "uninstall",
		yarn = "remove"
	)
}

#' Npm Output
#' 
#' Prints the output of the last npm command run, useful for debugging.
#' 
#' @export
engine_console <- function(){
  output <- tryCatch(get("engine_output", envir = storage), error = function(e) NULL)

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
#' Turns [engine_install()] `scope` argument to npm or yarn
#' installation flags.
#' 
#' @inheritParams engine_install
#' 
#' @return Character string, `npm install` flag or `yarn add`
#' 
#' @noRd
#' @keywords internal 
scope2flag <- function(scope =  c("prod", "dev", "global")){
  scope <- match.arg(scope)

	if(engine_get() == "npm"){
		switch(
			scope,
			prod = "--save",
			dev = "--save-dev",
			global = "-g"
		)
	} else if(engine_get() == "yarn"){
		switch(
			scope,
			prod = "",
			dev = "--dev"
		)
	}
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
pkg2msg <- function(packages, scope, method = c("install", "uninstall")){

  method <- match.arg(method)
  method <- engine_method_cmd(method)

  # collapse packages in one line
  packages <- paste0(packages, collapse = ", ")

  # messages
  started <- sprintf("%sing {.pkg %s} with scope {.val %s}", tools::toTitleCase(method), packages, scope)
  done <- sprintf("{.pkg %s} %sed with scope {.val %s}", packages, method, scope)
  failed <- sprintf("Failed to %s {.pkg %s}", method, packages)

  # arguments
  list(started, done, failed)
}

engine_method_cmd <- function(method){
  if(engine_get() == "npm")
    return(method)
  
  switch(method,
    install = "add",
    uninstall = "remove"
  )
}

#' Finds Engine
#' 
#' Returns engine command to use, either [engine_set] 
#' otherwise uses `which` (or `where`) command to find 
#' installation.
#' 
#' @noRd
#' @keywords internal
engine_find <- function(){
  path <- getOption("PACKER_ENGINE_PATH", NULL)

  if(!is.null(path))
    return(path)

  # which on UNIX and where on Windows
  cmd <- which_or_where() 
  path <- suppressWarnings(
    system2(cmd, engine_get(), stdout = TRUE)
  )
  
  # where may return multiple paths
  path[1]
}

#' Engine Check
#' 
#' Check if the engine is correctly set up and 
#' prints helpful messages if not.
#' 
#' @export 
engine_check <- function(){
  path <- engine_find()

  if(is.na(path) || path == ""){
    cli::cli_alert_danger("Could not find npm!")
    cli::cli_text("\n")
    cli::cli_alert("1 Are you sure you installed it?")
    cli::cli_ul()
    cli::cli_li("Manual install: {.url https://nodejs.org/en/download/}")
    cli::cli_li("Package Managers: {.url https://nodejs.org/en/download/package-manager/}")
    cli::cli_end()
    cli::cli_text("\n")
    cli::cli_alert("2 Are you sure it's in your {.var PATH}?")
    cli::cli_text(
      "If you have it installed but still see this: make sure ",
      "your installation of node and npm is in your {.var PATH}. ",
      "Otherwise you can manually set the path to your npm binary ",
      "with {.fn engine_set}, e.g.: {.var engine_set('path/to/npm/bin')}"
    )
    return(invisible())
  }

  v <- engine_version(verbose = FALSE)
  cli::cli_alert_success(
    "All good, using {.field {path}} version {.field {v}}"
  )

  invisible()
}

#' Engine Run
#' 
#' Convenience function to run commands
#' on the defined engine, see [engine_set].
#' 
#' @param ... Passed to [system2()].
#' 
#' @noRd 
#' @keywords internal
engine_run <- function(...){

  results <- system_2_quiet(...)

  assign("engine_output", results, envir = storage)

  # print warnings and errors
  print_results(results)

  invisible(results)
}

# wrapper for system2
system_2 <- function(...){
  engine <- engine_find()
  system2(engine, ..., stdout = TRUE, stderr = TRUE)
}

system_2_quiet <- purrr::quietly(system_2)

#' Initialise Project
#' 
#' Convenience to initialsie with npm or yarn.
#' 
#' @noRd 
#' @keywords internal
engine_init <- function(){
  scaffolded <- has_scaffold()
  if(scaffolded) return()
  
  engine_run(c("init", "-y"))

  cli::cli_alert_success("Initialiased {.file {engine_get()}}")
}

#' Package Script
#' 
#' Adds scripts to `package.json` file.
#' 
#' @noRd 
#' @keywords internal
engine_add_scripts <- function(){
  package <- jsonlite::read_json("package.json")
  package$scripts$none <- "webpack --config webpack.dev.js --mode=none"
  package$scripts$development <- "webpack --config webpack.dev.js"
  package$scripts$production <- "webpack --config webpack.prod.js"
  package$scripts$watch <- "webpack --config webpack.dev.js -d --watch"
  save_json(package, "package.json")
  cli::cli_alert_success("Added {.file {engine_get()}} scripts")
}

#' Engine Update
#' 
#' Update dependencies.
#' 
#' @keywords internal
#' @noRd 
engine_update <- function(){

  engine_update_msgs(parent.frame())

	cmd <- engine_update_cmd()
  results <- engine_run(cmd)

  cli::cli_process_done()

  invisible(results)
}

engine_update_msgs <- function(env = parent.frame()){
  
  if(engine_get() == "npm"){
    cli::cli_process_start(
      "Updating",
      "Updated",
      "Failed to update",
      .envir = env
    )
    return()
  }

  cli::cli_process_start(
    "Upgrading",
    "Upgraded",
    "Failed to upgrade",
    .envir = env
  )
}

engine_update_cmd <- function(){
	switch(engine_get(),
		npm = "update",
		yarn = "upgrade"
	)
}

engine_outdated_cmd <- function(){
	switch(engine_get(),
		npm = "outdated",
		yarn = "upgrade-interactive"
	)
}

#' Outdated Packages
#' 
#' Find outdated dependencies
#' 
#' @keywords internal
#' @noRd 
engine_outdated <- function(){
  cmd <- engine_find()
  system2(cmd, engine_outdated_cmd())
}

#' Version
#' 
#' Get the version of the currently set engine.
#' 
#' @param verbose Whether to print the version.
#' 
#' @return The semver as a string (invisibly).
#' 
#' @keywords internal
#' @noRd
engine_version <- function(verbose = interactive()){
  output <- engine_run("--version")
  version <- output$result

  if(verbose)
    cli::cli_alert(version)

  invisible(version)
}