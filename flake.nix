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
    flake-utils.lib.eachDefaultSystem (system: let
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
        platformVersions = ["33" "32" "31" "28"];
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
          flutter
          # dart
          gnumake
          check
          pkg-config
          glibc
          android-tools
          jdk
          git
          musl
          libcxx
          glibc
          glibc_multi
          pkg-config
          libclang
        ];

        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/flutter \
            --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home}

          wrapProgram $out/bin/android-studio \
            --prefix FLUTTER_SDK=${pkgs.flutter} \
            --prefix ANDROID_JAVA_HOME=${pkgs.jdk.home} \
            --prefix ANDROID_NDK=${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}
        '';
      };
    in {
      devShell = with pkgs;
        mkShell rec {
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          ANDROID_JAVA_HOME = "${pkgs.jdk.home}";
          ANDROID_NDK = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}";
          buildInputs = [
            myAndroidStudio
            rustToolchain
            flutter
            androidSdk
            gnumake
            jdk11
            libstdcxx5
            libzra
            libzip
            zlib
            libllvm
            libclang
            llvm
            musl
            libcxx
            glibc
            glibc_multi
            pkg-config
            libclang
          ];
          #GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/${buildToolsVersion}/aapt2";
        };
    });
}
