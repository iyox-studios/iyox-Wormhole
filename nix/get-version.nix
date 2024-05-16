{pkgs}: let
  pubspecYaml = builtins.readFile ../pubspec.yaml;
  versionRegex = ".+version:[[:space:]]+([0-9]+\\.+[0-9]+\\.[0-9]+).+";
  versionString = builtins.match versionRegex pubspecYaml;
in {
  version = builtins.elemAt versionString 0;
}
