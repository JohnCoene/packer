source("../fns.R")

skip_on_cran()

test_that("Checks", {

  # keep working directory
  wd <- getwd()

  expect_error(scaffold_leprechaun(edit = FALSE))

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  expect_output(scaffold_input("test", edit = FALSE))
  bundle_dev()
	on.exit({
    setwd(wd)
  	delete_tmp_package(pkg)
	})

  expect_message(checks())
	expect_error(are_minified())
})
