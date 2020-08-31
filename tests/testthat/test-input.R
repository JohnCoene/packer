source("../fns.R")

skip_on_cran()

test_that("Input", {

  # keep working directory
  wd <- getwd()

  expect_error(scaffold_input())

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  expect_error(scaffold_input())
  expect_output(scaffold_input("increment", edit = FALSE))
  expect_error(scaffold_input("increment", edit = FALSE))
  expect_message(bundle_prod())
  expect_message(npm_install())
  expect_output(scaffold_input("increment_again", edit = FALSE))
  expect_message(bundle_dev())
  expect_message(use_loader_babel())
  expect_message(use_loader_eslint())
  setwd(wd)
  delete_tmp_package(pkg)
})
