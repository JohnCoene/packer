#' Github Actions
#' 
#' Adds a Github Action to the package that will ensure
#' JavaScript files have been bundled for production.
#' 
#' @export
include_action_check <- function(){
	file <- pkg_file("hooks/check.yml")
	fs::dir_create(".github/workflows", recurse = TRUE)
	fs::file_copy(file, ".github/workflows/packer-check.yml")
	usethis::use_build_ignore(".github/")
}
