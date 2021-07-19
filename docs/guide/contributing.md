# Contributing

This document attempts to ease contributing to package that use
packer.

When contrubuting you likely start from a git repository.

```bash
git clone https://github.com/someone/something.git
cd something
```

Once the repository cloned one needs to install the dependencies
that the cloned project uses. This requires using matching the
engine the project uses. There are two possible engines `npm`
(default) or `yarn`. You should run `engine_adapt()` to
make sure you use the correct engine.

```
! Setting engine to yarn to match project.
Use functions starting in `yarn`, e.g.: `yarn_install()`
```

Once you have set the correct engine you can install the
dependencies the project uses.

```r
# for npm
packer::npm_install()

# for yarn
packer::yarn_install()
```

This done you can start contributing to the project by
placing you JavaScript code in the `srcjs` directory.
