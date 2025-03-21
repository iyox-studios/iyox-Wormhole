{pkgs}: let
  pubspecYaml = builtins.readFile ../pubspec.yaml;
  versionRegex = ".+version:[[:space:]]+([0-9]+\\.[0-9]+\\.[0-9]+)\\+([0-9]+).+";
  versionString = builtins.match versionRegex pubspecYaml;
in {
  versionName = builtins.elemAt versionString 0;
  versionCode = builtins.elemAt versionString 1;
}
