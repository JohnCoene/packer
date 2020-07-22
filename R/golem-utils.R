golem_config <- function(){
  config <- pkg_file("golem/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
  cli::cli_alert_success("Created webpack config file")
}

golem_files <- function(){
  base <- pkg_file("golem/srcjs")
  fs::dir_copy(base, SRC)
  cli::cli_alert_success("Created `srcjs`")
}

golem_edit <- function(edit = FALSE){
  path <- sprintf("%s/index.js", SRC)
  fs::file_show(path)
}