# Clock pill

DecorPanel id `launcher_pill_center` in `overlays/LauncherRRO/res/xml/launcher_pill_center.xml`.

Controller: `CarSysuiScalableHeaderController`. Panel id selects `res/layout/launcher_pill_center.xml`.

Layer 30. Corner 34 dp. Default `visible`.

## What the layout contains

A single `TextClock`, 12-hour `h:mm`, 24-hour `HH:mm`, style `LauncherPillText`. No button. The controller does not attach a click listener. Android's `TextClock` updates the text. Nothing in SystemUI formats this string.

The pill is 152 dp wide, centered: left and right are `50%` plus `launcher_pill_center_half` (−76 dp). Top 8 dp, bottom 76 dp.

`car_sysui_scalable_header.xml` is the fallback the controller uses for an unknown panel id. It is a clock plus a night-mode button. The center pill does not use that file.

## Poses

**Visible.** Centered at the top, set 0 and set 2.

**Set 1.** `layout_v1` keeps the pill centered (`50% ± 76 dp`) and moves it onto the bottom band: top is `100% − 84 dp`, bottom is `100% − 16 dp`. On the 1707 dp canvas that lands it between the status pill and the profile pill. It has no icons, so the vertical-rail icon stacking does not apply.

**T-Rex.** Stays centered on top. Corner 16 dp.

**Portrait.** Left 512 dp, right 664 dp, top 8 dp, bottom 76 dp, between the status pill and the profile pill.

**Hidden.** Setup.

Same transition family as the status pill: setup, rotation, `layout_variant_0` … `layout_variant_3`. Apps do not move it.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Position, size, corner | `launcher_pill_center.xml` and `launcher_pill_center_half`, `launcher_port_pill_center_*`. |
| Format, type size, color | `res/layout/launcher_pill_center.xml` and `LauncherPillText`. |
| A tap action on the clock | Requires a new id, a listener in `CarSysuiScalableHeaderController`, and any panel event that listener should post. The current clock is XML only. |
| The large clock card on set 2 page 2 | A different window: [widget-clock.md](../panels/widget-clock.md). |

The variant-2 clock widget and this pill are unrelated processes. Hiding the pill does not hide that card, and the reverse is also true.
