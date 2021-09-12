# `tests`

Add Tests


## Description

Adds tests to a project, currently supports mocha and peeky,
 see details for more.


## Usage

```r
include_tests(esm = TRUE)
include_tests_mocha(esm = TRUE)
include_tests_peeky()
add_test_file(name)
run_tests(open = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
`esm`     |     Whether to install `esm` and require it for tests (recommended).
`name`     |     Name of the test file to add, without extension.
`open`     |     Only valid for "peeky," this will open a development UI if `TRUE` .


## Details

`include_tests_mocha` uses [mocha](https://mochajs.org/) and
 [mocha-webpack](https://webpack.js.org/loaders/mocha-loader/) and
 creates a directory called `testjs` where tests should be placed.
 The function [`run_tests()`](#runtests()) will then uses mocha on all the files in
 the `testjs` directory. All tests should end with `.test.js` . Internally
 [`include_tests()`](#includetests()) also runs [`use_loader_mocha()`](#useloadermocha()) .
 `include_tests_peeky` uses [peeky](https://github.com/Akryum/peeky) 
 it's very similar to mocha but also comes with a development UI
 that can be accessed when running tests by setting `open` to
 `TRUE` .
 
 Requiring `esm` ( `esm = TRUE` ) is recommended as it will allow using the latest
 ESM, e.g.: `import` in tests.


