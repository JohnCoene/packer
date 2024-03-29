source("../fns.R")

skip_on_cran()

test_that("Widget", {
  # keep working directory
  wd <- getwd()

  # create package and
  pkg <- create_tmp_package()
  setwd(pkg)
  on.exit({
    setwd(wd)
    delete_tmp_package(pkg)
  })

  expect_error(scaffold_widget())
  expect_output(scaffold_widget("writeH1", edit = FALSE))
  expect_output(scaffold_widget("writeH2", edit = FALSE))
  expect_message(bundle())
})
