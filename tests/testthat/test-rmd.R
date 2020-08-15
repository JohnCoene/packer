source("../fns.R")

test_that("Rmd", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_project()
  setwd(pkg)
  expect_output(scaffold_rmd(edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)

  # test react
  pkg <- create_tmp_project()
  setwd(pkg)
  expect_output(scaffold_rmd(react = TRUE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)

  # test vue
  pkg <- create_tmp_project()
  setwd(pkg)
  expect_output(scaffold_rmd(vue = TRUE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})
