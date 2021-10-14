# `apply_framework7`

Apply Framework7


## Description

Apply Framework7 to a project, adds the relevant (babel) loader, installs dependencies,
 and creates, or updates, or replaces the `srcjs/index.js` file.


## Usage

```r
apply_framework7()
```


## Details

After running this function and bundling the JavaScript remember to place
 div(id = "app"), tags$script(src = "www/index.js") at the bottom of your shiny UI.


