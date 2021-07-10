# Engines

There are two available "engines" as packer calls them:

- [npm](https://www.npmjs.com/) (default)
- [yarn](https://yarnpkg.com/)

Some developers prefer yarn, others npm, the differences 
are minor. They both manage the packages (dependencies)
these will be installed, uninstalled, etc. differently
but ultimately they do the same thing.

NPM (Node Package Manager) comes out-of-the-box (hence it is
the default), while yarn is an open-source project initiated
by Facebook.

If you want to use yarn, first install it globally with:

```r
packer::engine_yarn_install()
```

Then __before scaffolding__ your project set the engine to 
yarn with.

```r
packer::engine_set("yarn")
```

This is error prone however, as everytime one reopen a project
one has to remember to run this function.

<Note type = "tip">
Set the environment variable <code>PACKER_ENGINE</code> to 
<code>yarn</code>
</Note>

To set the environment variable you may use 
`usethis::edit_r_environ()`.
