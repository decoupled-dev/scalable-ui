# App grid

`panel_app_grid` in `overlays/LauncherRRO/res/xml/panel_app_grid.xml`.

## What it is

A TaskPanel for `com.android.car.carlauncher/.AppGridActivity` (`appgrid_componentName`). It is the right-hand list of apps. It is not one of the widget cards.

`TaskBehavior newTaskLaunchPolicy="DEFAULT"` means an app started from this grid does not stay inside the grid. The new task is sent to the display's `DEFAULT` role, which is `launcher_app`. The grid then closes because it listens for `panelId=launcher_app`.

Default pose is `closed`. Layer 16, above the cards (layer 12) and under a launched app (layer 20). Corner radius 28 dp.

## Poses

**Opened (landscape).** Right half of the screen:

- Left edge is `50%` plus 16 dp.
- Right edge is `100%` minus 16 dp.
- Top 92 dp, bottom inset 124 dp, so the card clears the pills and the dock.

**Closed.** Same height, parked just past the right edge (`left="100%"`, width held by `launcher_app_grid_closed_right_offset` = −860 dp). Visibility stays true so the open animation is a slide, not a pop.

**Portrait.** `portrait_opened` uses the full portrait width between 16 dp and 1051 dp, from 92 dp to 1595 dp. `portrait_closed` is the same width shifted below the screen (top 1707 dp). It slides up.

**T-Rex.** `layout_v3_opened` / `layout_v3_closed` reuse the landscape card. Entering set 3 closes the grid.

**Set 1.** The grid file has no `layout_v1` bounds of its own. The left rail is accounted for on the map and on `launcher_app`. The grid remains the right half.

## What moves it

Opening is a pair of actions in `CarSysuiScalableFooterController.launchAllApps`:

1. Post `_System_TaskOpenEvent` with `panelId=panel_app_grid`. The XML transition `closed` → `opened` runs (400 ms). Posting this through `StateManager.handleEvent` directly does not start the animator. The comment in that method exists because a bare handle produced an empty event and the grid stayed off-screen.
2. Start `AppGridActivity` with `ACTION_APP_GRID`, `FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP`, as the current user, via a one-shot `PendingIntent`.

Other panels listen for that same TaskOpen: cards go to `apps_open` (slid off the right, alpha 0), and the map switches its insets to the left half.

Closing:

- `_System_TaskOpenEvent` for `launcher_app` (the user picked an app): `opened` → `closed`, 300 ms.
- `_System_OnHomeEvent`: 450 ms. The dock Home button posts this.
- TaskOpen for `map_panel`, or `toggle_fullscreen`: 350 ms.
- User switch completes: snap closed.
- `layout_variant_3`: close, because T-Rex has its own screens.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Grid rectangle, corner, slide distance, duration | `panel_app_grid.xml` and `launcher_app_grid_*` dimens. |
| Make the All apps icon open it | `launchAllApps` in `CarSysuiScalableFooterController`. The icon is `sysui_nav_all_apps` in `res/layout/oem_dock.xml`. The layout has no click logic. |
| Where a tapped app goes | `newTaskLaunchPolicy="DEFAULT"` here, and `role="DEFAULT"` on `launcher_app`. Changing the destination means changing that role, which is XML. Choosing the intent is the app grid activity, which is CarLauncher, not this overlay. |
| Hide the variant-2 scrollbar while the grid is open | `LayoutVariantWatcher.widgetColumnCovered`. It treats `panel_app_grid` in `opened` or `portrait_opened` as a cover. XML does not hide that rail. It is not a panel. |

While the grid is open the map surface is still full-screen. Only the map insets change, in `map_panel.xml` variant `apps_open`.
