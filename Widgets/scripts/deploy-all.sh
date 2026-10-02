#!/usr/bin/env bash
# Build every widget APK and install them as privileged apps on the connected device.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ADB=(adb)
if [[ -n "${ANDROID_SERIAL:-}" ]]; then
    ADB+=(-s "${ANDROID_SERIAL}")
fi

"${ROOT}/scripts/build-all.sh"

# module|package|priv-app directory
APPS=(
    "ev|com.scalableui.widgets.ev|WidgetsEv"
    "lights|com.scalableui.widgets.lights|WidgetsLights"
    "phone|com.scalableui.widgets.phone|WidgetsPhone"
    "seats|com.scalableui.widgets.seats|WidgetsSeats"
    "user|com.scalableui.widgets.user|WidgetsUser"
    "clock|com.scalableui.widgets.clock|WidgetsClock"
    "applauncher|com.scalableui.widgets.apps|WidgetsApps"
    "connections|com.scalableui.widgets.connections|WidgetsConnections"
)

echo "[deploy] adb root + remount"
"${ADB[@]}" root
sleep 1
"${ADB[@]}" remount

for entry in "${APPS[@]}"; do
    IFS='|' read -r module package privapp <<< "${entry}"
    apk="${ROOT}/${module}/build/outputs/apk/debug/${module}-debug.apk"
    allow="${ROOT}/permissions/privapp-permissions-${package}.xml"
    dest="/system/priv-app/${privapp}/${privapp}.apk"
    echo "[deploy] ${package} -> ${dest}"
    "${ADB[@]}" shell mkdir -p "/system/priv-app/${privapp}"
    "${ADB[@]}" push "${apk}" "${dest}"
    "${ADB[@]}" push "${allow}" "/system/etc/permissions/privapp-permissions-${package}.xml"
done

echo "[deploy] reboot so privileged grants apply"
"${ADB[@]}" reboot
"${ADB[@]}" wait-for-device
until [[ "$("${ADB[@]}" shell getprop sys.boot_completed | tr -d '\r')" == "1" ]]; do
    sleep 2
done
"${ADB[@]}" root
sleep 1
"${ADB[@]}" shell pm grant com.scalableui.widgets.phone android.permission.READ_CALL_LOG || true
"${ADB[@]}" shell pm grant com.scalableui.widgets.connections android.permission.BLUETOOTH_CONNECT || true
echo "[deploy] done"
