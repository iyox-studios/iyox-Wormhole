{ lib
, writeShellScriptBin
, gradle_7
, jq
, yq
}:

writeShellScriptBin "update-locks" ''
  set -eu -o pipefail
  cd android
  ${gradle_7}/bin/gradle dependencies --write-locks
  ${gradle_7}/bin/gradle --write-verification-metadata sha256 dependencies
  ${yq}/bin/xq '."verification-metadata".components.component' gradle/verification-metadata.xml | sed  's/@//g' \
    | ${jq}/bin/jq '[
        .[] |  { group, name, version,
                  artifacts: [([.artifact] | flatten | .[] | {(.name): .sha256.value})] | add
                }
      ]' > deps.json
''