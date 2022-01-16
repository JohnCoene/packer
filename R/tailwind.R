#' Use Tailwind
#' 
#' Creates PostCSS, and tailwindcss config files as well
#' as adds the appropriate loaders and installs dependencies.
#' 
#' @param test Test regular expression test which files should be transformed by the loader.
#' 
#' @export 
use_tailwind <- function(test = "\\.css$") {
  assert_that(has_scaffold())

  # installs and adds loaders
  use_loader_rule(
    c(
      "style-loader",
      "css-loader",
      "postcss-loader"
    ),
    test = test
  )

  # install npm dependencies
  npm_install(
    c(
      "postcss",
      "tailwindcss"
    )
  )

  # add config files
  cli::cli_alert_success(
    "Creating {.file postcss.config.js}"
  )
  fs::file_copy(
    pkg_file("tailwind/postcss.config.js"),
    "postcss.config.js"
  )

  cli::cli_alert_success(
    "Creating {.file tailwind.config.js}"
  )
  fs::file_copy(
    pkg_file("tailwind/tailwind.config.js"),
    "tailwind.config.js"
  )

  # initial style.css
  css <- "style.css"
  if(file.exists("srcjs/style.css"))
    css <- "style2.css"
  
  cli::cli_alert_success(
    "Creating {.file srcjs/{css}}"
  )

  fs::file_copy(
    pkg_file("tailwind/style.css"),
    sprintf(
      "srcjs/%s",
      css
    )
  )

  cli::cli_alert_info(
    "Add {.code import './{css}'} to your {.file index.js}"
  )

  invisible()
}