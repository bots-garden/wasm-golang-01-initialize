#!/bin/bash
GOOS=wasip1 GOARCH=wasm go build -o main.wasm main.go
ls -lh *.wasm
