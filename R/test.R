#' Add Tests
#' 
#' Adds tests to a project, currently supports mocha and peeky,
#' see details for more.
#' 
#' @param esm Whether to install `esm` and require it for tests (recommended).
#' @param name Name of the test file to add, without extension.
#' @param open Only valid for "peeky," this will open a development
#' UI if `TRUE`.
#' 
#' @details `include_tests_mocha` uses [mocha](https://mochajs.org/) and 
#' [mocha-webpack](https://webpack.js.org/loaders/mocha-loader/) and
#' creates a directory called `testjs` where tests should be placed.
#' The function [run_tests()] will then uses mocha on all the files in
#' the `testjs` directory. All tests should end with `.test.js`. 
#' `include_tests_peeky` uses [peeky](https://github.com/Akryum/peeky)
#' it's very similar to mocha but also comes with a development UI
#' that can be accessed when running tests by setting `open` to
#' `TRUE`.
#' 
#' Requiring `esm` (`esm = TRUE`) is recommended as it will allow using the latest
#' ESM, e.g.: `import` in tests.
#' 
#' @name tests
#' @export
include_tests_mocha <- function(esm = TRUE){
  assert_that(has_scaffold())
  assert_that(!fs::dir_exists("testjs"), msg = "Unit tests already set up")

  create_directory("testjs")
  template <- pkg_file("templates/mocha-test.js")
  fs::file_copy(template, "testjs/template.test.js")
  engine_install("mocha", scope = "dev")
  use_loader_mocha()

  req_esm <- ""
  if(esm){
    engine_install("esm", scope = "dev")
    req_esm <- " --require esm"
  }

  cli::cli_h2("Ignoring files")
  usethis::use_build_ignore("testjs") 
  usethis::use_git_ignore("testjs")

  # add scripts
  package <- jsonlite::read_json("package.json")
  package$scripts["test:mocha"] <- sprintf("mocha testjs%s", req_esm)
  save_json(package, "package.json")
  cli::cli_alert_success("Added npm test script")
  cli::cli_alert_info("Use {.code run_tests} to run the tests")
}

#' @rdname tests
#' @export
include_tests_peeky <- function(){
  assert_that(has_scaffold())
  assert_that(!fs::dir_exists("testjs"), msg = "Unit tests already set up")

  create_directory("testjs")
  template <- pkg_file("templates/peeky-test.js")
  fs::file_copy(template, "testjs/template.test.js")
  engine_install("@peeky/cli", scope = "dev")

  cli::cli_h2("Ignoring files")
  usethis::use_build_ignore("testjs") 
  usethis::use_git_ignore("testjs")

  # add scripts
  package <- jsonlite::read_json("package.json")
  package$scripts["test:peeky"] <- "peeky run"
  package$scripts["test:peeky-open"] <- "peeky open"
  save_json(package, "package.json")
  cli::cli_alert_success("Added npm test script")
  cli::cli_alert_info("Use {.code run_tests} to run the tests")
}

#' @name tests
#' @export
add_test_file <- function(name){
  assert_that(not_missing(name))
  assert_that(has_scaffold())
  assert_that(fs::dir_exists("testjs"), msg = "Tests are not setup, see `?include_tests`")
  
  package <- jsonlite::read_json("package.json")
  is_mocha <- any(grepl("mocha", names(package$scripts)))

  if(is_mocha)
    template <- pkg_file("templates/mocha-test.js")
  else
    template <- pkg_file("templates/peeky-test.js")

  # remove extension
  name <- trimws(name)
  name <- gsub("\\.js$", "", name)
  name <- gsub("\\.test$", "", name)
  path <- sprintf("testjs/%s.test.js", name)
  fs::file_copy(template, path)
}

#' @rdname tests
#' @export
run_tests <- function(open = FALSE){
  assert_that(has_scaffold())
  assert_that(fs::dir_exists("testjs"), msg = "Tests are not setup, see `?include_tests`")

  package <- jsonlite::read_json("package.json")
  is_mocha <- any(grepl("mocha", names(package$scripts)))

  if(is_mocha)
    run_tests_mocha()
  else
    run_tests_peeky(open)
}

run_tests_mocha <- function(){
  cmd <- engine_find()
  system2(cmd, "run test:mocha")
}

run_tests_peeky <- function(open = FALSE){
  open_cmd <- ""
  if(open)
    open_cmd <- "-open"

  cmd <- engine_find()
  args <- sprintf("run test:peeky%s", open_cmd)
  system2(cmd, args)
}