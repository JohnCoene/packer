#' #Name#
#' 
#' The poor man's `shiny::renderUI`
#' 
#' @param html HTML to display ([htmltools::tags]).
#' @param color Color of output.
#' 
#' @examples 
#' library(shiny)
#' 
#' ui <- fluidPage(
#'  #name#Output("id")
#' )
#' 
#' server <- function(input, output){
#'  output$id <- render#Name#({
#'    #name#(h2("Hello"))
#'  })
#' }
#' 
#' if(interactive())
#'  shinyApp(ui, server)
#' 
#' @export
#name# <- function(html = shiny::h2("Custom output"), color = "red"){
  list(html = as.character(html), color = color)
}

#' @export
render#Name# <- function(expr, env = parent.frame(), quoted = FALSE) {
  # Convert the expression + environment into a function
  func <- shiny::exprToFunction(expr, env, quoted)

  function(){
    func()
  }
}

#' @export
#name#Output <- function(id){

  # element
  el <- shiny::tags$div(id = id, class = "#name#")

  # dependency
  path <- system.file("packer", package = "#pkgname#")

  deps <- list(
    htmltools::htmlDependency(
      name = "#name#",
      version = "1.0.0",
      src = c(file = path),
      script = "#name#.js"
    )
  )

  # wrap together
  htmltools::attachDependencies(el, deps)
}
