# `use_loader_file`

Use File Loader


## Description

Adds the [list("file-loader")](https://webpack.js.org/loaders/file-loader/) 
 to resolve files: `png` , `jpg` , `jpeg` , and `gif` .


## Usage

```r
use_loader_file(test = "\\.(png|jpe?g|gif)$/i")
```


## Arguments

Argument      |Description
------------- |----------------
`test`     |     Test regular expression test which files should be transformed by the loader.


