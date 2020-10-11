## packer 0.0.6.9000

- Use `rstudio` to open files, if available.
- Added `scaffold_ambiorix` function.
- Added function to mock up package creation so examples can run for CRAN submission.

## packer 0.0.5

## Changes

- Added `scaffold_rmd` to scaffold R markdown projects.
- When a test for a specific loader exist the `use` is now appended to existing entry.
- Added `use_loader_eslint`.
- Added `use_eslint` argument to `use_babel`.
- Added tests

## packer 0.0.3

### Changes

- Loaders `use_loader_*` now accept `test` argument.
- Add `use_loader_rule` to allow adding loaders yet implemented.
- Add `use_loader_file` to allow importing images.
- Removed broken `use_loader_vue_style`, `apply_vue` now uses `use_loader_css` which works.
- Added `output_path` argument to `add_plugin_html`.

### Bug fixes

- Fixed import of external libraries (HTMLwidgets, Shiny, and jQuery).
- Fixed name check on scaffolds, e.g.: `scaffold_input("no space allowed")` would not fail before.

### Internals

- Reworked internals of `use_loader_*` functions.
- Refactored internals of `scaffold_input`, `scaffold_output`, and `scaffold_extension`.

## packer 0.0.2

### Changes

- Added `apply_react` adds the relevant (babel) loader, installs dependencies, and creates, or updates, or replaces the `srcjs/index.js` file.
- Added `react` argument to `scaffold_golem` to include react in a golem scaffold, run `apply_react` under the hood.
- Added `add_plugin_clean` to easily clean bundled files.
- Added unit test support via mocha.js woth `include_tests`, `run_tests`, and `add_test_file`.
- Allow multiple loaders with same `rule`.
- Add support for coffeescript loader.

## packer 0.0.1

Initial version
