#!/usr/bin/env bash
# Build one or more Runtime Resource Overlay (RRO) APKs with aapt2.
#
# Usage:
#   ./scripts/build_rro.sh                     # build all overlays/*/ with AndroidManifest.xml
#   ./scripts/build_rro.sh LauncherRRO CarLauncherThemeRRO
#   ./scripts/build_rro.sh --list
#
# Requires ANDROID_SDK_ROOT (or ANDROID_HOME) with build-tools and platforms/android-35.
# Run ./scripts/install_android_sdk.sh first if the SDK is missing.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OVERLAYS_DIR="${REPO_ROOT}/overlays"
OUT_DIR="${REPO_ROOT}/out/rro"
BUILD_TOOLS_VERSION="${ANDROID_BUILD_TOOLS_VERSION:-35.0.0}"
PLATFORM_VERSION="${ANDROID_PLATFORM_VERSION:-android-35}"

if [[ -f "$HOME/.android_sdk_env" ]]; then
  # shellcheck disable=SC1091
  source "$HOME/.android_sdk_env"
fi

ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/android-sdk}}"
BUILD_TOOLS="$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS_VERSION}"
AAPT2="${BUILD_TOOLS}/aapt2"
ZIPALIGN="${BUILD_TOOLS}/zipalign"
APKSIGNER="${BUILD_TOOLS}/apksigner"
ANDROID_JAR="$ANDROID_SDK_ROOT/platforms/${PLATFORM_VERSION}/android.jar"
KEYSTORE="${RRO_DEBUG_KEYSTORE:-$HOME/.android/rro-debug.keystore}"
KEY_ALIAS="${RRO_DEBUG_KEY_ALIAS:-rro}"
KEY_PASS="${RRO_DEBUG_KEY_PASS:-android}"

log() { echo "[build_rro] $*"; }
die() { echo "[build_rro] ERROR: $*" >&2; exit 1; }

need_tools() {
  [[ -x "$AAPT2" ]] || die "aapt2 not found at $AAPT2 — run ./scripts/install_android_sdk.sh"
  [[ -x "$ZIPALIGN" ]] || die "zipalign not found at $ZIPALIGN"
  [[ -x "$APKSIGNER" ]] || die "apksigner not found at $APKSIGNER"
  [[ -f "$ANDROID_JAR" ]] || die "android.jar missing at $ANDROID_JAR"
  command -v java >/dev/null || die "java is required to sign APKs"
}

ensure_keystore() {
  if [[ -f "$KEYSTORE" ]]; then
    return 0
  fi
  mkdir -p "$(dirname "$KEYSTORE")"
  log "Creating debug keystore at $KEYSTORE"
  keytool -genkeypair -v \
    -keystore "$KEYSTORE" \
    -alias "$KEY_ALIAS" \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -storepass "$KEY_PASS" -keypass "$KEY_PASS" \
    -dname "CN=ScalableUI RRO Debug,O=ScalableUI,C=US" >/dev/null
}

list_overlays() {
  local d
  for d in "$OVERLAYS_DIR"/*; do
    [[ -d "$d" && -f "$d/AndroidManifest.xml" ]] || continue
    basename "$d"
  done | sort
}

build_one() {
  local name="$1"
  local src="$OVERLAYS_DIR/$name"
  local work="$OUT_DIR/work/$name"
  local compiled="$work/compiled.zip"
  local linked="$work/unaligned.apk"
  local aligned="$work/aligned.apk"
  local out_apk="$OUT_DIR/${name}.apk"

  [[ -d "$src" ]] || die "overlay not found: $src"
  [[ -f "$src/AndroidManifest.xml" ]] || die "missing AndroidManifest.xml in $src"
  [[ -d "$src/res" ]] || die "missing res/ in $src"

  rm -rf "$work"
  mkdir -p "$work"

  log "Compiling resources: $name"
  "$AAPT2" compile --dir "$src/res" -o "$compiled"

  log "Linking overlay APK: $name"
  # --extra-packages not needed; --auto-add-overlay helps when ids collide.
  "$AAPT2" link \
    -o "$linked" \
    -I "$ANDROID_JAR" \
    --manifest "$src/AndroidManifest.xml" \
    --auto-add-overlay \
    "$compiled"

  log "Aligning + signing: $name"
  "$ZIPALIGN" -f 4 "$linked" "$aligned"
  "$APKSIGNER" sign \
    --ks "$KEYSTORE" \
    --ks-key-alias "$KEY_ALIAS" \
    --ks-pass "pass:$KEY_PASS" \
    --key-pass "pass:$KEY_PASS" \
    --out "$out_apk" \
    "$aligned"

  "$APKSIGNER" verify "$out_apk" >/dev/null
  log "OK  $out_apk ($(du -h "$out_apk" | awk '{print $1}'))"
}

main() {
  need_tools
  ensure_keystore
  mkdir -p "$OUT_DIR"

  if [[ "${1:-}" == "--list" ]]; then
    list_overlays
    exit 0
  fi

  local targets=("$@")
  if [[ ${#targets[@]} -eq 0 ]]; then
    mapfile -t targets < <(list_overlays)
  fi

  [[ ${#targets[@]} -gt 0 ]] || die "no overlay targets found under $OVERLAYS_DIR"

  local failed=0
  local name
  for name in "${targets[@]}"; do
    if ! build_one "$name"; then
      log "FAILED: $name"
      failed=$((failed + 1))
    fi
  done

  if [[ $failed -gt 0 ]]; then
    die "$failed overlay(s) failed to build"
  fi
  log "Built ${#targets[@]} overlay(s) into $OUT_DIR"
}

main "$@"
