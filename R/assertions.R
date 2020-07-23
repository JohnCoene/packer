# is npm installed and can it be found?
has_npm <- function(){
  length(npm_find()) > 0
}

assertthat::on_failure(has_npm) <- function(call, env){
  stop("Cannot find `npm`, are you sure it is installed?", call. = FALSE)
}

# check that argument is not missing
not_missing <- function(x){
  !missing(x)
}

assertthat::on_failure(not_missing) <- function(call, env){
  sprintf("Missing `%s`", deparse(call$x))
}

# check that vector is not empty
not_empty <- function(x){
  length(x) > 0
}

assertthat::on_failure(not_empty) <- function(call, env){
  "Must pass arguments to `...`"
}


# check that it is a package
is_package <- function(){
  desc <- fs::file_exists("DESCRIPTION")
  ns <- fs::file_exists("NAMESPACE")

  all(desc, ns)
}

assertthat::on_failure(is_package) <- function(call, env){
  stop("This function must be called from within an R package.")
}

# check that scaffold is present
has_scaffold <- function(){
  package_json <- fs::file_exists("package.json")
  src_dir <- fs::dir_exists(SRC)

  all(package_json, src_dir)
}

assertthat::on_failure(has_scaffold) <- function(call, env){
  stop("No scaffold found, see the `scaffold_*` family of functions", call. = FALSE)
}

# check that it is a golem package
is_golem <- function(){
  dev <- fs::dir_exists("dev")
  config <- fs::file_exists("inst/golem-config.yml")

  all(dev, config)
}

assertthat::on_failure(is_golem) <- function(call, env){
  stop("Not a golem app, see `golem::create_golem`", call. = FALSE)
}
