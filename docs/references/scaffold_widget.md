## `scaffold_widget`: Scaffold Widget

### Description


 Creates basic structure for a widget.


### Usage

```r
scaffold_widget(name, edit = interactive())
```


### Arguments

Argument      |Description
------------- |----------------
```name```     |     Name of widget, also passed to [`htmlwidgets::scaffoldWidget()`](htmlwidgets::scaffoldWidget().html) .
```edit```     |     Automatically open pertinent files.

### Details


 Internally runs [`htmlwidgets::scaffoldWidget()`](htmlwidgets::scaffoldWidget().html) do not run it prior to this function.


### Value


 `TRUE` (invisibly) if successfully run.


### Examples

```r 
 scaffold_widget() 
 
 ``` 

