# `scaffold_ambiorix`: Ambiorix

## Description


 Creates the basic structure for an ambiorix application.


## Usage

```r
scaffold_ambiorix(vue = FALSE, use_cdn = TRUE, edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
```vue```     |     Whether to include Vue, internally runs [`apply_vue()`](apply_vue().html) and adapts the `srcjs/index.js` template for Vue.
```use_cdn```     |     Whether to use the CDN for react or vue dependencies, this is passed to [`apply_react()`](apply_react().html) or [`apply_vue()`](apply_vue().html) if `react` or `vue` arguments are set to `TRUE` and ignored otherwise.
```edit```     |     Automatically open pertinent files.

## Details


 Only one of `react` or `vue` can be set to `TRUE` .


## Value


 `TRUE` (invisibly) if successfully run.


## Examples

```r 
 if(interactive()){
 # current directory
 wd <- getwd()
 
 # create a mock up ambiorix project
 tmp <- tmp_ambiorix()
 
 # move to package
 setwd(tmp)
 
 # scaffold ambiorix
 scaffold_ambiorix()
 
 # clean up
 setwd(wd)
 tmp_delete(tmp)
 }
 
 ``` 

