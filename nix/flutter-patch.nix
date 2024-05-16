{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "flutter-patched";

  src = pkgs.flutter;

  unpackPhase = ''
    mkdir -p $out
    cp -r -L --no-preserve=mode $src/* .
    chmod +x ./bin/flutter
  '';

  phases = ["unpackPhase" "patchPhase" "buildPhase"];

  patches = [
    ./flutter.patch
  ];

  buildInputs = [
    pkgs.flutter
  ];

  buildPhase = ''
    cp -r . $out/
  '';
}
