## packer 0.0.3.9000

- Loaders `use_loader_*` now accept `test` argument.
- Add `use_loader_rule` to allow adding loaders yet implemented.
- Add `use_loader_file` to allow importing images.
- Reworked internals of `use_loader_*` functions.
- Fixed import of external libraries (HTMLwidgets, Shiny, and jQuery).
- Fixed name check on scaffolds, e.g.: `scaffold_input("no space allowed")` would not fail before.
- Removed broke `use_loader_vue_style`, `apply_vue` now uses `use_loader_css` which works.
- Added `output_path` argument to `add_plugin_html`.

## packer 0.0.2

- Added `apply_react` adds the relevant (babel) loader, installs dependencies, and creates, or updates, or replaces the `srcjs/index.js` file.
- Added `react` argument to `scaffold_golem` to include react in a golem scaffold, run `apply_react` under the hood.
- Added `add_plugin_clean` to easily clean bundled files.
- Added unit test support via mocha.js woth `include_tests`, `run_tests`, and `add_test_file`.
- Allow multiple loaders with same `rule`.
- Add support for coffeescript loader.

## packer 0.0.1

Initial version
