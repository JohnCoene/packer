source("../fns.R")

test_that("Golem Bare", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})

test_that("Golem CDN", {

  # keep working directory
  wd <- getwd()

  # test react
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(react = TRUE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)

  # test vue
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(vue = TRUE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})

test_that("Golem no CDN", {

  # keep working directory
  wd <- getwd()

  # test react
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(react = TRUE, use_cdn = FALSE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)

  # test vue
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(vue = TRUE, use_cdn = FALSE, edit = FALSE))
  expect_message(packer::bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})
