# `scaffold_widget`

Scaffold Widget


## Description

Creates basic structure for a widget.


## Usage

```r
scaffold_widget(name, edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
`name`     |     Name of widget, also passed to [`htmlwidgets::scaffoldWidget()`](#htmlwidgets::scaffoldwidget()) .
`edit`     |     Automatically open pertinent files.


## Details

Internally runs [`htmlwidgets::scaffoldWidget()`](#htmlwidgets::scaffoldwidget()) do not run it prior to this function.


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
scaffold_widget()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


