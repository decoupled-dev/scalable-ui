# Passenger temperature

DecorPanel id `sysui_passenger_zone_panel` in `overlays/LauncherRRO/res/xml/launcher_climate_right.xml`.

Same controller as the driver pill: `CarSysuiScalableHeaderController`. The panel id selects `car_sysui_scalable_header_passenger_zone.xml`.

Layer 30. Capsule. Default `visible`.

## What the layout contains

A mirror of the driver pill, without the dummy header:

- `sysui_passenger_hvac_down`
- `sysui_passenger_hvac_temp`
- `sysui_passenger_hvac_up`

`adjustHvac(AREA_PASSENGER, ±1)` in the header controller. Same unit conversion as the driver side. The placeholder string is `--°` until the subscription delivers a value.

## Poses

**Visible.** Bottom right. Right edge is `100%` minus 16 dp. Left edge is `100%` plus `launcher_temp_pill_right_inset` (−256 dp). Same 84 dp height as the dock (`topOffset` −100 dp, bottom margin 16 dp).

**Set 1.** Stays on the bottom, to the right of the profile pill. The passenger pill still occupies the right end (`100% − 256` through `100% − 16`). The profile pill's right edge stops 12 dp before it (`launcher_v1_pill_right_edge`).

**T-Rex.** Same rectangle as set 0, corner 16 dp.

**Portrait.** Right side of the band above the card row: left 811 dp, right 1051 dp, top 1279 dp, bottom 1363 dp.

**Hidden.** Setup.

It does not move when an app opens. Chrome layer 30 stays above the app card.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Rectangle and which layout set uses it | `launcher_climate_right.xml`. |
| Button art and the readout width | `car_sysui_scalable_header_passenger_zone.xml`, shared dimens and styles. |
| The property write | `CarSysuiScalableHeaderController`, passenger area. A new button in the layout is inert until `wireClickListeners` binds it. |
| Hiding one zone on a single-zone vehicle | That policy does not exist in the panel XML. Both pills are always in `window_states`. A hide would be either a new event plus a `hidden` transition, or the controller posting an event it does not post today. |

Driver side: [driver-temperature.md](driver-temperature.md).
