create_tmp_package <- function(){
  tmp <- tempdir()
  # make sure it's empty
  files <- list.files(tmp)
  sapply(files, empty, dir = tmp)
  usethis::create_package(tmp)
  return(tmp)
}

empty <- function(file, dir = tmp){
  path <- file.path(dir, file)
  unlink(file, recursive = TRUE, force = TRUE)
}

delete_tmp_package <- function(tmp){
  unlink(tmp, recursive = TRUE, force = TRUE)
}

create_tmp_golem <- function(){
  tmp <- tempdir()
  golem::create_golem(tmp, open = FALSE)
  return(tmp)
}

create_tmp_project <- function(){
  tmp <- tempdir()
  usethis::create_project(tmp)
  return(tmp)
}

create_tmp_ambiorix <- function(){
  tmp <- tempdir()
  usethis::create_project(tmp)
  dir.create(sprintf("%s/templates", tmp))
  dir.create(sprintf("%s/assets", tmp))
  file.create(sprintf("%s/app.R", tmp))
  return(tmp)
}

