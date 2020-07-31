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

<Note>

`packer::bundle()` bundles for prod by default. 

</Note>
