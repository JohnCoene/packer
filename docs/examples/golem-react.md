# Golem with React

In this example we setup a golem application that uses React for some of the front-end. This starts by creating a new golem application then scaffolding for golem using packer, setting `react` to `TRUE` in the latter. This will set up the necessary babel configuration file, babel loader, create a template file and more to ensure react can be transpiled.

```r
golem::create_golem("reaction")
packer::scaffold_golem(react = TRUE)
```

```
── Scaffolding golem ─────────────────────────────────────────────────────────── 

✔ Initialiased npm
✔ webpack, webpack-cli, webpack-merge installed with scope dev
✔ Added npm scripts
✔ Created srcjs directory
✔ Created path directory
✔ Created webpack config files

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/Projects/reaction'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.dev\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.prod\\.js$' to '.Rbuildignore'
✔ Adding '^webpack\\.common\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── React loader & dependencies ──

✔ babel-loader installed with scope dev
✔ Added loader rule for 'babel-loader'
✔ react, react-dom installed with scope dev
✔ @babel/core, @babel/preset-env, @babel/preset-react installed with scope dev
✔ Created R/react_cdn.R containing `reactCDN()` function

── Babel config file ──

✔ Created .babelrc
✔ Adding '^\\.babelrc$' to '.Rbuildignore'

✔ Created template srcjs/index.js
! Place the following at in your shiny ui:
tagList(
  reactCDN(),
  div(id = "app"),
  tags$script(src = "www/index.js")
)

── Scaffold built ──

ℹ Run `bundle` to build the JavaScript files
```

Note the message indicating something needs to be added at the bottom of the shiny UI. This is because webpack will bundle the JavaScript in an `index.js` file and the template uses the `div` where `id="app"` as root. Also, by default packer does not setup webpack to bundle the `react` and `react-dom` dependencies, it instead makes use of the CDN by creating an R file `R/react_cdn.R` which contains a `reactCDN()` function meant to be placed in the shiny UI. This can be turned off with `use_cdn = FALSE` in `scaffold_golem`.

```r {highlight:['3,4-8']}
# app_ui
fluidPage(
  golem_add_external_resources(),
  h1("reaction"),
  tagList(
    reactCDN(),
    div(id = "app"),
    tags$script(src = "www/index.js")
  )
)
```

The scaffold created the following template in `srcjs/index.js`. 

```js
// Added by apply_react
import React from 'react';
import { createRoot } from 'react-dom/client';

// Added by apply_react
import 'shiny';

Shiny.addCustomMessageHandler('ask-alert', (msg) => {
  let response = prompt(msg);
  Shiny.setInputValue('askResponse', response);
});


const title = 'Shiny powered by React!';

createRoot(
  document.getElementById('app')
).render(
  <div>{title}</div>
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
