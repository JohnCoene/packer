# `use_npm`: Use npm

## Description


 By default packer looks for the npm installation using the `which` command.
 This function lets you override that behaviour and force a specific npm installation.


## Usage

```r
use_npm(path = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```path```     |     Path to npm installation to use.

## Examples

```r 
 use_npm("/usr/local/bin/npm") 
 
 ``` 

