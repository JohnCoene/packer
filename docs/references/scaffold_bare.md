# `scaffold_bare`

Bare


## Description

Creates a bare scaffold for no specific use case, as
 opposed to other scaffolds. This scaffold does not
 generate R code.


## Usage

```r
scaffold_bare(edit = NULL)
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
scaffold_bare()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


