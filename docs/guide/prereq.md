# Prerequisites

Here you will find a short guide to get you up to speed on the technology used under the hood. 

## R packages

R packages make sharing code, datasets, and anything else R-related extremely easy, they also come with a relatively strict structure, the ability to run unit tests, and much more. These have thus become a core feature of the R ecosystem and therefore are also used as the backbone of every packer project.

## Npm

Npm is Node's Package Manager and is, in a sense, Node's equivalent of CRAN, albeit much less strict. It contains a plethora of JavaScript packages waiting to be used with R pacakges, shiny apps, and plenty of other things. Npm is at its core very simple and packer provides convenience functions to interact with it from R.

You can use `packer::npm_install` to install packages. The first difference with `install.packages` is that every node/npm/packer project comes with an equivalent to [packrat](https://rstudio.github.io/packrat/) or [renv](https://rstudio.github.io/renv/) for JavaScript, therefore packages are installed for each project. The second difference is that installing node packages come with the concept of scopes:

1. `dev` for packages that is only required for you to develop your project
2. `prod` for packages that is required to run your project in production
3. `global` to install packages globally, on your entire machine (not recommended)

## Webpack

Webpack is the core of packer, it's what enables modularising JavaScript code, very much like modularising a shiny application: making code more manageable and reusable throughout the application. It is configured from the `webpack.config.js` file.

You can interact with webpack from R with packer using `packer::bundle` to bundle all the files or `packer::watch` to watch for changes in the JavaScript files and re bundles them when things change, ideal while developing the package.

<Tip title="Remember to bundle" text="Always remember to bundle the JavaScript file in order to see changes reflected in the R package." />

Packer will set up webpack to bundle each scaffold into its own JavaScript file but one can easily change that to bundle all of them into a single file.

```js
const path = require('path');

module.exports = {
  entry: './srcjs/index.js',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, './inst/packer'),
  },
  externals: {
    shiny: 'Shiny',
    jquery: 'jQuery',
  },
};
```
