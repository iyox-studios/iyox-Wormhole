{
  lib,
  writeShellScriptBin,
  gradle,
  jq,
  yq,
}:
writeShellScriptBin "update-locks" ''
  set -eu -o pipefail
  cd android
  ${gradle}/bin/gradle dependencies --write-locks
  ${gradle}/bin/gradle  \
                         --info --full-stacktrace \
                        -Ptarget-platform=android-arm,android-arm64,android-x64 \
                        -Ptarget=lib/main.dart \
                        -Pbase-application-name=android.app.Application \
                        -Pdart-obfuscation=false \
                        -Ptrack-widget-creation=true \
                        -Ptree-shake-icons=true \
                        -Psplit-per-abi=true \
                        assembleRelease --write-locks
  ${gradle}/bin/gradle --project-cache-dir gradle/tmp --write-verification-metadata sha256 dependencies
  ${gradle}/bin/gradle --project-cache-dir gradle/tmp --write-verification-metadata sha256 assembleRelease
  ${yq}/bin/xq '."verification-metadata".components.component' gradle/verification-metadata.xml | sed  's/@//g' \
    | ${jq}/bin/jq '[
        .[] |  { group, name, version,
                  artifacts: [([.artifact] | flatten | .[] | {(.name): .sha256.value})] | add
                }
      ]' > ../nix/deps.json
  rm gradle/verification-metadata.xml
  rm -r gradle/tmp
''
