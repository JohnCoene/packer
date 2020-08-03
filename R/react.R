#' Apply React
#' 
#' Apply React to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, or updates, or replaces the `srcjs/index.js` file.
#' 
#' @param use_cdn Whether to use the CDN for `react` and `react-dom` (recommended). 
#' This means later importing the dependencies in the shiny UI using `reactCDN()`,
#' this function will be created in a `R/react_cdn.R`.
#' The correct instructions are printed to the console by the application.
#' 
#' @details After running this function and bundling the JavaScript remember to place
#' the code printed by the function in shiny UI. By default [apply_react()] does not
#' bundle `react` and `react-dom` and thus requires using `reactCDN()` to import the
#' dependencies in the shiny application: this function is created in a `R/react_cdn.R`.
#' 
#' @examples 
#' \dontrun{
#' golem::create_golem("reaction")
#' packer::scaffold_golem(react = TRUE)
#' }
#' 
#' @export 
apply_react <- function(use_cdn = TRUE){
  assert_that(has_no_babel())

  # install deps
  cli::cli_h2("React loader & dependencies")
  use_loader_babel()
  react_scope <- ifelse(use_cdn, "dev", "prod")
  npm_install("react", "react-dom", scope = react_scope)
  npm_install("@babel/preset-env", "@babel/preset-react", scope = "dev")
  react_cdn_function(use_cdn)

  cli::cli_h2("Babel config file")
  react_babel_config()
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
      cli::cli_alert_success("Updated `srcjs/index.js` with react template")
    } else {
      cli::cli_alert_success("Replaced `srcjs/index.js` with react template")
    }

  } else {
    cli::cli_alert_success("Created template `srcjs/index.js`")
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
react_ui_code <- function(use_cdn){
  cdn <- ""
  if(use_cdn)
    cdn <- "reactCDN(),\n\t"

  code <- sprintf('tagList(\n\t%sdiv(id = "app"),\n\ttags$script(src = "www/index.js")\n)', cdn)

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
    cli::cli_alert_danger("`R/react_cdn.R` already exists")
    return()
  }

  cli::cli_alert_success("Created `R/react_cdn.R` containing `reactCDN()` function")
  template <- pkg_file("templates/react/react_cdn.R")
  fs::file_copy(template, "R/react_cdn.R")
}

#' Creates React babel config
#' 
#' @noRd
#' @keywords internal
react_babel_config <- function(){

  if(fs::file_exists(".babelrc")){
    cli::cli_alert_warning("`.babelrc` file already exists, add the following")
    print_react_babel_config()
    return()
  }

  path <- pkg_file("templates/react/_babelrc")
  fs::file_copy(path, ".babelrc")
  cli::cli_alert_success("Created `.babelrc`")
  usethis::use_build_ignore(".babelrc")
}

#' @noRd
#' @keywords internal
print_react_babel_config <- function(){
  path <- pkg_file("templates/react/_babelrc")
  content <- readLines(path)
  cli::cli_code(content)
}