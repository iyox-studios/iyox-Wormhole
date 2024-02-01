apk:
	flutter build apk --split-per-abi --release
	flutter build appbundle --release

linux:
	flutter build linux

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

.PHONY: all apk linux get-dep codegen lint clean

# Proto generation (calls terminal proto commands)
get-dep:
	flutter packages get
