# create webpack config
webpack_create_config <- function(name){
  template_path <- system.file("webpack/_webpack.config.js", package = "packer")
  template <- readLines(template_path)

  file_name <- sprintf("%s.js", name)

  template <- gsub("#FILE#", file_name, template)
  writeLines(template, WEBPACK_CONFIG)
}

# install webpack as dev dependency
webpack_install <- function(verbose = TRUE){
  npm_run("install --save-dev webpack webpack-cli", verbose)
}