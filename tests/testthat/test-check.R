source("../fns.R")

skip_on_cran()

test_that("Checks", {

  # keep working directory
  wd <- getwd()

  expect_error(scaffold_leprechaun(edit = FALSE))

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  expect_output(scaffold_leprechaun(edit = FALSE))
  setwd(wd)
	on.exit({
  	delete_tmp_package(pkg)
	})

	checks()
	put_rprofile_adapt()
	are_minified()
})
