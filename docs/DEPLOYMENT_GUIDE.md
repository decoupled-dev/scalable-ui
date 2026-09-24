# Scalable UI Demo — APK Deployment Guide

**Branch:** `integration`  
**Canonical prebuilts:** `assets/prebuilts/`  
**Mirror:** `prebuilt_apks/` (keep synced with `./scripts/sync_prebuilts.sh`)

---

## Recommended: one-command deploy

```bash
# Tip MultiPanelLandscape demo (prebuilt-safe — default)
./scripts/deploy_ui.sh --mode tip

# OemDemoRRO package (same tip panels, different overlay package)
./scripts/deploy_ui.sh --mode oem

# Pleos header/footer (requires CarSystemUI rebuilt with Controllers)
./scripts/deploy_ui.sh --mode pleos
```

`--mode tip` installs and enables:
- `CarSystemUI.apk`, `CarLauncher.apk`
- `MockWidgets.apk`, `MockMap.apk`
- `MultiPanelLandscapeRRO.apk`
- `CarLauncherMultiPanelRRO.apk`
- `CarSystemUIScalableUIOverlay.apk`

---

## What's in `assets/prebuilts/`

| APK | Purpose |
|---|---|
| `MultiPanelLandscapeRRO.apk` | Tip Scalable UI — glanceable map, 3 floating pills, HVAC/media/QS |
| `OemDemoRRO.apk` | Unified OEM package (default = tip panels; Pleos arrays optional) |
| `CarSystemUIScalableUIOverlay.apk` | Feature flags / dimens |
| `CarLauncherMultiPanelRRO.apk` | AppGrid full-screen / column widths |
| `CarSystemUI.apk` | Orchestrator + FloatingNav/Media/QS controllers |
| `CarLauncher.apk` | Home / AppGrid / ControlBar |
| `MockWidgets.apk` | Climate, Agenda, Clock, SmartHome, Camera, … |
| `MockMap.apk` | OSM Leaflet maps placeholder |

---

## Manual push (equivalent to `--mode tip`)

```bash
adb root && adb remount
PREBUILTS=/path/to/ScalableUI/assets/prebuilts

adb push $PREBUILTS/MultiPanelLandscapeRRO.apk /product/overlay/MultiPanelLandscapeRRO.apk
adb shell mkdir -p /product/overlay/CarSystemUIScalableUIOverlay
adb push $PREBUILTS/CarSystemUIScalableUIOverlay.apk \
  /product/overlay/CarSystemUIScalableUIOverlay/CarSystemUIScalableUIOverlay.apk
adb push $PREBUILTS/CarLauncherMultiPanelRRO.apk /product/overlay/CarLauncherMultiPanelRRO.apk

adb shell mkdir -p /system/priv-app/CarSystemUI /system/priv-app/CarLauncher
adb push $PREBUILTS/CarSystemUI.apk /system/priv-app/CarSystemUI/CarSystemUI.apk
adb push $PREBUILTS/CarLauncher.apk /system/priv-app/CarLauncher/CarLauncher.apk

adb shell mkdir -p /system/app/MockWidgets /system/app/MockMap
adb push $PREBUILTS/MockWidgets.apk /system/app/MockWidgets/MockWidgets.apk
adb push $PREBUILTS/MockMap.apk /system/app/MockMap/MockMap.apk

adb shell cmd overlay enable --user 10 com.android.systemui.rro.scalableUI.multiPanelLandscape
adb shell cmd overlay enable --user 10 com.android.car.carlauncher.rro.scalableUI.multiPanelLandscape
adb shell cmd overlay enable --user 10 com.android.systemui.rro.scalableUI.carSystemUI

adb shell stop && adb shell start
```

---

## Overlay package names (correct)

| Overlay | Package |
|---|---|
| MultiPanelLandscapeRRO | `com.android.systemui.rro.scalableUI.multiPanelLandscape` |
| OemDemoRRO | `com.android.systemui.rro.scalableUI.oemDemo` |
| CarSystemUIScalableUIOverlay | `com.android.systemui.rro.scalableUI.carSystemUI` |
| CarLauncherMultiPanelRRO | `com.android.car.carlauncher.rro.scalableUI.multiPanelLandscape` |

Do **not** enable MultiPanelLandscape and OemDemo together (both own `window_states`).

---

## Source-based CarSystemUI integration (landed)

The OEM scalable bar controllers are now wired from source, not only from a prebuilt APK.

1. `packages/apps/Car/SystemUI/Android.bp` includes `CarSysuiScalableBarControllers` in `static_libs`.
2. `CarSysuiScalableBarControllerModule` is installed from `PanelControllerModule` and binds class-keyed `DecorPanelController.Factory` entries (header, footer/media, face login).
3. Each factory reads `RroPackage`, `PrimaryMediaComponent`, and `MediaPanelId` from the parsed panel-controller XML (`PanelControllerMetadata`), with the previous hardcoded values as fallback.
4. Rebuild after changing controllers or XML:

```bash
source build/envsetup.sh
lunch aosp_tangorpro_car-trunk_staging-userdebug
m CarSystemUI CarLauncher MockWidgets OemDemoRRO MultiPanelLandscapeRRO \
  CarLauncherMultiPanelRRO CarSysuiScalableBarControllers
# then copy the APKs into assets/prebuilts/ (or run with OUT= set)
./scripts/deploy_ui.sh --mode pleos --serial <SERIAL>
```

On tangorpro, `CarSystemUI.apk` lives at `/system_ext/priv-app/CarSystemUI/` (the deploy script also writes `/system/priv-app/`; push both if `pm path com.android.systemui` still points at system_ext).

## Pleos controllers

Shipped `CarSystemUI.apk` includes `FloatingNavViewController` / `FloatingMediaViewController` / `QuickSettingsViewController` — enough for tip/oem modes.

Pleos dual-zone header/footer + face login needs the source integration above, then:
- `./scripts/deploy_ui.sh --mode pleos` (enables OemDemoRRO + launcher RRO)
- OemDemo `overlays.xml` now points `window_states` / `config_default_activities` at the pleos arrays so the header/footer/media controllers load
- Enable the aconfig flag after install: `aflags enable com.android.systemui.car.scalable_ui` then reboot
- Do not enable `CarSystemUIScalableUIOverlay` together with OemDemo — its legacy `<Panel>` XML is not registered in the current parser

---

## Product makefile

```makefile
$(call inherit-product, vendor/aospstack/ScalableUI/oem_demo_packages.mk)
```

---

## Verification checklist

- [ ] Home (CarLauncher) visible
- [ ] Three floating pills: driver HVAC / nav+media / passenger HVAC
- [ ] Glanceable map + side media
- [ ] App Grid full-screen via Apps button
- [ ] No empty panels from missing `FakeActivity`
- [ ] `cmd overlay list` shows expected overlay enabled

---

## GitHub

https://github.com/hemangpandhi/ScalableUI (branch: `integration`)
