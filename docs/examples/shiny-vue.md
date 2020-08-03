# Shiny app with Vue

In this example we create a shiny application with golem, and power some of the front-end using [Vue](https://vuejs.org/).

```r
golem::create_golem("vuer")
packer::scaffold_golem(vue = TRUE)
```

```
── Scaffolding golem ─────────────────────────────────────────────────────────

✔ Initialiased npm
✔ webpack, webpack-cli, webpack-merge installed with scope dev
✔ Added npm scripts
✔ Created `srcjs` directory
✔ Created `srcjs/config` directory
✔ Created webpack config files

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/Projects/vuer'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.dev\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.prod\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.common\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── Vue loader, plugin & dependency ──

✔ @babel/core, babel-loader installed with scope dev
✔ Added bundling rule for babel-loader
✔ @babel/preset-env installed with scope dev
✔ vue installed with scope dev
✔ vue-loader, vue-template-compiler installed with scope dev
✔ Added bundling rule for vue-loader
✔ vue-style-loader, css-loader installed with scope dev
✔ Added bundling rule for vue-style-loader & css-loader
✔ Created `R/vue_cdn.R` containing `vueCDN()` function
✔ Added alias to `srcjs/config/misc.json`

── Babel config file ──

✔ Created `.babelrc`
✔ Adding '^\\.babelrc$' to '.Rbuildignore'

── Template files ──

✔ Added `srcjs/Home.vue` template
! Place the following in your shiny ui:
tagList(
  vueCDN(),
  div(id = "app"),
  tags$script(src = "www/index.js")
)

── Scaffold built ──

ℹ Run `bundle` to build the JavaScript files
```

This scaffolds golem to use Vue. As hinted by the numerous messages above packer does many things to ensure this works but more notably the resulting scaffold will require using the Vue's CDN and will not set up a configuration that bundles Vue in the output (default): the CDN will likely load faster. Therefore `scaffold_golem` created a `vueCDN()` function in the golem app `R/vue_cdn.R`. This is to be used as indicated by the warning~ish produced.

Modify the `app_ui` function as indicated.

```r {highlight:['8-12']}
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      h1("vuer"),
      tagList(
        vueCDN(),
        div(id = "app"),
        tags$script(src = "www/index.js")
      )
    )
  )
}
```

One of the files generated is `Home.vue`.

```vue
<template>
  <p>{{ greeting }} powered by Vue!</p>
</template>

<script>
module.exports = {
  data: function() {
    return {
      greeting: "Shiny"
    };
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
```

Then one can bundle the files.

```r
packer::bundle()
```

Then load the functions and run the app.

```r
devtools::load_all()
run_app()
```

![](_media/shiny-vue.png)
