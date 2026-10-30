# Docks and pills

These are DecorPanels. They inflate a layout and run a SystemUI controller. They do not host an activity.

| Surface | File |
| --- | --- |
| Bottom dock, `oem_dock` | [bottom-dock.md](bottom-dock.md) |
| Driver temperature | [driver-temperature.md](driver-temperature.md) |
| Passenger temperature | [passenger-temperature.md](passenger-temperature.md) |
| Wi-Fi, Bluetooth, volume, brightness, day/night | [status-pill.md](status-pill.md) |
| Clock | [clock-pill.md](clock-pill.md) |
| Privacy chips and user | [profile-pill.md](profile-pill.md) |

The dock controller is `CarSysuiScalableFooterController`. Every other row on this page uses `CarSysuiScalableHeaderController`. Both classes live in `systemui/CarSysuiScalableBarControllers`.

Shared mechanics: [../GUIDE.md](../GUIDE.md).
