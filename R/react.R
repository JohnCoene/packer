#' Apply React
#' 
#' Apply React to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, or updates, or replaces the `srcjs/index.js` file.
#' 
#' @export 
apply_react <- function(){
  assert_that(has_no_babel())

  # install deps
  cli::cli_h2("React loader")
  use_loader_babel()
  npm_install("react", "react-dom", scope = "prod")

  cli::cli_h2("Babel config file")
  path <- pkg_file("templates/_babelrc")
  fs::file_copy(path, ".babelrc")
  cli::cli_alert_success("Created `.babelrc`")
  usethis::use_build_ignore(".babelrc")
  cat("\n")

  # template
  path <- pkg_file("templates/react.js")
  template <- readLines(path)
  imports <- c("import React from 'react';", "import ReactDOM from 'react-dom';")
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

  cli::cli_alert_warning("Place the following at the bottom of your shiny ui:")
  cli::cli_code('div(id = "app"), tags$script(src = "www/index.js")')
}