#' Use Styles
#' 
#' Installs loaders, creates `srcjs/styles` directory and prints required modifications to the `webpack.config.js` file.
#' 
#' @details The modifications to the `webpack.config.js` must be placed in the JSON under `module.exports`.
#' You can then place, for instance, create `srcjs/styles/style.css` and import it in `scrjs/index.js` with `import './styles/style.css';`.
#' 
#' @export
use_css <- function(){
  assert_that(has_scaffold())

  # install loaders
  npm_install("style-loader", "css-loader")

  # create styles dir
  create_directory("srcjs/styles")

  # create file
  file_path <- "srcjs/styles/styles.css"
  if(!fs::file_exists())
    fs::file_create(file_path)
  
  msg <- sprintf("Created `%s` file and directory", file_path)
  cli::cli_alert_success(msg)

  # message modifications
  cli::cli_alert_warning("Add the following to the `webpack.config.js`")
  cli::cli_code(css_module_base)
  cli::cli_alert_info("See `?use_css` for more details")
}
