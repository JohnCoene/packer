# TypeScript

TypeScript has grown in popularity when working with JavaScript.
It's a superset of the language, TypeScript is a JavaScript with
types, types make code slightly more verbose but clearer and
more strict. TypeScript code gets ultimately transpiled to
JavaScript.

We'll demonstrate with a golem application: create the app 
and the scaffold.

```r
golem::create_golem('something')
packer::scaffold_golem()
```

Once this done one can add the TypeScript loader with

```r
packer::use_loader_ts()
```

```
✔ typescript, ts-loader installed with scope "dev"
✔ Added loader rule for "typescript" and "ts-loader"
✔ Writing tsconfig.json
```

Note that this also creates `tsconfig.json` (if not already
present).

There are a few things that need changing, TypeScript uses
file with `.ts` extension. So we should rename the files
in the `srcjs` directory.

- `srcjs/index.js` -> `srcjs/index.ts`
- `srcjs/modules/message.js` -> `srcjs/modules/message.ts`

We'll simplify the example. In `index.ts` we'll just have
the simple code below, note that we removed the `.js`
extension from the import statement.

```ts {highlight: [2]}
// index.ts
import { message } from './modules/message';

message("Hello TypeScript");
```

Then we modify the `message` to specify the type of the
`msg` argument.

```ts {highlight: [2]}
// modules/message.ts
export const message = (msg: string) => {
  alert(msg);
}
```

That is it, one can bundle, load the package and run the app.

```r
packer::bundle()
devtools::load_all()
run_app()
```

There is, of course, a lot more to this, head to the 
[TypeScript website](https://www.typescriptlang.org/)
to learn more.
