#' HTML Plugin
#'
#' Add the [html-webpack-plugin](https://webpack.js.org/plugins/html-webpack-plugin/) to
#' the configuration to generate HTML with webpack, used in packer to generate the UI of
#' a golem app with webpack.
#'
#' @param use_pug Set to `TRUE` to use the [pug engine](https://pugjs.org/).
#' @param output_path Path to the generated html file, defaults to `../index.html` as
#' is ideal for golem. Note that this path is relative to your output directory specified
#' in your `webpack.common.js` file.
#'
#' @export
add_plugin_html <- function(use_pug = FALSE, output_path = "../index.html") {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  engine_install("html-webpack-plugin", scope = "dev")
  ext <- "html"

  # if pug install and change ext
  if (use_pug) {
    engine_install("pug", scope = "dev")
    use_loader_pug()
    ext <- "pug"
  }

  # copy template
  template_in <- sprintf("templates/index.%s", ext)
  template_in <- pkg_file(template_in)
  template_out <- sprintf("srcjs/index.%s", ext)
  fs::file_copy(template_in, template_out)
  cli::cli_alert_success("Created template {.file { template_out }}")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('html-webpack-plugin')", config))) {
    config <- c("const HtmlWebpackPlugin = require('html-webpack-plugin');", config)
  }

  plugin <- sprintf("var plugins = [\n  new HtmlWebpackPlugin({filename: '%s', template: 'srcjs/index.%s'}),", output_path, ext)

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  pkg_name <- get_pkg_name()
  cmd <- sprintf('system.file("app/index.html", package = "%s")', pkg_name)

  if (is_golem()) {
    cli::cli_alert_info("Use {.code shiny::htmlTemplate({ cmd })} as your shiny UI")
  }
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
add_plugin_clean <- function(
    dry = FALSE, verbose = FALSE, clean = TRUE,
    protect = TRUE) {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  engine_install("clean-webpack-plugin", scope = "dev")

  # options
  options <- list(dry = FALSE, verbose = FALSE, clean = TRUE, protect = TRUE)
  options_json <- jsonlite::toJSON(options, auto_unbox = TRUE)

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('clean-webpack-plugin')", config))) {
    config <- c("const CleanWebpackPlugin = require('clean-webpack-plugin');", config)
  }

  plugin <- sprintf("var plugins = [\n  new CleanWebpackPlugin(%s),", options_json)

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  cli::cli_alert_success("Added {.val clean-webpack-plugin} to configuration file")
}

#' Vue Loader Plugin
#'
#' Add the `clean-webpack-plugin` to the config files.
#'
#' @noRd
#' @keywords internal
add_plugin_vue <- function() {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('vue-loader/lib/plugin')", config))) {
    config <- c("const VueLoaderPlugin = require('vue-loader/lib/plugin');", config)
  }

  config[grepl("^var plugins = \\[", config)] <- "var plugins = [\nnew VueLoaderPlugin(),"

  writeLines(config, "webpack.common.js")
}

#' Prettier Plugin
#'
#' Add the [prettier-webpack-plugin](https://www.npmjs.com/package/prettier-webpack-plugin) to
#' prettify the pre-bundled files.
#'
#' @export
add_plugin_prettier <- function() {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  engine_install("prettier", "prettier-webpack-plugin", scope = "dev")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('prettier-webpack-plugin')", config))) {
    config <- c("const PrettierPlugin = require('prettier-webpack-plugin');", config)
  }

  plugin <- "var plugins = [\n  new PrettierPlugin(),"

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  cli::cli_alert_success("Added {.val prettier-webpack-plugin} to configuration file")
}

#' ESLint Plugin
#'
#' Add the [eslint-webpack-plugin](https://www.npmjs.com/package/eslint-webpack-plugin)
#' run ESLint on files.
#'
#' @export
add_plugin_eslint <- function() {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # install base
  engine_install("eslint", "eslint-webpack-plugin", scope = "dev")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('eslint-webpack-plugin')", config))) {
    config <- c("const ESLintPlugin = require('eslint-webpack-plugin');", config)
  }

  plugin <- "var plugins = [\nnew ESLintPlugin(),"

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  if (!fs::file_exists(".eslintrc")) {
    opts <- list(
      parserOptions = list(
        sourceType = "module"
      ),
      env = list(
        es6 = TRUE
      )
    )
    jsonlite::write_json(opts, ".eslintrc", auto_unbox = TRUE, pretty = TRUE)
    cli::cli_alert_success("Added {.val .eslintrc} to root")
    usethis::use_build_ignore(".eslintrc")
    usethis::use_git_ignore(".eslintrc")
  }

  cli::cli_alert_success("Added {.val eslint-webpack-plugin} to configuration file")
}

#' Progressive Web Applications
#'
#' Add the `workbox-webpack-plugin` to the config files.
#'
#' @export
add_plugin_workbox <- function() {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('workbox-webpack-plugin')", config))) {
    config <- c("const WorkboxPlugin = require('workbox-webpack-plugin');", config)
  }

  config[grepl("^var plugins = \\[", config)] <- "var plugins = [\nnew WorkboxPlugin.GenerateSW({clientsClaim: true, skipWaiting: true,}),"

  writeLines(config, "webpack.common.js")
  engine_install("eslint", "workbox-webpack-plugin", scope = "dev")

  cli::cli_alert_info("Add the following to your JavaScript (e.g.: {.file index.js})")
  cat(
    "
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', () => {
        navigator.serviceWorker.register('/www/service-worker.js').then(registration => {
          console.log('SW registered: ', registration);
        }).catch(registrationError => {
          console.log('SW registration failed: ', registrationError);
        });
      });
    }\n"
  )
}

#' Add Plugin jsdoc
#'
#' Add the [jsdoc](https://github.com/jsdoc/jsdoc)
#' plugin to generate documentation from JavaScript code
#' with tags similar to roxygen2.
#'
#' @param name Name of tutorial
#' @param edit Whether to open relevent file.
#'
#' @name jsdoc
#'
#' @export
add_plugin_jsdoc <- function(edit = interactive()) {
  assert_that(fs::file_exists("webpack.common.js"), msg = "Cannot find config file")
  assert_that(!fs::file_exists("jsdoc.conf.json"), msg = "Cannot find config file")

  # install base
  engine_install("jsdoc", "jsdoc-webpack-plugin", scope = "dev")

  # read config
  config <- readLines("webpack.common.js")

  if (!any(grepl("require('jsdoc-webpack-plugin')", config))) {
    config <- c("const JsDocPlugin = require('jsdoc-webpack-plugin');", config)
  }

  plugin <- "var plugins = [\n  new JsDocPlugin({conf: 'jsdoc.conf.json', cwd: '.', preserveTmpFile: false, recursive: true}),"

  config[grepl("^var plugins = \\[", config)] <- plugin

  writeLines(config, "webpack.common.js")

  cli::cli_alert_success("Added {.val jsdoc-webpack-plugin} to configuration file")

  # handle config file
  config_name <- "jsdoc.conf.json"
  cli::cli_alert_info("Created {.file {config_name}}")
  template <- pkg_file("jsdoc/conf.json")
  fs::file_copy(template, config_name)
  usethis::use_build_ignore(config_name)

  # output
  cli::cli_alert_info("Docs will be placed in {.file jsdoc}")
  usethis::use_build_ignore("jsdoc/")

  # tutorials
  cli::cli_alert_info("Created {.file tutorials}")
  fs::dir_create("tutorials")
  fs::file_create("tutorials/.gitkeep")
  usethis::use_build_ignore("tutorials/")

  if (edit) {
    fs::file_show(config_name)
  }
}

#' @rdname jsdoc
#' @export
add_jsdoc_tutorial <- function(name, edit = interactive()) {
  if (missing(name)) {
    stop("Missing `name`", call. = FALSE)
  }

  if (!fs::file_exists("jsdoc.conf.json")) {
    cli::cli_alert_warning("Missing ${.file jsdoc.conf.json}, run {.fn add_plugin_jsdoc}")
  }

  fl <- sprintf("tutorials/%s.markdown", name)

  writeLines(
    sprintf("# %s\n", tools::toTitleCase(name)),
    con = fl
  )

  if (edit) {
    fs::file_show(fl)
  }
}
