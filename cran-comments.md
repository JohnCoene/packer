## Test environments
* local R installation, R 4.0.1
* ubuntu 16.04 (on travis-ci), R 4.0.1
* win-builder (devel)
* rhub, R 4.0.1
* appveyor, Windows, R 4.0.2

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

> \dontrun{} should only be used if the example really cannot be executed
> (e.g. because of missing additional software, missing API keys, ...) by
> the user. That's why wrapping examples in \dontrun{} adds the comment
> ("# Not run:") as a warning for the user.
> Does not seem necessary.
> Please unwrap the examples if they are executable in < 5 sec, or replace
> \dontrun{} with \donttest{}.

I have removed the problematic examples. The `\dontrun{}` are not misplaced:
these genuinely cannot be run.

> Please ensure that your functions do not write by default or in your
> examples/vignettes/tests in the user's home filespace (including the
> package directory and getwd()). This is not allowed by CRAN policies.
> In your examples/vignettes/tests you can write to tempdir().

I'm afraid I cannot this is precisely the aim of the package; it does something
similar to roxygen2 and htmlwidgets. In that sense it does not write in any 
root directory, it checks that the root is an R package.
