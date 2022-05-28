#' NPX
#' 
#' Run an `npx` command.
#' 
#' @param ... Arguments to pass to npx
#' 
#' @export 
npx <- function(...){
  npx <- npx_find()
  system2(npx, args = paste0(..., collapse = " "), stdout = TRUE)
}

#' NPX Find
#' 
#' Find the NPX executable.
#' 
#' @noRd 
#' @keywords internal
npx_find <- function(){
  # which on UNIX and where on Windows
  cmd <- which_or_where() 
  path <- tryCatch(
    system2(cmd, "npx", stdout = TRUE),
    error = function(e) e
  )

  if(inherits(path, "error"))
    stop("Could not find path to `npx`", call. = FALSE)
  
  # where may return multiple paths
  path[1]
}
