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
  expect_output(scaffold_leprechaun(edit = FALSE))
  expect_error(scaffold_leprechaun(edit = FALSE))
  expect_message(use_loader_svelte())
  setwd(wd)
  delete_tmp_package(pkg)
})
