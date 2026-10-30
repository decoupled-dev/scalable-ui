# LauncherRRO panel XML: chrome, map and apps

This page walks through the window XML files in `overlays/LauncherRRO/res/xml/` that make up the map, the chrome (header pills, dock, temperature pills), the app surfaces (app grid, launched app, dock climate/vehicle/settings), the two controller configs, and the overlay resource map. The card and widget files are covered elsewhere. Every `@string`, `@array` and `@dimen` reference below is resolved from `overlays/LauncherRRO/res/values/`. Numbers assume the 240 dpi landscape canvas, about 1707 × 1067 dp (W × H); portrait is 1067 × 1707 dp. How variants, transitions and events fit together is explained in [../launcher/GUIDE.md](../launcher/GUIDE.md).

How to read the bounds below: `left`/`top` offsets are added to the percentage and `right`/`bottom` offsets are subtracted. So `right="100%" rightOffset="16dp"` means 16 dp in from the right edge, and `left="50%" leftOffset="-353dp"` means 353 dp left of center. The dimens only make sense under this reading. The XML does not state it.

| File | Purpose |
| --- | --- |
| [`home_panel.xml`](#resxmlhome_panelxml) | Parks the HOME activity (StubHome) off-screen so it never paints over the map. |
| [`map_panel.xml`](#resxmlmap_panelxml) | Full-screen Google Maps background; most variants only change the insets sent to Maps. |
| [`launcher_pill_left.xml`](#resxmllauncher_pill_leftxml) | Top-left status pill (Wi-Fi, Bluetooth, volume, brightness, night mode). |
| [`launcher_pill_center.xml`](#resxmllauncher_pill_centerxml) | Top-center clock pill. |
| [`launcher_pill_right.xml`](#resxmllauncher_pill_rightxml) | Top-right profile pill (privacy chips, user). |
| [`launcher_dock.xml`](#resxmllauncher_dockxml) | Floating bottom dock (`oem_dock`); left rail in set 1; widens as apps are pinned. |
| [`launcher_dock_controller.xml`](#resxmllauncher_dock_controllerxml) | Names `CarSysuiScalableFooterController` for the dock. |
| [`launcher_status_controller.xml`](#resxmllauncher_status_controllerxml) | Names `CarSysuiScalableHeaderController` for pills and temperature pills. |
| [`launcher_climate_left.xml`](#resxmllauncher_climate_leftxml) | Bottom-left driver temperature pill. |
| [`launcher_climate_right.xml`](#resxmllauncher_climate_rightxml) | Bottom-right passenger temperature pill. |
| [`panel_app_grid.xml`](#resxmlpanel_app_gridxml) | All-apps grid, slides into the right half. |
| [`launcher_app.xml`](#resxmllauncher_appxml) | `DEFAULT` catch-all card for apps opened from the grid. |
| [`launcher_climate_app.xml`](#resxmllauncher_climate_appxml) | Dock climate app card. |
| [`launcher_vehicle_app.xml`](#resxmllauncher_vehicle_appxml) | Dock vehicle app card; full-width in T-Rex. |
| [`launcher_settings_app.xml`](#resxmllauncher_settings_appxml) | Dock Car Settings card; right half in T-Rex. |
| [`overlays.xml`](#resxmloverlaysxml) | Resource map: which SystemUI resources this RRO replaces. |

Event sources used throughout:

- `_System_*` events: the Scalable UI framework (task opened in a panel, panel emptied, Home, setup wizard, user switch). `CarSysuiScalableFooterController` also posts `_System_OnHomeEvent` (Home button) and a `_System_TaskOpenEvent` for `panel_app_grid` (All apps button).
- `layout_variant_0` … `layout_variant_3`: `LayoutVariantWatcher`, from `Settings.Global scalable_ui_layout_variant`.
- `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split`: `LayoutVariantWatcher.selectTrexMode`, called by the footer controller (and re-posted by `restoreTrexMode`). It is a no-op outside set 3 landscape.
- `orientation_portrait` / `orientation_landscape`: `OrientationLayoutWatcher`.
- `toggle_fullscreen`: `CarSysuiScalableFooterController.toggleMapFullscreen`, sets 0–2 only.
- `dock_pins_N` / `dock_pins_port_N`: `DockPins.applyWidth`.

All Java lives in `systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/`.

---

## `res/xml/home_panel.xml`

- **Type:** TaskPanel
- **Panel id:** `home_panel`, display 0
- **Layer:** 0
- **Role:** `@string/launcher_home_component` = `com.android.car.stub.launcher/.StubHome`. It is also started at boot by the `config_default_activities` row `home_panel;com.android.car.stub.launcher/.StubHome`.

**Purpose in the UI.** The user never sees this panel. StubHome holds the HOME role, and switching back to a user starts it again. If it had no panel, its task would paint over the map. This panel gives it a window that is always off-screen, so Home and user switches land on the full map.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `closed` (default, the only variant) | Entirely left of the screen: left `-100%`, right `0dp`, top `0dp`, bottom `100%`. Not visible, alpha 0, focus off. |

**What moves it.** Every transition targets `closed`, so the panel never leaves this pose:

| Event | Result | Posted by |
| --- | --- | --- |
| `_System_OnHomeEvent` (0 ms) | `closed` | Framework; footer Home button |
| `_System_BeforeUserSwitch`, `_System_UserSwitchComplete` | `closed` | Framework |
| `_System_TaskOpenEvent` `panelId=home_panel` (0 ms) | `closed` | Framework, when StubHome's task lands here |

**Related.** [../launcher/panels/home-panel.md](../launcher/panels/home-panel.md). No controller or layout. Note: that page and the layer table in `GUIDE.md` still name `com.android.car.carlauncher/.CarLauncher` as the role. The XML and `strings.xml` say StubHome.

---

## `res/xml/map_panel.xml`

- **Type:** TaskPanel
- **Panel id:** `map_panel`, display 0
- **Layer:** 2
- **Role:** `@string/map_componentName` = `com.google.android.apps.maps/com.google.android.maps.MapsActivity`, also started at boot from `config_default_activities`.
- **Other:** `<Restart policy="LAST" maxRetry="3"/>`, `<TaskBehavior taskProperties="UNTRIMMABLE"/>`.

**Purpose in the UI.** Google Maps is the background of the whole screen. In landscape the window bounds stay at 0–100% in every pose except T-Rex split, so cards, the grid and apps sit on top of an unchanged map surface. What changes is `SafeBounds` and `Insets`, which tell Maps where to put its own controls so they are not under the chrome or a card. Hidden poses exist for setup, user switch and the T-Rex home/vehicle modes.

**Variants**

Home insets (from `base`): left 0, top 84 dp (`launcher_map_inset_top`, under the pills), right 528 dp (`launcher_map_inset_right`, clears the card column), bottom 112 dp (`launcher_map_inset_bottom`, clears the dock).

| Variant | What it looks like |
| --- | --- |
| `base` | Full screen, square corners, alpha 1, focus off, home insets. |
| `opened` (default) | `base`, visible. Sets 0 and 2 home. |
| `apps_open` | Full screen, visible. Insets left 24 dp, top 84, right 880 dp, bottom 112; SafeBounds right edge at `50%`. Maps' controls move into the left half beside the app grid. |
| `app_open` | Full screen, visible. Insets match the app card: 16 dp sides, 92 dp top, 124 dp bottom. |
| `nav` | Full screen, visible. Insets top 84, bottom 112, sides 0. Map-fullscreen pose. |
| `closed`, `suw`, `userswitch` | Full screen, not visible. `suw` and `userswitch` are empty children of `closed`. |
| `layout_v1` | `opened` with insets left 116 dp (`launcher_v1_map_inset_left`, clears the rail), top 16 dp, right 528, bottom 112. Set 1. |
| `portrait` | Bounds 0–1067 × 0–1707 dp. Insets top 84, bottom 440 dp (clears the card row and temperature pills). |
| `portrait_app_open` | Portrait bounds. SafeBounds is the portrait app card rect (16–1051 × 92–1595 dp). Insets left 16, top 92, right 16, bottom 112. |
| `portrait_apps_open` | Portrait bounds. SafeBounds 0–1067 × 84–92 dp; Insets top 84, bottom 440. |
| `portrait_nav` | Portrait bounds. Insets top 84, bottom 112. |
| `portrait_closed`, `portrait_userswitch` | Hidden. |
| `layout_v3_home`, `layout_v3_vehicle` | Children of `closed`: hidden. T-Rex home shows wallpaper; T-Rex vehicle is covered by the vehicle app. |
| `layout_v3_nav` | Child of `nav`. T-Rex fullscreen map. |
| `layout_v3_split` | Visible. Bounds are the left half: 0 to `50%` minus 8 dp (`launcher_v3_split_gutter`), full height. Insets top 84, right 8, bottom 112. |
| `layout_v3_apps_{home,nav,vehicle,split}` | Children of `apps_open`. Same pose; the name records which T-Rex mode to return to. |
| `layout_v3_app_{home,nav,vehicle,split}` | Children of `app_open`. Same idea for a launched app. |

**What moves it**

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_TaskOpenEvent` `panel_app_grid` | `opened`/`app_open`/`nav` → `apps_open` (400/350 ms); portrait equivalents → `portrait_apps_open`; `layout_v3_<mode>`/`layout_v3_app_<mode>` → `layout_v3_apps_<mode>` | Footer `launchAllApps`, then framework |
| `_System_TaskOpenEvent` `launcher_app` or `launcher_climate_app` | `opened`/`apps_open`/`nav` → `app_open`; portrait → `portrait_app_open`; T-Rex `layout_v3_<mode>`/`layout_v3_apps_<mode>` → `layout_v3_app_<mode>` | Framework |
| `_System_TaskOpenEvent` `launcher_vehicle_app` / `launcher_settings_app` | Sets 0–2 and portrait: → `app_open` / `portrait_app_open`. T-Rex: any `layout_v3_*` pose → `layout_v3_vehicle` / `layout_v3_split` | Framework |
| `_System_TaskPanelEmptyEvent` for any of the four app panels | `app_open` → `opened`, `portrait_app_open` → `portrait`. T-Rex: only `launcher_app` and `launcher_climate_app` emptying return `layout_v3_app_<mode>` → `layout_v3_<mode>` | Framework |
| `_System_TaskOpenEvent` `map_panel` | `closed`/`apps_open`/`app_open` → `opened`; portrait equivalents → `portrait`; `layout_v3_apps_<mode>` → `layout_v3_<mode>` | Framework |
| `_System_OnHomeEvent` | `closed`/`apps_open`/`app_open`/`nav`/`userswitch` → `opened` (450 ms, decelerate); portrait equivalents → `portrait` | Framework; footer Home (sets 0–2) |
| `toggle_fullscreen` | `opened`/`apps_open`/`app_open` → `nav`; `nav` → `opened`; same pattern in portrait | Footer `toggleMapFullscreen` |
| `_System_EnterSuwEvent` / `_System_ExitSuwEvent` | any → `suw`; `suw` → `opened` | Framework |
| `_System_BeforeUserSwitch` / `_System_UserSwitchComplete` | landscape poses → `userswitch` → `opened`; portrait poses → `portrait_userswitch` → `portrait` | Framework |
| `orientation_portrait` / `orientation_landscape` | Each landscape pose ↔ its `portrait_*` twin. `layout_v1` and every `layout_v3_*` go to `portrait`; landscape always returns to the set-0 poses | `OrientationLayoutWatcher` (then `LayoutVariantWatcher` re-posts the set) |
| `layout_variant_1` | `opened` → `layout_v1`; any `layout_v3_*` → `layout_v1` | `LayoutVariantWatcher` |
| `layout_variant_0` / `layout_variant_2` | `layout_v1` and any `layout_v3_*` → `opened` | `LayoutVariantWatcher` |
| `layout_variant_3` | `opened`/`layout_v1`/`nav`/`apps_open`/`app_open`/`closed` → `layout_v3_home` | `LayoutVariantWatcher` |
| `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` | Any `layout_v3_*` pose → `layout_v3_home` / `layout_v3_nav` / `layout_v3_vehicle` / `layout_v3_split` (0 ms if already there) | `LayoutVariantWatcher.selectTrexMode` from the footer |

Most animations are 350–400 ms accelerate-decelerate. Home returns are 450 ms decelerate.

Gaps worth knowing. `layout_v1` has no transitions for the app grid, launched apps, Home, `toggle_fullscreen` or user switch, so in set 1 the map keeps its set-1 insets while those surfaces open. No `layout_v3_*` pose has a `_System_BeforeUserSwitch` transition.

**Related.** [../launcher/panels/map-panel.md](../launcher/panels/map-panel.md). Dimens `launcher_map_inset_*`, `launcher_v1_map_inset_*`, `launcher_port_*`, `launcher_v3_split_gutter`. Java: `CarSysuiScalableFooterController` (`toggleMapFullscreen`, `launchHome`), `LayoutVariantWatcher`, `OrientationLayoutWatcher`.

---

## `res/xml/launcher_pill_left.xml`

- **Type:** DecorPanel
- **Panel id:** `launcher_pill_left`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_status_controller` → `CarSysuiScalableHeaderController`. For this panel id it inflates `res/layout/launcher_pill_left.xml`.

**Purpose in the UI.** The status pill at the top left. It holds Wi-Fi, Bluetooth, volume, brightness and the day/night toggle. The header controller pulls the stock quick-settings buttons into empty slots in the layout. It replaces part of the stock top system bar, which this overlay turns off.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | x 16–384 dp (368 dp wide), y 8–76 dp (68 dp tall). Corner 34 dp (`launcher_pill_corner`), alpha 1, focus on. |
| `visible` (default) / `hidden` | `base` shown / not shown. |
| `portrait` | x 132–500 dp, y 8–76 dp. Left member of the centered pill group. |
| `layout_v1` | Bottom band: x 368–736 dp, top `100%` − 84 dp, bottom `100%` − 16 dp. Set 1. |
| `layout_v3` | `base` position, corner 16 dp (`launcher_v3_pill_corner`). T-Rex. |

**What moves it.** Same transition list in all five pill files:

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_EnterSuwEvent` | any → `hidden` (also listed again with `fromVariant` `portrait` and `layout_v1`) | Framework |
| `_System_ExitSuwEvent` | `hidden` → `visible` | Framework |
| `orientation_portrait` | `visible`/`layout_v1`/`layout_v3` → `portrait` | `OrientationLayoutWatcher` |
| `orientation_landscape` | `portrait` → `visible` | `OrientationLayoutWatcher` |
| `layout_variant_0`, `layout_variant_2` | `layout_v1`/`layout_v3` → `visible` | `LayoutVariantWatcher` |
| `layout_variant_1` | `visible`/`layout_v3` → `layout_v1` | `LayoutVariantWatcher` |
| `layout_variant_3` | `visible`/`layout_v1`/`hidden` → `layout_v3` | `LayoutVariantWatcher` |

All layout and rotation moves are 350 ms accelerate-decelerate. Apps, Home and `toggle_fullscreen` do not move it.

**Related.** [../launcher/docks/status-pill.md](../launcher/docks/status-pill.md). Layout `res/layout/launcher_pill_left.xml`. Controller config [`launcher_status_controller.xml`](#resxmllauncher_status_controllerxml). Java: `CarSysuiScalableHeaderController` (`wireStatusPills`, `toggleNightMode`); `LayoutVariantWatcher` keeps the stock popups aligned after the pill moves.

---

## `res/xml/launcher_pill_center.xml`

- **Type:** DecorPanel
- **Panel id:** `launcher_pill_center`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_status_controller` → `CarSysuiScalableHeaderController`, inflating `res/layout/launcher_pill_center.xml`.

**Purpose in the UI.** The clock at the top center. The layout is a `TextClock`, so the controller does not need to update it. Focus is off on this pill (`Focus onTransition="false"`), unlike the other two header pills.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | Centered, 152 dp wide (`50%` ± 76 dp, `launcher_pill_center_half` = −76 dp), y 8–76 dp. Corner 34 dp, focus off. |
| `visible` (default) / `hidden` | Shown / not shown. |
| `portrait` | x 512–664 dp, y 8–76 dp. |
| `layout_v1` | Still centered, moved to the bottom band (`100%` − 84 dp to `100%` − 16 dp). |
| `layout_v3` | `base` position, corner 16 dp. |

**What moves it.** The same transitions as [`launcher_pill_left.xml`](#resxmllauncher_pill_leftxml): setup, rotation, `layout_variant_0` … `3`.

**Related.** [../launcher/docks/clock-pill.md](../launcher/docks/clock-pill.md). Layout `res/layout/launcher_pill_center.xml`. Java: `CarSysuiScalableHeaderController.getLayoutResourceName`.

---

## `res/xml/launcher_pill_right.xml`

- **Type:** DecorPanel
- **Panel id:** `launcher_pill_right`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_status_controller` → `CarSysuiScalableHeaderController`, inflating `res/layout/launcher_pill_right.xml`.

**Purpose in the UI.** The profile pill at the top right. The header controller adds the stock mic and camera privacy chips, and lays the stock profile button over the avatar and name so a tap opens the user switcher.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | x `100%` − 288 dp to `100%` − 16 dp (272 dp wide), y 8–76 dp. Corner 34 dp, focus on. |
| `visible` (default) / `hidden` | Shown / not shown. |
| `portrait` | x 676–948 dp, y 8–76 dp. |
| `layout_v1` | Bottom band: x `100%` − 540 dp to `100%` − 268 dp, which ends 12 dp before the passenger temperature pill. |
| `layout_v3` | `base` position, corner 16 dp. |

**What moves it.** The same transitions as [`launcher_pill_left.xml`](#resxmllauncher_pill_leftxml).

**Related.** [../launcher/docks/profile-pill.md](../launcher/docks/profile-pill.md). Layout `res/layout/launcher_pill_right.xml`. Java: `CarSysuiScalableHeaderController` (privacy chips, `assignUniqueIds`); `LayoutVariantWatcher` moves the chip popups.

---

## `res/xml/launcher_dock.xml`

- **Type:** DecorPanel
- **Panel id:** `oem_dock`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_dock_controller` → `CarSysuiScalableFooterController`. The panel id `oem_dock` makes it inflate `res/layout/oem_dock.xml`.

**Purpose in the UI.** The floating dock that replaces the stock bottom nav bar: Home, map fullscreen, All apps, assistant, climate, vehicle, car settings, recent, plus pinned apps. The dock's own pose only changes for setup, rotation, layout set 1 and pin count. Its buttons move the other panels.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | Centered at the bottom: `50%` ± 353 dp (706 dp wide, `launcher_dock_half_width`), top `100%` − 100 dp, bottom `100%` − 16 dp (84 dp tall). Corner 42 dp (`launcher_bar_corner`), focus on. |
| `visible` (default) / `hidden` | Shown / not shown. `visible` is also the zero-pins pose. |
| `pins_1` … `pins_4` | `visible` with half-widths 404 / 444 / 484 / 524 dp (808 / 888 / 968 / 1048 dp wide). |
| `portrait` | x 180–886 dp, y 1607–1691 dp. |
| `pins_port_1` … `pins_port_4` | Portrait, wider: x 129–937, 89–977, 49–1017, 9–1057 dp. |
| `layout_v1` | Left rail: x 16–100 dp, top 16 dp, bottom `100%` − 16 dp. Java turns the row vertical. |

There is no T-Rex variant. Set 3 keeps `visible`; Java restyles it.

**What moves it**

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_EnterSuwEvent` / `_System_ExitSuwEvent` | any → `hidden`; `hidden` → `visible` | Framework |
| `orientation_portrait` | `visible`/`layout_v1`/`pins_N` → `portrait` | `OrientationLayoutWatcher` |
| `orientation_landscape` | `portrait`/`pins_port_N` → `visible` | `OrientationLayoutWatcher` |
| `layout_variant_1` | `visible`/`pins_N` → `layout_v1` | `LayoutVariantWatcher` |
| `layout_variant_0`, `layout_variant_2`, `layout_variant_3` | `layout_v1` → `visible` (set 3 from `visible` is a 0 ms no-op) | `LayoutVariantWatcher` |
| `dock_pins_0` … `dock_pins_4` | any → `visible` / `pins_N`, 200 ms, no `fromVariant` | `DockPins.applyWidth` |
| `dock_pins_port_0` … `dock_pins_port_4` | any → `portrait` / `pins_port_N`, 200 ms | `DockPins.applyWidth` |

Because the `dock_pins_*` transitions have no `fromVariant`, they would pull the dock out of `layout_v1` or `hidden`. `DockPins.applyWidth` returns without posting while the setting is 1 (it sets `mWidthEvent = "rail"`). Nothing in the XML prevents a pins event during setup.

**Related.** [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md). Layout `res/layout/oem_dock.xml`. Controller config [`launcher_dock_controller.xml`](#resxmllauncher_dock_controllerxml). Java: `CarSysuiScalableFooterController`, `DockPins`, `LayoutVariantWatcher.applyDockOrientation` / `applyTrexChrome`.

---

## `res/xml/launcher_dock_controller.xml`

- **Type:** panel controller config (`<Controller>`)
- **Id:** `launcher_dock_controller`
- **Class:** `com.android.systemui.car.wm.scalableui.panel.controller.CarSysuiScalableFooterController`
- **RroPackage:** `com.android.systemui.rro.scalableUI.launcher`

**Purpose in the UI.** It has no pixels of its own. It tells the orchestrator which SystemUI class to create for a DecorPanel that references it (here only `oem_dock`). `RroPackage` names this overlay so the controller resolves its layout by name against the RRO package (`CarSysuiScalableBarControllerBase` looks it up with `getIdentifier`). The class must already be compiled into CarSystemUI, or patched into the installed APK as smali. The XML cannot add it.

**Variants.** None. This is not a panel.

**What moves it.** Nothing. The class picks its layout from the panel id (`oem_dock` → `layout/oem_dock`).

**Related.** [`launcher_dock.xml`](#resxmllauncher_dockxml), [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md), [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md). Java: `CarSysuiScalableFooterController.getLayoutResourceName`.

---

## `res/xml/launcher_status_controller.xml`

- **Type:** panel controller config (`<Controller>`)
- **Id:** `launcher_status_controller`
- **Class:** `com.android.systemui.car.wm.scalableui.panel.controller.CarSysuiScalableHeaderController`
- **RroPackage:** `com.android.systemui.rro.scalableUI.launcher`

**Purpose in the UI.** It is shared by five DecorPanels: the three header pills and the two temperature pills. The XML comment says it inflates `layout/car_sysui_scalable_header`. That layout is only the fallback for an unknown panel id. `getLayoutResourceName` maps the ids as follows:

| Panel id | Layout inflated |
| --- | --- |
| `launcher_pill_left` | `launcher_pill_left` |
| `launcher_pill_center` | `launcher_pill_center` |
| `launcher_pill_right` | `launcher_pill_right` |
| `sysui_driver_zone_panel` | `oem_climate_card` |
| `sysui_passenger_zone_panel` | `car_sysui_scalable_header_passenger_zone` |
| anything else | `car_sysui_scalable_header` |

**Variants.** None.

**What moves it.** Nothing. The controller does post events, though: `LayoutVariantWatcher` and the header controller handle night mode, HVAC writes and stock QS buttons. See the pill pages.

**Related.** [../launcher/docks/README.md](../launcher/docks/README.md), [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md). Java: `CarSysuiScalableHeaderController`, `CarSysuiScalableBarControllerBase`.

---

## `res/xml/launcher_climate_left.xml`

- **Type:** DecorPanel
- **Panel id:** `sysui_driver_zone_panel`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_status_controller` → `CarSysuiScalableHeaderController`, inflating `res/layout/oem_climate_card.xml`.

**Purpose in the UI.** The driver temperature pill at the bottom left: minus, the setpoint, plus. The header controller writes the HVAC setpoint through VHAL and shows `--°` until VHAL reports a value. The file name says "climate" but the panel id is the driver-zone id the controller keys on.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | x 16–256 dp (240 dp wide), top `100%` − 100 dp, bottom `100%` − 16 dp (84 dp tall, level with the dock). Corner 42 dp, focus on. |
| `visible` (default) / `hidden` | Shown / not shown. |
| `portrait` | x 16–256 dp, y 1279–1363 dp (above the portrait card row). |
| `layout_v1` | x 116–356 dp, same height band. Clears the left rail. |
| `layout_v3` | `base` position, corner 16 dp. |

**What moves it.** The same transitions as [`launcher_pill_left.xml`](#resxmllauncher_pill_leftxml): setup, rotation, `layout_variant_0` … `3`. Apps opening do not move it.

**Related.** [../launcher/docks/driver-temperature.md](../launcher/docks/driver-temperature.md). Layout `res/layout/oem_climate_card.xml` (`car_sysui_scalable_header_driver_zone.xml` only includes it). Java: `CarSysuiScalableHeaderController.adjustHvac`, `HvacTemperatureUnits`.

---

## `res/xml/launcher_climate_right.xml`

- **Type:** DecorPanel
- **Panel id:** `sysui_passenger_zone_panel`, display 0
- **Layer:** 30
- **Controller:** `@xml/launcher_status_controller` → `CarSysuiScalableHeaderController`, inflating `res/layout/car_sysui_scalable_header_passenger_zone.xml`.

**Purpose in the UI.** The passenger temperature pill at the bottom right, mirroring the driver pill.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | x `100%` − 256 dp to `100%` − 16 dp (240 dp wide), top `100%` − 100 dp, bottom `100%` − 16 dp. Corner 42 dp, focus on. |
| `visible` (default) / `hidden` | Shown / not shown. |
| `portrait` | x 811–1051 dp, y 1279–1363 dp. |
| `layout_v1` | Identical bounds to `base`. The pill does not actually move in set 1. |
| `layout_v3` | `base` position, corner 16 dp. |

**What moves it.** The same transitions as [`launcher_pill_left.xml`](#resxmllauncher_pill_leftxml).

**Related.** [../launcher/docks/passenger-temperature.md](../launcher/docks/passenger-temperature.md). Layout `res/layout/car_sysui_scalable_header_passenger_zone.xml`. Java: `CarSysuiScalableHeaderController`.

---

## `res/xml/panel_app_grid.xml`

- **Type:** TaskPanel
- **Panel id:** `panel_app_grid`, display 0
- **Layer:** 16
- **Role:** `@string/appgrid_componentName` = `com.android.car.carlauncher/.AppGridActivity`
- **Other:** `<TaskBehavior newTaskLaunchPolicy="DEFAULT"/>`: an app started from the grid leaves this panel and goes to the `DEFAULT` role (`launcher_app`).

**Purpose in the UI.** The All apps list, shown as a rounded card in the right half. Closed, it waits just past the right edge so opening is a slide. Tapping an icon starts the app in `launcher_app`, and the grid closes.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | Layer 16, alpha 1, corner 28 dp (`launcher_app_grid_corner`), focus off. |
| `opened` | x `50%` + 16 dp to `100%` − 16 dp, y 92 dp to `100%` − 124 dp. Visible, focus on. |
| `closed` (default) | Same height, x from `100%` to `100%` + 860 dp (`launcher_app_grid_closed_right_offset` = −860 dp). Off-screen right, but `isVisible="true"`. |
| `portrait_opened` | x 16–1051 dp, y 92–1595 dp. |
| `portrait_closed` | x 16–1051 dp, y 1707–3210 dp (below the screen), visible. |
| `layout_v3_opened` / `layout_v3_closed` | Empty children of `opened` / `closed`. Same rectangles, T-Rex names. |

**What moves it**

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_TaskOpenEvent` `panel_app_grid` | `closed` → `opened` (400 ms); portrait and `layout_v3_*` equivalents; already-open stays open | Footer `launchAllApps`, then framework |
| `_System_TaskOpenEvent` `launcher_app` | `opened` → `closed` (300 ms); portrait and T-Rex equivalents | Framework |
| `_System_TaskOpenEvent` `launcher_climate_app` / `vehicle` / `settings` | Only in T-Rex: `layout_v3_opened` → `layout_v3_closed` | Framework |
| `_System_TaskOpenEvent` `map_panel`, `toggle_fullscreen` | `opened` → `closed` (350 ms); portrait too | Framework / footer |
| `_System_OnHomeEvent` | `opened` → `closed` (450 ms decelerate); portrait too | Framework; footer Home |
| `_System_UserSwitchComplete` | snap to `closed` / `portrait_closed` (0 ms) | Framework |
| `orientation_portrait` / `orientation_landscape` | `opened` ↔ `portrait_opened` (350 ms), `closed` ↔ `portrait_closed` (0 ms); T-Rex poses go to portrait too | `OrientationLayoutWatcher` |
| `layout_variant_3` | `opened`/`closed` → `layout_v3_closed` | `LayoutVariantWatcher` |
| `layout_variant_0` / `1` / `2` | `layout_v3_opened` → `opened`, `layout_v3_closed` → `closed` | `LayoutVariantWatcher` |
| `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` | `layout_v3_opened` → `layout_v3_closed` | `LayoutVariantWatcher.selectTrexMode` |

Set 1 has no variant here. The grid stays in the right half. In sets 0–2, opening the dock climate, vehicle or settings app does not close the grid. Those cards (layer 24) cover it, and it remains `opened` underneath until Home, the map or a user switch closes it. From the XML alone it is not clear whether that is intended.

**Related.** [../launcher/panels/app-grid.md](../launcher/panels/app-grid.md). Dimens `launcher_app_grid_*`, `launcher_port_app_*`. Java: `CarSysuiScalableFooterController.launchAllApps`, `LayoutVariantWatcher.widgetColumnCovered`.

---

## `res/xml/launcher_app.xml`

- **Type:** TaskPanel
- **Panel id:** `launcher_app`, display 0
- **Layer:** 20
- **Role:** `@string/launcher_app_role` = `DEFAULT`, the framework's bucket for tasks no other role matches.

**Purpose in the UI.** The card that shows any app opened from the app grid (or from the recent slot or a pin). It covers almost the whole canvas with 16 dp side gaps, so the map is hidden behind it. The pills and dock (layer 30) stay on top and usable.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | Layer 20, alpha 1, corner 32 dp (`launcher_app_corner`), focus off. |
| `opened` | x 16 dp to `100%` − 16 dp, y 92 dp to `100%` − 124 dp (about 1675 × 851 dp). Visible, focus on. |
| `closed` (default) | Hidden, alpha 0. Same x; top `100%`, bottom `100%` − 124 dp (see the note below). |
| `portrait_opened` / `portrait_closed` | x 16–1051 dp; y 92–1595 dp / 1707–3210 dp. |
| `layout_v1` / `layout_v1_closed` | As `opened` / `closed`, left edge 116 dp (`launcher_v1_app_left`) to clear the rail. |
| `layout_v3_opened` / `layout_v3_closed` | Empty children of `opened` / `closed`. |

Note: in `closed` and `layout_v1_closed`, top (`100%`) is below bottom (`100%` − 124 dp), so the rectangle is inverted. It is hidden and alpha 0, so this only affects where the open slide starts.

**What moves it**

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_TaskOpenEvent` `launcher_app` | `closed` → `opened` (400 ms); same for portrait, `layout_v1`, `layout_v3` | Framework, when a DEFAULT task arrives |
| `_System_TaskPanelEmptyEvent` `launcher_app` | `opened` → `closed` (350 ms), and equivalents. Per the XML comment, a task leaving is not a close while another remains | Framework |
| `_System_TaskOpenEvent` climate / vehicle / settings app | `opened` → `closed` (300 ms) and equivalents | Framework |
| `_System_TaskOpenEvent` `panel_app_grid` or `map_panel` | → `closed` (300 ms) | Footer + framework |
| `_System_OnHomeEvent` | → `closed` (450 ms) in sets 0–2 and portrait | Framework; footer Home |
| `toggle_fullscreen` | → `closed` (350 ms) | Footer `toggleMapFullscreen` |
| `_System_UserSwitchComplete` | → closed pose (0 ms) | Framework |
| `orientation_*` | opened ↔ `portrait_opened`, closed ↔ `portrait_closed`; landscape returns to set-0 poses | `OrientationLayoutWatcher` |
| `layout_variant_1` / `0` / `2` / `3` | Between the set-0, `layout_v1` and `layout_v3_*` poses. Entering set 3 always closes | `LayoutVariantWatcher` |
| `trex_*` | `layout_v3_opened` → `layout_v3_closed` | `LayoutVariantWatcher.selectTrexMode` |

**Related.** [../launcher/panels/launched-app.md](../launcher/panels/launched-app.md). Java: `CarSysuiScalableFooterController.launchRecent`, `DockPins`, `LayoutVariantWatcher.widgetColumnCovered`.

---

## `res/xml/launcher_climate_app.xml`

- **Type:** TaskPanel
- **Panel id:** `launcher_climate_app`, display 0
- **Layer:** 24 when opened, 19 when `behind` or `closed` (no layer on `base`)
- **Role:** `@string/launcher_climate_app_role` = `com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity`
- **Other:** `<TaskBehavior newTaskLaunchPolicy="REMAIN_IN_SOURCE"/>`

**Purpose in the UI.** The full climate screen opened by the dock climate button. It is a different activity from the small climate card (`ClimateHomePanelActivity` in `launcher_climate`). It uses the same rectangle as `launcher_app`. Climate, vehicle and settings each have their own panel so that switching between them does not tile two tasks inside `launcher_app`. The panel being replaced drops to `behind`.

**Variants**

| Variant | What it looks like |
| --- | --- |
| `base` | x 16 dp to `100%` − 16 dp, y 92 dp to `100%` − 124 dp. Corner 32 dp, alpha 1, focus off. |
| `opened` | Layer 24, visible, focus on. |
| `behind` | Same rect, layer 19, not visible. Used when vehicle or settings opens on top. |
| `closed` (default) | Layer 19, hidden, alpha 0, top `100%` / bottom `100%` − 124 dp (inverted, as in `launcher_app`). |
| `portrait_opened` / `portrait_behind` / `portrait_closed` | Portrait card 16–1051 × 92–1595 dp; closed at y 1707–3210 dp. |
| `layout_v1` / `layout_v1_behind` / `layout_v1_closed` | Same three, left edge 116 dp. |
| `layout_v3_opened` / `layout_v3_closed` | Empty children of `opened` / `closed`. Climate has no special T-Rex rectangle. |

**What moves it**

| Event | Transition | Posted by |
| --- | --- | --- |
| `_System_TaskOpenEvent` `launcher_climate_app` | `closed` → `opened` (400 ms); `behind` → `opened` (0 ms); same for portrait, `layout_v1`, `layout_v3` | Framework, after footer `launchClimate` starts `ClimatePanelActivity` |
| `_System_TaskOpenEvent` `launcher_vehicle_app` / `launcher_settings_app` | `opened` → `behind` (400 ms) in sets 0–2 and portrait; `layout_v3_opened` → `layout_v3_closed` in T-Rex | Framework |
| `_System_TaskOpenEvent` `launcher_app`, `panel_app_grid`, `map_panel` | opened or behind → closed (300 ms) | Framework / footer |
| `_System_OnHomeEvent`, `toggle_fullscreen`, `_System_TaskPanelEmptyEvent` (own panel) | → closed (450 / 350 / 350 ms) | Framework / footer |
| `_System_UserSwitchComplete` | → closed (0 ms) | Framework |
| `orientation_*`, `layout_variant_*` | Swap between the set-0, portrait, `layout_v1` and `layout_v3` families; set 3 closes it | `OrientationLayoutWatcher`, `LayoutVariantWatcher` |
| `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` | `layout_v3_opened` → `layout_v3_closed` | `LayoutVariantWatcher.selectTrexMode` |

The portrait transitions for `map_panel`, `panel_app_grid` and `launcher_app` opening each appear twice in the file, with identical content.

**Related.** [../launcher/panels/climate-app.md](../launcher/panels/climate-app.md). Java: `CarSysuiScalableFooterController.launchClimate`.

---

## `res/xml/launcher_vehicle_app.xml`

- **Type:** TaskPanel
- **Panel id:** `launcher_vehicle_app`, display 0
- **Layer:** 24 opened, 19 `behind`/`closed`
- **Role:** `@string/launcher_vehicle_app_role` = `com.test.design/.presentation.ivi.glanceables.VehiclePanelActivity`
- **Other:** `newTaskLaunchPolicy="REMAIN_IN_SOURCE"`

**Purpose in the UI.** The full vehicle screen opened by the dock vehicle button. In sets 0–2 it is the same floating card as climate. In T-Rex vehicle mode it becomes the main content: full width between the pills and the dock, while the map is hidden.

**Variants.** The same as [`launcher_climate_app.xml`](#resxmllauncher_climate_appxml) (`opened`, `behind`, `closed`, portrait and `layout_v1` copies, `layout_v3_closed`), except that `layout_v3_opened` is replaced by:

| Variant | What it looks like |
| --- | --- |
| `layout_v3_vehicle` | Layer 24, visible, focus on, square corners. x 0 to `100%`, y 84 dp (`launcher_v3_content_top`) to `100%` − 112 dp (`launcher_v3_content_bottom`). |

**What moves it.** The same as climate with the panel names swapped: its own TaskOpen opens it; climate or settings TaskOpen sends it to `behind`; `launcher_app`, the grid, the map, Home, `toggle_fullscreen` and an empty panel close it. T-Rex differences:

| Event | Transition | Posted by |
| --- | --- | --- |
| `trex_vehicle` | `layout_v3_closed` → `layout_v3_vehicle` (350 ms) | Footer `launchCarStatus` → `LayoutVariantWatcher.selectTrexMode` before starting the activity |
| `_System_TaskOpenEvent` `launcher_vehicle_app` | `layout_v3_closed` → `layout_v3_vehicle` | Framework |
| `trex_home` / `trex_nav` / `trex_split`, TaskOpen of grid / `launcher_app` / climate / settings, own panel empty | `layout_v3_vehicle` → `layout_v3_closed` | `LayoutVariantWatcher` / framework |

`layout_variant_3` from `layout_v1_behind` animates for 350 ms here. In the climate file it is 0 ms.

**Related.** [../launcher/panels/vehicle-app.md](../launcher/panels/vehicle-app.md). The map's matching pose is `layout_v3_vehicle` (hidden) in [`map_panel.xml`](#resxmlmap_panelxml). Java: `CarSysuiScalableFooterController.launchCarStatus`, `LayoutVariantWatcher.selectTrexMode` / `restoreTrexMode`.

---

## `res/xml/launcher_settings_app.xml`

- **Type:** TaskPanel
- **Panel id:** `launcher_settings_app`, display 0
- **Layer:** 24 opened, 19 `behind`/`closed`
- **Role:** `@array/launcher_settings_app_role`. This is the only role here that is an array:
  - `com.android.car.settings/.common.CarSettingActivities$HomepageActivity`
  - `com.android.car.settings/.Settings_Launcher_Homepage`
- **Other:** `newTaskLaunchPolicy="REMAIN_IN_SOURCE"`

**Purpose in the UI.** Car Settings opened by the dock settings button. It is the same floating card as climate in sets 0–2. In T-Rex split mode it is the right half, next to a half-width map.

**Variants.** The same as [`launcher_climate_app.xml`](#resxmllauncher_climate_appxml), except that `layout_v3_opened` is replaced by:

| Variant | What it looks like |
| --- | --- |
| `layout_v3_split` | Layer 24, visible, focus on, corner 32 dp (inherited). x `50%` + 8 dp to `100%` − 16 dp, y 84 dp to `100%` − 112 dp. |

**What moves it.** The same as climate with names swapped; climate or vehicle TaskOpen sends it to `behind`. T-Rex:

| Event | Transition | Posted by |
| --- | --- | --- |
| `trex_split` | `layout_v3_closed` → `layout_v3_split` | Footer `launchCarSettings` → `LayoutVariantWatcher.selectTrexMode` |
| `_System_TaskOpenEvent` `launcher_settings_app` | `layout_v3_closed` → `layout_v3_split` | Framework |
| `trex_home` / `trex_nav` / `trex_vehicle`, TaskOpen of grid / `launcher_app` / climate / vehicle, own panel empty | `layout_v3_split` → `layout_v3_closed` | `LayoutVariantWatcher` / framework |

The map's `layout_v3_split` ends at `50%` − 8 dp, so there is a 16 dp gap at the center. If the gutter changes, both files must change together.

**Related.** [../launcher/panels/settings-app.md](../launcher/panels/settings-app.md). Dimens `launcher_v3_split_gutter`, `launcher_v3_content_*`. Java: `CarSysuiScalableFooterController.launchCarSettings`.

---

## `res/xml/overlays.xml`

- **Type:** overlay resource map (`<overlay>`)
- **Referenced by:** `AndroidManifest.xml` `android:resourcesMap="@xml/overlays"`. Target `com.android.systemui`, `isStatic="false"`, priority 1004, package `com.android.systemui.rro.scalableUI.launcher`.

**Purpose in the UI.** It lists which CarSystemUI resources this overlay replaces. Without this map, the panel files above would never be read. It turns Scalable UI on, turns the stock system bars off (the pills and dock replace them), points `window_states` and `config_default_activities` at this overlay's arrays, and fixes the privacy chip size and color.

**Variants.** None. Mapped items:

| Target | Value | Effect |
| --- | --- | --- |
| `bool/config_enableScalableUI` | `true` | Scalable UI orchestrator on. |
| `bool/config_enableTopSystemBar`, `…Bottom…`, `…Left…`, `…Right…` | all `false` | No stock system bars. |
| `array/window_states` | `config.xml` array | The window list: this page's panels plus the cards, plates and widgets. |
| `array/config_default_activities` | `config.xml` array | Boot activities: StubHome, Maps, the three cards, eight widgets. |
| `dimen/privacy_chip_width` | 44 dp | Stock is 56 dp with 24 dp side padding, which the comment says clips the glyph. |
| `dimen/privacy_chip_horizontal_padding`, `…vertical_padding` | 0 dp | Same reason. |
| `color/privacy_chip_dark_icon_color`, `…light_icon_color` | `@color/launcher_on_surface` (#FF1A1C1E, night #FFFFFFFF) | Chip glyphs match the pill text. |

**What moves it.** Nothing at runtime. Enabling or disabling the overlay (`cmd overlay enable/disable`) and restarting SystemUI is the only switch.

**Related.** `overlays/LauncherRRO/res/values/config.xml`, `dimens.xml`, `colors.xml`, [../launcher/GUIDE.md](../launcher/GUIDE.md), [../launcher/docks/profile-pill.md](../launcher/docks/profile-pill.md).
