# Docs

Webpack itself doesn't enable documenting but certainly 
facilitates it. Documenting JavaScript code should be 
familiar to R programmers as very much resembles roxygen2.

Within the JavaScript code we add special comments and tags,
just as we do with roxygen2, many of the tags themselves also
bear the same name. 

All tags can be found on the [official website](https://jsdoc.app/).

From an existing packer project (scaffolded), add the the jsdoc
pluding with `packer::add_plugin_jsdoc`.

This installs the plugin and creates a configuration
file `jsdoc.conf.json`. The default should work fine but you can
always take a look at the 
[official documentation](https://jsdoc.app/about-configuring-jsdoc.html)
if you want to customise things further.

Once this done, one can add documentation to the JavaScript code.

```r
/**
 * Adds one to a number
 * @param {number} x - A number.
 */
const AddOne = (x) => {
	return x + 1;
}
```

Next time the code is bundled (`packer::bundle`) documentation
will be generated in the `jsdoc/` directory (this can also be
changed in the config).

The documentation produced is essentially equivalent to a 
[pkgdown](https://github.com/r-lib/pkgdown/) website for 
JavaScript code.
