#' Button
#' 
#' Incremental button.
#' 
#' @param inputId Id of input.
#' @param value Initial value.
#' 
#' @examples 
#' library(shiny)
#' 
#' ui <- fluidPage(
#'  btn_input("theId", 0)
#' )
#' 
#' server <- function(input, output){
#' 
#'  observeEvent(input$theId, {
#'    print(input$theId)
#'  })
#' 
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
#' @export 
btn_input <- function(inputId, value = 0){

  stopifnot(!missing(inputId))
  stopifnot(is.numeric(value))

  dep <- htmltools::htmlDependency(
    name = "#name#Binding",
    version = "1.0.0",
    src = c(file = system.file("packer", package = "#pkgname#")),
    script = "index.js"
  )

  tagList(
    dep,
    tags$button(
      id = inputId,
      class = "#name#Binding btn btn-default",
      type = "button",
      value
    )
  )
}
