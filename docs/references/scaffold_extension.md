# `scaffold_extension`

Shiny Extension


## Description

Creates the basic structure for a shiny extension.


## Usage

```r
scaffold_extension(name, edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
`name`     |     Name of extension used to define file names and functions.
`edit`     |     Automatically open pertinent files.


## Value

`TRUE` (invisibly) if successfully run.


## Examples

```r
if(interactive()){
# current directory
wd <- getwd()

# create a mock up ambiorix project
tmp <- tmp_package()

# move to package
setwd(tmp)

# scaffold ambiorix
scaffold_extension()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


