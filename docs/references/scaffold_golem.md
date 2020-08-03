## `scaffold_golem`: Golem

### Description


 Creates the basic structure for golem app with JavaScript.


### Usage

```r
scaffold_golem(
  react = FALSE,
  vue = FALSE,
  use_cdn = TRUE,
  edit = interactive()
)
```


### Arguments

Argument      |Description
------------- |----------------
```react```     |     Whether to include React, internally runs [`apply_react()`](apply_react().html)  and adapts the `srcjs/index.js` template for React.
```vue```     |     Whether to include Vue, internally runs [`apply_vue()`](apply_vue().html) and adapts the `srcjs/index.js` template for Vue.
```use_cdn```     |     Whether to use the CDN for react or vue dependencies, this is passed to [`apply_react()`](apply_react().html) or [`apply_vue()`](apply_vue().html) if `react` or `vue` arguments are set to `TRUE` and ignored otherwise.
```edit```     |     Automatically open pertinent files.

### Details


 Only one of `react` or `vue` can be set to `TRUE` .


### Value


 `TRUE` (invisibly) if successfully run.


