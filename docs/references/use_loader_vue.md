# `use_loader_vue`: Use Vue Loader

## Description


 Adds the Vue loader to the loader configuration file.


## Usage

```r
use_loader_vue(test = "\\.vue$")
```


## Arguments

Argument      |Description
------------- |----------------
```test```     |     Test regular expression test which files should be transformed by the loader.

## Details


 Every time a new version of Vue is released, a corresponding version of `vue-template-compiler` 
 is released together. The compiler's version must be in sync with the base Vue package so that `vue-loader` 
 produces code that is compatible with the runtime. This means every time you upgrade Vue in your project,
 you should upgrade `vue-template-compiler` to match it as well.


