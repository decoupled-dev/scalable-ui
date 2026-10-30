#!/usr/bin/env bash
# Install and enable the Scalable UI launcher overlays on a userdebug AAOS device.
#
# Usage:
#   ./scripts/deploy.sh [--serial DEVICE] [--user USER_ID] [--variant 0-3] [--skip-build]
#
# Installs LauncherRRO and CarLauncherThemeRRO into /product/overlay, enables
# them for user 0 and the driver user, forces 240 dpi for both users, selects
# the landscape layout set, and restarts the framework.
#
# Prerequisites (see README.md):
#   - CarSystemUI rebuilt with CarSysuiScalableBarControllers linked
#   - Widget apps installed (Widgets/scripts/deploy-all.sh)
#   - StubCarLauncher, a maps app, and the card app (com.test.design) present
#
# APK source, first match wins:
#   $OUT/product/overlay/<Name>/<Name>.apk   (AOSP build, platform-signed)
#   out/rro/<Name>.apk                       (./scripts/build_rro.sh, debug-signed)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
USER_ID="${ANDROID_USER_ID:-10}"
VARIANT=0
DO_BUILD=true
ADB_SERIAL=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --serial) ADB_SERIAL="$2"; shift 2 ;;
        --user) USER_ID="$2"; shift 2 ;;
        --variant) VARIANT="$2"; shift 2 ;;
        --skip-build) DO_BUILD=false; shift ;;
        -h|--help)
            sed -n '2,18p' "$0"
            exit 0
            ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

ADB=(adb)
[[ -n "$ADB_SERIAL" ]] && ADB+=(-s "$ADB_SERIAL")

OVERLAYS=(LauncherRRO CarLauncherThemeRRO)
PKG_LAUNCHER="com.android.systemui.rro.scalableUI.launcher"
PKG_THEME="com.android.car.carlauncher.rro.launcherTheme"

log() { echo "[deploy] $*"; }
die() { echo "[deploy] ERROR: $*" >&2; exit 1; }

find_apk() {
    local name="$1"
    local candidates=()
    [[ -n "${OUT:-}" ]] && candidates+=("${OUT}/product/overlay/${name}/${name}.apk" "${OUT}/product/overlay/${name}.apk")
    candidates+=("${REPO_ROOT}/out/rro/${name}.apk")
    for apk in "${candidates[@]}"; do
        [[ -f "$apk" ]] && { echo "$apk"; return 0; }
    done
    return 1
}

if $DO_BUILD && [[ -z "${OUT:-}" ]]; then
    log "Building overlays with aapt2..."
    "${SCRIPT_DIR}/build_rro.sh" "${OVERLAYS[@]}"
fi

log "adb root + remount"
"${ADB[@]}" root >/dev/null
sleep 1
"${ADB[@]}" remount >/dev/null || true

for name in "${OVERLAYS[@]}"; do
    apk="$(find_apk "$name")" || die "No APK for ${name}; run ./scripts/build_rro.sh ${name}"
    dest="/product/overlay/${name}/${name}.apk"
    log "Push ${apk} -> ${dest}"
    "${ADB[@]}" shell mkdir -p "/product/overlay/${name}"
    "${ADB[@]}" push "$apk" "$dest" >/dev/null
done

# A new /product overlay is only scanned at boot.
log "Rebooting so the overlays are scanned..."
"${ADB[@]}" reboot
"${ADB[@]}" wait-for-device
until [[ "$("${ADB[@]}" shell getprop sys.boot_completed | tr -d '\r')" == "1" ]]; do
    sleep 2
done
"${ADB[@]}" root >/dev/null
sleep 1

# SystemUI parses panels as user 0; the driver user owns the activities.
log "Enabling overlays for users 0 and ${USER_ID}..."
for pkg in "$PKG_LAUNCHER" "$PKG_THEME"; do
    "${ADB[@]}" shell cmd overlay enable --user 0 "$pkg"
    "${ADB[@]}" shell cmd overlay enable --user "$USER_ID" "$pkg"
done

# LauncherRRO dimens target the 240 dpi canvas (1707x1067 dp on 2560x1600).
# display_density_forced is per user. SystemUI starts as user 0 and parses
# panel bounds once, so user 0 must be 240 too.
log "Setting display density to 240 dpi (users 0 and ${USER_ID})..."
"${ADB[@]}" shell settings put --user 0 secure display_density_forced 240
"${ADB[@]}" shell settings put --user "$USER_ID" secure display_density_forced 240
"${ADB[@]}" shell wm density 240

log "Selecting layout set ${VARIANT}..."
"${ADB[@]}" shell settings put global scalable_ui_layout_variant "$VARIANT"

log "Restarting the framework..."
"${ADB[@]}" shell stop
sleep 2
"${ADB[@]}" shell start

log "Overlay state (user ${USER_ID}):"
"${ADB[@]}" shell cmd overlay list --user "$USER_ID" | grep -E "scalableUI|launcherTheme" || true
log "Done."
