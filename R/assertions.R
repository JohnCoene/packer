# stop if npm is not found
stopif_no_npm <- function(){
  if(!npm_has())
    stop("Cannot find `npm`, do you have it installed?", call. = FALSE)
}

# stop if npm is not found
stopif_no_name <- function(name){
  if(missing(name))
    stop("Missing `name`of widget", call. = FALSE)
}

# check if it is a package
stopif_no_package <- function(){
  desc <- fs::file_exists("DESCRIPTION")
  ns <- fs::file_exists("NAMESPACE")

  is_pkg <- all(desc, ns)

  if(!is_pkg)
    stop("You must first create a package to house the widget, see `usethis::create_package`.")
}

# check if scafolded
stopif_no_npm_init <- function(){
  package_json <- fs::file_exists("package.json")
  src_dir <- fs::dir_exists(SRC)

  is_pkg <- all(package_json, src_dir)
  
  if(!is_pkg)
    stop("No widget scaffold, see `scaffold_widget`", call. = FALSE)
}

# stop if not golem app
stopif_no_golem <- function(){
  dev <- fs::dir_exists("dev")
  config <- fs::file_exists("inst/golem-config.yml")

  is_golem <- all(dev, config)
  
  if(!is_golem)
    stop("Not a golem app, see `golem::create_golem`", call. = FALSE)
}
