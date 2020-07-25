# Getting Started

All functions of packer are meant to be used within R packages, these provide a robust foundations for writing most R code and soon JavaScript. Therefore one always starts from an empty package.

Below we create a package named "alerts" via [usethis](http://usethis.r-lib.org/), which is a dependency of packer and so should already be installed on your machine.

```r
# creates package
usethis::create_package('alerts')
```

## Scaffolds

Then comes on of the core concepts of packer
