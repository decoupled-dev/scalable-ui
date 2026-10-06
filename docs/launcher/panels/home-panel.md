# Home panel

`home_panel` in `overlays/LauncherRRO/res/xml/home_panel.xml`.

## What it is

A TaskPanel whose role is `com.android.car.carlauncher/.CarLauncher`. Android delivers the HOME intent to that activity. If CarLauncher had no panel, the framework would show the stock launcher over the map. This panel exists so that activity has a window that is never on screen.

## Pose

One variant, `closed`, and it is the default.

- Layer 0, behind the map.
- Not visible, alpha 0.
- Bounds are entirely left of the screen: left `-100%`, right `0`.
- Focus stays off.

There is no opened pose.

## What moves it

Every transition targets `closed` with duration 0:

- `_System_OnHomeEvent`
- `_System_BeforeUserSwitch`
- `_System_UserSwitchComplete`
- `_System_TaskOpenEvent` when `panelId` is `home_panel`

Pressing the dock Home button does not reveal this panel. Home is `_System_OnHomeEvent`, which other panels use to close apps and restore the map. `CarSysuiScalableFooterController.launchHome` posts that event. In T-Rex, Home posts `trex_home` instead and this panel still stays closed.

## XML and SystemUI

| Change | Where |
| --- | --- |
| Keep CarLauncher off-screen, or give it a real on-screen pose | This XML file only. |
| Make the dock Home button restore the map, close apps, or enter T-Rex home | `CarSysuiScalableFooterController.launchHome` / `launchTrexHome`. The panel XML does not know the button exists. |
| Stop the stock launcher from being the HOME surface | The `role` on this TaskPanel, plus its row in `config_default_activities` (`home_panel;com.android.car.carlauncher/.CarLauncher`). |

No controller is attached. Nothing in this panel inflates a layout.
