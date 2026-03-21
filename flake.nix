{
  description = "Flutter 3.27.4";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    flake-parts,
    rust-overlay,
    naersk,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {
        system,
        pkgs,
        self',
        lib,
        ...
      }: let
        ndkVersion = "26.1.10909125";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = ["34.0.0"];
          platformVersions = ["35" "34" "33" "31"];
          abiVersions = ["armeabi-v7a" "arm64-v8a" "x86" "x86_64"];
          includeNDK = true;
          ndkVersions = [ndkVersion];
          toolsVersion = "26.1.1";
          platformToolsVersion = "34.0.5";

          cmakeVersions = ["3.22.1"];
        };
        androidSdk = androidComposition.androidsdk;

        gradle = pkgs.callPackage (pkgs.gradleGen {
          version = "8.8";
          hash = "sha256-pLQVhgH4Y2ze6rCb12r7ZAAwu1sUSq/iYaXorwJ9xhI=";
          defaultJava = pkgs.jdk;
        }) {};

        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust/rust-toolchain.toml;
        rustLib = rustToolchain.override {
          extensions = ["rust-src"];
        };
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
          overlays = [
            (import rust-overlay)
          ];
        };
        devShells.default = with pkgs;
          mkShell {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
            FLUTTER_SDK = "${pkgs.flutter}";
            JAVA_HOME = "${pkgs.jdk.home}";
            RUST_SRC_PATH = "${rustLib}/lib/rustlib/src/rust/library";
            buildInputs = [
              flutter
              androidSdk
              jdk
              yq
              just
              gradle

              # Rust
              rustToolchain
              flutter_rust_bridge_codegen
              cargo-expand

              fastlane
            ];
          };

        formatter = pkgs.alejandra;
      };
    };
}
