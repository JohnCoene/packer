source("../fns.R")

skip_on_cran()

test_that("Golem Bare", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(edit = FALSE))
  expect_message(bundle_dev())
  expect_message(add_plugin_html(use_pug = TRUE))
  expect_message(add_plugin_prettier())
  expect_message(add_plugin_eslint())
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
  expect_message(bundle())
  expect_message(use_loader_mocha())
  setwd(wd)
  delete_tmp_package(pkg)

  # test vue
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(vue = TRUE, edit = FALSE))
  expect_message(bundle())
  expect_message(add_plugin_clean())
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
  expect_error(add_test_file())
  expect_error(add_test_file('sth'))
  expect_message(include_tests())
  add_test_file('sth')
  expect_message(bundle())
  setwd(wd)
  delete_tmp_package(pkg)

  # test vue
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(vue = TRUE, use_cdn = FALSE, edit = FALSE))
  expect_message(bundle())
  setwd(wd)
  delete_tmp_package(pkg)
})
