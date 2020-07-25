# Getting Started

All functions of packer are meant to be used within R packages, these provide a robust foundations for writing most R code and soon JavaScript. Therefore one always starts from an empty package.

Below we create a package named "alerts" via [usethis](http://usethis.r-lib.org/), which is a dependency of packer and so should already be installed on your machine.

```r
# creates package
usethis::create_package('alerts')
```

## Scaffolds

Then comes on of the core concepts of packer: scaffolds. Scaffolds are basic structures that enables using JavaScript with R in a more structure way, via webpack. There are currently 5 scaffolds available.

* `scaffold_widget` - Scaffold an [htmlwidgets](http://www.htmlwidgets.org/) with webpack.
* `scaffold_golem` - Use webpack with [golem](http://golemverse.org/).
* `scaffold_extension` - Scaffold a shiny extension, e.g.: [shinyjs](https://deanattali.com/shinyjs/) or [waiter](https://waiter.john-coene.com/).
* `scaffold_input` - Scaffold a custom shiny input.
* `scaffold_output` - Scaffold a custom shiny output.

<Tip title="Multiple Scaffolds" text="Most scaffolds can be used more than once per package, e.g.: to create multiple inputs." />

Let's demonstrate with a scaffold for a shiny extension, the function takes a single argument `name` which will be used to define the name of R and JavaScript functions, files, modules, etc.

```r
packer::scaffold_extension("alert")
```

This does many things:

1. Initialises npm
2. Installs webpack
3. It creates an `srcjs` directory containing the JavaScript files
4. Creates a `webpack.config.js` file to configure webpack
5. Creates `inst` directory to place bundles.
