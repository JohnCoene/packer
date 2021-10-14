#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @param title Page title. 
#' @import shiny
#' @noRd
app_ui <- function(request, title = NULL) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(title),
    # Your application UI logic 
    tags$body(
      div(id = "app"),
      tags$script(src = "www/index.js")
    )
  )
}
