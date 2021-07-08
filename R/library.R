#' Make Library
#' 
#' Adds library settings to webpack config.
#' This allow exporting JavaScript objects.
#' 
#' @param name Name of the library, see details.
#' @param type Type of the library.
#' 
#' @details The functions will be exported
#' at the specified `name`, e.g.: if
#' the name is `myLib` then functions can be 
#' called with `myLib.function();`. 
#' 
#' @export 
make_library <- function(name, type = "umd"){
	if(missing(name))
		stop("Missing name", call. = FALSE)

	common <- readLines("webpack.common.js")
	common[grepl("\\[name\\]\\.js", common)] <- sprintf(
		"    filename: '[name].js',\n    library: {name: '%s', type: '%s'},", 
		name, type
	)

	writeLines(common, "webpack.common.js")

	cli::cli_alert_info("Use `{name}.foo()` to call exported functions.")
	invisible()
}