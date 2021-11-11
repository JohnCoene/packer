#' Dependencies for React
#' 
#' Includes React dependencies in a shiny application.
#' 
#' @param version Version of React to use, if `NULL` uses the latest
#' 
#' @keywords internal
reactCDN <- function(version = 17){
  unpkg <- "https://unpkg.com"

  version_string <- sprintf("@%d", version)

  react <- sprintf("%s/react%s/umd/react.production.min.js", unpkg, version_string)
  react_dom <- sprintf("%s/react-dom%s/umd/react-dom.production.min.js", unpkg, version_string)
  shiny::singleton(
    shiny::tags$head(
      shiny::tags$script(src = react, crossorigin = NA),
      shiny::tags$script(src = react_dom, crossorigin = NA)
    )
  )
}
