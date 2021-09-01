source("../fns.R")

skip_on_cran()

test_that("Output", {

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_package()
  setwd(pkg)
  on.exit({
    setwd(wd)
    delete_tmp_package(pkg)
  })
  expect_error(scaffold_output())
  expect_output(scaffold_output("out", edit = FALSE))
  expect_error(scaffold_output("out", edit = FALSE))
  expect_message(bundle())
  expect_output(scaffold_output("out_again", edit = FALSE))
  expect_message(bundle())
})
