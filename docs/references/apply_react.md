# `apply_react`: Apply React

## Description


 Apply React to a project, adds the relevant (babel) loader, installs dependencies,
 and creates, updates, or replaces the `srcjs/index.js` file.


## Usage

```r
apply_react(use_cdn = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
```use_cdn```     |     Whether to use the CDN for `react` and `react-dom` (recommended). This means later importing the dependencies in the shiny UI using `reactCDN()` , this function will be created in a `R/react_cdn.R` . The correct instructions to do so are printed to the console by the function.

## Details


 After running this function and bundling the JavaScript remember to place
 the code printed by the function in shiny UI. By default [`apply_react()`](apply_react().html) does not
 bundle `react` and `react-dom` and thus requires using `reactCDN()` to import the
 dependencies in the shiny application: this function is created in a `R/react_cdn.R` .


## Examples

```r 
 list("\n", "golem::create_golem(\"reaction\")\n", "packer::scaffold_golem(react = TRUE)\n") 
 
 ``` 

