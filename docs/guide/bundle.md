# Bundle

Once you have made changes to any file in the `srcjs` directory you need to bundle the JavaScript to produce the output in the `inst` directory of the package. 

<Note type = "tip">
Remember to bundle your JavaScript files to see the changes reflected in the package.
</Note>

## Development

Webpack optimises the bundle(s) differently depending on the mode: development or production. Since webpack bundles multiple files into one it can be difficult to trace back a bug and the file it originated from. To do so webpack uses a sourcemap, either as separate files or inline.

```r
packer::bundle_dev()
```

Using the above the files are bundled using a sourcemap, it's less efficient but will let you debug.

## Production

Webpack optimises the bundle differently for production, the output will be more efficient but more difficult to debug.

```r
packer::bundle_prod()
```

The production bundle removes comments, minifies the file, and
more. Also, in more recent versions, packer sets up
[terser](https://terser.org/) to remove all `console` methods at
the exception of `log`. This is great to
include messages in your development builds without having to manually delete them to remove them from the production build:
webpack takes care of that.

If you want to print to the console in your production build you
can use `info`, `warn`, `debug`, or `error`. 

<Note>

`packer::bundle()` bundles for prod by default. 

</Note>

## Watch

You can also run `watch` to automatically rebundle the files when the `src` files change.  

<Note type = "danger">
This is very CPU intensive, bundling for development is generally the better option.
</Note>
