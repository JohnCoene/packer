# `style_loaders`

Use Styles


## Description

Installs loaders and adds relevant configuration rules to `srcjs/config/loaders.json` .


## Usage

```r
use_loader_css(test = "\\.css$")
use_loader_sass(test = "\\.s[ac]ss$/i")
```


## Arguments

Argument      |Description
------------- |----------------
`test`     |     Test regular expression test which files should be transformed by the loader.


## Details

This will let you import styles much like any other modules, e.g.: import './styles.css' .


