golem_config <- function(){
  config <- pkg_file("golem/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
}

golem_files <- function(){
  base <- pkg_file("golem/srcjs")
  fs::dir_copy(base, SRC)
}

golem_edit <- function(edit = FALSE){
  path <- sprintf("%s/index.js", SRC)
  fs::file_show(path)
}