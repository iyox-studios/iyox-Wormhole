#!/usr/bin/env just --justfile

clean:
    flutter clean
    cd rust && cargo clean

lint:
    cd rust && cargo fmt
    dart format .

pubspecJSON:
	cat pubspec.lock | yq . > pubspec.lock.json

buildrunner mode:
	flutter pub run build_runner {{mode}}
