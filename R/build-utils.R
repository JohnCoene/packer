build <- function(mode =  c("production", "development", "none"), verbose = FALSE){
  assert_that(has_scaffold())
  
  mode <- match.arg(mode)
  args <- sprintf("run %s", mode)
  npm_run(args, verbose)
}

watch <- function(){
  assert_that(has_scaffold())
  npm_run("run watch")
}