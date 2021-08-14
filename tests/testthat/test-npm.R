source("../fns.R")

skip_on_cran()

test_that("NPM", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(edit = FALSE))
  expect_message(engine_adapt())
  # no error
	expect_message(npm_install('browserify'))
	expect_message(npm_install())
	npm_outdated()
  npm_fix()
	expect_error(npm_uninstall())
	expect_message(npm_update())
	expect_message(npm_uninstall('browserify'))
  setwd(wd)
  delete_tmp_package(pkg)
})