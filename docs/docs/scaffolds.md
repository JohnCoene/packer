# Scaffolds

## Golem

The `scaffold_golem` function will lay down the scaffolding for a golem package.

```r
golem::create_golem("stocks") # create golem
packer::scaffold_golem()
```

```
── Scaffolding golem ──────────────────────────────────────────────────── 

✔ Initialiased npm
✔ webpack, webpack-cli installed
✔ Added npm scripts
✔ Created `srcjs` directory
✔ Created webpack config file

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/home/jp/Projects/stocks'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.config\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── Scaffold built ──

ℹ Run `bundle` to build the JavaScript files
```

This will let you use packer to bundle files to `inst/app/www`.

<Danger title="Unique" text="The scaffold for golem is unique in that only one can be laid down." />

## Widgets

Htmlwidgets can also be scaffolded with `scaffold_widget`. Note that is will internally run `htmlwidgets::scaffoldWidget`.

```r
usethis::create_package("plotly")
packer::scaffold_widget("write_h1")
```

```
── Scaffolding widget ───────────────────────────────────────── write_h1 ── 

✔ Bare widget setup
✔ Created `srcjs` directory
✔ Initialiased npm
✔ webpack, webpack-cli installed
✔ Created webpack config file
✔ Created `srcjs/modules` directory
✔ Created `srcjs/widgets` directory
✔ Created `srcjs/index.js`
✔ Moved bare widget to `srcjs`
✔ Added npm scripts

── Adding files to .gitignore and .Rbuildignore ──

✔ Setting active project to '/home/jp/Projects/plotly'
✔ Adding '^srcjs$' to '.Rbuildignore'
✔ Adding '^node_modules$' to '.Rbuildignore'
✔ Adding '^package\\.json$' to '.Rbuildignore'
✔ Adding '^package-lock\\.json$' to '.Rbuildignore'
✔ Adding '^webpack\\.config\\.js$' to '.Rbuildignore'
✔ Adding 'node_modules' to '.gitignore'

── Adding packages to Imports ──

✔ Adding 'htmlwidgets' to Imports field in DESCRIPTION
● Refer to functions with `htmlwidgets::fun()`

── Scaffold built ──

ℹ Run `bundle` to build the JavaScript files
```

This produces a toy widget which renders a message in HTML `h1` tags.

```r
packer::bundle()
devtools::document()
devtools::load_all()
write_h1("hello packer!")
```

![](_media/toy-widget.png)

<Danger title="Warning" text="Do not run scaffold the widget with the htmlwidgets package" />

## Extensions

## Inputs

## Outputs

