#' Put a Test
#' 
#' Puts a testthat test to ensure the files are 
#' optimised for prod.
#' 
#' @note This function adds packer to `Suggests`.
#' 
#' @export 
put_test <- function(){
  
	assert_that(has_scaffold())
	assert_that(is_project())
	assert_that(is_installed("testthat"))

  pkg <- get_pkg_name()

	template_path <- system.file("hooks/test.R", package = "packer")
	template_cnt <- readLines(template_path)
	template <- gsub("#PKG#", pkg, template_cnt)

	test_dir <- "./tests/testthat"
	if(!dir.exists(test_dir))
		usethis::use_testthat()

	usethis::use_package("packer", type = "Suggests")

	test_file <- sprintf("%s/test-packer.R", test_dir)
	writeLines(template, con = test_file)

	cli::cli_alert_success("Create {.file {test_file}}")

	invisible()
}

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
		return(invisible())
	}

	on.exit({
		cli::cli_alert_success("Added pre-commit hook")
	})

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
#' @noRd
#' @keywords internal
are_minified <- function(dir){
	files <- list.files(dir, pattern = ".js$")

	if(length(files) == 0)
		cat(0, file = stdout())
	
	full_paths <- file.path(dir, files)

	locs <- sapply(full_paths, loc, quiet = TRUE)

	for(i in 1:length(locs)){
		if(locs[i] < 10)
			next

		cat(1, file = stdout())
	}

	cat(0, file = stdout())
}

#' @noRd
#' @keywords internal
are_minified_r <- function(dir){
	files <- list.files(dir, pattern = ".js$")

	if(length(files) == 0)
		return(TRUE)
	
	full_paths <- file.path(dir, files)

	locs <- sapply(full_paths, loc, quiet = TRUE)

	for(i in 1:length(locs)){
		if(locs[i] < 10)
			next

		return(FALSE)
	}

	return(TRUE)
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
		return("inst/assets")

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
	if(!fs::file_exists(rprof))
		fs::file_create(rprof)
	
	on.exit({
		cli::cli_alert_success("Added call to {.file {rprof}}")
	})

	rprof_tmp <- readLines(pkg_file("hooks/rprof.R"))

	content <- suppressMessages(readLines(rprof))
	content <- c(content, rprof_tmp)

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
	locs <- check_locs(full_paths)

	# has .Rprofile
	cli::cli_h2(".Rprofile")
	rprofile_check <- check_rprofile()

	# has precommit hook
	cli::cli_h2("Precommit hook")
	precommit_check <- check_precommit()

	# file size
	check_file_size(full_paths)

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
		return(invisible())
	
	if(!fs::dir_exists(".git/hooks"))
		return(invisible())

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
	if(length(paths) == 0)
		return()
	
	cli::cli_h2("Minification")
	sapply(paths, loc)
}

check_file_size <- function(paths){
	if(length(paths) == 0)
		return()
	
	cli::cli_h2("Files size")
	sapply(paths, size)
}

size <- function(path){
	sz <- system2("du", path, stdout = TRUE)
	k <- strsplit(sz, "\\t")[[1]][1]
	cli_alert_info("{.file {path}}: {.field {k}} Kb")
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
