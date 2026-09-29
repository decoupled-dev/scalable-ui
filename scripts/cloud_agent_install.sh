#!/usr/bin/env bash
# Cloud Agent install: Android SDK + verify standalone RRO packaging works.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

chmod +x scripts/install_android_sdk.sh scripts/build_rro.sh

./scripts/install_android_sdk.sh

# shellcheck disable=SC1091
source "$HOME/.android_sdk_env"

# Smoke-build a small set of primary RROs (fast, representative).
./scripts/build_rro.sh LauncherRRO MultiPanelLandscapeRRO OemDemoRRO

echo "[cloud-agent-install] RRO build environment ready."
