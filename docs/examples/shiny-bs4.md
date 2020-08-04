# Shiny with Vue and Bootstrap 4

In this example we build a shiny application that uses Vue and Bootstrap inputs via [bootstrap-vue](https://bootstrap-vue.org/). Like all shiny applications built with packer this starts with a golem package on which we scaffold with Vue.

```r
golem::create_golem("bs4")
packer::scaffold_golem(vue = TRUE)
```

```
── Scaffolding golem ──────────────────────────────────────────────────

✔ Initialiased npm
✔ webpack, webpack-cli, webpack-merge installed with scope dev
✔ Added npm scripts
✔ Created `srcjs` directory
✔ Created `srcjs/config` directory
✔ Created webpack config files

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/home/jp/Projects/bs4'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.dev\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.prod\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.common\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── Vue loader, plugin & dependency ──

✔ babel-loader installed with scope dev
✔ Added loader rule for babel-loader
✔ @babel/core, @babel/preset-env installed with scope dev
✔ vue installed with scope dev
✔ vue-loader, vue-template-compiler installed with scope dev
✔ Added loader rule for vue-loader, vue-template-compiler
✔ vue-style-loader, css-loader installed with scope dev
✔ Added loader rule for vue-style-loader, css-loader
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

Then again we notice the warning~ish message indicating changes need to be made to the `app_ui.R` file.

```r {highlight:['8-12']}
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      h1("bs4"),
      tagList(
        vueCDN(),
        div(id = "app"),
        tags$script(src = "www/index.js")
      )
    )
  )
}
```

We then install the bootstrap-vue and bootstrap npm packages in prod.

```r
packer::npm_install("bootstrap-vue", "bootstrap", scope = "prod")
```

```
✔ bootstrap-vue, bootstrap installed with scope prod
```

<Note type="warning">
Some inefficiency as Bootstrap 3 is still imported by shiny
</Note>

We can then import bootstrap-vue in our project by editing the `srcjs/index.js` file.

```js {highlight:['2-4',9,11]}
import Vue from "vue";
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import App from "./Home.vue";

// Install BootstrapVue
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

new Vue({
  el: "#app",
  template: "<App/>",
  components: { App }
});

```

Finally, we can use bootstrap in Vue, below we modify the `srcjs/Home.vue` file to have an text input and a button. Note that it also sends the data back to the R sever where it can be used with `input$text` (highlighted line below).

```vue {highlight:[20]}
<template>
  <div>
    <b-form-input v-model="inputText" placeholder="Enter your name" @keyup.enter="processText"></b-form-input>
    <b-button @click="processText" variant="outline-primary">Button</b-button>
    <h2>Your name is <span>{{ text }}</span></h2>
  </div>
</template>

<script>
module.exports = {
  data: function() {
    return {
      text: '',
      inputText: ''
    };
  },
  methods: {
    processText: function(){
      this.text = this.inputText // set text var
      Shiny.setInputValue('text', this.text);
      this.inputText = '' // remove input once entered
    }
  }
};
</script>
```

![](_media/vue-bs4.gif)
