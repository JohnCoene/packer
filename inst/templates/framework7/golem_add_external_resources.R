#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(title){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  # Optimized for mobile rendering and PWA
  tags$head(
    favicon(),
    tags$meta(charset = "utf-8"),
    tags$meta(
      name = "viewport",
      content = "width=device-width, initial-scale=1,
      maximum-scale=1, minimum-scale=1, user-scalable=no,
      viewport-fit=cover"
    ),
    tags$meta(
      name = "apple-mobile-web-app-capable",
      content = "yes"
    ),
    tags$meta(
      name = "theme-color",
      content = "#2196f3"
    ),
    tags$title(title)
  )
}
