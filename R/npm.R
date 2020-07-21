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

# return install or use
npm_find <- function(){
  npm <- getOption("JS4R_NPM", NULL)
  if(is.null(npm))
    npm <- suppressWarnings(system2("which", "npm", stdout = TRUE))
  
  return(npm)
}

# is npm installed and can it be found?
npm_has <- function(){
  length(npm_find()) > 0
}

# pass args to npm
npm_run <- function(..., verbose = TRUE){
  npm <- npm_find()
  system2(npm, ..., stdout = verbose)
}

# convenience: init npm
npm_init <- function(verbose = TRUE){
  npm_run("init -y", verbose)
}

# add scripts
npm_add_scripts <- function(){
  package <- jsonlite::read_json("package.json")
  package$scripts$none <- "webpack --config webpack.config.js --mode=none"
  package$scripts$development <- "webpack --config webpack.config.js --mode=development"
  package$scripts$production <- "webpack --config webpack.config.js --mode=production"
  package$scripts$watch <- "webpack --config webpack.config.js -d --watch"
  jsonlite::write_json(package, "package.json", pretty = TRUE, auto_unbox = TRUE)
}
