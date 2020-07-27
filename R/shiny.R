#' HTML Plugin
#' 
#' @noRd
#' @keywords internal
plugin_html <- function(){

  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  npm_install("html-webpack-plugin", "html-webpack-externals-plugin", scope = "dev")

  config <- readLines("webpack.common.js")
  config <- c("const HtmlWebpackPlugin = require('html-webpack-plugin')\n")

  cli::cli_alert_success("Add the plugin to the `common.webpack.js` file")
  cli::cli_code("
    plugins: [
      new HtmlWebpackPlugin({
        title: 'My App',
        filename: 'inst/index.html'
      }),
      new HtmlWebpackExternalsPlugin({
        externals: [
          {
            module: 'jquery',
            entry: 'shared/jquery.js',
            global: 'jQuery',
          },
          {
            module: 'shiny',
            entry: 'shared/shiny.js',
            global: 'Shiny',
          },
        ],
      })
    ]")
}
