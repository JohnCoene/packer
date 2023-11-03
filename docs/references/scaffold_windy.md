# `scaffold_windy`

Windy


## Description

Creates a scaffold for [windy](https://github.com/devOpifex/windy) ,
 it's a modified version of [`scaffold_bare()`](#scaffoldbare()) .


## Usage

```r
scaffold_windy(edit = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`edit`     |     Automatically open pertinent files. Defaults to `NULL` , which looks for the environment variable `PACKER_EDIT` and opens the files specified there. Otherwise takes a boolean.


## Value

`TRUE` (invisibly) if successfully run.


## Examples

```r
if (interactive()) {
# current directory
wd <- getwd()

# create a mock up ambiorix project
tmp <- tmp_package()

# move to package
setwd(tmp)

# scaffold bare
scaffold_windy()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


