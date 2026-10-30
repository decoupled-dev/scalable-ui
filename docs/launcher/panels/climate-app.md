# Climate app

`launcher_climate_app` in `overlays/LauncherRRO/res/xml/launcher_climate_app.xml`.

## What it is

The full climate UI opened from the dock, not the small climate card.

Role: `com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity` (`launcher_climate_app_role`).

The right-column card is a different activity, `ClimateHomePanelActivity`, in panel `launcher_climate`. Both can exist. The card is a glanceable. This panel is the large control surface.

`TaskBehavior newTaskLaunchPolicy="REMAIN_IN_SOURCE"` keeps tasks that start inside this panel here, instead of sending them to `launcher_app`.

Default pose is `closed`.

## Poses

The on-screen rectangle matches `launcher_app`: 16 dp side gaps, top 92 dp, bottom inset 124 dp, corner 32 dp.

| Variant | Layer | Visible | Where |
| --- | --- | --- | --- |
| `opened` | 24 | yes, focused | The card above. |
| `behind` | 19 | no | Same rectangle, under whoever just opened. Used when vehicle or settings replaces climate without destroying the task. |
| `closed` | 19 | no, alpha 0 | Same width, top at `100%` (slid below the screen). |
| `layout_v1` | 24 | yes | Left edge 116 dp, clear of the left rail. |
| `portrait_opened` | 24 | yes | Portrait app card, 16–1051 × 92–1595 dp. |
| `layout_v3_opened` | 24 | yes | Same card as set 0. T-Rex does not give climate a special full-screen pose. Vehicle and settings do. |

Layer 24 is above `launcher_app` (20), so this card covers a generic app. Layer 19 is under it, which is why `behind` disappears.

## What moves it

The dock climate icon (`oem_launch_hvac`) calls `CarSysuiScalableFooterController.launchClimate`. That method starts `ClimatePanelActivity` (action and component constants in the footer). It does not post a custom event. The framework sees the role match, places the task in this panel, and posts `_System_TaskOpenEvent` with `panelId=launcher_climate_app`. The XML transition `closed` → `opened` is 400 ms. `behind` → `opened` is instant, because the window is already the right size.

That same TaskOpen is what makes `launcher_vehicle_app` and `launcher_settings_app` go to `behind`, and what makes `launcher_app` close.

Leaving:

- TaskOpen for vehicle, settings, `launcher_app`, the app grid, or `map_panel` sends this panel to `behind` or `closed` as written in its `<Transitions>`.
- `_System_OnHomeEvent` closes it (450 ms), including from `behind`.
- `_System_TaskPanelEmptyEvent` closes it when the task is gone.
- `toggle_fullscreen` closes it.
- Entering T-Rex (`layout_variant_3`) closes the set-0 card. `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` also close it. Climate is not one of the four T-Rex modes.

If the Design package is not installed, `launchClimate` falls through to the AOSP HVAC panel overlay (`TOGGLE_HVAC_PANEL`). That path does not open this TaskPanel.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Rectangle, layer, the behind/closed choreography | `launcher_climate_app.xml`. |
| Which activity is allowed in | `launcher_climate_app_role` in `strings.xml`. |
| The dock icon and the decision to start that activity | `oem_launch_hvac` in `oem_dock.xml` (pixels only) and `launchClimate` in the footer controller. |
| Temperature plus/minus on the bottom pills | Not this panel. Those are `sysui_driver_zone_panel` and `sysui_passenger_zone_panel`, and `CarSysuiScalableHeaderController.adjustHvac`. |
| The small climate card on the right | `launcher_climate` / `ClimateHomePanelActivity`. |

The 300 ms debounce in `launchClimate` (`HVAC_TOGGLE_DEBOUNCE_MS`) is Java. XML has no debounce.
