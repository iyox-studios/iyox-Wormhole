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
  };
  outputs = inputs @ {
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [ "x86_64-linux" ];
      perSystem = {
        system,
        pkgs,
        self',
        lib,
        ...
      }: let
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = ["34.0.0"];
          platformVersions = ["35" "34"];
          abiVersions = ["armeabi-v7a" "arm64-v8a" "x86" "x86_64"];
          includeNDK = true;
          ndkVersions = ["26.1.10909125"];
          toolsVersion = "26.1.1";
          platformToolsVersion = "34.0.5";

          cmakeVersions = ["3.22.1"];
        };
        androidSdk = androidComposition.androidsdk;
        pubspecLock = pkgs.lib.importJSON ./pubspec.lock.json;

        gradle = pkgs.callPackage (pkgs.gradleGen {
          version = "8.8";
          hash = "sha256-pLQVhgH4Y2ze6rCb12r7ZAAwu1sUSq/iYaXorwJ9xhI=";
          defaultJava = pkgs.jdk;
        }) {};
      in rec {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
          overlays = [
            (final: prev: {
              flutter = prev.flutter.wrapFlutter (prev.flutter324.unwrapped.override {
                patches =
                  prev.flutter.unwrapped.patches
                  ++ [
                    ./nix/flutter.patch
                    ./nix/flutter2.patch
                    ./nix/flutter3.patch
                  ];
              });
            })
          ];
        };
        devShells.default = with pkgs;
          mkShell rec {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
            FLUTTER_SDK = "${pkgs.flutter}";
            JAVA_HOME = "${pkgs.jdk.home}";
            buildInputs = [
              flutter
              androidSdk
              jdk
              yq
              gradle
            ];
          };

        packages = {
          android = pkgs.callPackage ./nix/android.nix {
            inherit androidSdk pubspecLock gradle;
            pname = "iyox-wormhole";
            version = "1.0";
          };
          update-locks = pkgs.callPackage ./nix/update-locks.nix {
            inherit gradle;
          };
          update-verification-metdata = pkgs.callPackage ./nix/update-verification-metadata {
            inherit gradle;
          };
        };
        formatter = pkgs.alejandra;

        checks = let
          packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
          devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
        in
          packages // devShells;
      };
    };
}
