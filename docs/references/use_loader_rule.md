# `use_loader_rule`

Add a Loader rule


## Description

Adds a loader rule that is not yet implemented in packer.


## Usage

```r
use_loader_rule(
  packages,
  test,
  ...,
  use = as.list(packages),
  .name_use = "use"
)
```


## Arguments

Argument      |Description
------------- |----------------
`packages`     |     NPM packages (loaders) to install.
`test`     |     Test regular expression test which files should be transformed by the loader.
`...`     |     Any other options to pass to the rule.
`use`     |     Name of the loaders to use for `test` .
`.name_use`     |     Depending on the webpack config one might want to change the `use` to `loader` or `loaders` .


## Details

Reads the `srcjs/config/loaders.json` and appends the rule.


