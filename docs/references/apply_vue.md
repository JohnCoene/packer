## `apply_vue`: Apply Vue

### Description


 Apply Vue to a project, adds the relevant (babel) loader, installs dependencies,
 and creates, or updates, or replaces the `srcjs/index.js` file.


### Usage

```r
apply_vue(use_cdn = TRUE)
```


### Arguments

Argument      |Description
------------- |----------------
```use_cdn```     |     Whether to use the CDN for `vue` (recommended). This means later importing the dependencies in the shiny UI using `vueCDN()` , this function will be created in a `R/vue_cdn.R` . The correct instructions are printed to the console by the application.

### Details


 After running this function and bundling the JavaScript remember to place
 div(id = "app"), tags$script(src = "www/index.js") at the bottom of your shiny UI.


### Examples

```r 
 list("\n", "golem::create_golem(\"useVue\")\n", "packer::scaffold_golem(vue = TRUE)\n") 
 
 ``` 

