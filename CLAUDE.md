# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Scalable UI ("Fluidic Precision") is a custom multi-panel dashboard for Android Automotive OS (AAOS, Android 15 / API 35). It lives in an AOSP tree as `vendor/aospstack/ScalableUI` and is also built standalone. The primary physical target is the Pixel Tablet (`tangorpro`); the emulator target is `aosp_cf_x86_64_auto`.

Almost nothing here is a normal app. The repo is mostly **Runtime Resource Overlays (RROs)** that reconfigure CarSystemUI's Scalable UI orchestrator, plus the **SystemUI controller Java** those overlays depend on, plus **privileged widget apps** that get hosted inside panels. There are no unit tests in this repo.

## Commands

### Build RROs standalone (no AOSP tree needed)
```bash
./scripts/install_android_sdk.sh          # once; writes ~/.android_sdk_env
./scripts/build_rro.sh --list             # overlays/*/ with an AndroidManifest.xml
./scripts/build_rro.sh LauncherRRO        # -> out/rro/LauncherRRO.apk (debug-signed)
./scripts/build_rro.sh                    # all overlays
```
Output goes to `out/rro/` (gitignored). Standalone builds are signed with a generated debug key, not the platform key, so they install via `pm install` but are not drop-in replacements for `/product/overlay` platform-signed APKs.

### Build inside AOSP
```bash
source build/envsetup.sh
lunch aosp_tangorpro_car-trunk_staging-userdebug   # or aosp_cf_x86_64_auto-trunk_staging-userdebug
m MockWidgets CarSystemUI CarLauncher MultiPanelLandscapeRRO \
  CarLauncherMultiPanelRRO CarSystemUIScalableUIOverlay OemDemoRRO CarSysuiScalableBarControllers
```
Product makefile hook: `$(call inherit-product, vendor/aospstack/ScalableUI/oem_demo_packages.mk)`.

### Deploy to a device
```bash
./scripts/deploy_ui.sh --mode tip     # default: MultiPanelLandscapeRRO + launcher RRO + MockMap
./scripts/deploy_ui.sh --mode oem     # OemDemoRRO
./scripts/deploy_ui.sh --mode pleos   # OemDemoRRO with Pleos arrays; needs CarSystemUI rebuilt with Controllers
./scripts/deploy_ui.sh --mode tip --serial <SERIAL> --user 10 [--build] [--pixel]
```
The script does `adb root && adb remount`, pushes prebuilts from `assets/prebuilts/`, disables every Scalable UI overlay, enables the mode's set, forces 240 dpi for users 0 and 10, enables the maps placeholder, then `stop && start`.

Enable/disable one overlay by hand (current driver user is 10; SystemUI parses panels as user 0, so set both):
```bash
adb shell cmd overlay enable --user 0 com.android.systemui.rro.scalableUI.launcher
adb shell cmd overlay enable --user 10 com.android.systemui.rro.scalableUI.launcher
adb shell stop && sleep 2 && adb shell start
adb shell cmd overlay list --user 10 | grep scalableUI
```

### Widget apps (Gradle, Kotlin/Compose, AGP 9)
```bash
cd Widgets
./scripts/build-all.sh                # ./gradlew assembleDebug
./scripts/deploy-all.sh               # pushes each APK to /system/priv-app/Widgets<Name>/ + allowlist, reboots
./gradlew :ev:assembleDebug           # one module
```

### Debugging on device
```bash
adb shell settings put global scalable_ui_layout_variant 0   # 0..3, see "Layout sets" below
adb shell dumpsys overlay
adb shell dumpsys window windows | grep -E 'Embedded|TaskPanel'
adb logcat -s ScalableUI StateManager CarSysuiScalableFooterController LayoutVariantWatcher
```

## Architecture

### The orchestrator model (read `docs/launcher/GUIDE.md` before touching any panel XML)
The screen is not one layout. It is a list of **windows** declared in an RRO's `res/values/config.xml` under `window_states`, one XML file per window in `res/xml/`. CarSystemUI's Scalable UI orchestrator creates one surface per entry.

- **TaskPanel**: hosts an activity. `role` is a component name (or `DEFAULT`). When that activity starts, its task is placed in the panel and resized to its bounds. `config_default_activities` starts activities into panels at boot.
- **DecorPanel**: no activity. Names a `controller` XML, which names a Java class inside CarSystemUI that inflates a layout into the surface. The dock, header pills, temperature pills, and the opaque plates under cards are DecorPanels.
- **Variant**: one complete pose (bounds, layer, alpha, visibility, corner, map insets). `parent="@id/base"` inherits. `defaultVariant` is the boot pose.
- **Transition**: `onEvent` + optional `fromVariant` + `toVariant`. One event is delivered to every panel; each panel with a matching transition moves, the rest stay. Opening the app grid is therefore many transitions across many files, not one layout.

The dividing line, which decides where a change goes:
- **XML only (an overlay)**: a pose change on an event something already posts; a new panel; a new `role` binding; dock/pill pixels.
- **SystemUI Java required** (`systemui/CarSysuiScalableBarControllers/`): a new event name (nothing posts it until a controller calls `ScalableUIEventDispatcher.executeEvent`), a tap that launches an app or talks to the vehicle, watching a setting or rotation. Controllers must go through the dispatcher; a direct `StateManager.handleEvent` builds animators without starting them.
- **Widget app** (`Widgets/<name>/`): the pixels inside a card. The panel only supplies the rectangle.

### Three layers of code
1. **`overlays/*`**: RROs targeting `com.android.systemui` (most) or `com.android.car.carlauncher`. All `isStatic="false"` so they toggle at runtime. `LauncherRRO` is the current active design (map + right card column + 3 header pills + dock + 2 temperature pills, 11 widget cards, 4 layout sets). `MultiPanelLandscapeRRO` is the older "tip" demo; `OemDemoRRO` is MPL regenerated with Pleos bar assets via `scripts/sync_oem_demo_overlay.sh`. `DisableScalableUIRRO` (priority 9999) turns the whole thing off.
2. **`systemui/CarSysuiScalableBarControllers/`**: Java linked into CarSystemUI as a `static_libs` entry (see `integration/` for the Android.bp snippet and the Dagger module to copy next to `PanelControllerModule`). Key classes: `CarSysuiScalableFooterController` (dock: home, all apps, map toggle, climate/vehicle/settings launches, recent), `CarSysuiScalableHeaderController` (pills, night mode, HVAC temperature via VHAL, stock QS buttons pulled into slots), `LayoutVariantWatcher` (layout sets 0–3, T-Rex modes, variant-2 widget rail), `OrientationLayoutWatcher` (posts `orientation_portrait/landscape`), `DockPins` (pinned dock icons, posts `dock_pins_N`).
3. **`Widgets/`** (Gradle) and **`apps/MockWidgets/`** (Soong): privileged activities hosted in TaskPanels. Each `Widgets/<name>` is one `WidgetActivity` whose layout scales 1x1 to 2x2 (unit = 464×284 dp). They are `singleTask`, declare `configChanges` for resize, and need the matching allowlist from `Widgets/permissions/` pushed to `/system/etc/permissions/`. MockWidgets is the older set (climate, agenda, smart home, …) used by MPL/OemDemo.

### The device is running a patched prebuilt, not this Java
`device-dex/systemui/` holds smali for controller classes that were patched directly into `classes5.dex` of the installed `CarSystemUI.apk` (baksmali/smali 2.5.2, `-a 35`, dex stored uncompressed, zipaligned, platform-signed). The Java in `systemui/` is the source of truth for intent, but **editing it does nothing on the tablet until the matching smali is rebuilt into the APK** or CarSystemUI is rebuilt from an AOSP tree with the Controllers linked. `device-dex/systemui/README.md` lists which patches are live. `backups/` holds dated CarSystemUI APKs with sha256 files; back up before replacing the installed one.

### Prebuilts and artifacts
- `assets/prebuilts/` is canonical. `prebuilt_apks/` is a mirror; `scripts/sync_prebuilts.sh` (scp from a remote build laptop, host hardcoded) and `remote_build.sh` refresh it. Do not edit the mirror directly.
- `artifacts/a15/` are aapt2-built overlay APKs for branch `a15` with a `STAMP.txt`.
- `out/` is gitignored standalone build output.

## Gotchas that have cost time before
- **Only one `window_states` owner at a time.** MultiPanelLandscapeRRO, OemDemoRRO, and LauncherRRO each define `window_states`. Enabling two together produces broken geometry. Do not enable `CarSystemUIScalableUIOverlay` with OemDemo; its legacy `<Panel>` XML is not parsed.
- **DEWD overlays on Android 15** (`com.android.systemui.rro.dewd.aosp.dynamic`, `android.car.config.rro.dewd`, `com.android.car.resources.dewd`) must be `pm disable-user`'d for users 0 and 10 or the stock nav bar draws over everything. See `PixelTabletDeployment.md`. In an AOSP tree, remove `DewdDynamicAospRRO` from `samples/systemui_sample_rros.mk`.
- **Density is per user.** LauncherRRO dimens target 240 dpi (2560×1600 → ~1707×1067 dp). SystemUI starts as user 0 and parses bounds once, so user 0 must also be 240 or everything lays out at 320 until the next SystemUI restart.
- **Percent bounds resolve against the landscape canvas.** Portrait variants use absolute dp, never `100%`.
- **`home_panel` hosts `com.android.car.stub.launcher/.StubHome`** parked off-screen as the HOME visibility barrier. Without it the stock CarLauncher paints over the map on boot and user switch.
- **Privileged apps crash-loop the device without an allowlist.** MockWidgets needs `privapp-permissions-mockwidgets.xml` in `/system_ext/etc/permissions/`; each `Widgets/` app needs its file from `Widgets/permissions/`.
- **Hidden ≠ finished.** `isVisible="false"` stops the hosted activity but keeps the task; alpha 0 keeps it resumed. `_System_TaskPanelEmptyEvent` fires only when the last task actually leaves.
- **On tangorpro CarSystemUI lives at `/system_ext/priv-app/CarSystemUI/`**, not `/system/priv-app/`. The deploy script pushes both; check `pm path com.android.systemui`.

## The attached tablet (as of 2026-10-22)
- Pixel Tablet `tangorpro`, serial `3411105H8036YK`, `aosp_tangorpro_car` userdebug, Android "Baklava" (API 36+), landscape (rotation 3), 240 dpi override, user 10 ("David") is the foreground user.
- Only `com.android.systemui.rro.scalableUI.launcher` (LauncherRRO) and the launcher theme RRO are enabled. MPL and OemDemo are not installed. `android.car.config.rro.dewd` is still enabled and is not causing trouble on this image.
- CarSystemUI is at `/system/priv-app/CarSystemUI/`. Its sha256 (`f5e50c15…`) matches none of `assets/prebuilts/`, `out/`, or `backups/`, so the installed SystemUI is newer than every local copy. Pull it before replacing it.
- `adb exec-out screencap -p > x.png` gives a 2560×1600 landscape capture. Dock buttons at 240 dpi sit at y≈1512; Home is x≈828, All apps x≈946.
- Observed: switching the layout variant 1→2 or 1→3 directly leaves the dock icons stacked vertically and clipped. Going through 0 first renders correctly. The repo Java resets orientation for every variant, so the installed smali is behind the Java.

## Layout sets (`scalable_ui_layout_variant`)
| Value | Set |
| --- | --- |
| 0 | Dock bottom center, pills top, 3 cards right (default) |
| 1 | Dock as left vertical rail, pills along the bottom |
| 2 | Paged right column: all 11 cards, 3 per page, drag rail to page |
| 3 | T-Rex: dock buttons select `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` |

Portrait ignores the number and uses the shared portrait variants.

## Docs worth reading first
- `docs/launcher/GUIDE.md`: the mechanics above in full, event table, layer table, lifecycle.
- `docs/launcher/panels/*.md`, `docs/launcher/docks/*.md`: one file per window.
- `docs/DEPLOYMENT_GUIDE.md`: overlay package names, manual push paths, source-based Controllers integration.
- `docs/DYNAMIC_RRO_BINDING.md`: why controllers resolve views via `getIdentifier` against the RRO package.
- `device-dex/systemui/README.md`: what is actually patched on the device.

## Conventions
- Commit messages follow `type(scope): summary` (e.g. `feat(launcher):`, `fix(systemui):`, `feat(LauncherRRO):`).
- Branch `a15` is the Android 15 / Pixel Tablet line; `main` is the integration default.
- Scripts are bash with `set -euo pipefail`; `deploy_ui.sh` and `build_rro.sh` print `[name]`-prefixed logs.
