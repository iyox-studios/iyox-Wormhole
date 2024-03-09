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
      in rec {
        devShell = with pkgs;
          mkShell rec {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_JAVA_HOME = "${pkgs.jdk.home}";
            ANDROID_NDK = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}";
            buildInputs = [
              act
              rustToolchain
              flutter
              androidSdk
              gnome.zenity
              fastlane
            ];
          };

        formatter = pkgs.alejandra;

        buildMavenRepo = pkgs.callPackage ./nix/maven-repo.nix { };
                    mavenRepo = buildMavenRepo {
                        name = "nix-maven-repo";
                        repos = [
                          "https://dl.google.com/dl/android/maven2"
                          "https://repo1.maven.org/maven2"
                          "https://maven.pkg.jetbrains.space/kotlin/p/kotlin/dev"
                          "https://plugins.gradle.org/m2"
                        ];
                        deps = builtins.fromJSON (builtins.readFile ./nix/deps.json);
                      };

        packages = with pkgs; {
           updateLocks = callPackage ./nix/update-locks.nix { };
          default = flutter.buildFlutterApplication rec {
            pname = "iyox-wormhole";
            version = "0.0.7";
            src = ./.;

            pubspecLock = lib.importJSON ./pubspec.lock.json;

            cargoRoot = "native";

            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            JAVA_HOME = "${jdk.home}";

            cargoDeps = rustPlatform.fetchCargoTarball {
              name = "${pname}-${version}-cargo-deps";
              src = ./native;
              #inherit src;
              #sourceRoot = "src/native";
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
              gradle_7
              rustToolchain
              copyDesktopItems
            ];

            buildInputs = [
              udev
            ];

            configurePhase = ''
              echo "sdk.dir=${androidSdk}/libexec/android-sdk" >> android/local.properties
              echo "flutter.sdk=${flutter}" >> android/local.properties
              cat android/local.properties
            '';

            buildPhase = ''
              runHook preBuild
              cd android
              gradle app:assembleRelease \
              --offline --no-daemon --no-build-cache --info --full-stacktrace \
              --warning-mode=all --parallel --console=plain \
              -PnixMavenRepo=${mavenRepo} \
              -Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/30.0.3/aapt2
              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp -r app/build/outputs/* $out
              runHook postInstall
            '';

            extraWrapProgramArgs = "--chdir $out/app";
          };
        };
      }
    );
}
