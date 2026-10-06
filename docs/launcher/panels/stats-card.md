# Driving-stats card

`launcher_stats` in `overlays/LauncherRRO/res/xml/launcher_widget_stats.xml`.

Plate: DecorPanel `launcher_widget_stats_bg` in `launcher_widget_stats_bg.xml`, layer 11.

## What it is

TaskPanel for

`com.test.design/.presentation.ivi.glanceables.VehicleHomePanelActivity`

Boot-started. Layer 12. Default `visible`. This is the glanceable at the bottom of the column. The dock Vehicle button opens a different activity, `VehiclePanelActivity`, in `launcher_vehicle_app`.

## Where it sits

Set 0 and set 1: bottom of the right column.

- Same width anchors as climate and media.
- Top 673.5 dp, bottom 954.5 dp. The passenger temperature pill and the dock sit below that.

Set 2, page 0: that bottom slot. Pages 1–3: alpha 0, above the screen.

T-Rex home: right card of the row, `launcher_v3_w3_*` (about 1130–1650 dp). Hidden for nav, vehicle, and split.

Portrait: right of the three bottom cards (`launcher_port_w3_*`).

`apps_open`: off the right edge, alpha 0.

## What moves it

Same event set as the climate card: layout variants, widget pages, T-Rex modes, rotation, TaskOpen / empty / Home, `toggle_fullscreen`, setup.

Opening the dock vehicle app does not retarget this card. The vehicle TaskOpen is one of the events that sends this card to `apps_open` (off-screen) along with climate and media.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Rectangle and page membership | `launcher_widget_stats.xml` and `launcher_widget_stats_bg.xml`. |
| Hosted activity | `launcher_stats_component`. |
| Range, tire, or charge graphics | `VehicleHomePanelActivity`. |
| Fullscreen vehicle in T-Rex | `launcher_vehicle_app` variant `layout_v3_vehicle`, triggered by `trex_vehicle` from `launchCarStatus`. This card's T-Rex reaction is to hide. |
