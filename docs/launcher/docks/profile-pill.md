# Profile pill

DecorPanel id `launcher_pill_right` in `overlays/LauncherRRO/res/xml/launcher_pill_right.xml`.

Controller: `CarSysuiScalableHeaderController`. Panel id selects `res/layout/launcher_pill_right.xml`.

Layer 30. Corner 34 dp. Default `visible`.

## What the layout contains

A horizontal row, content centered, 16 dp end padding.

- `launcher_privacy_chips` — an empty `LinearLayout`. At runtime the controller adds the stock `MicPrivacyChip` and `CameraPrivacyChip` here. The chips are absent when the camera and mic are not in use, so the row is centered either way.
- `launcher_user_anchor` — avatar plus the current user name. The stock profile button is laid over this frame so a tap opens `qc_profile_switcher`.

The pill is 272 dp wide: two 44 dp chip slots, a 12 dp gap, a 32 dp avatar, and up to 140 dp of name. It sits in from the right edge by `launcher_pill_right_inset` (−288 dp, which includes the 16 dp screen margin). Top 8 dp, bottom 76 dp.

Stock privacy chips resolve their children by id inside `setOnClickListener`. The header controller's `assignUniqueIds` returns immediately after `setId` when the class name ends in `PrivacyChip`. Renumbering those children threw `ID does not reference a View inside this View` and the chip window never appeared. That guard is Java. Do not drop it when editing the controller.

`LayoutVariantWatcher` tracks this panel's screen rect (and the privacy-chip anchor `launcher_privacy_chips`) and moves the chip popup windows after the pill animates. The chips are separate windows, not children clipped to the DecorPanel.

## Poses

**Visible.** Top right, set 0 and set 2.

**Set 1.** Bottom band, left of the passenger temperature pill. Right edge stops 12 dp before that pill (`launcher_v1_pill_right_edge` / `launcher_v1_pill_right_inset`).

**T-Rex.** Same place as set 0. Corner 16 dp.

**Portrait.** Left 676 dp, right 948 dp, top 8–76 dp, as the right member of the centered pill group.

**Hidden.** Setup.

Apps, Home, and the map toggle do not move it.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Pill rectangle and corner | `launcher_pill_right.xml` (the panel file) and `launcher_pill_right_inset`, `launcher_port_pill_right_*`, `launcher_v1_pill_right_*`. |
| Avatar size, name width, chip slot | `res/layout/launcher_pill_right.xml`. The chip views themselves are stock SystemUI, added in `CarSysuiScalableHeaderController`. |
| Opening the user switcher | Header controller, overlaying the stock profile button on `launcher_user_anchor`. |
| Chip popups following the pill | `LayoutVariantWatcher` privacy-anchor tracking. |
| User-switch animation of the map | Framework events `_System_BeforeUserSwitch` and `_System_UserSwitchComplete` on `map_panel`. This pill hides only for setup, not for the switch. |
| The user card on set 2 page 2 | [widget-user.md](../panels/widget-user.md). Different window, hidden unless set 2 is showing that page. |
