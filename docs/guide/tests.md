# Unit Tests

Just like one can run unit tests for R code using [testthat](https://testthat.r-lib.org/), one can also test JavaScript code. Currently packer supports [mocha.js](https://mochajs.org/).

```r
# create a package and a scaffold
usethis::create_package("display")
packer::scaffold_output("display")
```

With a package and scaffold one can add tests.

```r
packer::include_tests()
```

```
✔ Created `testjs` directory
✔ mocha installed with scope dev
✔ mocha-loader installed with scope dev
✔ Added loader rule for mocha-loader

── Ignoring files ──

✔ Adding '^testjs$' to '.Rbuildignore'
✔ Adding 'testjs' to '.gitignore'
✔ Added npm test script
```

This creates a new `testjs` directory in which one can place tests; all the names of files containing tests should end with `.test.js`, e.g.: `name.test.js`. The function places a `template.test.js` file containing the following tests (one that should pass and another fail).

```js
// test.js
describe('Test', () => {
  it('should succeed', (done) => {
    setTimeout(done, 1000);
  });

  it('should fail', () => {
    if (require('./module')) {
      throw new Error('Failed');
    }
  });
});
```

Then run the tests.

```r
packer::run_tests()
```

```
Test
  ✓ should succeed (1004ms)
  1) should fail


1 passing (1s)
1 failing
```

You can add tests by creating a file yourself or use `packer::add_test_file()`
