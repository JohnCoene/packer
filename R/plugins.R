#' HTML Plugin
#' 
#' Add the [htmlWebpackPlugin](https://webpack.js.org/plugins/html-webpack-plugin/) to 
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
