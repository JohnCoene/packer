# `scaffold_leprechaun`

Leprechaun


## Description

Creates the basic structure for leprechaun app with JavaScript.


## Usage

```r
scaffold_leprechaun(react = FALSE, vue = FALSE, use_cdn = TRUE, edit = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`react`     |     Whether to include React, internally runs [`apply_react()`](#applyreact())  and adapts the `srcjs/index.js` template for React.
`vue`     |     Whether to include Vue, internally runs [`apply_vue()`](#applyvue()) and adapts the `srcjs/index.js` template for Vue.
`use_cdn`     |     Whether to use the CDN for react or vue dependencies, this is passed to [`apply_react()`](#applyreact()) or [`apply_vue()`](#applyvue()) if `react` or `vue` arguments are set to `TRUE` and ignored otherwise.
`edit`     |     Automatically open pertinent files. Defaults to `NULL` , which looks for the environment variable `PACKER_EDIT` and opens the files specified there. Otherwise takes a boolean.


## Details

Only one of `react` or `vue` can be set to `TRUE` .


## Value

`TRUE` (invisibly) if successfully run.


