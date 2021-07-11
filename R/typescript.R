#' Shiny types
#' 
#' Installs Shiny TypeScript types.
#' 
#' @note May not work with npm, yarn is advised.
#' 
#' @details This cannot be automated due to issues with
#' both npm and yarn. 
#' 
#' - It tends to fail with npm
#' - A limitation of yarn makes this impossible
#' 
#' With yarn, you will be prompted which version of 
#' jQuery types you want to install, ideally install
#' 3.5.5.
#' 
#' @keywords internal
#' @noRd 
ts_shiny_types <- function(){
	engine <- engine_get()

	if(engine == "npm"){
		cli::cli_alert_warning(
			"Installing types with npm may fail, try with yarn. See {.code engine_set}"
		)
	}

	# this won't work due to patch
	# engine_install("rstudio/shiny", scope = "dev")

	engine <- engine_get()
	cmd <- engine_install_cmd()
	cli::cli_alert(
		"Run the following from your terminal"
	)
	cli::cli_text(
		"{.code {engine} {cmd} rstudio/shiny}"
	)
}

#' Install Types
#' 
#' Install TypeScript types from npm.
#' 
#' @param ... Types to install.
#' @param type Name of types `@@types/*` to install.
#' @param versions,version Corresponding versions of types passed
#' to `...`, if `NULL` the latest version is installed.
#' 
#' @section Functions:
#' 
#' - `ts_get_types`: Flexible to retrieve multiple types.
#' - `ts_get_type`: Convenience to easily retrieve a single type.
#' 
#' @examples 
#' \dontrun{ts_get_type("jquery")}
#' \dontrun{ts_get_types("@@types/jquery")}
#' 
#' @name types
#' @export 
ts_get_types <- function(..., versions = NULL){
	types <- c(...)

	if(length(types) == 0)
		stop("No types specified", call. = FALSE)
	
	if(is.null(versions)){
		engine_install(types, scope = "dev")
		return()
	}

	if(length(types) != length(versions))
		stop("Number of types does not match the number of versions")
	
	types <- paste0(types, "@", versions)
	engine_install(types, scope = "dev")
}

#' @rdname types
#' @export
ts_get_type <- function(type, version = NULL){
	if(missing(type))
		stop("Missing type", call. = FALSE)

	if(!is.null(version))
		type <- sprintf("%s@%s", type, version)

	arg <- sprintf("@types/%s", type)
	engine_install(arg)
}