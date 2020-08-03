# Shiny app with Pug

In this example we build a shiny app with golem where the UI is fully powered by the [pug](https://pugjs.org/api/getting-started.html) templating engine.

```r
golem::create_golem("puggy")
packer::scaffold_golem()
```

Then add the webpackHtmlPlugin with the command below; `use_pug` installs and the pug loader and makes the requirements changes to the config files. It also places a pug template in the `srcsjs` directory. The plugin allows generating HTML using webpack, in this case compile it.

```r
add_plugin_html(use_pug = TRUE)
```

```
✔ pug, pug-loader installed with scope dev
✔ Added bundling rule
✔ Created template `srcjs/index.pug`
ℹ Use `shiny::htmlTemplate(system.file("app/index.html", package = "puggy"))` as your shiny UI.
```

We then modify the `run_app` function as below, we bring the `add_resource_path` from `app_ui.R` to the `run_app` function, otherwise the bundle is not served and we use the template generated with `shiny::htmlTemplate`.

```r {highlight:[2,'6-8']}
run_app <- function(...) {
  add_resource_path('www', app_sys('app/www'))
  
  with_golem_options(
    app = shinyApp(
      ui = shiny::htmlTemplate(
        system.file("app/index.html", package = "puggy")
      ), 
      server = app_server
    ), 
    golem_opts = list(...)
  )
}
```

You will find an `index.pug` file in the `srcjs` directory. Below we make a tiny modification to include a shiny `actionButton`.

```pug
//- layout.pug
doctype html
html
  head
    script(src="shared/jquery.js")
    script(src="shared/shiny.js")
    link(rel="stylesheet" type="text/css" href="shared/shiny.css")
    title Hello Packer
  body
    p Place the content here
    button(id="fromPug" type="button" class="btn btn-default action-button") Click me!
```

Note that the attributes necessary to create the `actionButton` can be obtained by inspecting a shiny app or creating a button from the console. Also, the template pug file includes the dependencies required to run shiny but does not include bootstrap so styling will be different, feel free to include it.

```r
shiny::actionButton("fromPug", "Click me")
## <button id="fromPug" type="button" class="btn btn-default action-button">Click me</button>
```

We then also add an `observeEvent` to make sure the button works.

```r
app_server <- function( input, output, session ) {
  # List the first level callModules here
  observeEvent(input$fromPug, {
    print("Hello from Pug")
  })
}
```

Then load the package and run the app.

```r
devtools::load_all()
run_app()
## Hello from Pug
```

![](_media/golem-pug.png)
