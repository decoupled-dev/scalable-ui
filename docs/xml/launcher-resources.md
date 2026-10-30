# LauncherRRO and CarLauncherThemeRRO resource XML

This page covers every non-panel resource file in [`overlays/LauncherRRO`](../../overlays/LauncherRRO/) (package `com.android.systemui.rro.scalableUI.launcher`, target `com.android.systemui`) and all of [`overlays/CarLauncherThemeRRO`](../../overlays/CarLauncherThemeRRO/) (package `com.android.car.carlauncher.rro.launcherTheme`, target `com.android.car.carlauncher`). The panel files in `res/xml/` are in [launcher-panels.md](launcher-panels.md) and [launcher-cards.md](launcher-cards.md).

How these files reach the screen:

- The panel XML in `res/xml/` refers to dimens, strings, and layouts here with ordinary `@dimen/…`, `@string/…`, `@layout/…` references.
- DecorPanels name a controller (`launcher_dock_controller.xml` or `launcher_status_controller.xml`). That Java class inflates one of the layouts below from the overlay package and finds its views by name with `getIdentifier(name, "id", rroPackage)`. See [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md).
- An id that no controller looks up is drawn but does nothing when tapped.

The controllers are in [`systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/). Class names below refer to files in that directory. The tablet may run a smali-patched prebuilt of these classes rather than this Java (see the repo `CLAUDE.md`), so on-device behavior can lag the source described here.

## Contents

| File | Purpose |
| --- | --- |
| [`AndroidManifest.xml`](#androidmanifestxml) | Declares the dynamic SystemUI overlay, priority 1004 |
| [`res/layout/car_sysui_scalable_footer.xml`](#reslayoutcar_sysui_scalable_footerxml) | Footer fallback layout; includes `oem_dock` |
| [`res/layout/car_sysui_scalable_header.xml`](#reslayoutcar_sysui_scalable_headerxml) | Header fallback layout: clock plus night-mode button |
| [`res/layout/car_sysui_scalable_header_driver_zone.xml`](#reslayoutcar_sysui_scalable_header_driver_zonexml) | Driver-zone fallback; includes `oem_climate_card` |
| [`res/layout/car_sysui_scalable_header_passenger_zone.xml`](#reslayoutcar_sysui_scalable_header_passenger_zonexml) | Passenger temperature pill |
| [`res/layout/launcher_pill_center.xml`](#reslayoutlauncher_pill_centerxml) | Clock pill |
| [`res/layout/launcher_pill_left.xml`](#reslayoutlauncher_pill_leftxml) | Status pill: Wi-Fi, Bluetooth, volume, brightness, day/night |
| [`res/layout/launcher_pill_right.xml`](#reslayoutlauncher_pill_rightxml) | Profile pill: privacy chips and current user |
| [`res/layout/launcher_widget_card_bg.xml`](#reslayoutlauncher_widget_card_bgxml) | Opaque plate under each widget card |
| [`res/layout/oem_climate_card.xml`](#reslayoutoem_climate_cardxml) | Driver temperature pill |
| [`res/layout/oem_dock.xml`](#reslayoutoem_dockxml) | Bottom dock |
| [`res/values/attrs.xml`](#resvaluesattrsxml) | Copies of CarSystemUI attribute names |
| [`res/values/colors.xml`](#resvaluescolorsxml) | Light-theme chrome colors |
| [`res/values/config.xml`](#resvaluesconfigxml) | System bars off, `window_states`, `config_default_activities` |
| [`res/values/dimens.xml`](#resvaluesdimensxml) | Every size and position used by layouts and panels |
| [`res/values/strings.xml`](#resvaluesstringsxml) | Panel roles, component names, content descriptions |
| [`res/values/styles.xml`](#resvaluesstylesxml) | Button, icon, divider, and text styles for the chrome |
| [`res/values-night/colors.xml`](#resvalues-nightcolorsxml) | Dark-theme chrome colors |
| [`res/values-night/dimens.xml`](#resvalues-nightdimensxml) | Hairline stroke and matching card task insets in dark theme |
| [`res/drawable/ic_climate_minus.xml`](#resdrawableic_climate_minusxml) | Minus glyph on the temperature pills |
| [`res/drawable/ic_climate_plus.xml`](#resdrawableic_climate_plusxml) | Plus glyph on the temperature pills |
| [`res/drawable/ic_dock_mic.xml`](#resdrawableic_dock_micxml) | Assistant fallback glyph in the dock |
| [`res/drawable/ic_dock_recent.xml`](#resdrawableic_dock_recentxml) | Empty recent-app slot glyph |
| [`res/drawable/ic_status_bluetooth.xml`](#resdrawableic_status_bluetoothxml) | Bluetooth placeholder glyph |
| [`res/drawable/ic_status_brightness.xml`](#resdrawableic_status_brightnessxml) | Brightness placeholder glyph |
| [`res/drawable/ic_status_day.xml`](#resdrawableic_status_dayxml) | Night-mode button while dark theme is on |
| [`res/drawable/ic_status_night.xml`](#resdrawableic_status_nightxml) | Night-mode button while light theme is on |
| [`res/drawable/ic_status_profile.xml`](#resdrawableic_status_profilexml) | Avatar on the profile pill |
| [`res/drawable/ic_status_volume.xml`](#resdrawableic_status_volumexml) | Volume placeholder glyph |
| [`res/drawable/ic_status_wifi.xml`](#resdrawableic_status_wifixml) | Wi-Fi placeholder glyph |
| [`res/drawable/launcher_dock_bg.xml`](#resdrawablelauncher_dock_bgxml) | Capsule surface of the dock and every pill |
| [`res/drawable/launcher_dock_icon_bg.xml`](#resdrawablelauncher_dock_icon_bgxml) | Filled circle with ripple behind temperature buttons |
| [`res/drawable/launcher_dock_icon_ripple.xml`](#resdrawablelauncher_dock_icon_ripplexml) | Press ripple behind dock icons |
| [`res/drawable/launcher_pill_bg_v3.xml`](#resdrawablelauncher_pill_bg_v3xml) | 16 dp-corner pill surface for T-Rex |
| [`res/drawable/launcher_status_icon_bg.xml`](#resdrawablelauncher_status_icon_bgxml) | Press ripple behind status-pill glyphs |
| [`res/drawable/launcher_widget_card_bg.xml`](#resdrawablelauncher_widget_card_bgxml) | Rounded opaque card plate |
| [`res/drawable-nodpi/`, `res/drawable-night-nodpi/`](#resdrawable-nodpi-and-resdrawable-night-nodpi) | Full-color PNG dock icons, day and night |
| [CarLauncherThemeRRO `AndroidManifest.xml`](#androidmanifestxml-1) | Declares the dynamic CarLauncher overlay, priority 1005 |
| [CarLauncherThemeRRO `res/values/config.xml`](#resvaluesconfigxml-1) | Light theme flag and app bar color |
| [CarLauncherThemeRRO `res/values-night/config.xml`](#resvalues-nightconfigxml) | Dark theme flag and app bar color |
| [CarLauncherThemeRRO `res/xml/overlays.xml`](#resxmloverlaysxml) | Resource map for the two CarLauncher values |

## Manifest

### `AndroidManifest.xml`

**What it is.** The manifest of the LauncherRRO overlay APK: package `com.android.systemui.rro.scalableUI.launcher`, `versionCode`/`versionName` 60, `minSdkVersion` and `targetSdkVersion` 35, `android:hasCode="false"`. The `<overlay>` element targets `com.android.systemui` with `isStatic="false"`, `priority="1004"`, and `resourcesMap="@xml/overlays"`. [`Android.bp`](../../overlays/LauncherRRO/Android.bp) builds it as `runtime_resource_overlay` `LauncherRRO`, platform certificate, `product_specific`.

**Purpose in the UI.** Enabling this overlay is what turns the screen into the map, card column, header pills, dock, and temperature pills. Because it is not static, it can be switched on and off at runtime with `cmd overlay enable/disable` followed by a SystemUI restart.

**Key contents.**
- `resourcesMap="@xml/overlays"` means only the entries listed in [`res/xml/overlays.xml`](../../overlays/LauncherRRO/res/xml/overlays.xml) replace SystemUI values: the five system-bar booleans, `window_states`, `config_default_activities`, three `privacy_chip_*` dimens, and two `privacy_chip_*_icon_color` colors (set to `@color/launcher_on_surface`). That file is described in [launcher-panels.md](launcher-panels.md). Everything else here (layouts, styles, most dimens) stays inside the overlay package and is reached either from panel XML or by controllers that open the overlay package with `createPackageContext`.
- The package name is load-bearing. `launcher_dock_controller.xml` and `launcher_status_controller.xml` put it in `<RroPackage>`, and `DockPins.RRO_PACKAGE` hardcodes it. Without `<RroPackage>`, both bar controllers default to `com.android.systemui.rro.scalableUI.sysuiBars`.

**Used by.** `scripts/deploy.sh` (`PKG_LAUNCHER`), `scripts/build_rro.sh`, `scalableui_packages.mk`.

## Layouts

The controller chooses the layout by panel id:

| Panel id (from `res/xml/`) | Controller | Layout name returned by `getLayoutResourceName()` |
| --- | --- | --- |
| `oem_dock` | `CarSysuiScalableFooterController` | `oem_dock` |
| any other id | `CarSysuiScalableFooterController` | `car_sysui_scalable_footer` |
| `sysui_driver_zone_panel` (or `oem_climate_card`) | `CarSysuiScalableHeaderController` | `oem_climate_card` |
| `sysui_passenger_zone_panel` | `CarSysuiScalableHeaderController` | `car_sysui_scalable_header_passenger_zone` |
| `launcher_pill_left` / `_center` / `_right` | `CarSysuiScalableHeaderController` | same name as the panel id |
| any other id | `CarSysuiScalableHeaderController` | `car_sysui_scalable_header` |

### `res/layout/car_sysui_scalable_footer.xml`

**What it is.** A `FrameLayout` whose only child is `<include layout="@layout/oem_dock" />`.

**Purpose in the UI.** None in the current layout. It is the name `CarSysuiScalableFooterController` falls back to when the panel id is not one it knows. The only footer panel in this overlay is `oem_dock`, which gets `oem_dock.xml` directly. If the fallback is ever used, it draws the same dock.

**Key contents.** No ids of its own. All ids come from `oem_dock.xml`.

**Used by.** `CarSysuiScalableFooterController.getLayoutResourceName()` as the default return value. No panel in `res/xml/` reaches that branch.

### `res/layout/car_sysui_scalable_header.xml`

**What it is.** A horizontal `LinearLayout` on `@drawable/launcher_dock_bg` with a `TextClock` (`h:mm` / `HH:mm`, style `LauncherPillText`) and an `ImageButton` `sysui_night_mode` (style `LauncherStatusButton`, `@drawable/ic_status_night`).

**Purpose in the UI.** None in the current layout. It is the header controller's fallback for an unknown panel id. Every header-controller panel in this overlay has its own layout. The center clock pill does not use this file.

**Key contents.** `sysui_night_mode` would be wired by `CarSysuiScalableHeaderController.wireNightMode` (tap calls `UiModeManager.setNightModeActivated`), the same as on the status pill.

**Used by.** `CarSysuiScalableHeaderController.getLayoutResourceName()` default branch only.

### `res/layout/car_sysui_scalable_header_driver_zone.xml`

**What it is.** A `FrameLayout` that includes `@layout/oem_climate_card`. Its comment calls it the fallback name for the driver zone.

**Purpose in the UI.** None found. `CarSysuiScalableHeaderController` returns `oem_climate_card` for `sysui_driver_zone_panel` and never returns this name. No other file in the overlay or the controller source refers to it. It may exist for a stock CarSystemUI controller that asks for this name; that is not shown by anything in this repo.

**Key contents.** No ids of its own.

**Used by.** Nothing in this repo (grep for `car_sysui_scalable_header_driver_zone` finds only the file itself).

### `res/layout/car_sysui_scalable_header_passenger_zone.xml`

**What it is.** A horizontal `LinearLayout` `sysui_passenger_zone_root` on `@drawable/launcher_dock_bg`, with minus button, readout, and plus button.

**Purpose in the UI.** The passenger temperature pill at the bottom right: two filled circles with a temperature between them. It mirrors the driver pill but has no hidden header view. Panel details: [../launcher/docks/passenger-temperature.md](../launcher/docks/passenger-temperature.md).

**Key contents.**

| Id | View | Wiring (`CarSysuiScalableHeaderController`) |
| --- | --- | --- |
| `sysui_passenger_zone_root` | root `LinearLayout` | Found in `bindPassengerZone`. `LayoutVariantWatcher.applyTrexChrome` swaps its background to `launcher_pill_bg_v3` in T-Rex. |
| `sysui_passenger_hvac_down` | `ImageButton`, `LauncherDockButton`, `ic_climate_minus` | `wireClickListeners`: `adjustHvac(AREA_PASSENGER, -1)`. |
| `sysui_passenger_hvac_temp` | `TextView`, `LauncherPillText`, width `launcher_temp_text_width`, text `launcher_temp_placeholder` (`--°`) | Updated from the HVAC subscription. |
| `sysui_passenger_hvac_up` | `ImageButton`, `ic_climate_plus` | `adjustHvac(AREA_PASSENGER, +1)`. |

`wireDesignScreen` runs after `wireClickListeners`. For `sysui_passenger_zone_panel` it sets a click listener on every view in the tree except image buttons that already have one, and that listener starts `com.test.design/...VehiclePanelActivity`. So a tap on the readout or the pill background opens the vehicle panel, not climate. The passenger-temperature panel page does not mention this.

**Used by.** `CarSysuiScalableHeaderController.getLayoutResourceName()` for `sysui_passenger_zone_panel`, which is the DecorPanel in `res/xml/launcher_climate_right.xml`.

### `res/layout/launcher_pill_center.xml`

**What it is.** A horizontal `LinearLayout` on `@drawable/launcher_dock_bg` containing one `TextClock` (`h:mm` / `HH:mm`, `letterSpacing` 0.02, style `LauncherPillText`).

**Purpose in the UI.** The clock in the middle of the top edge. It is not a button. See [../launcher/docks/clock-pill.md](../launcher/docks/clock-pill.md).

**Key contents.** No ids. `TextClock` updates itself. `LayoutVariantWatcher.applyTrexChrome` finds any `TextClock` and swaps its parent's background to `launcher_pill_bg_v3` in T-Rex and back to `launcher_dock_bg` otherwise.

**Used by.** `CarSysuiScalableHeaderController` for panel id `launcher_pill_center` (`res/xml/launcher_pill_center.xml`).

### `res/layout/launcher_pill_left.xml`

**What it is.** A horizontal `LinearLayout` on `@drawable/launcher_dock_bg` with four 52 dp `FrameLayout` slots, each holding a placeholder `ImageButton`, followed by the night-mode `ImageButton`.

**Purpose in the UI.** The status pill at the top left: Wi-Fi, Bluetooth, volume, brightness, and a day/night toggle. Tapping the first four opens the stock quick-control popups. See [../launcher/docks/status-pill.md](../launcher/docks/status-pill.md).

**Key contents.**

| Slot id / button id | Placeholder | Wiring (`CarSysuiScalableHeaderController.wireStatusPills` → `bindMainThreadPanel`) |
| --- | --- | --- |
| `launcher_status_wifi_slot` / `launcher_status_wifi` | `ic_status_wifi` | Stock `qc_connectivity_panel` button, taken from SystemUI's `qc_status_icons_horizontal`. Fallback: `Settings.ACTION_WIFI_SETTINGS`. |
| `launcher_status_bluetooth_slot` / `launcher_status_bluetooth` | `ic_status_bluetooth` | Stock `qc_bluetooth_panel`. Fallback `ACTION_BLUETOOTH_SETTINGS`. |
| `launcher_status_volume_slot` / `launcher_status_volume` | `ic_status_volume` | Stock `qc_volume_panel`. Fallback `ACTION_SOUND_SETTINGS`. |
| `launcher_status_brightness_slot` / `launcher_status_brightness` | `ic_status_brightness` | Stock `qc_display_panel`. Fallback `ACTION_DISPLAY_SETTINGS`. |
| `sysui_night_mode` | `ic_status_night` | `wireNightMode`: tap calls `toggleNightMode` → `UiModeManager.setNightModeActivated`. `updateNightModeIcon` sets `ic_status_day` while night is on and `ic_status_night` while it is off, with content description `launcher_light_theme` / `launcher_dark_theme`. |

The stock button is placed in its own main-thread window aligned to the slot and is not drawn; the overlay's placeholder icon stays the visible art. If the stock panel cannot be created, the placeholder button opens the fallback Settings screen instead. `LayoutVariantWatcher` keeps the four slot ids in `STATUS_SLOTS` and moves the popup windows to follow the slots after the pill animates.

**Used by.** `CarSysuiScalableHeaderController` for panel id `launcher_pill_left` (`res/xml/launcher_pill_left.xml`). `LayoutVariantWatcher` (`STATUS_PANEL`, `STATUS_SLOTS`).

### `res/layout/launcher_pill_right.xml`

**What it is.** A clickable horizontal `LinearLayout` `launcher_user_profile` on `@drawable/launcher_dock_bg`, containing an empty `LinearLayout` `launcher_privacy_chips` and a `FrameLayout` `launcher_user_anchor` that holds a 32 dp avatar (`ic_status_profile`, tinted `launcher_on_surface`) and a `TextView` `launcher_user_name` (18 sp, max width 140 dp, one line).

**Purpose in the UI.** The profile pill at the top right: camera and microphone privacy chips when those sensors are in use, then the current user's avatar and name. Tapping the user part opens the stock profile switcher. See [../launcher/docks/profile-pill.md](../launcher/docks/profile-pill.md).

**Key contents.**

| Id | Wiring |
| --- | --- |
| `launcher_user_profile` | Root. `LayoutVariantWatcher.applyTrexChrome` swaps its background in T-Rex. |
| `launcher_privacy_chips` | `CarSysuiScalableHeaderController.wirePrivacyChips` inflates SystemUI's `camera_privacy_chip` and `mic_privacy_chip` and hosts them here. `LayoutVariantWatcher` uses it as `PRIVACY_ANCHOR` to move the chip windows. |
| `launcher_user_anchor` | `wireUserProfile` → `bindMainThreadPanel(root, "launcher_user_anchor", "launcher_user_profile", …, "qc_profile_switcher", Settings.ACTION_USER_SETTINGS)`. A tap opens `qc_profile_switcher`, or user settings if that cannot be created. `LayoutVariantWatcher` also reads this view's position. |
| `launcher_user_name` | `wireUserProfile` sets the text to the current user's name. The layout text `@string/launcher_user_profile` ("Profile") is only a placeholder. |

**Used by.** `CarSysuiScalableHeaderController` for panel id `launcher_pill_right` (`res/xml/launcher_pill_right.xml`). `LayoutVariantWatcher` (`PROFILE_PANEL`, `PRIVACY_ANCHOR`).

### `res/layout/launcher_widget_card_bg.xml`

**What it is.** A single `FrameLayout` with `android:background="@drawable/launcher_widget_card_bg"`.

**Purpose in the UI.** The gray or dark rounded plate under each widget card. It sits on layer 11, under the card TaskPanel on layer 12, so the map never shows through a rounded or translucent card in either theme.

**Key contents.** No ids and no controller. The plate DecorPanels name this layout directly in `role="@layout/launcher_widget_card_bg"` and have no `controller` attribute.

**Used by.** All eleven plate panels: `res/xml/launcher_widget_climate_bg.xml`, `launcher_widget_media_bg.xml`, `launcher_widget_stats_bg.xml`, and `launcher_w_{ev,lights,phone,seats,user,clock,apps,connections}_bg.xml`. See [launcher-cards.md](launcher-cards.md).

### `res/layout/oem_climate_card.xml`

**What it is.** A horizontal `LinearLayout` `sysui_driver_zone_root` on `@drawable/launcher_dock_bg` with a 0×0 `gone` `View` `oem_card_header`, then minus button, readout, and plus button.

**Purpose in the UI.** The driver temperature pill at the bottom left. Its circles use the same `LauncherDockButton` style as the passenger pill. See [../launcher/docks/driver-temperature.md](../launcher/docks/driver-temperature.md).

**Key contents.**

| Id | Wiring (`CarSysuiScalableHeaderController`) |
| --- | --- |
| `sysui_driver_zone_root` | `bindDriverZone`. T-Rex background swap in `LayoutVariantWatcher.applyTrexChrome`. |
| `oem_card_header` | Found in `wireClickListeners`. If it is missing, the code takes the root's first child as the header and gives it a click listener that opens the climate panel. The gone placeholder keeps the minus button from being treated as that header. |
| `sysui_driver_hvac_down` | `adjustHvac(AREA_DRIVER, -1)`. |
| `sysui_driver_hvac_temp` | Readout, placeholder `--°`. `wireClickListeners` gives it `launchClimatePanel`. |
| `sysui_driver_hvac_up` | `adjustHvac(AREA_DRIVER, +1)`. |

`wireDesignScreen` then runs for `sysui_driver_zone_panel` and gives every view except the two listening image buttons a tap that starts `com.test.design/...ClimatePanelActivity`. A tap on the readout or pill background opens the climate screen either way.

**Used by.** `CarSysuiScalableHeaderController` for panel id `sysui_driver_zone_panel` (`res/xml/launcher_climate_left.xml`). Also included by `car_sysui_scalable_header_driver_zone.xml`.

### `res/layout/oem_dock.xml`

**What it is.** A horizontal `LinearLayout` on `@drawable/launcher_dock_bg`: three navigation buttons, a divider, four shortcut buttons, a divider, and the recent-app slot. All buttons use style `LauncherDockIcon`. Dividers use `LauncherDockDivider`. The XML has no click handlers.

**Purpose in the UI.** The floating dock that replaces the navigation bar, centered on the bottom edge in sets 0, 2, and 3 and a left rail in set 1. Pinned apps are added after the recent slot at runtime and the capsule widens. See [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md).

**Key contents.**

| Id | Icon | Content description | What a tap does |
| --- | --- | --- | --- |
| `sysui_nav_home` | `ic_dock_home` | "Home" | `CarSysuiScalableFooterController.launchHome`: posts `_System_OnHomeEvent`; in T-Rex, `launchTrexHome` (`trex_home`). |
| `sysui_footer_fullscreen_toggle` | `ic_dock_nav` | "Map fullscreen" | `toggleMapFullscreen`: posts `toggle_fullscreen`; in T-Rex selects `trex_nav`. |
| `sysui_nav_all_apps` | `ic_dock_apps` | "All apps" | `launchAllApps`: posts `_System_TaskOpenEvent` for `panel_app_grid`, then starts `com.android.car.carlauncher/.AppGridActivity`. |
| `oem_launch_assistant` | `ic_dock_mic` | "Assistant" | `wireLaunch` → `launchDefaultAssistant`. `bindAssistantIcon` replaces the mic with the selected assistant's icon and falls back to `ic_dock_mic`. |
| `oem_launch_hvac` | `ic_dock_climate` | "Climate" | `launchClimate`: starts `com.test.design/...ClimatePanelActivity` (`DESIGN_CLIMATE_COMPONENT`). Because the footer also binds this id as `mNavPinned`, a long press calls `launchCarStatus`. |
| `oem_launch_vehicle` | `ic_dock_vehicle` | "Vehicle" | `launchCarStatus`: starts `...VehiclePanelActivity`; in T-Rex selects `trex_vehicle` first. |
| `oem_launch_car_settings` | `ic_dock_settings` | "Car settings" | `launchCarSettings`: starts `com.android.car.settings/.common.CarSettingActivities$HomepageActivity`; in T-Rex selects `trex_split` first. |
| `oem_dock_recent` | `ic_dock_recent`, alpha 0.45, 14 dp padding | "Recent app" | Owned by `DockPins`, not the footer. `showRecent` sets the last app's icon and a listener that launches that component. `clearRecent` restores `ic_dock_recent`, hides the slot, and sets an empty listener. |

Notes from the code:
- `CarSysuiScalableFooterController.bindViews` calls `LayoutVariantWatcher.attachDock(root)` (vertical rail in set 1 via `applyDockOrientation`) and `DockPins.attach(root)` for this panel.
- The footer's `launchRecent` (opens `CarRecentsActivity`) is wired to an id `sysui_nav_recent`, which this layout does not contain. [bottom-dock.md](../launcher/docks/bottom-dock.md) lists `launchRecent` for `oem_dock_recent`; the Java shows `DockPins` handles that button instead.
- Several content descriptions are read by code, so changing the strings changes behavior: `LayoutVariantWatcher.trexIconColor` and `isDockIcon` match "Home", "Map fullscreen", "All apps", "Assistant", "Climate", "Vehicle", "Car settings"; `AssistantDockIcon.bind` finds the button by "Assistant"; `DockPins.recentButton` falls back to finding "Recent app".

**Used by.** `CarSysuiScalableFooterController` for panel id `oem_dock` (`res/xml/launcher_dock.xml`). Included by `car_sysui_scalable_footer.xml`. `DockPins`, `LayoutVariantWatcher`, `AssistantDockIcon` operate on the inflated view.

## Values

### `res/values/attrs.xml`

**What it is.** Nine `<attr>` declarations with the same names and formats as CarSystemUI: `controller`, `icon`, `highlightWhenSelected`, `longIntent`, `panelLayoutRes`, `remoteQCProvider`, `localQCProvider`, `intent`, `disableWhileDriving`. The comment says they let an overlaid status-bar layout set stock button attributes, with idmap rewriting them to SystemUI's attribute ids.

**Purpose in the UI.** Nothing visible. They would matter only if a layout in this overlay used the stock CarSystemUI button classes with those attributes.

**Key contents.** The nine attribute names above.

**Used by.** Nothing in this overlay. No layout here uses an app-namespace attribute; the status buttons are taken from SystemUI's own `qc_status_icons_horizontal` at runtime instead. This file appears to be left over from an earlier status-bar layout.

### `res/values/colors.xml`

**What it is.** Seven light-theme colors, all fully opaque except the ripples.

**Purpose in the UI.** The pale chrome in light theme: off-white pills, dock, and card plates with a soft gray outline and near-black text and glyphs.

**Key contents.**

| Color | Value | Used for |
| --- | --- | --- |
| `launcher_surface` | `#FFF4F6F8` | Fill of `launcher_dock_bg`, `launcher_pill_bg_v3`, `launcher_widget_card_bg`. |
| `launcher_on_surface` | `#FF1A1C1E` | `LauncherStatusButton` tint, `LauncherPillText` color, profile avatar tint and name, `ic_dock_mic` and `ic_dock_recent` fill, and (via `res/xml/overlays.xml`) SystemUI's `privacy_chip_dark_icon_color` / `privacy_chip_light_icon_color`. |
| `launcher_dock_icon_fill` | `#FFC9D0D8` | Circle in `launcher_dock_icon_bg` (temperature buttons). |
| `launcher_temp_glyph` | `#FF1A1C1E` | `ic_climate_minus`, `ic_climate_plus`. |
| `launcher_stroke` | `#FFA8B0BA` | Outline of the three surface drawables; `LauncherDockDivider` background. |
| `launcher_ripple_on_fill` | `#241A1C1E` | Ripple in `launcher_dock_icon_bg`. |
| `launcher_ripple_on_surface` | `#241A1C1E` | Ripple in `launcher_dock_icon_ripple` and `launcher_status_icon_bg`. |

**Used by.** The drawables and styles listed above, `layout/launcher_pill_right.xml`, `res/xml/overlays.xml`. Night values are in [`res/values-night/colors.xml`](#resvalues-nightcolorsxml).

### `res/values/config.xml`

**What it is.** The SystemUI configuration that turns on Scalable UI and declares the windows. Every entry here is forwarded to SystemUI through `res/xml/overlays.xml`.

**Purpose in the UI.** It decides that there is no stock status bar or nav bar, which windows exist, their creation order, and which activities start in them at boot.

**Key contents.**
- **System bars off.** `config_enableScalableUI` true; `config_enableTopSystemBar`, `config_enableBottomSystemBar`, `config_enableLeftSystemBar`, `config_enableRightSystemBar` all false. The dock DecorPanel replaces the bottom bar and the three header pills replace the top bar.
- **`window_states`**, 35 entries in this order:
  1. `home_panel`, `map_panel`
  2. header pills `launcher_pill_left`, `launcher_pill_center`, `launcher_pill_right`
  3. `launcher_dock`, then temperature pills `launcher_climate_left`, `launcher_climate_right`
  4. plates for the three home cards (`launcher_widget_climate_bg`, `_media_bg`, `_stats_bg`), then the cards (`launcher_widget_climate`, `_media`, `_stats`)
  5. plates for the eight extra widgets (`launcher_w_ev_bg` … `launcher_w_connections_bg`), then the widgets (`launcher_w_ev`, `_lights`, `_phone`, `_seats`, `_user`, `_clock`, `_apps`, `_connections`)
  6. `panel_app_grid`, `launcher_app`, `launcher_climate_app`, `launcher_vehicle_app`, `launcher_settings_app`

  Stacking is set by each panel's `<Layer>`, not by this order. A panel file that is not listed here is never created.
- **`config_default_activities`**, `panelId;component` pairs started at boot: `home_panel` → `com.android.car.stub.launcher/.StubHome`; `map_panel` → `com.google.android.apps.maps/com.google.android.maps.MapsActivity`; `launcher_climate` / `launcher_media` / `launcher_stats` → `com.test.design` `ClimateHomePanelActivity` / `MediaHomePanelActivity` / `VehicleHomePanelActivity`; and the eight `launcher_w_*` panels → `com.scalableui.widgets.<name>/…WidgetActivity`. The app grid and the four app panels have no boot activity.
- The panel ids on the left (`launcher_climate`, not `launcher_widget_climate`) are the `id` attributes inside the panel files, not the file names.

**Used by.** `res/xml/overlays.xml` (`bool/config_enable*`, `array/window_states`, `array/config_default_activities`). Read by CarSystemUI's Scalable UI orchestrator. Only one enabled overlay should define `window_states` at a time (see `CLAUDE.md`).

### `res/values/dimens.xml`

**What it is.** All sizes and positions for the chrome layouts and the panel bounds, written for the 240 dpi canvas (about 1707×1067 dp landscape). Negative values are offsets from a `%` anchor in the panel XML. Comments in the file show the arithmetic.

**Purpose in the UI.** Moving or resizing any pill, card, the dock, the app grid, or the map's safe area is done here, usually without touching the panel XML.

**Key contents**, by group:

| Group | Entries | Sizes / places |
| --- | --- | --- |
| Chrome geometry | `launcher_bar_corner` 42, `launcher_pill_corner` 34, `launcher_stroke_width` 1.5, `launcher_dock_button_*`, `launcher_dock_icon_*`, `launcher_bar_end_padding` 12, `launcher_dock_divider_*`, `launcher_status_button_*`, `launcher_status_pill_end_padding` 14, `launcher_temp_text_width` 72 | Capsule radii, 60 dp dock/temperature buttons, 52 dp status slots, divider, readout width. Used by styles, layouts, drawables, and the `Corner` of the dock, pill, and temperature panels. |
| Map safe area | `launcher_map_inset_{left,top,right,bottom}` (0/84/528/112), `launcher_map_inset_{left,right}_apps` (24/880) | Insets sent to Maps in `map_panel.xml` so its controls clear the pills, card column, and dock, or the app grid while it is open. |
| Header pills | `launcher_pill_top` 8, `launcher_pill_bottom` 76, `launcher_pill_edge` 16, `launcher_pill_left_right` 384, `launcher_pill_center_half` −76, `launcher_pill_right_inset` −288 | The three 68 dp pills along the top. `launcher_pill_edge` is the 16 dp screen margin shared by the pills, dock, and temperature pills. |
| Privacy chips | `privacy_chip_width` 44, `privacy_chip_horizontal_padding` 0, `privacy_chip_vertical_padding` 0 | Forwarded to SystemUI by `res/xml/overlays.xml` to replace the stock 56 dp chip. `CarSysuiScalableHeaderController.privacyChipWidth()` reads `privacy_chip_width` from `com.android.systemui`. |
| Bottom row | `launcher_dock_bottom_margin` 16, `launcher_dock_top_offset` −100, `launcher_dock_half_width` −353, `launcher_dock_half_1..4` (−404/−444/−484/−524), `launcher_temp_pill_left_right` 256, `launcher_temp_pill_right_inset` −256 | 84 dp dock centered at 706 dp wide and its four pinned widths in `launcher_dock.xml`; the two 240 dp temperature pills. |
| Set 1 (left rail) | `launcher_v1_*` | Rail right edge 100, driver pill 116–356, status pill 368–736, profile pill offsets, bottom-band pill offset −84, map insets and app left edge 116. |
| App grid and apps | `launcher_app_grid_top` 92, `launcher_app_grid_bottom_offset` 124, `launcher_app_grid_edge` 16, `launcher_app_grid_corner` 28, `launcher_app_corner` 32, `launcher_app_grid_closed_right_offset` −860 | `panel_app_grid.xml` and the four app panels; also used in `map_panel.xml`. |
| Card column (plates) | `launcher_widget_corner` 16, `launcher_widget_left` −480, `launcher_widget_right` 16, `launcher_widget_{climate,media,stats}_{top,bottom}` (80–364, 376–660, 672–956), `launcher_widget_offscreen_*` | Plate bounds for the three right-column slots. |
| Card column (tasks, `_in`) | `launcher_widget_task_corner` 14.5 and every `*_in` dimen | The same rectangles pulled in by 1.5 dp (the light stroke width) so the TaskPanel sits inside its plate's outline. |
| Set 2 paging | `launcher_v2_above_{top,bottom}` (−320/−36), `launcher_v2_below_{top,bottom}` (1100/1384), plus `_in` copies | Parking spots just above and below the screen for cards not on the current page. |
| Set 3 (T-Rex) | `launcher_v3_pill_corner` 16, `launcher_v3_widget_{top,bottom}`, `launcher_v3_w{1,2,3}_{left,right}`, `launcher_v3_split_gutter` 8, `launcher_v3_content_{top,bottom}` (84/112), plus `_in` copies | 16 dp pill corners, three cards in a centered row, the 50/50 split gutter, the content area for the vehicle and settings apps. |
| Portrait | `launcher_port_*` | Absolute dp on the 1067×1707 dp portrait canvas: pill group, dock and its pinned widths, temperature pills, three-card row, app area, map insets. The comment explains why portrait must not use `100%`. |

**Used by.** Panel files in `res/xml/` (nearly all), the layouts and styles listed above, `drawable/launcher_dock_bg.xml`, `launcher_pill_bg_v3.xml`, `launcher_widget_card_bg.xml`, and `res/xml/overlays.xml` for the three `privacy_chip_*` entries. Every dimen in the file is referenced somewhere.

Oddity: the portrait dock comment reads "606dp wide" on one line and "706dp dock" on the next. The values (`180dp`–`886dp`) are 706 dp.

### `res/values/strings.xml`

**What it is.** Component names and roles for the TaskPanels, plus labels used as content descriptions and placeholder text. All are `translatable="false"`.

**Purpose in the UI.** Changing which app appears in the map, a card, or an app panel starts here. The labels are what accessibility reads, and several of them are also matched by code (see below).

**Key contents.**
- **Map, home, grid.** `map_componentName` (role of `map_panel`), `launcher_home_component` (role of `home_panel`, `StubHome`), `appgrid_componentName` (`com.android.car.carlauncher/.AppGridActivity`, used in `panel_app_grid.xml`).
- **App panels.** `launcher_app_role` = `DEFAULT` (catch-all for apps opened from the grid); `launcher_climate_app_role` and `launcher_vehicle_app_role` (`com.test.design` `ClimatePanelActivity`, `VehiclePanelActivity`); `launcher_settings_app_role`, a string-array of two Car Settings components.
- **Cards.** `launcher_climate_component`, `launcher_media_component`, `launcher_stats_component` (`com.test.design` `*HomePanelActivity`), and `launcher_w_{ev,lights,phone,seats,user,clock,apps,connections}_component` (`com.scalableui.widgets.<name>/.WidgetActivity`).
- **Labels.** Header: `launcher_dark_theme`, `launcher_light_theme`, `launcher_wifi`, `launcher_bluetooth`, `launcher_brightness`, `launcher_volume`, `launcher_user_profile`. Dock: `launcher_dock_home`, `_navigation`, `_apps`, `_assistant`, `_climate`, `_vehicle`, `_settings`, `_recent`. Temperature: `launcher_temp_down`, `launcher_temp_up`, `launcher_temp_placeholder` (`--°`).

To use a different map or card app, change all of:
1. the string here (it is the panel's `role`, which routes the task into the panel),
2. the matching row in `config_default_activities` in `config.xml` (it starts the activity at boot and uses the full `package/class` form),
3. for the dock's climate, vehicle, and settings buttons, the Java constants too: the footer starts `DESIGN_CLIMATE_COMPONENT` / `DESIGN_VEHICLE_COMPONENT` (`CarSysuiScalableBarControllerBase`) and a hardcoded Car Settings component, and `CarSysuiScalableHeaderController.wireDesignScreen` hardcodes the `com.test.design` class names. Changing only the role strings leaves the dock launching the old components.

The labels "Wi-Fi", "Bluetooth", "Volume", "Brightness", "Dark theme", "Light theme", "Decrease temperature", "Increase temperature", and the seven dock labels are matched literally by `LayoutVariantWatcher.trexIconColor` and `isDockIcon` to color glyphs in T-Rex; "Assistant" by `AssistantDockIcon`; "Recent app" by `DockPins`. Renaming them breaks those lookups.

**Used by.** `res/xml/map_panel.xml`, `home_panel.xml`, `panel_app_grid.xml`, `launcher_app.xml`, `launcher_climate_app.xml`, `launcher_vehicle_app.xml`, `launcher_settings_app.xml`, the eleven card panels; the layouts above; `CarSysuiScalableHeaderController.updateNightModeIcon` (`launcher_light_theme`, `launcher_dark_theme` by name). Every string is referenced.

### `res/values/styles.xml`

**What it is.** Five styles for the chrome views. The comment notes that layouts are inflated with the overlay package context, so these styles resolve inside the overlay.

**Purpose in the UI.** They make every dock icon, temperature button, status glyph, divider, and readout the same size and color.

**Key contents.**

| Style | Sets | Applied in |
| --- | --- | --- |
| `LauncherDockButton` | 60 dp square, 6 dp side margins, `launcher_dock_icon_bg` (filled circle), 15 dp padding, `fitCenter` | Temperature +/− buttons in `oem_climate_card.xml` and `car_sysui_scalable_header_passenger_zone.xml`. |
| `LauncherDockIcon` (parent `LauncherDockButton`) | 10 dp side margins, `launcher_dock_icon_ripple` (no fill), 0 padding | Every dock button in `oem_dock.xml`. |
| `LauncherDockDivider` | 1×30 dp, 10 dp margins, `launcher_stroke` | The two dividers in `oem_dock.xml`. |
| `LauncherStatusButton` | 52 dp square, `launcher_status_icon_bg`, 11 dp padding, `fitCenter`, tint `launcher_on_surface` | Status and night-mode buttons in `launcher_pill_left.xml` and `car_sysui_scalable_header.xml`. |
| `LauncherPillText` | `launcher_on_surface`, 22 sp, `sans-serif-medium`, single line | Clocks and temperature readouts. |

**Used by.** The layouts listed in the table.

## Night values

### `res/values-night/colors.xml`

**What it is.** The same seven color names as `res/values/colors.xml` with dark-theme values.

**Purpose in the UI.** When night mode is on (for example after the night-mode button on the status pill), the dock, pills, and card plates turn dark charcoal with white text and glyphs.

**Key contents.** `launcher_surface` `#FF1C1F24`, `launcher_on_surface` `#FFFFFFFF`, `launcher_dock_icon_fill` `#FF3A414A`, `launcher_temp_glyph` `#FFFFFFFF`, `launcher_stroke` `#FF3C434C`, `launcher_ripple_on_fill` `#40FFFFFF`, `launcher_ripple_on_surface` `#33FFFFFF`.

**Used by.** The same references as the day colors; Android picks this file under `-night`. The same surface colors appear in CarLauncherThemeRRO's `app_bar_background_color`.

### `res/values-night/dimens.xml`

**What it is.** Overrides for `launcher_stroke_width` (1 dp instead of 1.5 dp) and for every card-task `_in` dimen and `launcher_widget_task_corner` (15 dp instead of 14.5 dp).

**Purpose in the UI.** In dark theme the outlines are a hairline. The card TaskPanels move out by 0.5 dp so they still sit exactly inside the thinner plate outline.

**Key contents.** `launcher_stroke_width`; `launcher_widget_task_corner`; `launcher_widget_{left,right,offscreen_left,offscreen_right}_in`; `launcher_widget_{climate,media,stats}_{top,bottom}_in`; `launcher_v2_{above,below}_{top,bottom}_in`; `launcher_v3_widget_*_in`, `launcher_v3_w{1,2,3}_*_in`; `launcher_port_widget_*_in`, `launcher_port_w{1,2,3}_*_in`. Each is the day value moved 0.5 dp outward.

**Used by.** The card TaskPanel files in `res/xml/` (`launcher_widget_*.xml`, `launcher_w_*.xml`) and the three surface drawables (`launcher_stroke_width`).

## Drawables

The status glyphs are filled white (`#FFFFFFFF`) in the vector. Their color on screen comes from the `android:tint` in `LauncherStatusButton` or the `ImageView` that shows them.

### `res/drawable/ic_climate_minus.xml`

**What it is.** 24 dp vector, Material Rounded "remove", fill `@color/launcher_temp_glyph`.

**Purpose in the UI.** The minus glyph in the left circle of both temperature pills.

**Key contents.** One path.

**Used by.** `layout/oem_climate_card.xml` (`sysui_driver_hvac_down`), `layout/car_sysui_scalable_header_passenger_zone.xml` (`sysui_passenger_hvac_down`).

### `res/drawable/ic_climate_plus.xml`

**What it is.** 24 dp vector, Material Rounded "add", fill `@color/launcher_temp_glyph`.

**Purpose in the UI.** The plus glyph in the right circle of both temperature pills.

**Key contents.** One path.

**Used by.** `layout/oem_climate_card.xml` (`sysui_driver_hvac_up`), `layout/car_sysui_scalable_header_passenger_zone.xml` (`sysui_passenger_hvac_up`).

### `res/drawable/ic_dock_mic.xml`

**What it is.** 24 dp vector, Material Rounded "mic", fill `@color/launcher_on_surface` (black on the light dock, white on the dark one).

**Purpose in the UI.** The assistant button's icon when no assistant app icon can be loaded.

**Key contents.** One path.

**Used by.** `layout/oem_dock.xml` (`oem_launch_assistant`); `CarSysuiScalableFooterController` (`resolveRroDrawable("ic_dock_mic")` in the assistant-icon fallback).

### `res/drawable/ic_dock_recent.xml`

**What it is.** 24 dp vector of a clock-with-arrow "history" style glyph, three paths, fill `@color/launcher_on_surface`.

**Purpose in the UI.** The placeholder in the recent-app slot. At runtime it is replaced by the last-used app's icon; with no recent app the slot is hidden.

**Key contents.** Three paths.

**Used by.** `layout/oem_dock.xml` (`oem_dock_recent`); `DockPins.recentPlaceholder()` looks it up by name.

### `res/drawable/ic_status_bluetooth.xml`

**What it is.** 24 dp white vector, Material Rounded "bluetooth".

**Purpose in the UI.** The Bluetooth glyph on the status pill.

**Key contents.** One path.

**Used by.** `layout/launcher_pill_left.xml` (`launcher_status_bluetooth`).

### `res/drawable/ic_status_brightness.xml`

**What it is.** 24 dp white vector, Material Rounded "settings_brightness" (a sun in a frame, so it differs from the theme toggle).

**Purpose in the UI.** The display-brightness glyph on the status pill.

**Key contents.** One path.

**Used by.** `layout/launcher_pill_left.xml` (`launcher_status_brightness`).

### `res/drawable/ic_status_day.xml`

**What it is.** 24 dp white vector, Material Rounded "light_mode" (sun).

**Purpose in the UI.** Shown on the night-mode button while dark theme is on, meaning a tap switches to light.

**Key contents.** One path.

**Used by.** No layout. `CarSysuiScalableHeaderController.updateNightModeIcon` sets it by name when night is active.

### `res/drawable/ic_status_night.xml`

**What it is.** 24 dp white vector, Material Rounded "dark_mode" (moon).

**Purpose in the UI.** Shown on the night-mode button while light theme is on, meaning a tap switches to dark.

**Key contents.** One path.

**Used by.** `layout/launcher_pill_left.xml` and `layout/car_sysui_scalable_header.xml` (`sysui_night_mode`); `CarSysuiScalableHeaderController.updateNightModeIcon`.

### `res/drawable/ic_status_profile.xml`

**What it is.** 24 dp white vector, Material Rounded "account_circle".

**Purpose in the UI.** The avatar next to the user name on the profile pill.

**Key contents.** One path. Tinted `launcher_on_surface` by the `ImageView`.

**Used by.** `layout/launcher_pill_right.xml`.

### `res/drawable/ic_status_volume.xml`

**What it is.** 24 dp white vector, Material Rounded "volume_up".

**Purpose in the UI.** The volume glyph on the status pill.

**Key contents.** One path.

**Used by.** `layout/launcher_pill_left.xml` (`launcher_status_volume`).

### `res/drawable/ic_status_wifi.xml`

**What it is.** 24 dp white vector, Material Rounded "wifi".

**Purpose in the UI.** The Wi-Fi glyph on the status pill.

**Key contents.** One path.

**Used by.** `layout/launcher_pill_left.xml` (`launcher_status_wifi`).

### `res/drawable/launcher_dock_bg.xml`

**What it is.** Rectangle `shape`: solid `launcher_surface`, corner radius `launcher_bar_corner` (42 dp), stroke `launcher_stroke_width` in `launcher_stroke`.

**Purpose in the UI.** The capsule surface of the dock, the three header pills, and both temperature pills. 42 dp is more than half of both the 68 dp and 84 dp heights, so every one renders as a full capsule.

**Key contents.** The three attributes above.

**Used by.** `layout/oem_dock.xml`, `launcher_pill_left.xml`, `launcher_pill_center.xml`, `launcher_pill_right.xml`, `oem_climate_card.xml`, `car_sysui_scalable_header_passenger_zone.xml`, `car_sysui_scalable_header.xml`; `LayoutVariantWatcher.applyTrexChrome` restores it when leaving T-Rex.

### `res/drawable/launcher_dock_icon_bg.xml`

**What it is.** `ripple` (color `launcher_ripple_on_fill`) over an oval filled with `launcher_dock_icon_fill`.

**Purpose in the UI.** The filled circles behind the plus and minus glyphs, with press feedback.

**Key contents.** One oval item.

**Used by.** `styles.xml` `LauncherDockButton`, so the temperature buttons. `LauncherDockIcon` overrides the background, so dock icons do not get the circle.

### `res/drawable/launcher_dock_icon_ripple.xml`

**What it is.** `ripple` (color `launcher_ripple_on_surface`) with only an oval mask, so it is transparent at rest.

**Purpose in the UI.** The circular press ripple on dock icons. The PNG icons already carry their own color and plate.

**Key contents.** Mask item only.

**Used by.** `styles.xml` `LauncherDockIcon`, so every button in `layout/oem_dock.xml`.

### `res/drawable/launcher_pill_bg_v3.xml`

**What it is.** Same as `launcher_dock_bg` but with corner radius `launcher_v3_pill_corner` (16 dp).

**Purpose in the UI.** In layout set 3 (T-Rex) the header and temperature pills become rounded rectangles instead of capsules.

**Key contents.** Solid `launcher_surface`, 16 dp corners, `launcher_stroke` outline.

**Used by.** No layout. `LayoutVariantWatcher.applyTrexChrome` looks it up by name and sets it on the clock pill, the status-button pills, `sysui_driver_zone_root`, `sysui_passenger_zone_root`, and `launcher_user_profile` while T-Rex is active. The panel XML separately sets the window corner to `launcher_v3_pill_corner`.

### `res/drawable/launcher_status_icon_bg.xml`

**What it is.** `ripple` (color `launcher_ripple_on_surface`) with an oval mask, transparent at rest.

**Purpose in the UI.** The circular press ripple inside each 52 dp status slot.

**Key contents.** Mask item only.

**Used by.** `styles.xml` `LauncherStatusButton`.

### `res/drawable/launcher_widget_card_bg.xml`

**What it is.** Rectangle `shape`: solid `launcher_surface`, corner `launcher_widget_corner` (16 dp), stroke `launcher_stroke_width` in `launcher_stroke`.

**Purpose in the UI.** The rounded, outlined, opaque plate visible as the border around each widget card.

**Key contents.** The three attributes above.

**Used by.** `layout/launcher_widget_card_bg.xml`, which the eleven `*_bg` plate panels in `res/xml/` name as their `role`.

### `res/drawable-nodpi/` and `res/drawable-night-nodpi/`

**What it is.** Two folders with the same six PNGs: `ic_dock_home`, `ic_dock_nav`, `ic_dock_apps`, `ic_dock_climate`, `ic_dock_vehicle`, `ic_dock_settings`. Each is 192×192 RGBA. `nodpi` means Android does not rescale them per density; the 60 dp `LauncherDockIcon` view scales them with `fitCenter`. The `-night-` set is the dark-theme art and is picked automatically in night mode.

**Purpose in the UI.** The full-color icons for Home, Map, All apps, Climate, Vehicle, and Car settings in the dock. The assistant and recent slots use the vector drawables above instead.

**Key contents.** In T-Rex, `LayoutVariantWatcher.applyTrexChrome` applies a `SRC_IN` color filter to these buttons (color chosen by content description), so the PNG shape is kept and its colors are replaced.

**Used by.** `layout/oem_dock.xml` only.

## CarLauncherThemeRRO

### `AndroidManifest.xml`

**What it is.** Manifest for package `com.android.car.carlauncher.rro.launcherTheme`, version 1, SDK 35, no code. `<overlay>` targets `com.android.car.carlauncher`, `isStatic="false"`, `priority="1005"`, `resourcesMap="@xml/overlays"`. [`Android.bp`](../../overlays/CarLauncherThemeRRO/Android.bp) builds `CarLauncherThemeRRO`, platform certificate, `product_specific`.

**Purpose in the UI.** It recolors CarLauncher, whose `AppGridActivity` is the All apps panel, so the grid follows the system day/night theme and matches the LauncherRRO chrome. Its own comment says it does not replace any Scalable UI panels.

**Key contents.** The two values in `res/xml/overlays.xml`.

**Used by.** `scripts/deploy.sh` (`PKG_THEME`, installed alongside LauncherRRO), `scalableui_packages.mk`, repo `README.md`.

### `res/values/config.xml`

**What it is.** Day values: `car_ui_is_light_theme` = `true`, `app_bar_background_color` = `#F4F6F8`.

**Purpose in the UI.** In light theme CarLauncher is told to use its light theme, and its app bar is the same off-white as the LauncherRRO `launcher_surface`.

**Key contents.** The two entries above. What CarLauncher does with `car_ui_is_light_theme` is inside CarLauncher, which is not in this repo.

**Used by.** `res/xml/overlays.xml` in this overlay.

### `res/values-night/config.xml`

**What it is.** Night values: `car_ui_is_light_theme` = `false`, `app_bar_background_color` = `#1C1F24`.

**Purpose in the UI.** In dark theme CarLauncher uses its dark theme and a charcoal app bar that matches the dark `launcher_surface`.

**Key contents.** The two entries above.

**Used by.** `res/xml/overlays.xml` in this overlay.

### `res/xml/overlays.xml`

**What it is.** The `resourcesMap` for this overlay: `bool/car_ui_is_light_theme` and `color/app_bar_background_color` in CarLauncher, mapped to this overlay's values. Comment: "Follows system night mode. Does not replace Scalable UI panels."

**Purpose in the UI.** Limits the overlay to those two CarLauncher resources. Nothing else in CarLauncher changes.

**Key contents.** Two `<item>` rows.

**Used by.** `AndroidManifest.xml` (`android:resourcesMap`).
