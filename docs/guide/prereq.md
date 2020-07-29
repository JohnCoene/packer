# Prerequisites

Here you will find a short guide to get you up to speed on the technology used under the hood. 

## R packages

R packages make sharing code, datasets, and anything else R-related extremely easy, they also come with a relatively strict structure, the ability to run unit tests, and much more. These have thus become a core feature of the R ecosystem and therefore are also used as the backbone of every packer project.

```r
# create a package named usesJS
usethis::create_package("usesJS")
```

<Tip title="Package development" text="Knowledge of R package development is necessary to work with packer." />

## Npm

Npm is Node's Package Manager and is, in a sense, Node's equivalent of CRAN, albeit much less strict. It contains a plethora of JavaScript packages waiting to be used with R pacakges, shiny apps, and plenty of other things. Npm is at its core very simple and packer provides convenience functions to interact with it from R.

You can use `packer::npm_install` to install packages. The first difference with `install.packages` is that every node/npm/packer project comes with an equivalent to [packrat](https://rstudio.github.io/packrat/) or [renv](https://rstudio.github.io/renv/) for JavaScript, therefore packages are installed for each project. The second difference is that installing node packages come with the concept of scopes:

1. `dev` for packages that is only required for you to develop your project
2. `prod` for packages that is required to run your project in production
3. `global` to install packages globally, on your entire machine (not recommended)

There are probably only a handful of libraries that should be installed globally. You should only install in `prod` what is required to run your code in the front-end, any package used to prepare the bundle (e.g.: `sass`) is not required in the front-end and therefore should be installed as `dev`.

```r
# install the sass package for development purposes.
packer::npm_install("sass", scope = "dev")
```

## Webpack

Webpack is the core of packer, it's what enables modularising JavaScript code, very much like modularising a shiny application: making code more manageable and reusable throughout the application. It is configured from the `webpack.config.js` file.

You can interact with webpack from R with packer using `packer::bundle` to bundle all the files or `packer::watch` to watch for changes in the JavaScript files and re bundles them when things change, ideal while developing the package.

```r
# bundle JavaScript files
packer::bundle()
```
