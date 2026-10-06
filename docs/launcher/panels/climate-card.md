# Climate card

`launcher_climate` in `overlays/LauncherRRO/res/xml/launcher_widget_climate.xml`.

The opaque plate under it is the DecorPanel `launcher_widget_climate_bg` in `launcher_widget_climate_bg.xml`. The plate repeats every transition at layer 11. The task is layer 12. The plate has no controller and no activity.

## What it is

A TaskPanel for the glanceable climate card:

`com.test.design/.presentation.ivi.glanceables.ClimateHomePanelActivity`

Boot starts it because `config_default_activities` has a row for `launcher_climate`. Restart policy `LAST`, three retries. Focus stays off, so taps fall through to the activity inside the task rather than to a panel-level focus grab. Corner radius of the task is 14.5 dp, inset 1.5 dp inside the plate's 16 dp corner so the plate's stroke stays visible.

This is not the dock climate app. That is `ClimatePanelActivity` in `launcher_climate_app`.

Default pose is `visible`.

## Where it sits

Set 0 and set 1, top of the right column. Anchored to the right edge:

- Left: `100%` plus `launcher_widget_left_in` (−478.5 dp), so the card is about 480 dp wide.
- Right: `100%` minus 17.5 dp.
- Top 81.5 dp, bottom 362.5 dp.

Set 2, page 0: same top slot, alpha 1. Pages 1–3: alpha 0, parked above the screen (`launcher_v2_above_*`).

T-Rex home: left card of the centered row, `launcher_v3_w1_*` (about 58–578 dp) and vertically 391.5–672.5 dp. Hidden in the other T-Rex modes (`layout_v3_away`).

Portrait: left of the three cards in the bottom row (`launcher_port_w1_*`, top about 1376 dp). When an app is open, that card moves below the portrait screen.

`apps_open` / `layout_v2_away`: alpha 0 and shifted past the right edge (`launcher_widget_offscreen_*`), which is the slide used when the app grid or a launched app covers the column.

`hidden`: not visible, alpha 0. Setup uses this.

## What moves it

All of these are transitions in the XML. The events come from elsewhere.

- `layout_variant_0` … `layout_variant_3` from `LayoutVariantWatcher`.
- `widget_page_0` … `widget_page_3` from the variant-2 rail in that same class.
- `trex_home`, `trex_nav`, `trex_vehicle`, `trex_split` from `LayoutVariantWatcher.selectTrexMode`.
- `_System_TaskOpenEvent` for the app grid, `launcher_app`, climate app, vehicle app, or settings app: leave the column.
- `_System_OnHomeEvent`, `_System_TaskPanelEmptyEvent` for those app panels, and TaskOpen for `map_panel`: come back.
- `toggle_fullscreen`: leave, same as the other cards. The map's `nav` pose is full width.
- `orientation_portrait` / `orientation_landscape` from `OrientationLayoutWatcher`.
- Setup enter/exit.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Card rectangle, which page shows it, T-Rex row slot, slide off-screen | `launcher_widget_climate.xml`. Copy the same bounds into `launcher_widget_climate_bg.xml` or the plate and the task disagree. |
| Which activity is hosted | `launcher_climate_component` and the `config_default_activities` row. |
| What the card draws (temperature, fans) | The Design app's `ClimateHomePanelActivity`. Not SystemUI, not this XML. |
| Making set 2 page at all | `LayoutVariantWatcher` posts `widget_page_N` and draws the rail. Adding a fifth page is a Java change (`WIDGET_PAGE_COUNT`) plus new variants here. |
| Dock climate button | Does not move this card except by the side effect of opening `launcher_climate_app`, which this file treats like any other covering app. |
