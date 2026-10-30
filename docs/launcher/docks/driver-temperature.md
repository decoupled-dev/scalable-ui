# Driver temperature

DecorPanel id `sysui_driver_zone_panel` in `overlays/LauncherRRO/res/xml/launcher_climate_left.xml`.

Controller: `launcher_status_controller.xml` → `CarSysuiScalableHeaderController`. For this panel id the controller inflates `oem_climate_card` (`getLayoutResourceName`). `car_sysui_scalable_header_driver_zone.xml` only includes that same layout.

Layer 30. Capsule corner 42 dp. Default `visible`.

## What the layout contains

`oem_climate_card.xml`:

- A gone `oem_card_header`. It is 0×0 and `gone` on purpose. If it were a visible header, the controller would treat the first child as a card title and the minus button would stop stepping the temperature.
- `sysui_driver_hvac_down` — minus.
- `sysui_driver_hvac_temp` — the number, placeholder `--°` until VHAL reports.
- `sysui_driver_hvac_up` — plus.

Clicks are `adjustHvac(AREA_DRIVER, ±1)` in the header controller. The write goes to the HVAC VHAL. Display units follow `HVAC_TEMPERATURE_DISPLAY_UNITS`; `HvacTemperatureUnits` converts the Celsius setpoint and steps one Fahrenheit degree when that unit is selected. That conversion is in Java.

Tapping the number calls `launchClimatePanel` when that listener is attached. The launcher pill's number is the `TextView` `sysui_driver_hvac_temp`. The header wires a click on it inside `wireClickListeners` only when the view is found. On this layout the number can open the climate panel; the plus and minus only step the setpoint.

There is no seat-heat button on this pill. Seat controls live in the seats widget.

## Poses

**Visible.** Bottom left. Left 16 dp, right 256 dp, top `100% − 100 dp`, bottom `100% − 16 dp`. The pill is 240 dp wide and 84 dp tall: two 60 dp circles, a 72 dp readout, 12 dp gaps, 12 dp end padding.

**Set 1.** `layout_v1` moves it to 116–356 dp, still on the bottom, one margin past the left rail. The status pill sits to its right.

**T-Rex.** `layout_v3` keeps the set-0 rectangle and sets the corner to 16 dp (`launcher_v3_pill_corner`).

**Portrait.** Top 1279 dp, bottom 1363 dp, left 16 dp, right 256 dp. That is above the three-card row, which starts around 1375 dp.

**Hidden.** Setup.

Transitions are the shared chrome set: setup, `orientation_portrait` / `orientation_landscape`, `layout_variant_0` … `layout_variant_3`. No app-open transition. The pill stays up while apps cover the canvas.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Position, size, corner, when it hides for setup or rotation | `launcher_climate_left.xml` and `launcher_temp_pill_*` / `launcher_v1_temp_*` / `launcher_port_temp_*`. |
| Glyphs, text size, padding | `oem_climate_card.xml`, `ic_climate_minus` / `ic_climate_plus`, `LauncherDockButton` style. |
| Step size, area id, unit conversion, the VHAL write | `CarSysuiScalableHeaderController.adjustHvac` and `HvacTemperatureUnits`. XML cannot write a vehicle property. |
| Opening the full climate UI from the dock | The dock, not this pill. See [climate-app](../panels/climate-app.md). |

Passenger is the mirror: [passenger-temperature.md](passenger-temperature.md).
