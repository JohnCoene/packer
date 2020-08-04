# `use_loader_mocha`: Use Mocha Loader

## Description


 Adds the [list("mocha-loader")](https://webpack.js.org/loaders/mocha-loader/) for tests.


## Usage

```r
use_loader_mocha(test = "\\.test\\.js$")
```


## Arguments

Argument      |Description
------------- |----------------
```test```     |     Test regular expression test which files should be transformed by the loader.

## Details


 Excludes `node_modules` by default.


