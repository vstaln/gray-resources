#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-resources.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-resources" ;;
    *) rel="x86_64-apple-darwin/gray-resources" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-resources" ;;
    *) rel="x86_64-unknown-linux-musl/gray-resources" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-resources.exe" "$here/target/release/gray-resources" "$here/target/debug/gray-resources.exe" "$here/target/debug/gray-resources"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-resources binary not found in $here" >&2
exit 1
