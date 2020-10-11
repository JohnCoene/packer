#' Mock up
#' 
#' Functions to mock up packages for tests
#' 
#' @param tmp A temp mock up project.
#' 
#' @name mockup
#' 
#' @export 
tmp_package <- function(){
  tmp <- tempdir()
  usethis::create_package(tmp)
  return(tmp)
}

#' @rdname mockup
#' @export 
tmp_golem <- function(){
  tmp <- tempdir()
  golem::create_golem(tmp)
  return(tmp)
}

#' @rdname mockup
#' @export 
tmp_project <- function(){
  tmp <- tempdir()
  usethis::create_project(tmp)
  return(tmp)
}

#' @rdname mockup
#' @export 
tmp_ambiorix <- function(){
  tmp <- tempdir()
  usethis::create_project(tmp)
  dir.create(sprintf("%s/templates", tmp))
  dir.create(sprintf("%s/assets", tmp))
  file.create(sprintf("%s/app.R", tmp))
  return(tmp)
}

#' @rdname mockup
#' @export 
tmp_delete <- function(tmp){
  unlink(tmp, recursive = TRUE, force = TRUE)
}

