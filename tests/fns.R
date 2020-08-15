create_tmp_package <- function(){
  tmp <- tempdir()
  usethis::create_package(tmp)
  return(tmp)
}

delete_tmp_package <- function(tmp){
  unlink(tmp, recursive = TRUE, force = TRUE)
}

create_tmp_golem <- function(){
  tmp <- tempdir()
  golem::create_golem(tmp)
  return(tmp)
}

create_tmp_project <- function(){
  tmp <- tempdir()
  usethis::create_project(tmp)
  return(tmp)
}

