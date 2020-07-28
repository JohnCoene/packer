#' HTML Plugin
#' 
#' Add the [htmlWebpackPlugin](https://webpack.js.org/plugins/html-webpack-plugin/) to 
#' the configuration to generate HTML with webpack.
#' 
#' @param use_pug Set to `TRUE` to use the [pug engine](https://pugjs.org/).
#' 
#' @export
add_plugin_html <- function(use_pug = FALSE){

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

  plugin <- sprintf("
var plugins = [
  new HtmlWebpackPlugin({
    filename: 'index.html',
    template: 'srcjs/index.%s'
  }),", ext)

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  # output path
  output_path <- jsonlite::read_json("srcjs/config/output_path.json")

  cli::cli_alert_info(sprintf('Use `shiny::htmlTemplate("%s/index.%s")` as your UI.', output_path, ext))
}
