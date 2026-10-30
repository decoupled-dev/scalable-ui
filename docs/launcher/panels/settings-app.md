# Settings app

`launcher_settings_app` in `overlays/LauncherRRO/res/xml/launcher_settings_app.xml`.

## What it is

Car Settings, opened from the dock. The role is a string array, because the homepage has two component names:

- `com.android.car.settings/.common.CarSettingActivities$HomepageActivity`
- `com.android.car.settings/.Settings_Launcher_Homepage`

`newTaskLaunchPolicy="REMAIN_IN_SOURCE"`. Default `closed`. Same floating card as climate and vehicle in sets 0, 1, and 2: layer 24 when opened, layer 19 when `behind` or `closed`, 32 dp corners, 16 dp side gaps.

## Poses

`opened`, `behind`, `closed`, the portrait copies, and `layout_v1` (left edge 116 dp) match `launcher_climate_app`.

**T-Rex `layout_v3_split`** is the right half:

- Left edge `50%` plus 8 dp (`launcher_v3_split_gutter`).
- Right edge `100%` minus 16 dp.
- Top 84 dp, bottom inset 112 dp.
- Layer 24, focused.

The map's matching pose, `layout_v3_split`, is the left half, also inset by that 8 dp gutter. The two windows meet at the center with a gap between them. Pills and the dock stay on layer 30.

## What moves it

Dock icon `oem_launch_car_settings` → `CarSysuiScalableFooterController.launchCarSettings`.

That method starts the Homepage activity. In T-Rex it first posts `trex_split` through `LayoutVariantWatcher.selectTrexMode`. The framework then posts TaskOpen for this panel because the role matched.

`closed` → `opened` is 400 ms in sets 0–2. `behind` → `opened` is 0 ms. In T-Rex the `trex_split` transitions target `layout_v3_split`.

Climate or vehicle opening sends this panel to `behind`. A generic app, the app grid, the map, Home, or `toggle_fullscreen` closes it. `trex_home`, `trex_nav`, and `trex_vehicle` leave the split.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Card size and the split rectangle | This XML, `launcher_v3_split_gutter`, `launcher_v3_content_top`, `launcher_v3_content_bottom`. The map's left half is `map_panel.xml` variant `layout_v3_split`. Both files must change together if the gutter changes. |
| Which settings activities are captured | `launcher_settings_app_role` in `strings.xml`. A settings subscreen whose component is not in that array falls through to `launcher_app` (`DEFAULT`) unless `REMAIN_IN_SOURCE` keeps it here because it was started from the homepage task. |
| The dock button and the T-Rex branch | `launchCarSettings` in the footer. XML does not decide between the floating card and the split. The event name does: TaskOpen versus `trex_split`. |

No glanceable settings card exists in the right column. Settings only appears when the dock opens it.
