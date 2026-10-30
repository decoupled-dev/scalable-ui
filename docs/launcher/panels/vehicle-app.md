# Vehicle app

`launcher_vehicle_app` in `overlays/LauncherRRO/res/xml/launcher_vehicle_app.xml`.

## What it is

The full vehicle UI opened from the dock. Role: `com.test.design/.presentation.ivi.glanceables.VehiclePanelActivity`.

The bottom-right card in the column is a different activity, `VehicleHomePanelActivity`, in panel `launcher_stats`.

`newTaskLaunchPolicy="REMAIN_IN_SOURCE"`. Default pose `closed`. On-screen card matches `launcher_app` (16 dp sides, top 92 dp, bottom inset 124 dp, 32 dp corners) except in T-Rex.

## Poses

`opened` is layer 24 and focused. `behind` is the same rectangle, layer 19, hidden, so climate or settings can cover it without a second slide from off-screen. `closed` is slid below the bottom edge, alpha 0.

`layout_v1` insets the left edge to 116 dp. Portrait uses the shared portrait app card.

**T-Rex `layout_v3_vehicle`** is its own rectangle, not the floating card:

- Square corners.
- Left 0, right `100%`.
- Top `launcher_v3_content_top` (84 dp), under the pills.
- Bottom inset `launcher_v3_content_bottom` (112 dp), above the dock.
- The map's `layout_v3_vehicle` pose is hidden, so this window is the content.

`layout_v3_closed` reuses `closed`.

## What moves it

Dock icon `oem_launch_vehicle` → `CarSysuiScalableFooterController.launchCarStatus`.

In sets 0–2 that starts `VehiclePanelActivity`. The framework posts TaskOpen for `launcher_vehicle_app`. XML animates `closed` → `opened` in 400 ms. Climate and settings go to `behind`. `launcher_app` closes.

In T-Rex, `launchCarStatus` first calls `LayoutVariantWatcher.selectTrexMode("trex_vehicle")`, then starts the same activity. The T-Rex transitions in this file send the panel to `layout_v3_vehicle` instead of the floating card. The map hides. The three home cards hide.

If Design is missing, the footer does not open this panel. It posts `toggle_card_expand_stats`, which is the old OEM stats-card path and is not what the launcher overlay's vehicle window uses.

Leaving matches climate: Home, app grid, map, `toggle_fullscreen`, an empty panel, or another of the three dock apps. `trex_home`, `trex_nav`, and `trex_split` leave the fullscreen vehicle pose.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Floating-card size, the fullscreen T-Rex rectangle, behind/closed | This XML and `launcher_v3_content_top` / `launcher_v3_content_bottom`. |
| Role | `launcher_vehicle_app_role`. |
| Button behavior, including "in T-Rex, go fullscreen" | `launchCarStatus` in the footer. The XML cannot know the current layout set. `LayoutVariantWatcher.isTrex` is the check, and it is true only for set 3 while landscape. |
| Remembering T-Rex mode while an app is on top, then restoring vehicle | `LayoutVariantWatcher` (`mTrexMode`, `restoreTrexMode`). The footer schedules that restore 500 ms later. |

The driving-stats card (`launcher_stats`) stays a separate window. Opening this panel slides that card away with the other cards; it does not expand it.
