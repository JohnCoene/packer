#' Use Styles
#' 
#' Installs loaders and prints required modifications to the `webpack.config.js` file.
#' 
#' @details The modifications to the `webpack.config.js` must be placed in the JSON under `module.exports`.
#' You can then place, for instance, create `srcjs/style.css` and import it in `scrjs/index.js` with `import './style.css';`.
#' 
#' @export
use_css <- function(){
  assert_that(has_scaffold())

  npm_install("style-loader", "css-loader")

  cli::cli_alert_warning("Add the following to the `webpack.config.js`")
  cli::cli_code(css_module_base)
  cli::cli_alert_info("See `?use_css` for more details")
}
