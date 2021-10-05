# `scaffold_bare`

Bare


## Description

Creates a bare scaffold for not specific use case, as
 opposed to other scaffolds. This scaffold does not
 generate R code.


## Usage

```r
scaffold_bare(edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
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

# scaffold bare
scaffold_bare()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


