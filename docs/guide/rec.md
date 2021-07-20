# Recommendations

These are recommendations to make working with webpack and 
packer slightly easier for yourself and others who may
want to contribute to your project.

## Hook

When developing you will want to use `packer::bundle_dev()` to
include the sourcemap to have useful error messages.

However, you may want to ensure that you do not push the 
development bundle. You want to make sure that the JavaSript
files you push to Github are optimisied and minified.

You can run `packer::put_precommit_hook()`, this will add a 
pre-commit hook that will make sure that the JavaScript files
you commit are minified, if not, an error message is displayed
and the files are not committed.

Run `packer::bundle_prod()` to fix this.

## Engine

You may have gone through the documentation on [engines](/engines),
this explains how to set your default engine of choice 
(npm or yarn). But what if your engine defaults from that of 
the project you want to contribute to?

The easiest way to tackle this for yourself, and ensure that 
others use the right engine to contribute to your project is to
use `put_rprofile_adapt()`.

This will add `engine_adapt()` to the `.Rprofile` thereby making
sure that everyone uses the same engine.

## Checks

You can always run `packer::checks` to see whether the above are
in place.
