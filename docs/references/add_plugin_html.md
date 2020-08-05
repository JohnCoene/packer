# `add_plugin_html`: HTML Plugin

## Description


 Add the [html-webpack-plugin](https://webpack.js.org/plugins/html-webpack-plugin/) to
 the configuration to generate HTML with webpack, used in packer to generate the UI of
 a golem app with webpack.


## Usage

```r
add_plugin_html(use_pug = FALSE, output_path = "../index.html")
```


## Arguments

Argument      |Description
------------- |----------------
```use_pug```     |     Set to `TRUE` to use the [pug engine](https://pugjs.org/) .
```output_path```     |     Path to the generated html file, defaults to `../index.html` as is ideal for golem. Note that this path is relative to your output directory specified in your `webpack.common.js` file.

