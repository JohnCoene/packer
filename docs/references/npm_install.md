# `npm_install`

Install and Uninstall Npm Packages


## Description

Install and uninstall npm packages.


## Usage

```r
npm_install(..., scope = c("dev", "prod", "global"))
npm_uninstall(..., scope = c("dev", "prod", "global"))
```


## Arguments

Argument      |Description
------------- |----------------
`...`     |     Packages to install or uninstall. If no packages are specified then this function install packages in `package.json` (useful e.g.: after clone).
`scope`     |     Scope of installation or uninstallation, see scopes.


