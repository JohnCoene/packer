# Recommended

These are recommendations to make working with webpack and 
packer slightly easier for yourself and others who may
want to contribute to your project.

<Note type="tip">
You can run <code>put_recommended()</code> to use the two
recommended checks below.
</Note>

## Roclet

There are two roclets to bundle the code when documenting the
package, e.g.: with `devtools::document()`.
You can pass manually every time you document or edit the 
`DESCRIPTION` so it is picked up automatically.

```
Roxygen: list(markdown = TRUE, roclets = c("namespace", "collate", "rd", "packer::prod_roclet"))
```

Ideally you'd want to use `prod_roclet` as shown above 
(so the code is optimised for prod), alternatively
you can use the `dev_roclet`.

## Hook

When developing you will want to use `packer::bundle_dev()` to
include the sourcemap to have useful error messages.

However, you may want to ensure that you do not commit the 
development bundle to your version control system. 
You want to make sure that the JavaSript
files you push to, say, Github, are optimisied and minified.

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

## Github Actions

You can add a github action to make sure that others (and yourself)
that make pull requests have bundled the JavaScript files for 
production. This can be included with 
`packer::include_action_check()`.
If the files are not minified the action fails, it succeeds
otherwise.

## Test

You can also add a [testthat](https://testthat.r-lib.org/) test
to your package to ensure that the JavaScript files are minified
with `packer::put_test()`.

## Checks

You can always run `packer::checks` to see whether the above are
in place.
