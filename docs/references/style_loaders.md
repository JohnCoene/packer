# `style_loaders`

Use Styles


## Description

Installs loaders and adds relevant configuration rules to `srcjs/config/loaders.json` .


## Usage

```r
use_loader_css(test = "\\.css$", import = TRUE, modules = TRUE)
use_loader_sass(test = "\\.s[ac]ss$/i")
use_loader_style(test = "\\.css$", import = TRUE, modules = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
`test`     |     Test regular expression test which files should be transformed by the loader.
`import`     |     Whether to enable `import` statements for `.css` files. If `FALSE` use `require` .
`modules`     |     Enables CSS modules and their config, a complex but powerful feature detailed [here](https://webpack.js.org/loaders/css-loader/#modules)


## Details

This will let you import styles much like any other modules, e.g.: import './styles.css' .


