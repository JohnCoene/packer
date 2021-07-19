#' Put Pre-Commit Hook
#' 
#' Add a pre-commit hook that runs at every commit
#' to ensure that JavaScript files are minified.
#' 
#' @note Will only work if using git.
#' 
#' @examples 
#' \dontrun{put_precommit_hook()}
#' 
#' @export
put_precommit_hook <- function(){
	if(!dir.exists(".git"))
		stop("Not using git", call. = FALSE)
	
	file <- pkg_file("hooks/minified.sh")
	script <- readLines(file)
	script <- hook_edit_path(script)
	usethis::use_git_hook("pre-commit", script)
}

#' Dynamic Path 
#' 
#' Dynamic path based on project
#' 
#' @keywords internal
#' @noRd 
hook_get_path <- function(){
	if(is_golem())
		return("inst/app/www")
	
	if(is_ambiorix())
		return("assets")

	return("inst/packer")
}

#' Edit Hook Path
#' 
#' @keywords internal
#' @noRd 
hook_edit_path <- function(script){
	path <- hook_get_path()	
	gsub("<<PATH>>", path, script)
}