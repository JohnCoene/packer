#' Apply Vue
#' 
#' Apply Vue to a project, adds the relevant (babel) loader, installs dependencies, 
#' and creates, or updates, or replaces the `srcjs/index.js` file.
#' 
#' @param replace_index Whether to replace the `srcjs/index.js` file.
#' 
#' @details After running this function and bundling the JavaScript remember to place
#' `div(id = "app"), tags$script(src = "www/index.js")` at the bottom of your shiny UI.
#' 
#' @examples 
#' \dontrun{
#' golem::create_golem("useVue")
#' packer::scaffold_golem(vue = TRUE)
#' }
#' 
#' @export 
apply_vue <- function(replace_index = FALSE){
  assert_that(has_no_babel())
  assert_that(!fs::file_exists("srcjs/index.js"), msg = "`srcjs/index.js` already exists, delete or rename it")

  # loader
  # Vue loader comes with plugin
  cli::cli_h2("Vue loader")
  use_loader_babel()
  use_loader_vue()
  use_loader_vue_style()
  add_plugin_vue()

  # resolve vue compiler
  # DOES NOT WORK AS STANDALONE JSON
  #resolve: {
  #  alias: {
  #    'vue$': 'vue/dist/vue.esm.js'
  #  }
  #}

  cli::cli_h2("Babel config file")
  path <- pkg_file("templates/_babelrc_vue")
  fs::file_copy(path, ".babelrc")
  cli::cli_alert_success("Created `.babelrc`")
  usethis::use_build_ignore(".babelrc")
  cat("\n")

  # template
  cli::cli_h2("Template files")
  index <- pkg_file("templates/vue.js")
  home <- pkg_file("templates/vue.vue")

  fs::file_copy(index, "srcjs/index.js")
  fs::file_copy(home, "srcjs/Home.vue")
  cli::cli_alert_success("Added `srcjs/Home.vue` template")

  cli::cli_alert_warning("Place the following at the bottom of your shiny ui:")
  cli::cli_code('div(id = "app"), tags$script(src="www/index.js")')
}