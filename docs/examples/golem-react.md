# Golem with React

In this example we setup a golem application that uses React for some of the front-end. This starts by creating a new golem application then scaffolding for golem using packer, setting `react` to `TRUE` in the latter. This will set up the necessary babel configuration file, babel loader, create a template file and more to ensure react can be transpiled.

```r
golem::create_golem("reaction")
packer::scaffold_golem(react = TRUE)
```

```
── Scaffolding golem ───────────────────────────────────────────────────────────────────────

✔ Initialiased npm
✔ webpack, webpack-cli, webpack-merge installed with scope dev
✔ Added npm scripts
✔ Created `srcjs` directory
✔ Created `srcjs/config` directory
✔ Created webpack config files

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/Packages/reaction'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.dev\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.prod\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.common\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── React loader ──

✔ @babel/core, @babel/preset-env, @babel/preset-react, babel-loader installed with scope dev
✔ Added bundling rule
✔ react, react-dom installed with scope prod

── Babel config file ──

✔ Created `.babelrc`
✔ Adding '^\\.babelrc$' to '.Rbuildignore'

✔ Replaced `srcjs/index.js` with react template
! Place the following at the bottom of your shiny ui:
div(id = "app"), tags$script(src = "www/index.js")

── Scaffold built ──

ℹ Run `bundle` to build the JavaScript files
```

Note the message indicating something needs to be added at the bottom of the shiny UI. This is because webpack will bundle the JavaScript in an `index.js` file and the template uses the `div` where `id="app"`  as root.

```r
# app_ui
fluidPage(
  h1("reaction"),
  div(id = "app"), tags$script(src = "www/index.js")
)
```

The scaffold created the following template in `srcjs/index.js`. 

```js
import React from 'react';
import ReactDOM from 'react-dom';

const title = 'Shiny powered by React!';
 
ReactDOM.render(
  <div>{title}</div>,
  document.getElementById('app')
);
```

This inserts a div in the element where `id="app"`, hence the modifications to the shiny UI. You can then bundle the JavaScript, load the app and observe the React in the UI.

```r
packer::bundle()
devtools::load_all()
run_app()
```

![](_media/golem-react.png)

Part of the UI is still powered by shiny.
