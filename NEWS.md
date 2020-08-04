## packer 0.0.2

- Added `apply_react` adds the relevant (babel) loader, installs dependencies, and creates, or updates, or replaces the `srcjs/index.js` file.
- Added `react` argument to `scaffold_golem` to include react in a golem scaffold, run `apply_react` under the hood.
- Added `add_plugin_clean` to easily clean bundled files.
- Added unit test support via mocha.js woth `include_tests`, `run_tests`, and `add_test_file`.
- Allow multiple loaders with same `rule`.
- Add support for coffeescript loader.

## packer 0.0.1

Initial version
