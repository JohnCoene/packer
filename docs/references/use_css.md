# `use_css`: Use Styles

## Description


 Installs loaders, creates `srcjs/styles` directory containing a CSS file and prints required modifications to the `webpack.config.js` file.


## Usage

```r
use_css()
```


## Details


 The modifications to the `webpack.config.js` must be placed in the JSON under `module.exports` .
 The created CSS file can then be imported much like any other JavaScript file.


