apk:
	flutter build apk --split-per-abi --release
	flutter build appbundle --release

linux:
	flutter build linux

windows:
	flutter build windows

container-apk:
	docker run --name=example \
		--mount type=bind,source=${PWD},target=/root/wormhole/ \
		docker.io/luki42/flutter-rust \
		bash -c "cd /root/wormhole && make apk"

container-run: 
	docker run -it --rm \
	--mount type=bind,source=${PWD},target=/root/wormhole/ \
	flutter_rust bash

codegen:
	flutter_rust_bridge_codegen \
	--rust-input native/src/api.rs \
	--dart-output lib/gen/bridge_generated.dart \
	--c-output ios/Runner/bridge_generated.h \
	--dart-decl-output lib/gen/bridge_definitions.dart \
	--wasm

format:
	cd native && cargo fmt
	dart format .

lint:
	cd native && cargo clippy
	flutter analyze .

clean:
	flutter clean
	cd native && cargo clean

get-dep:
	flutter packages get

icon-gen:
	dart run icons_launcher:create

.PHONY: all apk linux windows get-dep codegen lint clean icon-gen


