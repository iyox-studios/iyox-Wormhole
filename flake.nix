{
  description = "Flutter 3.10.0";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./native/rust-toolchain.toml;

        ndkVersion = "23.1.7779620";
        buildToolsVersion = "27.0.3";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = [buildToolsVersion "30.0.3"];
          platformVersions = ["34" "33" "32" "31" "28"];
          abiVersions = ["armeabi-v7a" "arm64-v8a"];
          includeNDK = true;
          ndkVersions = [ndkVersion];
          cmakeVersions = ["3.18.1" "3.22.1"];
        };
        androidSdk = androidComposition.androidsdk;

        myAndroidStudio = pkgs.symlinkJoin {
          name = "myAndroidStudio";
          paths = with pkgs; [
            android-studio
            rustToolchain
            flutter
            gnumake
            android-tools
            jdk
          ];

          nativeBuildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/flutter \
              --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home}

            wrapProgram $out/bin/android-studio \
              --prefix FLUTTER_SDK=${pkgs.flutter} \
              --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home} \
              --prefix ANDROID_SDK_ROOT=~/Android/Sdk
          '';
        };
      in {
        devShell = with pkgs;
          mkShell rec {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_JAVA_HOME = "${pkgs.jdk.home}";
            ANDROID_NDK = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}";
            buildInputs = [
              act
              myAndroidStudio
              rustToolchain
              flutter
              androidSdk
              gnome.zenity
              fastlane
            ];
          };

        formatter = pkgs.alejandra;

        packages = with pkgs; {
          default = flutter.buildFlutterApplication rec {
            pname = "iyox-wormhole";
            version = "0.0.7";
            src = ./.;

            pubspecLock = lib.importJSON ./pubspec.lock.json;

            cargoRoot = "native";

            cargoDeps = rustPlatform.fetchCargoTarball {
               name = "${pname}-${version}-cargo-deps"; 
               #src = ./native;
               inherit src;
               sourceRoot = "src/native";
               hash = "sha256-z2vmWwolBOaEP4DKMU2zw80gp9KH4F+TxpeqAJpjXxM=";
             };

            patches = [
              ./corrosion.patch
            ];

            preConfigure = ''
              export CMAKE_PREFIX_PATH="${corrosion}:$CMAKE_PREFIX_PATH"
            '';

            nativeBuildInputs = [
              corrosion
              #rustPlatform.cargoSetupHook
              #cargo
              rustToolchain
              copyDesktopItems
            ];

            buildInputs = [
              udev
            ];

            extraWrapProgramArgs = "--chdir $out/app";
          };
        };
      }
    );
}
