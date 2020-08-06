# `scaffold_rmd`: Golem

## Description


 Creates the basic structure for golem app with JavaScript.


## Usage

```r
scaffold_rmd(react = FALSE, vue = FALSE, edit = interactive())
```


## Arguments

Argument      |Description
------------- |----------------
```react```     |     Whether to include React, internally runs [`apply_react()`](apply_react().html)  and adapts the `srcjs/index.js` template for React.
```vue```     |     Whether to include Vue, internally runs [`apply_vue()`](apply_vue().html) and adapts the `srcjs/index.js` template for Vue.
```edit```     |     Automatically open pertinent files.

## Details


 Only one of `react` or `vue` can be set to `TRUE` .


## Value


 `TRUE` (invisibly) if successfully run.


