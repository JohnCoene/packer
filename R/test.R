#' Add Tests
#' 
#' Adds tests to a project.
#' 
#' @param name Name of the test file to add, without extension.
#' 
#' @details Uses [mocha](https://mochajs.org/) and 
#' [mocha-webpack](https://webpack.js.org/loaders/mocha-loader/) and
#' creates a directory called `testjs` where tests should be placed.
#' The function [run_tests()] will then uses mocha on all the files in
#' the `testjs` directory. All tests should end with `.test.js`. Internally
#' [include_tests()] also runs [use_loader_mocha()].
#' 
#' @examples 
#' \dontrun{include_tests()}
#' \dontrun{add_test_file("inputs")}
#' 
#' @name tests
#' @export
include_tests <- function(){
  assert_that(has_scaffold())
  assert_that(!fs::dir_exists("testjs"), msg = "Unit tests already set up")

  create_directory("testjs")
  template <- pkg_file("templates/mocha-test.js")
  fs::file_copy(template, "testjs/template.test.js")
  npm_install("mocha", scope = "dev")
  use_loader_mocha()

  cli::cli_h2("Ignoring files")
  usethis::use_build_ignore("testjs") 
  usethis::use_git_ignore("testjs")

  package <- jsonlite::read_json("package.json")
  package$scripts["test:mocha"] <- 'mocha testjs'
  save_json(package, "package.json")
  cli::cli_alert_success("Added npm test script")
}

#' @name tests
#' @export
add_test_file <- function(name){
  assert_that(not_missing(name))
  assert_that(has_scaffold())
  assert_that(fs::dir_exists("testjs"), msg = "Tests are not setup, see `include_tests`")

  # remove extension
  name <- trimws(name)
  name <- gsub("\\.js$", "", name)
  name <- gsub("\\.test$", "", name)
  path <- sprintf("testjs/%s.test.js", name)
  template <- pkg_file("templates/mocha-test.js")
  fs::file_copy(template, path)
}

#' @rdname tests
#' @export
run_tests <- function(){
  assert_that(has_scaffold())
  assert_that(fs::dir_exists("testjs"), msg = "Tests are not setup, see `include_tests`")

  npm <- npm_find()
  system2(npm, "run test:mocha") # run tests
}