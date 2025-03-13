{
  naersk,
  pname,
  flutter,
  version,
  versionCode,
  pubspecLock,
  androidSdk,
  jdk,
  fetchzip,
  gradle,
  callPackage,
  rustPlatform,
  lib,
  stdenv,
  replaceVars,
  buildDartApplication,
  rustToolchain,
  nixpkgs,
  pkgsCross,
  ndkVersion,
  writeShellScript,
}: let
  src = ../.;
  buildMavenRepo = callPackage ./maven-repo.nix {};
  mavenRepo = buildMavenRepo {
    name = "nix-maven-repo";
    repos = [
      "https://dl.google.com/dl/android/maven2"
      "https://repo1.maven.org/maven2"
      "https://maven.pkg.jetbrains.space/kotlin/p/kotlin/dev"
      "https://plugins.gradle.org/m2"
      "https://storage.flutter-io.cn/download.flutter.io"
    ];
    deps = builtins.fromJSON (builtins.readFile ./deps.json);
  };

  # TODO use rust from rustToolchain
  rustBuilder = target: let

  in
    (naersk.lib.x86_64-linux.override {
         cargo = rustToolchain;
         rustc = rustToolchain;
    }).buildPackage {
      pname = "rust_iyox_wormhole_${target}";
      inherit version;
      src = ../rust;

      CARGO_BUILD_TARGET = target;
      "AR_${target}" = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar";
      "CC_${target}" = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang";
      "CFLAGS_${target}" = "--target=${target}21";
      "CXX_${target}" = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++";
      "CXXFLAGS_${target}" = "--target=${target}21";
      "RANLIB_${target}" = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ranlib";
      #CARGO_ENCODED_RUSTFLAGS = "-L../build/rust_lib_iyox_wormhole/build/cargokit/libgcc_workaround/26";
      #_CARGOKIT_NDK_LINK_TARGET = "--target=${target}21";
      #_CARGOKIT_NDK_LINK_CLANG = "${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang";
      "CARGO_TARGET_${lib.stringAsChars (x: if x == "-" then "_" else x) (lib.toUpper target)}_LINKER"= writeShellScript "test"  ''
          ${androidSdk}/libexec/android-sdk/ndk/${ndkVersion}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang --target=${target}21 "$@"
        '';
      postPatch = ''
        cp ${../pubspec.yaml} ../pubspec.yaml
      '';

      copyLibs = true;

      #setSourceRoot = "sourceRoot=$(echo */rust)";
      #cargoRoot = "rust";

      useFetchCargoVendor = true;
      cargoHash = "sha256-H9xq58e+B76866bQkoQmsdDsQ0OqeAgPoZW4dUD+9gQ=";
    };

  build_tool_runner = buildDartApplication.override {dart = flutter.dart;} {
    pname = "build_tool_runner";
    version = "0.0.1";
    src = ../rust_builder/cargokit/build_tool;
    pubspecLock = lib.importJSON ../rust_builder/cargokit/build_tool/pubspec.lock.json;
    patches = [
      ./build_tool_builder.patch
    ];

    dartOutputType = "kernel";
    dartEntryPoints = {
      "bin/build_tool_runner.dill" = "bin/build_tool.dart";
    };
  };

  rust_armv7 = rustBuilder "armv7-linux-androideabi";
  rust_aarch64 = rustBuilder "aarch64-linux-android";
  rust_x86_64 = rustBuilder "x86_64-linux-android";
in
  flutter.buildFlutterApplication rec {
    inherit pname version pubspecLock src;

    customSourceBuilders = {
      rust_lib_iyox_wormhole = {
        version,
        src,
        ...
      }:
        stdenv.mkDerivation rec {
          pname = "rust_lib_iyox_wormhole";
          inherit version src;
          inherit (src) passthru;

          patches = [
            ./gradle-plugin.patch
            (replaceVars ./run_build_tool.patch {
              build_tool_runner = "${build_tool_runner}/bin/build_tool_runner.dill";
            })
          ];

          installPhase = ''
            runHook preInstall

            cp -r . $out

            runHook postInstall
          '';
        };
    };

    targetFlutterPlatform = "web"; # to skip linux fixups

    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    ANDROID_NDK_ROOT = "${androidSdk}/libexec/android-sdk/ndk-bundle";
    FLUTTER_SDK = "${flutter}";
    JAVA_HOME = "${jdk.home}";

    patches = [
      ./gradle.patch
    ];

    nativeBuildInputs = [
      gradle
      flutter
    ];

    buildInputs = [
    ];

    configurePhase = ''
      export HOME="$NIX_BUILD_TOP"

      mkdir -p build/flutter_assets/fonts
      mkdir -p .dart_tool && cp --no-preserve=all "$packageConfig" .dart_tool/package_config.json

      echo "sdk.dir=${androidSdk}/libexec/android-sdk" >> android/local.properties
      echo "flutter.sdk=${flutter}" >> android/local.properties

      echo "flutter.versionName=${version}" >> android/local.properties
      echo "flutter.versionCode=${versionCode}" >> android/local.properties
      echo "flutter.buildMode=release" >> android/local.properties

      flutter config --no-analytics &>/dev/null # mute first-run
    '';

    buildPhase = ''
      runHook preBuild

      flutter build apk --release -v || true

      mkdir -p build/rust_lib_iyox_wormhole/build/armv7-linux-androideabi/release
      mkdir -p build/rust_lib_iyox_wormhole/build/aarch64-linux-android/release
      mkdir -p build/rust_lib_iyox_wormhole/build/x86_64-linux-android/release
      cp ${rust_armv7}/lib/* build/rust_lib_iyox_wormhole/build/armv7-linux-androideabi/release/
      cp ${rust_aarch64}/lib/* build/rust_lib_iyox_wormhole/build/aarch64-linux-android/release/
      cp ${rust_x86_64}/lib/* build/rust_lib_iyox_wormhole/build/x86_64-linux-android/release/

      cd android

      gradle --project-cache-dir gradle/tmp \
        --offline --no-daemon --no-build-cache --info --full-stacktrace \
        --console=plain \
        -Pverbose=true \
        -Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2 \
        -PnixMavenRepo=file://${mavenRepo} \
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
      cp -r ./build/app/outputs/flutter-apk/* $out/
      runHook postInstall
    '';

    dontFixup = true;
    dontStrip = true;
    dontWrapGApps = true;
  }
