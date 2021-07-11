source("../fns.R")

skip_on_cran()

test_that("TypeScript", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(edit = FALSE))
	expect_message(use_loader_ts())
	expect_message(ts_shiny_types())
	expect_message(ts_get_type("jquery"))
	expect_message(ts_get_types("@types/jquery"), version = "3.5.5")
  setwd(wd)
  delete_tmp_package(pkg)
})
