# Launched app

`launcher_app` in `overlays/LauncherRRO/res/xml/launcher_app.xml`.

## What it is

The catch-all TaskPanel. Its role is the string `DEFAULT` (`launcher_app_role`). Any task that does not match a more specific role on this display lands here. In practice that is an app the user opened from the app grid.

Climate, vehicle, and settings do not use this panel. They have their own roles, so a dock switch cannot place two of those tasks side by side inside `launcher_app`.

Default pose is `closed`. Layer 20. Corner radius 32 dp. Focus turns on only while `opened`.

## Poses

**Opened.** Almost the full canvas, with the same 16 dp side gap as the grid:

- Left `launcher_app_grid_edge` (16 dp).
- Right `100%` minus 16 dp.
- Top 92 dp.
- Bottom inset 124 dp.

The dock and the header pills stay on layer 30, so they remain visible and tappable.

**Closed.** Same width, shifted so the top is at `100%` (below the screen) and alpha 0. The open transition slides it up. Duration 400 ms.

**Set 1.** `layout_v1` uses the same card with left edge 116 dp, clear of the left dock rail.

**Portrait.** `portrait_opened` is 16–1051 dp horizontally and 92–1595 dp vertically. `portrait_closed` starts at y = 1707 dp, below the portrait canvas.

**T-Rex.** `layout_v3_opened` / `layout_v3_closed` reuse the set-0 card. T-Rex vehicle and settings do not use this panel.

There is no `behind` pose. This panel is either the front card or it is closed.

## What moves it

- Framework posts `_System_TaskOpenEvent` with `panelId=launcher_app` when a DEFAULT task arrives. `closed` → `opened`.
- The same event tells `panel_app_grid` to close, the map to enter `app_open` (insets only), and the cards to leave.
- `_System_TaskPanelEmptyEvent` for this panel: `opened` → `closed`. The XML comment is specific: a task leaving is not a close while another task remains. The card drops only when the panel is empty. Dock climate, vehicle, and settings closing this panel is a different path: their TaskOpen forces `opened` → `closed` in 300 ms so they can take layer 24 alone.
- App grid opening also closes this card (300 ms), so All apps replaces whatever was launched.
- `_System_OnHomeEvent` closes it in 450 ms.
- `toggle_fullscreen` closes it.
- `map_panel` TaskOpen closes it.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Card size, corner, slide, who is forced closed when climate opens | `launcher_app.xml`. |
| Which component has this role | `launcher_app_role` in `strings.xml`. `DEFAULT` is the framework's unmatched-task bucket. |
| The All apps button that leads here | Footer `launchAllApps`, then the user taps an icon inside `AppGridActivity`. This panel does not launch anything itself. |
| Recent slot and pinned icons launching an app | `CarSysuiScalableFooterController.launchRecent` and `DockPins`. Once the activity starts, the framework's role match puts it in this panel and the TaskOpen transition runs. No extra event is required for the slide. |
| Hiding the variant-2 rail while this card is up | `LayoutVariantWatcher.widgetColumnCovered`. |

`Focus onTransition="true"` on `opened` is what lets the embedded app take input. The closed pose keeps focus off so a hidden task does not steal touches.
