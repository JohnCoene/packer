# Library and Minification

By default webpack will minify and optimise the code a great deal.

Take the following piece of JavaScript code for instance.

```js
// global variable
let number = 41;

// my hello function
function hello(myVariable){
    let total = number + myVariable;
    console.log(total);
}
```

By default webpack will minify it; removing
whitespaces, comments, even _renaming variables._ 
This is great because it minimises file size a great deal.

```js
let n=41;function h(e){let l=n+e;console.log(l)}
```

However, what if we want to export this JavaScript code
so others can use it directly.
Other users won't be able to call the `hello` function,
it has been simplified to something unknown.

In order to preserve this we have to tell webpack we are
building a library.

Packer lets you do this with a single function.

```r
packer::make_library(name = 'myLib')
```

This will preserve the function names and make them available
at the library name provided, e.g.:

```js
myLib.hello();
```

This is useful if you have an R function that generates JavaScript
code.

```r
fooForShinyUI <- function(var){
	shiny::tags$script(
		sprintf("myLib.hello(%s)", var)
	)
}
```
