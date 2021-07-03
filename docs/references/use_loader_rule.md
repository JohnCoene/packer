# `use_loader_rule`

Add a Loader Ruée


## Description

Adds a loader rule that is not yet implemened in packer.


## Usage

```r
use_loader_rule(packages, test, ..., use = as.list(packages))
```


## Arguments

Argument      |Description
------------- |----------------
`packages`     |     NPM packages (loaders) to install.
`test`     |     Test regular expression test which files should be transformed by the loader.
`...`     |     Any other options to pass to the rule.
`use`     |     Name of the loaders to use for `test` .


## Details

Reads the `srcsjs/config/loaders.json` and appends the rule.


