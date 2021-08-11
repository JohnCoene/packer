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
	if(!dir.exists(".git")){
		cli::cli_alert_danger("Not using git")
		return()
	}
	
	file <- pkg_file("hooks/minified.sh")
	script <- readLines(file)
	script <- hook_edit_path(script)
	usethis::use_git_hook("pre-commit", script)
}

#' Minified
#' 
#' Checks whether files within a directory are minified.
#' 
#' @param dir Directory of files to check
#' 
#' @examples 
#' \dontrun{is_minified("path/to/js-dir")}
#' 
#' @export 
are_minified <- function(dir){
	files <- list.files(dir, pattern = ".js$")

	if(length(files) == 0)
		return(invisible())
	
	full_paths <- file.path(dir, files)

	locs <- sapply(full_paths, loc, quiet = TRUE)

	for(i in 1:length(locs)){
		if(locs[i] < 10)
			next

		cat(1, file = stdout())
	}

	cat(0, file = stdout())
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

#' Rprofile
#' 
#' Add [engine_adapt()] to `.Rprofile`.
#' 
#' This is recommended so anyone contributing to
#' the project is guaranteed to be on the correct
#' engine.
#' 
#' @export 
put_rprofile_adapt <- function(){
	rprof <- ".Rprofile"
	if(!fs::file_exists(rprof)){
		fs::file_create(rprof)
	}

	rprof <- readLines(pkg_file("hooks/rprof.R"))

	content <- readLines(rprof)
	content <- c(content, rprof)

	writeLines(content, con = rprof)
}

#' Recommended Checks
#' 
#' Recommended checks for packer projects,
#' runs [put_rprofile_adapt] and 
#' [put_precommit_hook].
#' 
#' @export 
put_recommended <- function(){
	put_rprofile_adapt()
	put_precommit_hook()
}

#' Checks
#' 
#' Run checks on a package using packer.
#' 
#' @section Checks:
#' 
#' - Output files are minified
#' - [put_precommit_hook] is in place
#' - [put_rprofile_adapt] is in place
#' 
#' @export 
checks <- function(){
	cli::cli_h1("Checks")

	path <- hook_get_path()
	files <- list.files(path, pattern = ".js$")
	full_paths <- file.path(path, files)

	# lines of code
	cli::cli_h2("Minification")
	locs <- check_locs(full_paths)

	# has .Rprofile
	cli::cli_h2(".Rprofile")
	rprofile_check <- check_rprofile()

	# has precommit hook
	cli::cli_h2("Precommit hook")
	precommit_check <- check_precommit()

	invisible(
		list(
			locs = locs,
			rprofile = rprofile_check,
			precommit_check = precommit_check
		)
	)
}

# Check precommit is in place
check_precommit <- function(){
	if(!fs::dir_exists(".git"))
		return()
	
	if(!fs::dir_exists(".git/hooks"))
		return()

	has_check <- FALSE
	if(fs::file_exists(".git/hooks/pre-commit")){
		content <- suppressWarnings(readLines(".git/hooks/pre-commit"))
		has_check <- grepl("not minified", content)
	}

	if(any(has_check))
		cli::cli_alert_success("pre-commit hook set")
	else 
		cli::cli_alert_warning("No pre-commit hook set, see {.fn packer::put_precommit_hook}")
	
	return(has_check)
}

# check that the Rprofile exists and has check
check_rprofile <- function(){
	if(!file.exists(".Rprofile")){
		cli::cli_alert_warning("No {.file .Rprofile} found, see {.fn packer::put_rprofile_adapt}")
		return(FALSE)
	}

	content <- suppressWarnings(readLines(".Rprofile"))
	has_adapt <- grepl("engine_adapt", content)

	if(any(has_adapt))
		cli::cli_alert_success("{.fn packer::engine_adapt} found in {.file .Rprofile}")
	else
		cli::cli_alert_warning("{.fn packer::engine_adapt} {.strong not} found in {.file .Rprofile}")

	return(has_adapt)
}

# check if files are minified
check_locs <- function(paths){
	sapply(paths, loc)
}

loc <- function(path, quiet = FALSE){
	l <- system2("wc", sprintf("-l %s", path), stdout = TRUE)
	l <- as.integer(strsplit(l, " ")[[1]][1])
	minified <- l < 4
	text <- ifelse(minified, "minified", "not minified")

	if(!quiet){
		fn <- cli::cli_alert_success
		if(!minified)
			fn <- cli::cli_alert_warning

		fn("{.file {path}} is {.strong {text}}")
	}

	return(l)
}