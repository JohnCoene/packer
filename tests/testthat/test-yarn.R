source("../fns.R")

skip_on_cran()

test_that("Install yarn", {
	expect_message(engine_yarn_install())
})

test_that("Yarn", {

	on.exit({
		engine_set("npm")
	})

	# wrong engine
	engine_set("npm")
	expect_error(yarn_add("sth"))
	engine_set("yarn")

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
  expect_output(scaffold_golem(edit = FALSE))
	expect_message(engine_yarn_set())
	expect_message(yarn_version())
	expect_message(yarn_add("browserify"))
	yarn_install()
	yarn_upgrade()
	yarn_remove("browserify")
	expect_message(yarn_console())
  expect_message(bundle_prod())
	expect_message(use_loader_style())
	expect_message(use_loader_eslint())
  expect_message(add_plugin_eslint())
  setwd(wd)
  delete_tmp_package(pkg)
})
