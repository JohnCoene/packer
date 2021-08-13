source("../fns.R")

skip_on_cran()

test_that("Input", {

  # keep working directory
  wd <- getwd()

  expect_error(scaffold_leprechaun())

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  expect_output(scaffold_leprechaun(edit = FALSE))
  expect_error(scaffold_leprechaun(edit = FALSE))
  setwd(wd)
  delete_tmp_package(pkg)
})
