#!/usr/bin/env -S just --justfile

default:
  @just --list

clean:
    flutter clean
    cd rust && cargo clean

lint:
    cd rust && cargo fmt
    dart format .

buildrunner mode:
	flutter pub run build_runner {{mode}} -d

codegen:
    flutter_rust_bridge_codegen generate

build-apk:
    flutter build apk --split-per-abi --release

build-aab:
    flutter build aab
