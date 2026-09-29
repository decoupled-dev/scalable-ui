#!/usr/bin/env bash
# Idempotent Android SDK bootstrap for standalone RRO builds (aapt2).
# Full AOSP/Soong is not required for packaging runtime_resource_overlay APKs.
set -euo pipefail

ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/android-sdk}}"
CMDLINE_VERSION="${ANDROID_CMDLINE_TOOLS_VERSION:-13114758}"
BUILD_TOOLS_VERSION="${ANDROID_BUILD_TOOLS_VERSION:-35.0.0}"
PLATFORM_VERSION="${ANDROID_PLATFORM_VERSION:-android-35}"

mkdir -p "$ANDROID_SDK_ROOT"
export ANDROID_SDK_ROOT
export ANDROID_HOME="$ANDROID_SDK_ROOT"

CMDLINE_DIR="$ANDROID_SDK_ROOT/cmdline-tools/latest"
SDKMANAGER="$CMDLINE_DIR/bin/sdkmanager"

if [[ ! -x "$SDKMANAGER" ]]; then
  echo "[install_android_sdk] Installing Android command-line tools..."
  TMP="$(mktemp -d)"
  ZIP="$TMP/cmdline-tools.zip"
  URL="https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_VERSION}_latest.zip"
  curl -fsSL "$URL" -o "$ZIP"
  unzip -q "$ZIP" -d "$TMP"
  mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
  rm -rf "$CMDLINE_DIR"
  mv "$TMP/cmdline-tools" "$CMDLINE_DIR"
  rm -rf "$TMP"
fi

yes | "$SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" --licenses >/dev/null || true
"$SDKMANAGER" --sdk_root="$ANDROID_SDK_ROOT" \
  "platform-tools" \
  "platforms;${PLATFORM_VERSION}" \
  "build-tools;${BUILD_TOOLS_VERSION}"

AAPT2="$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS_VERSION}/aapt2"
if [[ ! -x "$AAPT2" ]]; then
  echo "[install_android_sdk] ERROR: aapt2 missing at $AAPT2" >&2
  exit 1
fi

# Persist env for subsequent commands (sourced by build_rro / cloud_agent_install).
PROFILE_SNIPPET="$HOME/.android_sdk_env"
cat > "$PROFILE_SNIPPET" <<EOF
export ANDROID_SDK_ROOT="$ANDROID_SDK_ROOT"
export ANDROID_HOME="\$ANDROID_SDK_ROOT"
export PATH="\$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:\$ANDROID_SDK_ROOT/platform-tools:\$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS_VERSION}:\$PATH"
EOF

# shellcheck disable=SC1090
source "$PROFILE_SNIPPET"

echo "[install_android_sdk] ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
echo "[install_android_sdk] aapt2=$("$AAPT2" version 2>&1 | head -1)"
echo "[install_android_sdk] Ready."
