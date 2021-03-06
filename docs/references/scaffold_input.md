# `scaffold_input`

Scaffold a Custom Input


## Description

Sets basic structure for a shiny input.


## Usage

```r
scaffold_input(name, edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
`name`     |     Name of input, will define internal name binding and CSS class.
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
scaffold_input()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


