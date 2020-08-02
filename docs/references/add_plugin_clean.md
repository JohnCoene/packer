## `add_plugin_clean`: Clean Plugin

### Description


 Add the [clean-webpack-plugin](https://www.npmjs.com/package/clean-webpack-plugin) to
 clean the bundled files.


### Usage

```r
add_plugin_clean(dry = FALSE, verbose = FALSE, clean = TRUE, protect = TRUE)
```


### Arguments

Argument      |Description
------------- |----------------
```dry```     |     Whether to simulate the removal of files.
```verbose```     |     Write Logs to the console.
```clean```     |     Whether to automatically remove all unused webpack assets on rebuild.
```protect```     |     Whether to not allow removal of current webpack assets.

