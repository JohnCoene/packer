source("../fns.R")

skip_on_cran()

test_that("Extension", {

  # keep working directory
  wd <- getwd()

  # create package and 
  pkg <- create_tmp_package()
  setwd(pkg)

  expect_error(scaffold_extension())
  expect_output(scaffold_extension("ext", edit = FALSE))
  expect_error(scaffold_extension("ext", edit = FALSE))
  expect_message(bundle())
  expect_message(use_loader_babel(use_eslint = TRUE))
  expect_message(bundle())

  setwd(wd)
  delete_tmp_package(pkg)
})
