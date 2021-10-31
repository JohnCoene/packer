#' Github Actions
#' 
#' Adds a Github Action to the package that will bundle
#' the JavaScript for production on commit.
#' 
#' @export
include_action_bundle <- function(){
	file <- pkg_file("hooks/bundle.yml")
	fs::file_copy(file, ".github/workflows/packer-bundle.yml")
}
