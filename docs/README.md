<!-- badges: start -->
![Travis build status](https://travis-ci.com/JohnCoene/packer.svg?branch=master) ![Coveralls test coverage](https://coveralls.io/repos/github/JohnCoene/packer/badge.svg)
<!-- badges: end -->

# packer

<img src="_media/packer.png" style="max-height:200px;float:right;"/>

An opinionated framework for using JavaScript with R.

### About

Packer enforces good practice and provides convenience functions to make work with JavaScript not just easier but also scalable. Packer is a robust wrapper for [npm](https://www.npmjs.com/) and [webpack](https://webpack.js.org/) that enables to modularise JavaScript code, leverage npm packages, and much more.

Things you can do with packer:

- Use npm packages with htmlwidgets
- Create your shiny UI with the pug templating engine
- Include React in you shiny application
- Bundle JavaScript files for golem
- Use Vue in a shiny app
- And so much more...

### Inspiration

The scaffolds are very much inspired by the same functionality from [htmlwidgets](http://www.htmlwidgets.org/) `scaffoldWidget` function and [golem](http://golemverse.org/) `create_golem`.

### Related Work

If you enjoy packer you should explore [reactR](https://github.com/react-R/reactR) which does something very similar to packer to create React-powered widgets and inputs, as well as [vueR](https://github.com/vue-r/vueR) which brings Vue to R.
