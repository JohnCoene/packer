<!-- badges: start -->
![R-CMD-check](https://github.com/JohnCoene/packer/workflows/R-CMD-check/badge.svg)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/JohnCoene/packer?label=latest&style=flat-square) ![Codecov test coverage](https://codecov.io/gh/JohnCoene/packer/branch/master/graph/badge.svg)
<!-- badges: end -->

# packer

<img src="_media/packer.png" style="max-height:200px;float:right;"/>

An opinionated framework for using JavaScript with R.

### About

Packer enforces good practice and provides convenience functions to make work with JavaScript not just easier but also scalable. Packer is a robust wrapper for [npm](https://www.npmjs.com/) and [webpack](https://webpack.js.org/) that enables modularising JavaScript code, leveraging npm packages, and much more.

Things you can do with packer:

- Use npm packages with htmlwidgets
- Create your shiny UI with the pug templating engine
- Include React/Vue in you shiny application
- Bundle JavaScript files for golem
- Scope CSS selectors
- Use Lit web components
- And so much more...

<Note>
You can read more about the advantages of using webpack with R in the book <a href="https://book.javascript-for-r.com/webpack-intro.html" target="_blank">JavaScript for R</a>, it contains a set
of chapters on the topic.
</Note>

### Why use packer?

Packer (thanks to webpack) has numerous advantages.
In essence, it's a bit like the difference between a set of 
R scripts and an R package. An R package enables testing,
documenting, structuring, and more.

- [x] Minify JavaSrcipt and CSS files
- [x] Easily update dependencies
- [x] Catch errors at build time
- [x] Modularise JavaScript code
- [x] Document JavaScript code
- [x] Plenty more

_Packer presented at WhyR 2020._

<iframe width="100%" height="315" src="https://www.youtube.com/embed/c9AtMOoJgAM?start=3886" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Companions

Packer is a great companion to the following packages.

1. [shiny](https://shiny.rstudio.com/)
2. [htmlwidgets](https://www.htmlwidgets.org/)
3. [golem](https://golemverse.org/)
4. [ambiorix](https://ambiorix.john-coene.com/)
5. [leprechaun](https://github.com/devOpifex/leprechaun)
6. [rmarkdown](https://rmarkdown.rstudio.com/)
7. [framework7](https://framework7.io/)

Feel free to open an issue if you think packer should support
another package or framework. If you just want a simpel support
for webpack with R you can use the `scaffold_bare`.

### In the wild

_Some real-world examples of packer usage, because 
reading source code can help._

There are a few public repositories that make use of packer
see [Github](https://github.com/search?p=1&q=path%3Asrcjs%2Fconfig&type=Code).

[Julien Barnier](https://github.com/juba) has built the 
[obsplot package](https://github.com/juba/obsplot) with the
help of packer.

[DreamRs](https://github.com/dreamRs) have used packer for the [bar](https://github.com/dreamRs/bar) package.

[Ewen](https://github.com/ewenme) has used packer for the [shinya11y](shinya11yhttps://github.com/ewenme/shinya11y) package.

The [waiter](https://github.com/JohnCoene/waiter) package,
[g2r](https://github.com/devOpifex/g2r),
[firebase](https://github.com/JohnCoene/firebase) 
are also built on top of packer. 
There is also [tippy](https://github.com/JohnCoene/tippy), [sever](https://github.com/JohnCoene/sever), 
[cicerone](https://github.com/JohnCoene/cicerone), 
[awn](https://github.com/JohnCoene/awn), and
[marker](https://github.com/JohnCoene/marker).

### Related Work

If you enjoy packer you should explore [reactR](https://github.com/react-R/reactR) which does something very similar to packer to create React-powered widgets and inputs, as well as [vueR](https://github.com/vue-r/vueR) which brings Vue to R.

Also see [parcel](https://parcel.john-coene.com/) to use parcel.js (instead of webpack) for JavaScript with R 
(though the R package does have all the features of packer).

### Inspiration

The scaffolds are very much inspired by the same functionality from [htmlwidgets](http://www.htmlwidgets.org/) `scaffoldWidget` function and [golem](http://golemverse.org/) `create_golem`.
