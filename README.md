# wasm-bindgen + Emscripten (MODULARIZE=instance) example

Demonstrates that `#[wasm_bindgen]` exports are emitted as named ES module
exports when a Rust staticlib is linked with `-sWASM_BINDGEN
-sMODULARIZE=instance -sEXPORT_ES6=1`.

```sh
./build.sh
```

Expected output:

```
add(17, 25) = 42
greet("emscripten") = Hello, emscripten!
```

The generated `out.mjs` exposes the clean wasm-bindgen API as named exports:

```js
import init, { add, greet } from './out.mjs';
await init();
add(17, 25); // 42
```

In factory mode (`-sMODULARIZE=1`) the same functions are reachable as
`Module.add` / `Module.greet`.

## Requirements

- `cargo` with the `wasm32-unknown-emscripten` target installed
- `wasm-bindgen` on `$PATH`
- `emcc` on `$PATH` (or set `EMCC=/path/to/emcc`)
