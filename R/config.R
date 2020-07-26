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

  config_core_file(name)

  config_output_path(output_dir)

  config_entry_points(name, entry_dir)

  config_externals(externals)

  config_loaders()

}

#' @noRd 
#' @keywords internal
config_core_file <- function(name){
  if(fs::file_exists("webpack.config.js"))
    return()

  config <- pkg_file("common/webpack.config.js")
  fs::file_copy(config, "webpack.config.js")
}

#' @noRd 
#' @keywords internal
config_output_path <- function(output_dir){
  if(fs::file_exists("srcjs/config/output_path.json"))
    return()

  save_json(output_dir, "srcjs/config/output_path.json")  
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