# Bottom dock

DecorPanel id `oem_dock` in `overlays/LauncherRRO/res/xml/launcher_dock.xml`.

Controller `launcher_dock_controller.xml` names `CarSysuiScalableFooterController`. The panel id `oem_dock` makes that class inflate `res/layout/oem_dock.xml` instead of the stock footer.

Layer 30. Capsule corner `launcher_bar_corner` (42 dp). Default pose `visible`. Focus on transition is true so the buttons receive taps.

## What the layout contains

`oem_dock.xml` is a horizontal row. The controller wires each id. The XML has no click listeners.

| Id | Label | What the footer does |
| --- | --- | --- |
| `sysui_nav_home` | Home | Sets 0–2: post `_System_OnHomeEvent`, then repair the map task bounds. T-Rex: `selectTrexMode("trex_home")`. |
| `sysui_footer_fullscreen_toggle` | Map | Sets 0–2: post `toggle_fullscreen`. T-Rex: `selectTrexMode("trex_nav")`. |
| `sysui_nav_all_apps` | All apps | Post TaskOpen for `panel_app_grid`, then start `AppGridActivity`. |
| `oem_launch_assistant` | Assistant | Start the default assistant. No panel event. The installed build first runs `AssistantDockIcon.prepare`, which removes the other tasks from the app card so the last app is not left behind the assistant overlay. Tasks whose package is in `Settings.Global` `scalable_ui_assistant_keep_packages` (default `com.android.car.media`) are kept, because removing Media Center kills the process holding the media app's browser-service binding and a paused source then drops its session. |
| `oem_launch_hvac` | Climate | Start `ClimatePanelActivity`, which the role places in `launcher_climate_app`. |
| `oem_launch_vehicle` | Vehicle | Start `VehiclePanelActivity` into `launcher_vehicle_app`. T-Rex also posts `trex_vehicle`. |
| `oem_launch_car_settings` | Settings | Start Car Settings homepage into `launcher_settings_app`. T-Rex also posts `trex_split`. |
| `oem_dock_recent` | Recent | `launchRecent`. `DockPins` owns the icons added after this slot. |

Two hairline views split the row into navigation, shortcuts, and the recent/pin area. Those views are not buttons.

## Poses

**Visible (set 0, set 2, set 3).** Centered on the bottom.

- Left and right are `50%` plus `launcher_dock_half_width` (−353 dp), so the capsule is 706 dp wide.
- Top is `100%` plus `launcher_dock_top_offset` (−100 dp).
- Bottom is `100%` minus 16 dp.
- Height is 84 dp. Eight 60 dp icons, 20 dp gaps, two dividers, 12 dp end padding.

**Pins.** `pins_1` … `pins_4` are the same pose with a wider half-width: −404, −444, −484, −524 dp. The first pin adds the separator (about 101 dp of growth, 50.5 dp each side). Each further pin adds 80 dp. `dock_pins_0` returns to `visible`.

**Portrait.** Absolute rect, top 1607 dp, bottom 1691 dp, left/right centered on the 1067 dp canvas (`launcher_port_dock_*`). `pins_port_1` … `pins_port_4` widen that rect. Events are `dock_pins_port_N`.

**Set 1, `layout_v1`.** Left rail: left 16 dp, right 100 dp, top 16 dp, bottom 16 dp off the bottom. The icons are still declared in a horizontal layout. `LayoutVariantWatcher.applyDockOrientation` sets the `LinearLayout` to `VERTICAL` and retunes gaps when the setting is 1 and the display is landscape. XML does not stack them.

**T-Rex.** Bounds stay on `visible` (`layout_variant_3` from `visible` has duration 0). Java restyles the background and icon tint (`applyTrexChrome`). The four mode buttons are the same ids; the footer branches on `LayoutVariantWatcher.isTrex`.

**Hidden.** Setup wizard.

## What moves it

- `orientation_portrait` / `orientation_landscape` from `OrientationLayoutWatcher`.
- `layout_variant_0` … `layout_variant_3` from `LayoutVariantWatcher`. Set 3 does not change the rectangle.
- `dock_pins_N` and `dock_pins_port_N` from `DockPins.applyWidth`. Duration 200 ms. While set 1 is active, `DockPins` does not post a width event (`mWidthEvent = "rail"`), because the rail width is fixed.
- `_System_EnterSuwEvent` / `_System_ExitSuwEvent` from the framework.

Button presses do not change the dock's own pose, except pins changing its width. They change other panels.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Icon art, order, gaps, divider, capsule background | `oem_dock.xml`, styles in `styles.xml`, dimens `launcher_dock_*`, drawables `ic_dock_*`. |
| Capsule position and the wider pin poses | `launcher_dock.xml`. |
| What a tap does | `CarSysuiScalableFooterController` (`wireNavClick`, `wireLaunch`, `launchHome`, `launchAllApps`, `toggleMapFullscreen`, `launchClimate`, `launchCarStatus`, `launchCarSettings`, `launchDefaultAssistant`, `launchRecent`). A new icon in the layout does nothing until this class finds it by id. |
| Pin list, drag to unpin, recent icon, posting `dock_pins_N` | `DockPins.java`. |
| Vertical rail | Bounds in XML variant `layout_v1`. Orientation in `LayoutVariantWatcher.applyDockOrientation`. |
| T-Rex colors on the dock | `LayoutVariantWatcher.applyTrexChrome`. |
| Installing the class into a prebuilt SystemUI | The matching smali under `device-dex/systemui/smali/`. |

`config_enableBottomSystemBar` is false in this overlay. This DecorPanel is the bottom bar.
