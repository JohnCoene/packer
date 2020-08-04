#' HTML Plugin
#' 
#' Add the [html-webpack-plugin](https://webpack.js.org/plugins/html-webpack-plugin/) to 
#' the configuration to generate HTML with webpack, used in packer to generate the UI of 
#' a golem app with webpack.
#' 
#' @param use_pug Set to `TRUE` to use the [pug engine](https://pugjs.org/).
#' 
#' @export
add_plugin_html <- function(use_pug = FALSE){

  assert_that(is_golem())

  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  npm_install("html-webpack-plugin", scope = "dev")
  ext <- "html"

  # if pug install and change ext
  if(use_pug){
    npm_install("pug", scope = "dev")
    use_loader_pug()
    ext <- "pug"
  }

  # copy template
  template_in <- sprintf("templates/index.%s", ext)
  template_in <- pkg_file(template_in)
  template_out <- sprintf("srcjs/index.%s", ext)
  fs::file_copy(template_in, template_out)
  cli::cli_alert_success(sprintf("Created template `%s`", template_out))

  # read config
  config <- readLines("webpack.common.js")

  if(!any(grepl("require('html-webpack-plugin')", config)))
    config <- c("const HtmlWebpackPlugin = require('html-webpack-plugin');", config)

  plugin <- sprintf("var plugins = [\nnew HtmlWebpackPlugin({filename: '../index.html', template: 'srcjs/index.%s'}),", ext)

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  pkg_name <- get_pkg_name()
  cmd <- sprintf('system.file("app/index.html", package = "%s")', pkg_name)

  cli::cli_alert_info(sprintf('Use `shiny::htmlTemplate(%s)` as your shiny UI.', cmd))
}

#' Clean Plugin
#' 
#' Add the [clean-webpack-plugin](https://www.npmjs.com/package/clean-webpack-plugin) to 
#' clean the bundled files.
#' 
#' @param dry Whether to simulate the removal of files.
#' @param verbose Write Logs to the console.
#' @param clean Whether to automatically remove all unused webpack assets on rebuild.
#' @param protect Whether to not allow removal of current webpack assets.
#' 
#' @export
add_plugin_clean <- function(dry = FALSE, verbose = FALSE, clean = TRUE,
  protect = TRUE){

  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  npm_install("clean-webpack-plugin", scope = "dev")

  # options
  options <- list(dry = FALSE, verbose = FALSE, clean = TRUE, protect = TRUE)
  options_json <- jsonlite::toJSON(options, auto_unbox = TRUE)

  # read config
  config <- readLines("webpack.common.js")

  if(!any(grepl("require('clean-webpack-plugin')", config)))
    config <- c("const { CleanWebpackPlugin } = require('clean-webpack-plugin');", config)

  plugin <- sprintf("var plugins = [\nnew CleanWebpackPlugin(%s),", options_json)

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  cli::cli_alert_success("Added clean-webpack-plugin to configuration file")
}

#' Vue Loader Plugin
#' 
#' Add the `clean-webpack-plugin` to the config files.
#' 
#' @noRd
#' @keywords internal
add_plugin_vue <- function(){

  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  # npm_install("vue-loader", scope = "dev")

  # read config
  config <- readLines("webpack.common.js")

  if(!any(grepl("require('vue-loader/lib/plugin')", config)))
    config <- c("const VueLoaderPlugin = require('vue-loader/lib/plugin');", config)

  config[grepl("^var plugins = \\[", config)] <- "var plugins = [\nnew VueLoaderPlugin()"

  writeLines(config, "webpack.common.js")

}
