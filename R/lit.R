#' Lit
#' 
#' Use [Lit](https://lit.dev) in your project.
#' 
#' @param ts Whether to use TypeScript (recommended).
#' 
#' @export
ease_lit <- function(ts = FALSE){
	engine_install("lit", scope = "prod")

	if(!ts)
		return(invisible())

	# if the ts config file is not found 
	# it likely means the loader is not in place
	if(!fs::file_exists("tsconfig.json"))
		use_loader_ts()

	engine_install("typescript", scope = "dev")	

	# we use a different config file
	fs::file_copy(
		pkg_file("lit/config.json"),
		"tsconfig.json",
		overwrite = TRUE
	)
}
