source("../fns.R")

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
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})
