# `use_loader_babel`: Use babel Loader

## Description


 Adds the loader for babel comiler to the loader configuration file.


## Usage

```r
use_loader_babel(test = "\\.(js|jsx)$", use_eslint = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
```test```     |     Test regular expression test which files should be transformed by the loader.
```use_eslint```     |     Whether to also add the ESlint loader.

## Details


 The `use_elsint` argument is useful here as loaders have
 to be defined in the correct order or files might be checked after
 being processed by babel.
 
 Excludes `node_modules` by default.


