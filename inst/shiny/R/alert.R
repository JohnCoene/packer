#' Show an alert
#' 
#' Show a vanilla JavaScript alert.
#' 
#' @param msg Message to display.
#' @param session A valid shiny `session`.
#'  
#' @examples 
#' library(shiny)
#' library(#name#)
#' 
#' ui <- fluidPage(
#'   use_deps(),
#'   actionButton('show', 'show an alert')
#' )
#' 
#' server <- function(input, output){
#'  observeEvent(input$show, {
#'    show_alert('Hello packer!')
#'  })
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
#' @export
show_alert <- function(msg, session = shiny::getDefaultReactiveDomain()){
  session$sendCustomMessage("#name#-alert", msg)
}
