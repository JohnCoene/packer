# typed.js

In this example we use packer to scaffold an htmlwidget and use the npm package [typed.js](https://github.com/mattboldt/typed.js).

```r
usethis::create_package("type")
packer::scaffold_widget("type")
```

We can then install the typed.js in prod as this is needed from the browser.

```r
packer::npm_install("typed.js", scope = "prod")
```

Then we can edit the `srcjs/widgets/type.js` file to use typed.js.

```js {highlight:[3, 14,21]}
// typed.js
import 'widgets';
import Typed from 'typed.js';

HTMLWidgets.widget({

  name: 'type',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var typed;

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        typed = new Typed('#' + el.id, x);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
```

Then adapt the `type.R` file to receive the `strings` and, optionally, other parameters to pass to typed.js.

```r {highlight:[2,5]}
# type.R
type <- function(strings, ..., width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(strings = strings, ...)

  # create widget
  htmlwidgets::createWidget(
    name = 'type',
    x,
    width = width,
    height = height,
    package = 'type',
    elementId = elementId
  )
}
```

Then the files can be bundled.

```r
packer::bundle()
```

And finally the package can be used.

```r
type(c("hello", "packer!"), loop = TRUE, typeSpeed = 20)
```

![](_media/typed.gif)
