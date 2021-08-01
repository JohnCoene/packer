# PWA

Progressive Web Applications (or PWAs) are web apps that deliver an
experience similar to native applications. There are many things
that can contribute to that. Of these, the most significant is the
ability for an app to be able to function when __offline__. This is
achieved through the use of a web technology called Service Workers.

You can easily add offline experience to your shiny application
with a single function.

From a shiny application created with golem and scaffolded with
packer.

```r
golem::create_golem('pwa-app')
packer::scaffold_golem()
```

Then, add the workbox plugin with:

```r
packer::add_plugin_workbox()
```

```r
ℹ Add the following to your JavaScript (e.g.: index.js)

if ('serviceWorker' in navigator) {
	window.addEventListener('load', () => {
		navigator.serviceWorker.register('/www/service-worker.js').then(registration => {
			console.log('SW registered: ', registration);
		}).catch(registrationError => {
			console.log('SW registration failed: ', registrationError);
		});
	});
}
```

Proceed as mentioned, add the code to your `srcjs/index.js` file.

```js
// srcjs/index.js
import { message } from './modules/message.js';
import 'shiny';

// In shiny server use:
// session$sendCustomMessage('show-packer', 'hello packer!')
Shiny.addCustomMessageHandler('show-packer', (msg) => {
  message(msg);
})

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/www/service-worker.js').then(registration => {
      console.log('SW registered: ', registration);
    }).catch(registrationError => {
      console.log('SW registration failed: ', registrationError);
    });
  });
}
```

After bundling the app with `packer::bundle()`, you should see
new files in the output directory (`inst/app`).

```
inst/app
└── www
    ├── favicon.ico
    ├── index.js
    ├── index.js.map
    ├── service-worker.js
    ├── service-worker.js.map
    ├── workbox-15dd0bab.js
    └── workbox-15dd0bab.js.map
```