# Styling

Oftentimes JavaScript and CSS code interplay, you might
use JavaScript to dynamically toggle between classes,
or create elements with on-the-fly styling.

Therefore, one might be interested in including the CSS in the
JavaScript code.

As always with webpack there are many different ways to achieve
this and the documentation for the various configurations
can be confusing.

The one advised by packer can be setup with `use_loader_style`.
To demonstrate we'll create simple golem application.

```r
golem::create_golem('css-app')
packer::scaffold_golem()
```

The above creates a golem project and scaffolds a plain packer
setup. We'll modify the default to, instead of showing the 
message as an alert, inserts it into the body of the app.

First, we'll add the aforementioned loader.

```r
packer::use_loader_style()
```

Now we'll edit `srcjs/modules/message.js` file to import the CSS
file (we'll create it next).

Note that imports the CSS as a `styles` object then, on line 8,
we add the class `msg` from the object.

```js {highlight: [3,8]}
import 'jquery';

import styles from './msg.css';

const message = (msg) => {
  let div = document.createElement("h1");
  $(div).text(msg);
  $(div).addClass(styles.msg);
  $('body').append(div);
}

export { message };
```

The CSS file is placed in `srcjs/modules/msg.css` and
looks like the code below.

```css
:local .msg{
	color: red;
}
```

This is where the magic happens essentially, we can scope
the CSS. The `:local` prefix will scope the class according
to where it is imported. 

There are other scopes and much more depth to this
mechanism. 
For more documentation on scoping can be found on the 
[webpack site](https://webpack.js.org/loaders/css-loader/#scope)

This enables many things, such as avoiding having clashes between 
CSS selectors. Also the tight integration of CSS and JavaScript
means that, for instance, removing the `.msg` class from the CSS
will break the JavaScript: it will not bundle. 
This is what we want.
Removing the class will break the code either way, the difference
is that _it fails loudly at build time rather than silently at 
run time._

```r
# R/app_server.R
app_server <- function( input, output, session ) {
  session$sendCustomMessage('show-packer', "The Message!") 
}
```

To test it add the trigger to the server and run the app.

```r
packer::bundle()
devtools::load_all()
run_app()
```

Once running you can inspect the code (or generated JavaScript).
You will notice that the message appears in the app in red as
styled by the CSS file. 

However, the class applied to that element is not `.msg` as 
defined in the CSS, it's a generated id 
(e.g.: `_35BUzsK8ifHlhmsJOM0CJT`). This is the effect of the 
scoping and will ensure there are no clashes across the app.
