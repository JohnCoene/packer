#' Show an alert
#' 
#' Show a vanilla JavaScript alert.
#' 
#' @param msg Message to display.
#' @param session A valid shiny `session`.
#'  
#' @export
show_alert <- function(msg, session = shiny::getDefaultReactiveDomain()){
  session$sendCustomMessage("#name#-alert", msg)
}
