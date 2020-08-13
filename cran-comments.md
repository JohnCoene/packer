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

> Please ensure that your functions do not write by default or in your
> examples/vignettes/tests in the user's home filespace (including the
> package directory and getwd()). This is not allowed by CRAN policies.
> In your examples/vignettes/tests you can write to tempdir().

The very aim of almost all the functions in the package is precisely to so.
I'm very confused how packages like [usethis](https://github.com/r-lib/usethis),
[htmlwidgets](https://github.com/ramnathv/htmlwidgets) or 
[pkgdown](https://github.com/r-lib/pkgdown) pass CRAN checks when they do so
to a much greater extend. I have scoured their source code and cannot find
anything that prevents 
"functions do not write by default [...] in the user's home filespace"
