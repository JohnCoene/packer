source("../fns.R")

skip_on_cran()

test_that("Install yarn", {
	expect_message(engine_yarn_install())
})

test_that("Yarn", {
	# wrong engine
	engine_set("npm")
	expect_error(yarn_add("sth"))
	engine_set("yarn")
	expect_null(engine_which())
	expect_error(yarn_remove())

  # keep working directory
  wd <- getwd()

  # test bare
  pkg <- create_tmp_golem()
  setwd(pkg)
	on.exit({
		set_yarn("")
		engine_set("npm")
		setwd(wd)
		delete_tmp_package(pkg)
	})
  expect_output(scaffold_golem(edit = FALSE))
	expect_message(engine_yarn_set())
	expect_is(engine_which(), "character")
	yarn_version()
	expect_message(yarn_add("browserify"))
	yarn_run("production")
	yarn_install()
	yarn_upgrade()
	yarn_remove("browserify")
	expect_message(yarn_console())
  expect_message(bundle_prod())
	expect_message(use_loader_style())
  expect_message(add_plugin_eslint())
	expect_invisible(engine_get())
	yarn_outdated()
	yarn_clean()
})
