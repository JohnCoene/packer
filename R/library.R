#' Make Library
#' 
#' Adds library settings to webpack config.
#' This allow exporting JavaScript objects.
#' 
#' @param name Name of the library, default recommended, 
#' see details.
#' @param type Type of the library.
#' 
#' @details The functions will be exported
#' at the specified `name`, e.g.: if
#' the name is `myLib` then functions can be 
#' called with `myLib.function();`. 
#' The default (`[name]`) means the name of the exported
#' library will be the same as the name of the scaffold.
#' This is advised because otherwise, if one has multiple
#' scaffold, an absolute will overwrite itself and only 
#' the last scaffold added will be a valid library.
#' 
#' @export 
make_library <- function(name = "[name]", type = "umd"){
	common <- readLines("webpack.common.js")
	common[grepl("\\[name\\]\\.js", common)] <- sprintf(
		"    filename: '[name].js',\n    library: {name: '%s', type: '%s'},", 
		name, type
	)

	writeLines(common, "webpack.common.js")

	cli::cli_alert_info("Use `{name}.foo()` to call exported functions.")
	invisible()
}