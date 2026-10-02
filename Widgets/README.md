# Widgets

Eight privileged AAOS apps. Each APK has one hosted activity. Scalable UI sets the window size; the same scrolling layout fills 1x1 through 2x2.

Unit 1 matches the demo hosted card: **464 dp × 284 dp**.

| Size | Bounds |
| --- | --- |
| 1x1 | 464 × 284 dp |
| 1x2 | 464 × 568 dp |
| 2x1 | 928 × 284 dp |
| 2x2 | 928 × 568 dp |

Bind `WidgetActivity` from a TaskPanel. `MainActivity` is the launcher and uses a different task so it does not replace the hosted widget.

| App | Component |
| --- | --- |
| EV | `com.scalableui.widgets.ev/.WidgetActivity` |
| Lights | `com.scalableui.widgets.lights/.WidgetActivity` |
| Phone | `com.scalableui.widgets.phone/.WidgetActivity` |
| Seats | `com.scalableui.widgets.seats/.WidgetActivity` |
| User | `com.scalableui.widgets.user/.WidgetActivity` |
| Clock | `com.scalableui.widgets.clock/.WidgetActivity` |
| Apps | `com.scalableui.widgets.apps/.WidgetActivity` |
| Connections | `com.scalableui.widgets.connections/.WidgetActivity` |

EV, lights, seats, user, and night mode read the live vehicle properties. Phone uses the call log. Clock time is the system clock. Apps lists launcher activities. Connections reads Wi-Fi and Bluetooth.

```bash
./scripts/build-all.sh
./scripts/deploy-all.sh
```

`deploy-all.sh` pushes each APK to `/system/priv-app/` with its allowlist under `/system/etc/permissions/`, then reboots.
