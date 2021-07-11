# `types`

Install Types


## Description

Install TypeScript types from npm.


## Usage

```r
ts_get_types(..., versions = NULL)
ts_get_type(type, version = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`...`     |     Types to install.
`versions, version`     |     Corresponding versions of types passed to `...` , if `NULL` the latest version is installed.
`type`     |     Name of types @types/* to install.


## Examples

```r
ts_get_type("jquery")
ts_get_types("@types/jquery")
```


