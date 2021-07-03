# `make_library`

Make Library


## Description

Adds library settings to webpack config.
 This allow exporting JavaScript objects.


## Usage

```r
make_library(name, type = "umd")
```


## Arguments

Argument      |Description
------------- |----------------
`name`     |     Name of the library, see details.
`type`     |     Type of the library.


## Details

The functions will be exported
 at the specified `name` , e.g.: if
 the name is `myLib` then functions can be
 called with `myLib.function();` .


