#' Use npm
#' 
#' By default packer looks for the npm installation using the `which` command.
#' This function lets you override that behaviour and force a specific npm installation.
#' 
#' @param path Path to npm installation to use.
#' 
#' @examples \dontrun{use_npm("/usr/local/bin/npm")}
#' 
#' @export
use_npm <- function(path = NULL){
  options(JS4R_NPM = path)
  invisible()
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
  npm <- npm_find()

  # if not print only warnings and errors
  results <- tryCatch(
    system2(npm, ..., stdout = TRUE, stderr = TRUE),
    error = function(e) e,
    warning = function(w) w
  )

  system_we(results)

}

#' Initialise npm
#' 
#' Convenience to initialsie npm
#' 
#' @noRd 
#' @keywords internal
npm_init <- function(){
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
  package$scripts$none <- "webpack --config webpack.config.js --mode=none"
  package$scripts$development <- "webpack --config webpack.config.js --mode=development"
  package$scripts$production <- "webpack --config webpack.config.js --mode=production"
  package$scripts$watch <- "webpack --config webpack.config.js -d --watch"
  jsonlite::write_json(package, "package.json", pretty = TRUE, auto_unbox = TRUE)
  cli::cli_alert_success("Added npm scripts")
}
