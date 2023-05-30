apk:
	flutter build apk --target-platform android-arm64
	flutter build appbundle

linux:
	flutter build linux

codegen:
	CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include" flutter_rust_bridge_codegen \
	--rust-input native/src/api.rs \
	--dart-output lib/gen/bridge_generated.dart \
	--c-output ios/Runner/bridge_generated.h \
	--dart-decl-output lib/gen/bridge_definitions.dart \
	--wasm

deploy:
	fastlane deploy

elevate:
	fastlane elevate

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
