# `scaffold_golem`

Golem


## Description

Creates the basic structure for golem app with JavaScript.


## Usage

```r
scaffold_golem(
  react = FALSE,
  vue = FALSE,
  framework7 = FALSE,
  use_cdn = TRUE,
  edit = interactive()
)
```


## Arguments

Argument      |Description
------------- |----------------
`react`     |     Whether to include React, internally runs [`apply_react()`](#applyreact())  and adapts the `srcjs/index.js` template for React.
`vue`     |     Whether to include Vue, internally runs [`apply_vue()`](#applyvue()) and adapts the `srcjs/index.js` template for Vue.
`framework7`     |     Whether to include Framework7, internally runs [`apply_framework7()`](#applyframework7())  and adapts the `srcjs/index.js` template for Framework7.
`use_cdn`     |     Whether to use the CDN for react, vue or Framework7 dependencies, this is passed to [`apply_react()`](#applyreact()) , [`apply_vue()`](#applyvue()) or [`apply_framework7()`](#applyframework7()) if `react` , `vue` or `framework7` arguments are set to `TRUE` and ignored otherwise.
`edit`     |     Automatically open pertinent files.


## Details

Only one of `react` , `vue` or `framework7` can be set to `TRUE` . `use_cdn` is
 not supported for Framework7.


## Value

`TRUE` (invisibly) if successfully run.


## Examples

```r
if(interactive()){
# current directory
wd <- getwd()

# create a mock up golem project
tmp <- tmp_golem()

# move to package
setwd(tmp)

# scaffold golem
scaffold_golem()

# clean up
setwd(wd)
tmp_delete(tmp)
}
```


