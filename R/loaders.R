#' Use Styles
#' 
#' Installs loaders and adds relevant configuration rules to `srcjs/config/loaders.json`.
#' 
#' @details This will let you import styles much like any other modules, e.g.: `import './styles.css'`.
#' 
#' @section Packages:
#' 
#' * [use_loader_css()] - installs `style-loader` and `css-loader` packages as dev.
#' * [use_loader_sass()] - installs `style-loader`, `css-loader`, `sass-loader`, and `sass` as dev.
#' 
#' @name style_loaders
#' @export
use_loader_css <- function(){
  assert_that(has_scaffold())

  # install loaders
  npm_install("style-loader", "css-loader", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.css$",
    use = list("style-loader", "css-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("css-loader & style-loader")
  cli::cli_alert_info("Create `srcjs/styles/styles.css` and import with `import '../styles/styles.css'`")
}

#' @rdname style_loaders
#' @export
use_loader_sass <- function(){
  assert_that(has_scaffold())

  npm_install("style-loader", "css-loader", "sass-loader", "sass", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.s[ac]ss$/i",
    use = list("style-loader", "css-loader", "sass-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("sass-loader")
  cli::cli_alert_info("Create `srcjs/styles/styles.scss` and import with `import '../styles/styles.scss'`")
}

#' Use Pug Loader
#' 
#' Adds the loader for the pug templating engine.
#' 
#' @export 
use_loader_pug <- function(){
  assert_that(has_scaffold())

  npm_install("pug", "pug-loader", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.pug$",
    use = list("pug-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("pug-loader")
}

#' Use babel Loader
#' 
#' Adds the loader for babel comiler to the loader configuration file.
#' 
#' @details Excludes `node_modules` by default.
#' 
#' @export 
use_loader_babel <- function(){
  assert_that(has_scaffold())

  npm_install("@babel/core", "babel-loader", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.(js|jsx)$",
    exclude = "/node_modules/",
    use = list("babel-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("babel-loader")
}

#' Use Vue Loader
#' 
#' Adds the Vue loader to the loader configuration file.
#' 
#' @details Every time a new version of Vue is released, a corresponding version of `vue-template-compiler` 
#' is released together. The compiler's version must be in sync with the base Vue package so that `vue-loader`
#' produces code that is compatible with the runtime. This means every time you upgrade Vue in your project, 
#' you should upgrade `vue-template-compiler` to match it as well.
#' 
#' @export 
use_loader_vue <- function(){
  assert_that(has_scaffold())

  npm_install("vue", "vue-loader", "vue-template-compiler", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.vue$",
    use = list("vue-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("vue-loader")
}

#' Use Vue Style Loader
#' 
#' Similar to [use_loader_css()], dynamically inject CSS into the document as style tags.
#' 
#' @export 
use_loader_vue_style <- function(){
  assert_that(has_scaffold())

  npm_install("vue-style-loader", "css-loader", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.css$",
    use = list("vue-style-loader", "css-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg("vue-style-loader & css-loader")
}

#' Add loader to config file
#' 
#' Check if module rule already exists before adding rule.
#' 
#' @param loader `list` defining the loader rules.
#' 
#' @noRd 
#' @keywords internal
loader_add <- function(loader){
  json_path <- "srcjs/config/loaders.json"

  assert_that(fs::file_exists(json_path), msg = "Cannot find loader config file")

  loaders <- jsonlite::read_json(json_path)

  tests <- sapply(loaders, function(x){
    x$test
  })
  tests <- unlist(tests)

  if(loader$test %in% tests){
    cli::cli_alert_warning("Module rule for loader already exists in `config/loaders.json`")
    return(invisible(FALSE))
  }

  loaders <- append(loaders, list(loader))
  save_json(loaders, json_path)
}

loader_msg <- function(loader){
  msg <- sprintf("Added bundling rule for %s\n", loader)
  cli::cli_alert_success(msg)
}