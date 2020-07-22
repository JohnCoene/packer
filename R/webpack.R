# create webpack config
widget_config <- function(name = "index.js"){
  template_path <- pkg_file("widget/webpack.config.js")
  template <- readLines(template_path)

  file_name <- sprintf("%s.js", name)

  template <- gsub("#FILE#", file_name, template)
  writeLines(template, WEBPACK_CONFIG)
}

# install webpack as dev dependency
webpack_install <- function(){
  npm_run("install --save-dev webpack webpack-cli")
}