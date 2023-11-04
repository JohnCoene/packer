# Installation

Under the hood, many of the functionalities of packer are powered by [npm](https://www.npmjs.com/), Node's Package Manager which comes bundled with node.js.

## Node

### Mac OS

The easiest way is via homebrew.

```
brew update
brew install node
```

Otherwise there is also an [installer](https://nodejs.org/en/download/).

### Ubuntu

```
sudo apt install nodejs npm
```

### Windows

Download and install the official [executable](https://nodejs.org/en/download/) or use [chocolatey](https://chocolatey.org/).

```
cinst nodejs
# or for full install with npm
cinst nodejs.install
```

Or use [scoop](https://scoop.sh/).

```
scoop install nodejs
```

### Other

If you are on another OS or Linux distro check the official, very concise [guide](https://nodejs.org/en/download/package-manager/) to install from various package managers.

## R Package

Once you have the dependency you can install the stable version of packer from CRAN.

```r
install.packages("packer")
```

Or get the development version from Github

```r
# install.packages("remotes")
remotes::install_github("JohnCoene/packer")
```

## Yarn

By default packer will use npm, you can use yarn instead.
There is far more on this in the [engine](/#/guide/engines) 
documentation.

If you want to use yarn you will need to have it installed.
You can do so with `engine_yarn_install`.
