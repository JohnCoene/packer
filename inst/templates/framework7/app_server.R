#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  observeEvent(input$slider_value, {
    message(sprintf("Slider value: %s", input$slider_value))
  })
}
