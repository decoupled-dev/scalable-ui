# Status pill

DecorPanel id `launcher_pill_left` in `overlays/LauncherRRO/res/xml/launcher_pill_left.xml`.

Controller: `CarSysuiScalableHeaderController` via `launcher_status_controller.xml`. The panel id selects `res/layout/launcher_pill_left.xml`.

Layer 30. Corner 34 dp (a 68 dp pill is a capsule at 34 dp). Default `visible`.

## What the layout contains

Five slots in a row, 52 dp each, 20 dp apart, 14 dp end padding. The pill runs from x = 16 dp to x = 384 dp, y = 8 dp to y = 76 dp.

| Slot id | Static icon | What the header controller does |
| --- | --- | --- |
| `launcher_status_wifi_slot` | `ic_status_wifi` | Pulls stock `qc_connectivity_panel` into the slot. Fallback intent `Settings.ACTION_WIFI_SETTINGS`. |
| `launcher_status_bluetooth_slot` | `ic_status_bluetooth` | Stock `qc_bluetooth_panel`. |
| `launcher_status_volume_slot` | `ic_status_volume` | Stock `qc_volume_panel`. Fallback sound settings. |
| `launcher_status_brightness_slot` | `ic_status_brightness` | Stock `qc_display_panel`. |
| `sysui_night_mode` | `ic_status_night` / day glyph | Not a stock panel. `toggleNightMode` calls `UiModeManager.setNightModeActivated`. The glyph shows the theme the next tap will select. |

The static icons are placeholders. `wireStatusPills` replaces the slot contents with the stock buttons when those views exist on the main thread. If the stock button is missing, the placeholder remains and the fallback settings intent is used.

The stock buttons open popup windows that are not children of this DecorPanel. `LayoutVariantWatcher` records the slot rectangles (`launcher_status_wifi_slot` and the three siblings) and repositions those popup windows after the pill moves, including across the 350 ms layout-variant animation. Several follow-up passes run so the window catches the pill at the end of the transition. That repositioning is Java. The pill XML does not contain the popups.

Theme changes rebuild the dock and reset panels to their default pose. `LayoutVariantWatcher` sets `mReapplyVariant` and posts `layout_variant_N` again.

## Poses

**Visible.** Top left, as above.

**Set 1, `layout_v1`.** Bottom band, clear of the rail and the driver pill: left 368 dp, right 736 dp, top `100% − 84 dp`, bottom `100% − 16 dp`. The 68 dp pill is shorter than the 84 dp temperature pills beside it.

**T-Rex, `layout_v3`.** Same place as set 0. Corner becomes 16 dp.

**Portrait.** Left 132 dp, right 500 dp, same 8–76 dp vertical band. The three pills are pulled into one centered group.

**Hidden.** Setup (`_System_EnterSuwEvent`).

No transition on app open, Home, or `toggle_fullscreen`. The pill stays.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Pill rectangle, corner, visibility per layout set | `launcher_pill_left.xml`, `launcher_pill_left_right`, `launcher_v1_pill_left_*`, `launcher_port_pill_left_*`. |
| Order of icons, gaps, placeholder drawables | `res/layout/launcher_pill_left.xml`. |
| Binding a slot to a stock quick-settings panel, night mode | `CarSysuiScalableHeaderController` (`wireStatusPills`, `toggleNightMode`). A new slot in XML is not live until this method names it. |
| Keeping the popup glued to the slot after a move | `LayoutVariantWatcher` (`STATUS_SLOTS`, `updatePrivacyWindow` is the profile side; the status path is the slot rects `mStatusX/Y/W/H`). |
| Privacy chips | They are not in this pill. They are added to [profile-pill.md](profile-pill.md). |
