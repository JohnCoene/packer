<!-- badges: start -->
![Travis build status](https://img.shields.io/travis/com/JohnCoene/packer?style=flat-square) ![Coveralls test coverage](https://img.shields.io/coveralls/JohnCoene/packer?style=flat-square) ![License](https://img.shields.io/badge/license-MIT-green?style=flat-square) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/JohnCoene/packer?label=latest&style=flat-square)
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
