source("../fns.R")

skip_on_cran()

test_that("Ambiorix Bare", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_ambiorix()
  setwd(pkg)
  expect_output(scaffold_ambiorix(edit = FALSE))
  expect_message(bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})

test_that("Ambiorix Vue", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_ambiorix()
  setwd(pkg)
  expect_output(scaffold_ambiorix(vue = TRUE, edit = FALSE))
  expect_message(bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})
