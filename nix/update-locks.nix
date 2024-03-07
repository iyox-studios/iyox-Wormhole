{ lib
, writeShellScriptBin
, gradle
, jq
, xml-to-json-fast
}:

writeShellScriptBin "update-locks" ''
  set -eu -o pipefail
  cd android
  ${gradle}/bin/gradle dependencies --write-locks
  ${gradle}/bin/gradle --write-verification-metadata sha256 dependencies
  ${xml-to-json-fast}/bin/xml-to-json-fast -sam -t components gradle/verification-metadata.xml \
    | ${jq}/bin/jq '[
        .[] | .component |
        { group, name, version,
          artifacts: [([.artifact] | flatten | .[] | {(.name): .sha256.value})] | add
        }
      ]' > deps.json
  rm gradle/verification-metadata.xml
''