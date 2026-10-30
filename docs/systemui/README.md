# SystemUI classes

The Java in [`systemui/CarSysuiScalableBarControllers/`](../../systemui/CarSysuiScalableBarControllers/) is linked into CarSystemUI. It does what overlay XML cannot.

LauncherRRO's XML declares panels, their poses, and which event moves each panel to which pose. It cannot:

- post a new event (nothing sends `layout_variant_2` or `orientation_portrait` unless code does),
- react to a tap by launching an app, opening a panel, or writing to the vehicle,
- read the vehicle (HVAC temperature, units, night mode) or a system setting,
- fill a DecorPanel with views: the dock and pills have no activity, so a controller inflates their layouts.

Every class here exists for one of those reasons.

| Document | Classes |
| --- | --- |
| [dock-classes.md](dock-classes.md) | `CarSysuiScalableFooterController`, `DockPins`, `AssistantDockIcon` |
| [header-classes.md](header-classes.md) | `CarSysuiScalableHeaderController`, `HvacTemperatureUnits`, `CarVhalSubscriptionHelper`, `PanelOutsideHost` |
| [core-classes.md](core-classes.md) | `CarSysuiScalableBarControllerBase`, `ScalableDecorPanelController`, `SysuiDumpable`, `LayoutVariantWatcher`, `OrientationLayoutWatcher`, `Android.bp`, the Dagger module and the CarSystemUI integration snippet |

## How a controller gets on screen

1. A panel XML in LauncherRRO names a controller file, for example `controller="@xml/launcher_dock_controller"`.
2. The controller file names a Java class in `ControllerName`, for example `CarSysuiScalableFooterController`.
3. CarSystemUI's `PanelControllerInitializer` resolves the class and looks it up in the Dagger map filled by `CarSysuiScalableBarControllerModule`.
4. The factory builds the controller. It inflates a layout from the overlay package by name and wires the views.
5. To move panels, the controller posts events through `ScalableUIEventDispatcher.executeEvent`. Panels with a matching transition in their XML move.

If step 3 is missing (library not linked or module not included), the panel stays empty.

See also [../launcher/GUIDE.md](../launcher/GUIDE.md) and [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md).
