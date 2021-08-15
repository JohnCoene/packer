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
  expect_error(ts_get_types("error", versions = c(1,2)))
	expect_message(ts_get_type("jquery"))
	expect_message(ts_get_types("@types/jquery"), versions = "3.5.5")
  expect_message(ease_lit(TRUE))
  setwd(wd)
  delete_tmp_package(pkg)
})
