#' Use Styles
#' 
#' Installs loaders, creates `srcjs/styles` directory containing a CSS file and prints required modifications to the `webpack.config.js` file.
#' 
#' @details The modifications to the `webpack.config.js` must be placed in the JSON under `module.exports`.
#' The created CSS file can then be imported much like any other JavaScript file.
#' 
#' @export
use_css <- function(){
  assert_that(has_scaffold())

  # install loaders
  npm_install("style-loader", "css-loader")

  # create styles dir
  create_directory("srcjs/styles")

  # create file
  file_path <- "srcjs/styles/style.css"
  if(!fs::file_exists(file_path))
    fs::file_create(file_path)
  
  msg <- sprintf("Created `%s` file and directory", file_path)
  cli::cli_alert_success(msg)

  # message modifications
  cli::cli_alert_warning("Add the following to the `webpack.config.js`")
  cli::cli_code(css_module_base)
  cli::cli_alert_info("See `?use_css` for more details")
}
