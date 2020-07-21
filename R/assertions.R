# stop if npm is not found
stopif_no_npm <- function(){
  if(!npm_has())
    stop("Cannot find `npm`, do you have it installed?", call. = FALSE)
}

# stop if npm is not found
stopif_no_name <- function(name){
  if(missing(name))
    stop("Stop missing `name`", call. = FALSE)
}

stopif_no_package <- function(){
  desc <- fs::file_exists("DESCRIPTION")
  ns <- fs::file_exists("NAMESPACE")

  is_pkg <- all(desc, ns)

  if(!is_pkg)
    stop("You must first create a package to house the widget, see `usethis::create_package`.")
}