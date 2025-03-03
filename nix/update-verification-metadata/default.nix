{
  lib,
  python3,
  git,
  writeShellApplication,
  gradle,
  updateAction ? "dependencies",
  cmd ? "gradle --refresh-dependencies --project-cache-dir gradle/tmp --write-verification-metadata sha256 ${updateAction}",
  verificationFile ? "gradle/verification-metadata.xml",
  whitelist ? [],
}:
writeShellApplication {
  name = "update-verification-metadata";

  runtimeInputs = [python3 gradle git];
  text = ''
    cd android
    verificationFile=''${1:-${verificationFile}}
    if [ ! -f "$verificationFile" ]
    then
      echo "Error: $verificationFile does not (yet) exist."
      exit 1
    fi
    echo "Removing all component entries from $verificationFile ..."
    python ${./update-verification-metadata.py} "$verificationFile" ${builtins.toString (builtins.map lib.escapeShellArg whitelist)}
    echo "Regenerating gradle verification data ..."
    ${cmd}
  '';
}
