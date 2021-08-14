source("../fns.R")

skip_on_cran()

test_that("Leprechaun", {

  # keep working directory
  wd <- getwd()

  expect_error(scaffold_leprechaun(edit = FALSE))

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  expect_error(scaffold_leprechaun(edit = FALSE))
	file.create(".leprechaun")
  expect_error(scaffold_leprechaun(vue = TRUE, react = TRUE, edit = FALSE))
  expect_output(scaffold_leprechaun(edit = FALSE))
  expect_error(scaffold_leprechaun(edit = FALSE))
  expect_message(use_loader_svelte())
  setwd(wd)
  delete_tmp_package(pkg)
})

test_that("Leprechaun Vue", {

  # keep working directory
  wd <- getwd()

  pkg <- create_tmp_package()
  setwd(pkg)
	file.create(".leprechaun")
  expect_output(scaffold_leprechaun(vue = TRUE, edit = FALSE))
  setwd(wd)
  delete_tmp_package(pkg)
})
