{
  description = "Flutter 3.10.0";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
  }: let
    pname = "iyox-wormhole";
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import rust-overlay)
          ];
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };

        version = (import ./nix/get-version.nix {inherit pkgs;}).version;
        flutter-patched = pkgs.callPackage ./nix/flutter-patch.nix {};

        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./native/rust-toolchain.toml;

        ndkVersion = "25.1.8937393";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = ["34.0.0" "30.0.3" "33.0.1"];
          platformVersions = ["35" "34" "33" "32" "31" "30" "28"];
          abiVersions = ["armeabi-v7a" "arm64-v8a" "x86" "x86_64"];
          includeNDK = true;
          ndkVersions = [ndkVersion];
          toolsVersion = "26.1.1";
          platformToolsVersion = "34.0.5";

          cmakeVersions = ["3.18.1" "3.22.1"];
        };
        androidSdk = androidComposition.androidsdk;

        cargoDeps = pkgs.rustPlatform.fetchCargoTarball {
          name = "${pname}-${version}-cargo-deps";
          src = ./native;
          hash = "sha256-GC8WPIC1a+bT3BlDNMFEzV/4LoLoFFnygNnxDLcrIFc=";
        };

        pubspecLock = pkgs.lib.importJSON ./pubspec.lock.json;
        PWD = builtins.getEnv "PWD";
      in rec {
        devShell = with pkgs;
          mkShell rec {
            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            FLUTTER_SDK = "${pkgs.flutter}";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
            LD_LIBRARY_PATH = "${PWD}/build/linux/x64/debug/bundle/lib/:${PWD}/build/linux/x64/release/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/profile/bundle/lib/";
            ANDROID_JAVA_HOME = "${pkgs.jdk17.home}";
            #ANDROID_NDK = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}";
            buildInputs = [
              act
              rustToolchain
              flutter
              androidSdk
              zenity
              fastlane
              cargo-ndk
            ];
          };

        formatter = pkgs.alejandra;

        buildMavenRepo = pkgs.callPackage ./nix/maven-repo.nix {};
        mavenRepo = buildMavenRepo {
          name = "nix-maven-repo";
          repos = [
            "https://dl.google.com/dl/android/maven2"
            "https://repo1.maven.org/maven2"
            "https://maven.pkg.jetbrains.space/kotlin/p/kotlin/dev"
            "https://plugins.gradle.org/m2"
            "https://storage.flutter-io.cn/download.flutter.io"
          ];
          deps = builtins.fromJSON (builtins.readFile ./nix/deps.json);
        };

        packages = with pkgs; {
          updateLocks = callPackage ./nix/update-locks.nix {};
          linux = flutter.buildFlutterApplication {
            src = ./.;
            inherit cargoDeps pname version pubspecLock;

            cargoRoot = "native";

            FLUTTER_SDK = "${pkgs.flutter}";
            LD_LIBRARY_PATH = "./build/linux/x64/debug/bundle/lib/:./build/linux/x64/release/bundle/lib/:${PWD}/apps/onyx/build/linux/x64/profile/bundle/lib/";

            ANDROID_JAVA_HOME = "${pkgs.jdk17.home}";

            patches = [
              ./corrosion.patch
            ];

            preConfigure = ''
              export CMAKE_PREFIX_PATH="${corrosion}:$CMAKE_PREFIX_PATH"
            '';

            nativeBuildInputs = [
              corrosion
              rustPlatform.cargoSetupHook
              gradle-unwrapped
              rustToolchain
              copyDesktopItems
              cargo-ndk
            ];

            buildInputs = [
              git
              udev
            ];
          };
          android = flutter.buildFlutterApplication rec {
            src = ./.;
            inherit cargoDeps pname version pubspecLock;

            cargoRoot = "native";

            targetFlutterPlatform = "web"; # to skip linux fixups

            ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
            ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
            ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
            FLUTTER_SDK = "${pkgs.flutter}";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";

            ANDROID_JAVA_HOME = "${pkgs.jdk17.home}";

            nativeBuildInputs = [
              corrosion
              rustPlatform.cargoSetupHook
              gradle-unwrapped
              rustToolchain
              cargo-ndk
            ];

            buildInputs = [
              git
              udev
            ];

            configurePhase = ''
              echo "sdk.dir=${androidSdk}/libexec/android-sdk" >> android/local.properties
              echo "flutter.sdk=${flutter-patched}" >> android/local.properties

              export HOME="$NIX_BUILD_TOP"
              flutter config --no-analytics &>/dev/null # mute first-run
              flutter config --enable-linux-desktop >/dev/null
            '';

            buildPhase = ''
              runHook preBuild

              mkdir -p build/flutter_assets/fonts
              cp --no-preserve=all "$pubspecLockFilePath" pubspec.lock
              mkdir -p .dart_tool && cp --no-preserve=all "$packageConfig" .dart_tool/package_config.json

              cd android
              gradle \
              --offline --no-daemon --no-build-cache --info --full-stacktrace \
              --warning-mode=all --parallel --console=plain \
              -PnixMavenRepo=${mavenRepo} \
              -Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2 \
              -Ptarget-platform=android-arm,android-arm64,android-x64 \
              -Ptarget=lib/main.dart \
              -Pbase-application-name=android.app.Application \
              -Pdart-obfuscation=false \
              -Ptrack-widget-creation=true \
              -Ptree-shake-icons=true \
              -Psplit-per-abi=true \
              assembleRelease
              cd ..

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              mkdir -p $out
              cp -r ./build/app/outputs/*apk/ $out
              runHook postInstall
            '';

            dontFixup = true;
            dontStrip = true;
            dontWrapGApps = true;
          };
        };
      }
    );
}
