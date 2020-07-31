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
  loader_msg()
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
  loader_msg()
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
  loader_msg()
}

#' Use babel Loader
#' 
#' Adds the loader for babel comiler to loader configuration file.
#' 
#' @details Excludes `node_modules` by default.
#' 
#' @export 
use_loader_babel <- function(){
  assert_that(has_scaffold())

  npm_install("@babel/core", "@babel/preset-env", "@babel/preset-react", "babel-loader", scope = "dev")

  # message modifications
  loader <- list(
    test = "\\.(js|jsx)$",
    exclude = "/node_modules/",
    use = list("babel-loader")
  )
  loader_add(loader)
  
  # wrap up
  loader_msg()
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

loader_msg <- function(){
  cli::cli_alert_success("Added bundling rule\n")
}