# `engine`

Set Engine


## Description

Defines the engine to use with packer.
 One can pick between npm and yarn.


## Usage

```r
engine_set(engine = c("npm", "yarn"))
engine_get()
```


## Arguments

Argument      |Description
------------- |----------------
`engine`     |     The engine to use.


## Details

Generally one would want to define
 the engine prior to scaffolding.
 For convenience you can instead set the environment
 variable `PACKER_ENGINE` to your engine of choice.
 Packer reads this variable, all subsequent use
 of packer will use the defined engine.
 You can use the function `usethis::edit_r_environ` 
 to do so.


