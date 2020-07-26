# `npm_install`: Install Npm Packges

## Description


 Install npm packges.


## Usage

```r
npm_install(..., scope = c("prod", "dev", "global"))
```


## Arguments

Argument      |Description
------------- |----------------
```...```     |     Packages to install.
```scope```     |     Scope of installation, see scopes.

## Examples

```r 
 # install browserify globally
 npm_install("browserify", scope = "global") 
 
 ``` 

