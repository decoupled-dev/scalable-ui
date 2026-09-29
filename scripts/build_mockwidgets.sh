#!/usr/bin/env bash
# Standalone MockWidgets APK build (no full AOSP tree).
# Uses platform android.jar + optional android.car.jar from the Android SDK.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
APP_DIR="${REPO_ROOT}/apps/MockWidgets"
OUT_DIR="${REPO_ROOT}/out/apps"
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
D8="${BUILD_TOOLS}/d8"
ANDROID_JAR="$ANDROID_SDK_ROOT/platforms/${PLATFORM_VERSION}/android.jar"
CAR_JAR="$ANDROID_SDK_ROOT/platforms/${PLATFORM_VERSION}/optional/android.car.jar"
KEYSTORE="${RRO_DEBUG_KEYSTORE:-$HOME/.android/rro-debug.keystore}"
KEY_ALIAS="${RRO_DEBUG_KEY_ALIAS:-rro}"
KEY_PASS="${RRO_DEBUG_KEY_PASS:-android}"

log() { echo "[build_mockwidgets] $*"; }
die() { echo "[build_mockwidgets] ERROR: $*" >&2; exit 1; }

[[ -x "$AAPT2" ]] || die "aapt2 missing — run ./scripts/install_android_sdk.sh"
[[ -f "$ANDROID_JAR" ]] || die "android.jar missing at $ANDROID_JAR"
[[ -f "$CAR_JAR" ]] || die "android.car.jar missing at $CAR_JAR"
[[ -x "$D8" ]] || die "d8 missing at $D8"
command -v javac >/dev/null || die "javac not found"

if [[ ! -f "$KEYSTORE" ]]; then
  mkdir -p "$(dirname "$KEYSTORE")"
  keytool -genkeypair -v \
    -keystore "$KEYSTORE" \
    -alias "$KEY_ALIAS" \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -storepass "$KEY_PASS" -keypass "$KEY_PASS" \
    -dname "CN=ScalableUI RRO Debug, O=Decoupled, C=US"
fi

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$OUT_DIR" "$WORK/res_flat" "$WORK/java" "$WORK/classes"

log "Compiling resources"
"$AAPT2" compile --dir "$APP_DIR/res" -o "$WORK/res_flat/"

# Link package, generate R.java. Use --shared-lib style not needed for app.
FLAT_FILES=("$WORK"/res_flat/*.flat)
"$AAPT2" link \
  -o "$WORK/base.apk" \
  -I "$ANDROID_JAR" \
  --manifest "$APP_DIR/AndroidManifest.xml" \
  --java "$WORK/java" \
  --auto-add-overlay \
  --min-sdk-version 35 \
  --target-sdk-version 35 \
  --rename-manifest-package com.android.car.mockwidgets \
  "${FLAT_FILES[@]}"

# Include optional jpg/png that aapt2 compile --dir already flattened.
# Ensure album cover jpg is present if compile missed binary assets.
if [[ -f "$APP_DIR/res/drawable/album_cover_rhythm.jpg" ]]; then
  :
fi

log "Compiling Java"
find "$APP_DIR/src" "$WORK/java" -name '*.java' > "$WORK/sources.list"
javac --release 17 \
  -classpath "$ANDROID_JAR:$CAR_JAR" \
  -d "$WORK/classes" \
  @"$WORK/sources.list"

log "Dexing"
"$D8" --min-api 35 --lib "$ANDROID_JAR" --output "$WORK" "$WORK"/classes/com/android/car/mockwidgets/*.class

# Merge dex into apk
cp "$WORK/base.apk" "$WORK/unsigned.apk"
(
  cd "$WORK"
  zip -q -u unsigned.apk classes.dex
)

log "Aligning + signing"
"$ZIPALIGN" -f 4 "$WORK/unsigned.apk" "$WORK/aligned.apk"
"$APKSIGNER" sign \
  --ks "$KEYSTORE" \
  --ks-pass "pass:$KEY_PASS" \
  --ks-key-alias "$KEY_ALIAS" \
  --key-pass "pass:$KEY_PASS" \
  --out "$OUT_DIR/MockWidgets.apk" \
  "$WORK/aligned.apk"

# Refresh prebuilt mirrors used by deploy_ui.sh
cp -f "$OUT_DIR/MockWidgets.apk" "$REPO_ROOT/assets/prebuilts/MockWidgets.apk"
cp -f "$OUT_DIR/MockWidgets.apk" "$REPO_ROOT/prebuilt_apks/MockWidgets.apk"

SIZE="$(wc -c < "$OUT_DIR/MockWidgets.apk" | tr -d ' ')"
log "OK  $OUT_DIR/MockWidgets.apk ($(numfmt --to=iec "$SIZE" 2>/dev/null || echo "${SIZE}B"))"
