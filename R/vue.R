#' Apply Vue
#' 
#' Apply Vue to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, or updates, or replaces the `srcjs/index.js` file.
#' 
#' @param use_cdn Whether to use the CDN for `vue` (recommended). 
#' This means later importing the dependencies in the shiny UI using `vueCDN()`,
#' this function will be created in a `R/vue_cdn.R`.
#' The correct instructions are printed to the console by the application.
#' 
#' @details After running this function and bundling the JavaScript remember to place
#' `div(id = "app"), tags$script(src = "www/index.js")` at the bottom of your shiny UI.
#' 
#' @export 
apply_vue <- function(use_cdn = TRUE){
  assert_that(has_no_babel())
  assert_that(!fs::file_exists("srcjs/index.js"), msg = "`srcjs/index.js` already exists, delete or rename it")

  # loader
  # Vue loader comes with plugin
  cli::cli_h2("Vue loader, plugin & dependency")
  vue_scope <- ifelse(use_cdn, "dev", "prod")
  use_loader_babel()
  npm_install("@babel/core", "@babel/preset-env", scope = "dev")
  npm_install("vue", scope = vue_scope)
  use_loader_vue()
  use_loader_css()
  add_plugin_vue()
  vue_cdn_function(use_cdn)
  vue_alias()

  # resolve vue compiler
  # DOES NOT WORK AS STANDALONE JSON
  #resolve: {
  #  alias: {
  #    'vue$': 'vue/dist/vue.esm.js'
  #  }
  #}

  cli::cli_h2("Babel config file")
  babel_config("templates/vue/_babelrc")

  # template
  cli::cli_h2("Template files")
  index <- pkg_file("templates/vue/vue.js")
  home <- pkg_file("templates/vue/vue.vue")

  fs::file_copy(index, "srcjs/index.js")
  fs::file_copy(home, "srcjs/Home.vue")
  cli::cli_alert_success("Added {.file srcjs/Home.vue} template")

  # only print if project is golem app
  # otherwise Rmarkdown = no need
  if(is_golem()){
    cli::cli_alert_warning("Place the following in your shiny ui:")
    vue_ui_code_golem()
  }

  if(is_ambiorix()){
    cli::cli_alert_warning("Remember the following")
    cli::cli_ol()
    cli::cli_li("Import vue")
    vue_ui_code_ambiorix()
    cli::cli_li("Source the bundle in the template")
    cli::cli_code('<script src="static/index.js"></script>')
    cli::cli_li("Create app root in the template")
    cli::cli_code('<div id="app"></div>')
  }
}

#' Dependencies for Vue in Golem
#' 
#' Includes dependencies in a shiny application.
#' 
#' @param use_cdn Whether it uses the CDN.
#' 
#' @noRd
#' @keywords internal
vue_ui_code_golem <- function(use_cdn = TRUE){
  cdn <- ""
  if(use_cdn)
    cdn <- "vueCDN(),\n  "

  code <- sprintf('tagList(\n  %sdiv(id = "app"),\n  tags$script(src = "www/index.js")\n)', cdn)

  cli::cli_code(code)
}

#' Dependencies for Vue in Ambiorix
#' 
#' Includes dependencies in a shiny application.
#' 
#' @param use_cdn Whether it uses the CDN.
#' 
#' @noRd
#' @keywords internal
vue_ui_code_ambiorix <- function(use_cdn = TRUE){
  
  if(use_cdn){
    cli::cli_code('<script src="https://cdn.jsdelivr.net/npm/vue"></script>')
  } else {
    cli::cli_code("import Vue from 'vue'")
  }

  invisible()
  
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
vue_cdn_function <- function(use_cdn = TRUE){
  if(!use_cdn)
    return()

  if(is_ambiorix())
    return()

  exists <- fs::file_exists("R/vue_cdn.R")

  if(exists){
    cli::cli_alert_danger("{.file R/vue_cdn.R} already exists")
    return()
  }

  cli::cli_alert_success("Created {.file R/vue_cdn.R} containing {.fn vueCDN} function")
  template <- pkg_file("templates/vue/vue_cdn.R")
  fs::file_copy(template, "R/vue_cdn.R")
}

#' Resolve Alias
#' 
#' @noRd
#' @keywords internal
vue_alias <- function(){
  misc <- jsonlite::read_json("srcjs/config/misc.json")
  vue <- list(vue = "vue/dist/vue.esm.js")
  misc$resolve$alias <- append(misc$resolve$alias, vue)
  save_json(misc, "srcjs/config/misc.json")
  cli::cli_alert_success("Added alias to {.file srcjs/config/misc.json}")
}