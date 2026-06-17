// The wasm-bindgen exports are reachable as named ES module exports,
// alongside the default `init`.
import init, { add, greet } from './out.mjs';

await init();

console.log('add(17, 25) =', add(17, 25));
console.log('greet("emscripten") =', greet('emscripten'));
