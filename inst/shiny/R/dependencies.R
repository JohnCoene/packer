#' Dependencies
#' 
#' Include dependencies, place anywhere in the shiny UI.
#' 
#' @importFrom shiny singleton tags
#' 
#' @export
use_name <- function(){
  singleton(
    tags$head(
      tags$script(src = "#name#-assets/index.js")
    )
  )
}
