<div align="center">

<img src="docs/_media/packer.png" height = "200px"/>

<!-- badges: start -->
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/JohnCoene/packer?label=latest&style=flat-square)
[![R-CMD-check](https://github.com/JohnCoene/packer/workflows/R-CMD-check/badge.svg)](https://github.com/JohnCoene/packer/actions)
[![Codecov test coverage](https://codecov.io/gh/JohnCoene/packer/branch/master/graph/badge.svg)](https://app.codecov.io/gh/JohnCoene/packer?branch=master)
<!-- badges: end -->

[Website](https://packer.john-coene.com/) | [Installation](https://packer.john-coene.com/#/guide/installation) | [Get Started](https://packer.john-coene.com/#/guide/getting-started) | [Book](https://book.javascript-for-r.com/webpack-intro.html)

## An opinionated framework for using JavaScript with R

</div>

At its core packer consists of functions to scaffold R packages powered by webpack and npm, these take the form of scaffolds which are built on top of packages. All of the scaffolds below thus need to be run from within an R package.

### Things you can do with packer

- Use npm packages with htmlwidgets
- Create your shiny UI with the pug templating engine
- Include React/Vue in you shiny application
- Bundle JavaScript files for golem
- Scope CSS selectors
- Use Lit web components
- And so much more...

### Usage

Always start from an empty package and run `scaffold_*` to set up the required basic structure.

```r
packer::scaffold_input("<name_of_input>")
```

Once the scaffold laid down you can either `bundle` the JavaScript or `watch` for changes as you develop it.

```r
packer::bundle()
```

You can then document and install the package to try it out.

## Install

Get the stable version from CRAN:

```r
install.packages("packer")
```

Get the development version from Github with `remotes`.

```r
# install.packages("remotes")
remotes::install_github("JohnCoene/packer")
```
