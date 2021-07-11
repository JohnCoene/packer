#' Shiny types
#' 
#' Installs Shiny TypeScript types.
#' 
#' @note May not work with npm, yarn is advised.
#' 
#' @keywords internal
#' @noRd 
get_shiny_types <- function(){
	engine <- engine_get()

	if(engine == "npm"){
		cli::cli_alert_warning(
			"Installing types with npm may fail, try with yarn. See {.code engine_set}"
		)
	}

	engine_install("https://github.com/rstudio/shiny", scope = "dev")
}