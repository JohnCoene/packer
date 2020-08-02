## `apply_react`: Apply React

### Description


 Apply React to a project, adds the relevant (babel) loader, installs dependencies,
 and creates, or updates, or replaces the `srcjs/index.js` file.


### Usage

```r
apply_react()
```


### Details


 After running this function and bundling the JavaScript remember to place
 div(id = "app"), tags$script(src = "www/index.js") at the bottom of your shiny UI.


### Examples

```r 
 list("\n", "golem::create_golem()\n", "packer::scaffold_golem(react = TRUE)\n") 
 
 ``` 

