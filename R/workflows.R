#' Github Actions
#' 
#' Adds a Github Action to the package that will bundle
#' the JavaScript for production on commit.
#' 
#' @export
include_action_check <- function(){
	file <- pkg_file("hooks/check.yml")
	fs::dir_create(".github/workflows", recurse = TRUE)
	fs::file_copy(file, ".github/workflows/packer-check.yml")
}
