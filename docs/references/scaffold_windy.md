# `scaffold_windy`

Windy


## Description

Creates a scaffold for [windy](https://github.com/devOpifex/windy) ,
 it's a modified version of [`scaffold_bare()`](#scaffoldbare()) .


## Usage

```r
scaffold_windy(edit = interactive())
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
scaffold_windy()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


