# XML reference

One section per XML file in the repo: what the file is and what it does on screen.

| Document | Covers |
| --- | --- |
| [launcher-panels.md](launcher-panels.md) | `overlays/LauncherRRO/res/xml/`: home and map panels, status pills, dock, temperature pills, app grid, launched-app panels, panel controllers, `overlays.xml` |
| [launcher-cards.md](launcher-cards.md) | `overlays/LauncherRRO/res/xml/`: the eleven widget cards and the opaque plates under them |
| [launcher-resources.md](launcher-resources.md) | `overlays/LauncherRRO` manifest, layouts, values, drawables; `overlays/CarLauncherThemeRRO` |
| [widgets.md](widgets.md) | `Widgets/`: manifests, layouts, resources and privileged-permission allowlists of the widget apps |

## How the files relate

- `res/values/config.xml` lists every window in `window_states`. Each entry is one file in `res/xml/`.
- A **TaskPanel** file names an activity in `role`. The activity is started into the panel and resized to its bounds. `config_default_activities` starts the home-screen ones at boot.
- A **DecorPanel** file names a controller file (`launcher_dock_controller.xml`, `launcher_status_controller.xml`). The controller names a Java class in `systemui/CarSysuiScalableBarControllers/` that inflates a layout from `res/layout/` into the panel.
- Each panel file holds **variants** (poses) and **transitions** (event → variant). One event is delivered to every panel; each panel with a matching transition moves.
- Sizes come from `res/values/dimens.xml`, component names from `res/values/strings.xml`.

For the mechanics in full, read [../launcher/GUIDE.md](../launcher/GUIDE.md). For one page per window, see [../launcher/panels/](../launcher/panels/README.md) and [../launcher/docks/](../launcher/docks/README.md).
