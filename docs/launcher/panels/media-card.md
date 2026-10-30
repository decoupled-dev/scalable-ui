# Media card

`launcher_media` in `overlays/LauncherRRO/res/xml/launcher_widget_media.xml`.

Plate: DecorPanel `launcher_widget_media_bg` in `launcher_widget_media_bg.xml`, layer 11, same transitions, no controller.

## What it is

TaskPanel for

`com.test.design/.presentation.ivi.glanceables.MediaHomePanelActivity`

Started at boot from `config_default_activities`. Layer 12. Task corner 14.5 dp. Focus off. Default `visible`.

The dock has no media button in `oem_dock.xml`. Playback UI on the home screen is this card. `CarSysuiScalableFooterController` still contains media-key and `launchMedia` helpers for older OEM card layouts (`oem_media_card`). Those paths are not wired to the launcher dock.

## Where it sits

Set 0 and set 1: middle of the right column.

- Same left/right anchors as the climate card (`100% − 478.5 dp` to `100% − 17.5 dp`).
- Top 377.5 dp, bottom 658.5 dp. Twelve dp below the climate card.

Set 2, page 0: that same middle slot, alpha 1. Pages 1–3: alpha 0, above the screen.

T-Rex home: center card of the row, `launcher_v3_w2_*` (about 594–1114 dp), same vertical band as the other two T-Rex cards (391.5–672.5 dp). Other T-Rex modes hide it.

Portrait: middle of the bottom row (`launcher_port_w2_*`).

Covered by the app grid or a launched app: `apps_open`, off the right edge, alpha 0.

## What moves it

The transition list matches the climate card. Events are posted by `LayoutVariantWatcher` (sets, T-Rex modes, widget pages), `OrientationLayoutWatcher` (rotation), the framework (TaskOpen, TaskPanelEmpty, Home, setup), and the footer (`toggle_fullscreen` in sets 0–2).

## XML and SystemUI

| Change | Where |
| --- | --- |
| Slot, page, T-Rex position | `launcher_widget_media.xml` and the `_bg` file. |
| Hosted activity | `launcher_media_component`, `config_default_activities`. |
| Album art, play, pause | `MediaHomePanelActivity` in the Design app. |
| A dock button that opens a full media app | New icon in `oem_dock.xml` plus a click handler in `CarSysuiScalableFooterController`. XML on this card would then need a transition if that launch should move the card. Today the card moves only because some other panel opened. |
