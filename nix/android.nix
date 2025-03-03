{
  pname,
  flutter,
  version,
  pubspecLock,
  androidSdk,
  jdk,
  fetchzip,
  gradle,
  callPackage,
}: let
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
in
  flutter.buildFlutterApplication rec {
    src = ../.;
    inherit pname version pubspecLock;

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
    ];

    buildInputs = [
    ];

    configurePhase = ''
      echo "sdk.dir=${androidSdk}/libexec/android-sdk" >> android/local.properties
      echo "flutter.sdk=${flutter}" >> android/local.properties

      export HOME="$NIX_BUILD_TOP"
      flutter config --no-analytics &>/dev/null # mute first-run
      flutter config --enable-linux-desktop >/dev/null
    '';

    buildPhase = ''
      runHook preBuild

      mkdir -p build/flutter_assets/fonts
      mkdir -p .dart_tool && cp --no-preserve=all "$packageConfig" .dart_tool/package_config.json

      cd android
      echo "${mavenRepo}"
      gradle --project-cache-dir gradle/tmp \
        --offline --no-daemon --no-build-cache --info --full-stacktrace \
        --console=plain \
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
