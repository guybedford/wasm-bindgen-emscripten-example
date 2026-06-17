#!/usr/bin/env bash
# Build a Rust staticlib with #[wasm_bindgen] exports and link it with
# Emscripten under -sMODULARIZE=instance, demonstrating that the clean
# wasm-bindgen exports (`add`, `greet`) are emitted as named ES module exports.
#
# Requirements on $PATH: cargo, the wasm32-unknown-emscripten target,
# wasm-bindgen, and emcc (override with EMCC=/path/to/emcc).
set -euo pipefail

cd "$(dirname "$0")"

EMCC="${EMCC:-emcc}"
TARGET=wasm32-unknown-emscripten
LIB="target/$TARGET/debug/libwasm_bindgen_emscripten_example.a"

echo "==> Building Rust staticlib"
cargo build --target "$TARGET"

echo "==> Linking with emcc (-sWASM_BINDGEN -sMODULARIZE=instance)"
echo 'int main() { return 0; }' > empty.c
"$EMCC" empty.c "$LIB" \
  -fwasm-exceptions \
  -sWASM_BINDGEN \
  -sMODULARIZE=instance \
  -Wno-experimental \
  -o out.mjs

echo "==> Verifying named ES module exports"
node ./run.mjs
