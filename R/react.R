#' Apply React
#' 
#' Apply React to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, updates, or replaces the `srcjs/index.js` file.
#' 
#' @param use_cdn Whether to use the CDN for `react` and `react-dom` (recommended). 
#' This means later importing the dependencies in the shiny UI using `reactCDN()`,
#' this function will be created in a `R/react_cdn.R`.
#' The correct instructions to do so are printed to the console by the function.
#' 
#' @details After running this function and bundling the JavaScript remember to place
#' the code printed by the function in shiny UI. By default [apply_react()] does not
#' bundle `react` and `react-dom` and thus requires using `reactCDN()` to import the
#' dependencies in the shiny application: this function is created in a `R/react_cdn.R`.
#' 
#' @export 
apply_react <- function(use_cdn = TRUE){
  assert_that(has_no_babel())

  # install deps
  cli::cli_h2("React loader & dependencies")
  use_loader_babel()
  react_scope <- ifelse(use_cdn, "dev", "prod")
  npm_install("react", "react-dom", scope = react_scope)
  npm_install("@babel/core", "@babel/preset-env", "@babel/preset-react", scope = "dev")
  react_cdn_function(use_cdn)

  cli::cli_h2("Babel config file")
  babel_config("templates/react/_babelrc")
  cat("\n")

  # template
  path <- pkg_file("templates/react/react.js")
  template <- c("// Added by apply_react", "", readLines(path))
  imports <- c("// Added by apply_react", "", "import React from 'react';", "import ReactDOM from 'react-dom';")
  index_path <- "srcjs/index.js"

  # default index
  index <- c(imports, template)
  
  # create or update
  if(fs::file_exists(index_path)){

    # if index.js = default golem replace
    current <- readLines(index_path)
    golem_index <- readLines(pkg_file("golem/javascript/index.js"))

    # otherwise update
    if(!identical(current, golem_index)){
      index <- c(imports, current, template)
      cli::cli_alert_success("Updated {.file srcjs/index.js} with react template")
    } else {
      cli::cli_alert_success("Replaced {.file srcjs/index.js} with react template")
    }

  } else {
    cli::cli_alert_success("Created template {.file srcjs/index.js}")
  }

  writeLines(index, "srcjs/index.js")

  cli::cli_alert_warning("Place the following at in your shiny ui:")
  react_ui_code(use_cdn)
}

#' Dependencies for React
#' 
#' Includes dependencies in a shiny application.
#' 
#' @param version Version of React to use, if `NULL` uses the latest
#' 
#' @noRd
#' @keywords internal
react_ui_code <- function(use_cdn = TRUE){
  cdn <- ""
  if(use_cdn)
    cdn <- "reactCDN(),\n  "

  code <- sprintf('tagList(\n  %sdiv(id = "app"),\n  tags$script(src = "www/index.js")\n)', cdn)

  cli::cli_code(code)
}

#' Creates Dependency File and Function
#' 
#' Creates `R/react_cdn.R` containing `ReactCDN` function if
#' `use_cdn` is `TRUE`.
#' 
#' @inheritParams apply_react
#' 
#' @noRd
#' @keywords internal
react_cdn_function <- function(use_cdn = TRUE){
  if(!use_cdn)
    return()

  exists <- fs::file_exists("R/react_cdn.R")

  if(exists){
    cli::cli_alert_danger("{.file R/react_cdn.R} already exists")
    return()
  }

  cli::cli_alert_success("Created {.file R/react_cdn.R} containing {.fn reactCDN} function")
  template <- pkg_file("templates/react/react_cdn.R")
  fs::file_copy(template, "R/react_cdn.R")
}
