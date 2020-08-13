# `tests`: Add Tests

## Description


 Adds tests to a project.


## Usage

```r
include_tests(esm = TRUE)
add_test_file(name)
run_tests()
```


## Arguments

Argument      |Description
------------- |----------------
```esm```     |     Whether to install `esm` and require it for tests (recommended).
```name```     |     Name of the test file to add, without extension.

## Details


 Uses [mocha](https://mochajs.org/) and
 [mocha-webpack](https://webpack.js.org/loaders/mocha-loader/) and
 creates a directory called `testjs` where tests should be placed.
 The function [`run_tests()`](run_tests().html) will then uses mocha on all the files in
 the `testjs` directory. All tests should end with `.test.js` . Internally
 [`include_tests()`](include_tests().html) also runs [`use_loader_mocha()`](use_loader_mocha().html) .
 
 Requiring `esm` ( `esm = TRUE` ) is recommended as it will allow using the latest
 ESM, e.g.: `import` in tests.


