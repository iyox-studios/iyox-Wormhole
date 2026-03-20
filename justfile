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
