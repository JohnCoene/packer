#' Dependencies
#' 
#' Include dependencies, place anywhere in the shiny UI.
#' 
#' @importFrom shiny singleton tags
#' 
#' @export
use#Name# <- function(){
  singleton(
    tags$head(
      tags$script(src = "#pkgname#-assets/#name#.js")
    )
  )
}

#' Show an alert
#' 
#' Show a vanilla JavaScript alert.
#' 
#' @param msg Message to display.
#' @param session A valid shiny `session`.
#'  
#' @examples 
#' library(shiny)
#' 
#' ui <- fluidPage(
#'   use_name(),
#'   verbatimTextOutput("response")
#' )
#' 
#' server <- function(input, output){
#' #name#("Please enter something:")
#'  output$response <- renderPrint({
#'    input$#name#Response
#'  })
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
#' @export
#name# <- function(msg, session = shiny::getDefaultReactiveDomain()){
  session$sendCustomMessage("#name#-alert", msg)
}
