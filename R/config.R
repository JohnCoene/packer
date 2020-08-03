#' Handles all webpack configuration
#' 
#' @param name Name of widget
#' @param entry_dir Directory of entrypoint.
#' @param output_dir Output directory.
#' @param externals External libraries to import.
#' 
#' @noRd 
#' @keywords internal
configure <- function(name, entry_dir, output_dir = "./inst/packer", externals = list(shiny = "Shiny")){

  create_directory("srcjs/config")

  # webpack configs
  common <- config_common_file()
  dev <- config_dev_file()
  prod <- config_prod_file()
  if(all(common, dev, prod))
    cli::cli_alert_success("Created webpack config files")

  config_output_path(output_dir)

  config_entry_points(name, entry_dir)

  config_externals(externals)

  config_misc()

  config_loaders()

}

#' @noRd 
#' @keywords internal
config_common_file <- function(){
  if(fs::file_exists("webpack.common.js"))
    return(FALSE)

  config <- pkg_file("common/webpack.common.js")
  fs::file_copy(config, "webpack.common.js")
  return(TRUE)
}

#' @noRd 
#' @keywords internal
config_dev_file <- function(){
  if(fs::file_exists("webpack.dev.js"))
    return(FALSE)

  config <- pkg_file("common/webpack.dev.js")
  fs::file_copy(config, "webpack.dev.js")
  return(TRUE)
}

#' @noRd 
#' @keywords internal
config_prod_file <- function(){
  if(fs::file_exists("webpack.prod.js"))
    return(FALSE)

  config <- pkg_file("common/webpack.prod.js")
  fs::file_copy(config, "webpack.prod.js")
  return(TRUE)
}

#' @noRd 
#' @keywords internal
config_output_path <- function(output_dir){
  if(fs::file_exists("srcjs/config/output_path.json"))
    return()

  # if the user is building a golem app override the output_dir
  if(is_golem() && output_dir != "./inst/app/www")
    output_dir <- "./inst/app/www"

  save_json(output_dir, "srcjs/config/output_path.json")  
}

#' @noRd 
#' @keywords internal
config_misc <- function(){
  if(fs::file_exists("srcjs/config/misc.json"))
    return()

  misc <- list()

  save_json(misc, "srcjs/config/misc.json")  
}

#' @noRd 
#' @keywords internal
config_externals <- function(externals = list(shiny = "Shiny")){

  if(fs::file_exists("srcjs/config/externals.json")){
    existing <- jsonlite::read_json("srcjs/config/externals.json")
    
    # remove duplicate externals
    nms <- names(existing)
    externals <- externals[!names(externals) %in% nms]

    externals <- append(existing, externals)
  }

  save_json(externals, "srcjs/config/externals.json")
}

#' @noRd 
#' @keywords internal
config_entry_points <- function(name, entry_dir){

  entry_point_path <- sprintf("./srcjs/%s%s.js", entry_dir, name)
  entry_point <- list(entry_point_path)
  names(entry_point) <- name

  if(fs::file_exists("srcjs/config/entry_points.json")){
    json <- jsonlite::read_json("srcjs/config/entry_points.json")
    entry_point <- append(json, entry_point)
  }

  save_json(entry_point, "srcjs/config/entry_points.json")

}

#' @noRd 
#' @keywords internal
config_loaders <- function(){

  if(fs::file_exists("srcjs/config/loaders.json"))
    return()

  save_json(list(), "srcjs/config/loaders.json")
}