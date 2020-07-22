build <- function(mode =  c("production", "development", "none"), verbose = FALSE){
  stopif_no_npm_init()
  
  mode <- match.arg(mode)
  args <- sprintf("run %s", mode)
  npm_run(args, verbose)
}

watch <- function(){
  stopif_no_npm_init()
  npm_run("run watch")
}