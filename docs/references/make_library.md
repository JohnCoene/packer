# `make_library`

Make Library


## Description

Adds library settings to webpack config.
 This allow exporting JavaScript objects.


## Usage

```r
make_library(name = "[name]", type = "umd")
```


## Arguments

Argument      |Description
------------- |----------------
`name`     |     Name of the library, default recommended, see details.
`type`     |     Type of the library.


## Details

The functions will be exported
 at the specified `name` , e.g.: if
 the name is `myLib` then functions can be
 called with `myLib.function();` .
 The default ( [name] ) means the name of the exported
 library will be the same as the name of the scaffold.
 This is advised because otherwise, if one has multiple
 scaffold, an absolute will overwrite itself and only
 the last scaffold added will be a valid library.


