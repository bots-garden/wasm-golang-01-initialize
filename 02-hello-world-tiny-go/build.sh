#!/bin/bash
tinygo build -scheduler=none --no-debug \
  -o main.wasm \
  -target wasi main.go

ls -lh *.wasm