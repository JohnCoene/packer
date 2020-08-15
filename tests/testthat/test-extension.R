source("../fns.R")

test_that("Extension", {

  # keep working directory
  wd <- getwd()

  # create package and 
  pkg <- create_tmp_package()
  setwd(pkg)

  expect_error(scaffold_extension())
  expect_output(scaffold_extension("ext", edit = FALSE))
  expect_error(scaffold_extension("ext", edit = FALSE))
  expect_message(packer::bundle())

  setwd(wd)
  delete_tmp_package(pkg)
})
