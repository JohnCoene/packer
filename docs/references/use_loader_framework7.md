# `use_loader_framework7`

Use Framework7 Loader


## Description

Adds the [Framework7 loader](https://www.npmjs.com/package/framework7-loader) .


## Usage

```r
use_loader_framework7(test = "\\.(f7).(html|js|jsx)$")
```


## Arguments

Argument      |Description
------------- |----------------
`test`     |     Test regular expression test which files should be transformed by the loader.


## Details

Excludes `node_modules` by default. If used outside `scaffold_golem` 
 context, installs the babel-loader in the dev scope.


