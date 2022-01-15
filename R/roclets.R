#' Roclet Prod
#' 
#' Roclet to run [bundle_prod] when documenting.
#' 
#' @import roxygen2
#' 
#' @export 
prod_roclet <- function() {
	roclet("prod")
}

#' @export 
roclet_process.roclet_prod <- function(
	x, 
	blocks, 
	env, 
	base_path
) {
	invisible()
}

#' @export 
roclet_output.roclet_prod <- function(
	x, 
	results, 
	base_path, 
	...
) {
	bundle("production")
}

#' Roclet Dev
#' 
#' Roclet to run [bundle_dev] when documenting.
#' 
#' @import roxygen2
#' 
#' @export 
dev_roclet <- function() {
	roclet("dev")
}

#' @export 
roclet_process.roclet_dev <- function(
	x, 
	blocks, 
	env, 
	base_path
) {
	invisible()
}

#' @export 
roclet_output.roclet_dev <- function(
	x, 
	results, 
	base_path, 
	...
) {
	bundle("development")
}
