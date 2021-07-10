<!-- badges: start -->
![R-CMD-check](https://github.com/JohnCoene/packer/workflows/R-CMD-check/badge.svg)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/JohnCoene/packer?label=latest&style=flat-square) ![Codecov test coverage](https://codecov.io/gh/JohnCoene/packer/branch/master/graph/badge.svg)
<!-- badges: end -->

# packer

<img src="_media/packer.png" style="max-height:200px;float:right;"/>

An opinionated framework for using JavaScript with R.

Support for both npm and yarn, the
[documentation](https://packer.john-coene.com/#/guide/engines)
and `set_engine`
<Badge type="success">New</Badge>

### About

Packer enforces good practice and provides convenience functions to make work with JavaScript not just easier but also scalable. Packer is a robust wrapper for [npm](https://www.npmjs.com/) and [webpack](https://webpack.js.org/) that enables modularising JavaScript code, leveraging npm packages, and much more.

Things you can do with packer:

- Use npm packages with htmlwidgets
- Create your shiny UI with the pug templating engine
- Include React in you shiny application
- Bundle JavaScript files for golem
- Use Vue in a shiny app
- Scope CSS selectors
- And so much more...

<Note>
You can read more about the advantages of using webpack with R in the book <a href="https://book.javascript-for-r.com/webpack-intro.html" target="_blank">JavaScript for R</a>, it contains a set
of chapters on the topic.
</Note>

## Why use packer?

Packer presented at WhyR 2020.

<iframe width="560" height="315" src="https://www.youtube.com/embed/c9AtMOoJgAM?start=3886" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Inspiration

The scaffolds are very much inspired by the same functionality from [htmlwidgets](http://www.htmlwidgets.org/) `scaffoldWidget` function and [golem](http://golemverse.org/) `create_golem`.

## In the wild

_Some real-world examples of packer usage, because 
reading source code can help._

There are a few public repositories that make use of packer
see [Github](https://github.com/search?p=1&q=path%3Asrcjs%2Fconfig&type=Code).

The [waiter](https://github.com/JohnCoene/waiter) package and
[g2r](https://github.com/devOpifex/g2r) are also built on top
 of packer. There is also [tippy](https://github.com/JohnCoene/tippy), and [sever](https://github.com/JohnCoene/sever).

### Related Work

If you enjoy packer you should explore [reactR](https://github.com/react-R/reactR) which does something very similar to packer to create React-powered widgets and inputs, as well as [vueR](https://github.com/vue-r/vueR) which brings Vue to R.

Also see [parcel](https://parcel.john-coene.com/) to use parce.js (instead of webpack) for JavaScript with R.
