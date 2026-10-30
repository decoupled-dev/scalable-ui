# Scalable UI Launcher

A multi-panel home screen for Android Automotive OS (Android 15 / API 35), built on CarSystemUI's Scalable UI orchestrator. The reference target is the Pixel Tablet (`tangorpro`, 2560×1600 at 240 dpi).

What it draws:

- A full-screen map behind everything.
- Three status pills along the top (connectivity and display, clock, user profile).
- A bottom dock that replaces the navigation bar (home, all apps, map toggle, climate, vehicle, settings, assistant, pinned and recent apps).
- Driver and passenger temperature pills.
- A right-hand column of widget cards (climate, media, driving stats, and eight widget apps).
- Four landscape layout sets selected over adb, plus portrait variants that follow display rotation.

## Repository layout

| Path | What it is |
| --- | --- |
| `overlays/LauncherRRO/` | The SystemUI overlay that defines every panel, pose and transition (`com.android.systemui.rro.scalableUI.launcher`). |
| `overlays/CarLauncherThemeRRO/` | Light theme for the CarLauncher app grid (`com.android.car.carlauncher.rro.launcherTheme`). |
| `systemui/CarSysuiScalableBarControllers/` | Java linked into CarSystemUI: dock, pills, HVAC, layout sets, rotation, dock pins. |
| `integration/` | The Android.bp change and Dagger module that register the controllers in CarSystemUI. |
| `Widgets/` | Gradle project with the eight privileged widget apps and their allowlists. |
| `docs/launcher/` | How the panels work: `GUIDE.md`, one file per panel and per dock/pill. |
| `docs/DYNAMIC_RRO_BINDING.md` | Why the controllers resolve views by name against the overlay package. |
| `scripts/` | Standalone RRO build, SDK installer, device deploy. |
| `scalableui_packages.mk` | Product makefile hook. |

Read `docs/launcher/GUIDE.md` before changing any panel XML.

## How it fits together

The screen is a list of windows declared in `overlays/LauncherRRO/res/values/config.xml` (`window_states`), one XML file per window in `res/xml/`.

- **TaskPanel**: hosts an activity. The map, the widget cards, the app grid and launched apps are TaskPanels.
- **DecorPanel**: no activity; a SystemUI controller inflates a layout into it. The dock, the pills, the temperature pills and the plates under the cards are DecorPanels.
- **Variant / Transition**: each panel has named poses and moves between them when an event is posted.

Where a change goes:

- **Overlay XML only**: moving or resizing panels on an existing event, adding a panel, binding a different activity, dock/pill visuals.
- **SystemUI Java**: a new event, a tap that launches an app or writes to the vehicle, watching a setting or rotation. Controllers post events through `ScalableUIEventDispatcher.executeEvent`.
- **Widget app**: what is drawn inside a card.

## Build

### In an AOSP tree

1. Place this repo at `vendor/<oem>/ScalableUI`.
2. Link the controllers into CarSystemUI as described in `integration/car_systemui_android.bp.snippet` and `integration/dagger/CarSysuiScalableBarControllerModule.java`.
3. Add to your product:
   ```make
   $(call inherit-product, vendor/<oem>/ScalableUI/scalableui_packages.mk)
   ```
4. Build:
   ```bash
   source build/envsetup.sh
   lunch aosp_tangorpro_car-trunk_staging-userdebug
   m CarSystemUI CarLauncher StubCarLauncher CarSysuiScalableBarControllers LauncherRRO CarLauncherThemeRRO
   ```

### Overlays without an AOSP tree

```bash
./scripts/install_android_sdk.sh          # once; writes ~/.android_sdk_env
./scripts/build_rro.sh                    # -> out/rro/LauncherRRO.apk, out/rro/CarLauncherThemeRRO.apk
```

These are signed with a generated debug key. They install into `/product/overlay` on a userdebug build but are not platform-signed.

### Widget apps

```bash
cd Widgets
./scripts/build-all.sh                    # ./gradlew assembleDebug
./scripts/deploy-all.sh                   # pushes to /system/priv-app + allowlists, reboots
```

Each app is privileged and needs its allowlist from `Widgets/permissions/` in `/system/etc/permissions/`, or the device boot-loops. See `Widgets/README.md`.

## Deploy to a device

```bash
./scripts/deploy.sh                       # build overlays, push, enable, 240 dpi, layout set 0
./scripts/deploy.sh --serial <SERIAL> --user 10 --variant 0
```

The script uses `$OUT/product/overlay` when `$OUT` is set, otherwise `out/rro/`.

Enable or disable by hand. SystemUI parses panels as user 0, so set both users:

```bash
adb shell cmd overlay enable --user 0  com.android.systemui.rro.scalableUI.launcher
adb shell cmd overlay enable --user 10 com.android.systemui.rro.scalableUI.launcher
adb shell stop && sleep 2 && adb shell start
```

## Layout sets (adb)

```bash
adb shell settings put global scalable_ui_layout_variant <0-3>
```

| Value | Layout |
| --- | --- |
| 0 | Dock bottom centre, pills top, three cards right (default) |
| 1 | Dock as a left vertical rail, pills along the bottom |
| 2 | Paged right column: all eleven cards, three per page, drag the rail to page |
| 3 | T-Rex: dock buttons switch between home, full-screen map, full-screen vehicle, and map + settings split |

Portrait ignores the value and uses the portrait variants.

## Runtime dependencies

These are referenced by the overlay but not built from this repo:

| Component | Used for | Configured in |
| --- | --- | --- |
| `com.android.car.stub.launcher/.StubHome` (AOSP `StubCarLauncher`) | HOME visibility barrier, parked off-screen | `config.xml`, `home_panel.xml` |
| `com.google.android.apps.maps/com.google.android.maps.MapsActivity` | Full-screen map | `strings.xml` `map_componentName` |
| `com.android.car.carlauncher/.AppGridActivity` | All-apps grid | `strings.xml` `appgrid_componentName` |
| `com.android.car.settings` | Settings panel | `strings.xml` |
| `com.test.design/.presentation.ivi.glanceables.*` | Climate, media, and stats cards; climate and vehicle full-screen apps | `strings.xml`, `config.xml` `config_default_activities`; `CarSysuiScalableBarControllerBase.DESIGN_*` |

Replace `com.test.design` with your own card app by changing those strings and constants. Any activity works if it is resizable and `singleTask`.

## Device setup notes

- **Density is per user.** The overlay dimensions target 240 dpi. Set `display_density_forced` to 240 for user 0 and for the driver user, or SystemUI lays out at the hardware density until its next restart.
- **Only one `window_states` owner.** Do not enable another Scalable UI overlay that defines `window_states` at the same time.
- **DEWD overlays.** If the stock navigation bar draws over the dock, disable the DEWD overlays for users 0 and the driver user (`pm disable-user com.android.systemui.rro.dewd.aosp.dynamic`, `com.android.car.resources.dewd`), or remove `DewdDynamicAospRRO` from `samples/systemui_sample_rros.mk`.
- **Hidden is not finished.** `isVisible="false"` stops the hosted activity but keeps its task.

## Debugging

```bash
adb shell dumpsys overlay
adb shell dumpsys window windows | grep -E 'Embedded|TaskPanel'
adb logcat -s ScalableUI StateManager CarSysuiScalableFooterController LayoutVariantWatcher
```

## Known differences from the demo device

The demo tablet runs a CarSystemUI image patched at the dex level. Building from this source gives the same panels and controllers with these differences:

- **Assistant button.** The demo image routes the dock assistant button through an additional launcher class that is not part of this source. The source shows the system default voice assistant through `VoiceInteractionManagerService`.
- **Night mode.** The demo image toggles night mode through a separate helper class. In the source, night mode is handled inside `CarSysuiScalableHeaderController`.
- **Layout set switching.** The source resets the dock orientation for every set. On the demo image, switching straight from set 1 to set 2 or 3 could leave the dock icons stacked; the source does not have that problem.
