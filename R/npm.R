#' Use npm
#' 
#' Use a specific npm installation.
#' 
#' @param npm npm command to use internally.
#' 
#' @export
use_npm <- function(npm = NULL){
  options(JS4R_NPM = npm)
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

# stop if npm is not found
stopifno_npm <- function(){
  if(!npm_has())
    stop("Cannot find `npm`, do you have it installed?", call. = FALSE)
}

# pass args to npm
npm_run <- function(...){
  npm <- npm_find()
  system2(npm, ...)
}

# convenience: init npm
npm_init <- function(){
  npm_run("init -y")
}

# add scripts
npm_add_scripts <- function(){
  package <- jsonlite::read_json("package.json")
  package$scripts$build <- "webpack --config webpack.config.js"
  jsonlite::write_json(package, "package.json", pretty = TRUE, auto_unbox = TRUE)
}
