# Map panel

`map_panel` in `overlays/LauncherRRO/res/xml/map_panel.xml`.

## What it is

The background TaskPanel. Role is `com.google.android.apps.maps/com.google.android.maps.MapsActivity` (`map_componentName`). Display 0. Restart policy `LAST`, three retries. `TaskBehavior` is `UNTRIMMABLE`, so the system does not throw the map task away to save memory.

Default pose is `opened`. Layer 2. Bounds are the full screen (`0, 0` to `100%, 100%`) with square corners. The map does not shrink when a card is placed on top of it. Cards are separate windows on higher layers.

`SafeBounds` and `Insets` are sent to Maps so its own zoom and recenter controls avoid the chrome. They are not the window size.

Home insets, from `dimens.xml`:

- Left 0.
- Top 84 dp, under the header pills (they end at 76 dp).
- Right 528 dp, clear of the card column.
- Bottom 112 dp, clear of the dock (the dock occupies the bottom 100 dp, plus 12 dp of air).

## Poses that matter

| Variant | When you see it | Bounds | Insets |
| --- | --- | --- | --- |
| `opened` | Set 0 and set 2 home. | Full screen. | The home insets above. |
| `apps_open` | App grid is open. | Still full screen. | Left 24 dp, right 880 dp, so Maps' controls sit in the uncovered left half. |
| `app_open` | A launched app, climate, vehicle, or settings card covers the canvas. | Still full screen. | Match the app card margins (16 dp sides, 92 dp top, 124 dp bottom). |
| `nav` | Map button in sets 0–2. | Full screen. | Top and bottom only. Side inset is 0, so controls may use the full width. Widgets are gone. |
| `closed` | Setup, and T-Rex home / vehicle. | Full screen, not visible. | Inherited. |
| `layout_v1` | Set 1, left rail. | Full screen. | Left inset becomes 116 dp so controls clear the rail. Top inset drops to 16 dp because the pills have moved to the bottom. |
| `layout_v3_home`, `layout_v3_vehicle` | T-Rex wallpaper and fullscreen vehicle. | Hidden (`closed`). | — |
| `layout_v3_nav` | T-Rex map. | Same as `nav`. | — |
| `layout_v3_split` | T-Rex settings. | Left half, stopping 8 dp short of center (`launcher_v3_split_gutter`). | Same half, plus the pill and dock insets. |
| `portrait` and `portrait_*` | Rotation 0 or 180. | Absolute portrait canvas, 1067×1707 dp. | Top 84 dp. Bottom 440 dp while the widget row is showing. |
| `suw`, `userswitch` | Setup wizard, user switch. | Hidden. | — |

`layout_v3_app_*` and `layout_v3_apps_*` remember which T-Rex mode was up when an app or the grid opened, so the return path is defined per mode.

## What moves it

The framework and the dock. This file only listens.

- App grid opens (`_System_TaskOpenEvent`, `panelId=panel_app_grid`): `opened` or `app_open` → `apps_open` (400 ms / 350 ms).
- Any launched app opens (`launcher_app`, `launcher_climate_app`, `launcher_vehicle_app`, `launcher_settings_app`): → `app_open`.
- That app's panel becomes empty, or Home, or a TaskOpen aimed at `map_panel`: back to `opened`.
- `toggle_fullscreen`: `opened` / `apps_open` / `app_open` ↔ `nav`. Posted by `CarSysuiScalableFooterController.toggleMapFullscreen` in sets 0–2. In T-Rex that method does not post `toggle_fullscreen`. It calls `LayoutVariantWatcher.selectTrexMode("trex_nav")`.
- `layout_variant_0` … `layout_variant_3`: between `opened`, `layout_v1`, and the T-Rex poses. Posted by `LayoutVariantWatcher` from `Settings.Global` `scalable_ui_layout_variant`.
- `trex_home`, `trex_nav`, `trex_vehicle`, `trex_split`: the four T-Rex modes. Posted by `LayoutVariantWatcher.selectTrexMode`, which the dock calls.
- `orientation_portrait` / `orientation_landscape`: posted by `OrientationLayoutWatcher`. The orchestrator itself does not emit these.
- Setup and user-switch events hide and restore the map.

Animations are 350–450 ms with the platform accelerate-decelerate or decelerate interpolator.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Map rectangle, insets, corner, which pose follows an existing event | `map_panel.xml` and the `launcher_map_inset_*` dimens. |
| A new inset when the grid opens | A new `<Insets>` on the `apps_open` variant. No Java. |
| The map button | `CarSysuiScalableFooterController.toggleMapFullscreen`. Sets 0–2 post `toggle_fullscreen`. T-Rex posts `trex_nav` and removes overlay tasks. |
| Which activity is the map | `map_componentName` in `strings.xml`, and the `config_default_activities` row for `map_panel`. |
| Forcing the Maps task back to the opened rectangle after Home | `launchHome` in the footer controller (`realignMapPanelIfNeeded`, `resizeMapsTask`). The XML transition is a no-op if the panel is already `opened` while the task bounds have drifted. That repair is Java. |
| Choosing set 0–3 | `LayoutVariantWatcher`. XML only contains the destination pose. |

The map activity is Google Maps. This overlay does not draw the map. It supplies the window and the insets.
