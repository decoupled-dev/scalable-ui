# SystemUI classes: the dock

The dock is the DecorPanel `oem_dock` declared in `overlays/LauncherRRO/res/xml/launcher_dock.xml`. The overlay supplies its rectangle, its poses, and the pixels in [`res/layout/oem_dock.xml`](../../overlays/LauncherRRO/res/layout/oem_dock.xml). The layout has no click handlers. Everything a dock button does, and the pinned-app and recent-app slots, come from the three Java classes below.

Read [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md) for the poses and [../xml/launcher-resources.md](../xml/launcher-resources.md#reslayoutoem_dockxml) for the layout ids before changing any of this. [README.md](README.md) explains how a controller gets onto a panel. [core-classes.md](core-classes.md) covers the base class and `LayoutVariantWatcher`, which this code calls into.

Source directory: [`systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/)

## Contents

| Class | Role |
| --- | --- |
| [`CarSysuiScalableFooterController`](#carsysuiscalablefootercontroller) | The DecorPanel controller for `oem_dock`. Inflates the dock layout and makes each built-in button launch an app or post a Scalable UI event. |
| [`DockPins`](#dockpins) | Singleton attached by the footer. Fills the recent-app slot, adds up to four pinned apps, lets the user drag icons to reorder or unpin, and posts `dock_pins_N` so the capsule widens. |
| [`AssistantDockIcon`](#assistantdockicon) | Static helper for prebuilt SystemUI images. Replaces the assistant glyph with the selected assistant's icon, and clears the app card before the assistant opens. Not called by any Java in this repo. |

A note on what is running: the tablet runs a patched prebuilt `CarSystemUI.apk`, not a build of this Java. The dex patches are described in `device-dex/systemui/README.md` in the main checkout (that directory is not in this worktree). Where the installed behavior differs from the Java, this page says so.

---

## `CarSysuiScalableFooterController`

File: [`CarSysuiScalableFooterController.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController.java). Extends `CarSysuiScalableBarControllerBase`.

### Why it is needed

A DecorPanel has no activity. Without a controller it is an empty surface. Overlay XML can only say "this panel uses controller X" and "move this rectangle when event Y arrives". It cannot:

- inflate `oem_dock.xml` into the surface,
- attach a click listener to a button,
- start an activity as the foreground user (SystemUI runs as user 0; the driver is user 10 on the tablet),
- post an event that the framework does not post by itself (`toggle_fullscreen`, `trex_*`, or a `_System_TaskOpenEvent` for `panel_app_grid` before the grid activity starts),
- show the voice assistant, or read which assistant is selected,
- remove leftover tasks or resize the Maps task when Home is pressed.

Without this class the dock capsule is drawn by the orchestrator but stays blank. If the class is present but the overlay's `oem_dock.xml` is missing, the base class inflates an empty `View`. If the factory is not registered in Dagger (see Lifecycle), the panel stays empty.

The class is also used by older overlays for other panels (`oem_canvas`, `oem_media_card`, `sysui_footer_media_panel`, `oem_phone_card`, `oem_car_status_card`). That code (media session binding, Bluetooth subtitle, driving range, seat heat/vent, HVAC +/-) is in the same file. LauncherRRO only uses it for `oem_dock`. This page covers the dock path and lists the rest briefly.

### What it does

As the user sees it, on the LauncherRRO dock:

- **Home**: apps and the app grid slide closed, the map returns to its home pose, the cards come back. In layout set 3 (T-Rex) it selects the `trex_home` mode instead.
- **Map**: toggles the map between the home pose and full width (`toggle_fullscreen`). In T-Rex it selects `trex_nav`.
- **All apps**: the app grid slides in and `AppGridActivity` starts in it.
- **Assistant**: opens the selected voice assistant. The button shows that assistant's launcher icon, or the mic glyph if none is selected.
- **Climate**: opens the Design climate panel (`com.test.design` `ClimatePanelActivity`). If that package is missing it toggles the stock AOSP HVAC sheet.
- **Vehicle**: opens the Design vehicle panel. In T-Rex it first selects `trex_vehicle`.
- **Settings**: opens Car Settings home. In T-Rex it first selects `trex_split`.
- **Recent slot and pins**: owned by [`DockPins`](#dockpins), not this class.

When Car UX restrictions are fully restricted (driving, distraction optimization), every built-in dock button is disabled and drawn at alpha 0.4, and the launch methods return early.

### Lifecycle

1. **Registration.** [`integration/dagger/CarSysuiScalableBarControllerModule.java`](../../integration/dagger/CarSysuiScalableBarControllerModule.java) puts `CarSysuiScalableFooterController.Factory` into the `DecorPanelController.Factory` map with `@ClassKey(CarSysuiScalableFooterController.class)`. The factory is built with `hvacPanelOverlayViewController::toggle`, so the Climate fallback can open the stock HVAC sheet.
2. **Selection.** `launcher_dock.xml` names `@xml/launcher_dock_controller`. That file names this class in `<ControllerName>` and sets `<RroPackage>com.android.systemui.rro.scalableUI.launcher</RroPackage>`.
3. **Creation.** CarSystemUI's panel controller initializer calls `Factory.create(panelId, metadata)` once per DecorPanel that names this class. `RroPackage`, `PrimaryMediaComponent` and `MediaPanelId` come from the controller XML; missing tags fall back to `DEFAULT_RRO_PACKAGE` (`com.android.systemui.rro.scalableUI.sysuiBars`), `DEFAULT_PRIMARY_MEDIA`, and `DEFAULT_MEDIA_PANEL_ID`.
4. **Inflation.** The DecorPanel calls `getView()`. The base class resolves the overlay package context, looks up the layout named by `getLayoutResourceName()` (`oem_dock` for panel id `oem_dock`) with `getIdentifier`, inflates it, and calls `bindViews(root)`. See [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md).
5. **`bindViews` for `oem_dock`**, in order: `LayoutVariantWatcher.attachDock(root)` (vertical rail in set 1), `bindFooterNav`, `bindMediaControls` (finds nothing on the dock), `wireClickListeners`, `wireOptionalLaunches` (includes the assistant icon binding), then `DockPins.attach(root)`.
6. **Attach / detach.** The base class registers a `View.OnAttachStateChangeListener`. On attach, `onPanelAttached` starts the VHAL helper, registers for `CarUxRestrictions`, and calls `onControllerAttached`. On detach, the reverse, ending in `onControllerDetached`, which removes callbacks, the assistant watchers, the Bluetooth receiver, and VHAL subscriptions. If the view is already attached it attaches immediately; otherwise it posts `onPanelAttached` to the view.
7. **Theme change.** `refreshTheme()` detaches and drops the view. The DecorPanel calls `getView()` again, which inflates a new dock and runs `bindViews` again, so `LayoutVariantWatcher.attachDock` and `DockPins.attach` also run again.

Threads:

- DecorPanel views live on the WM Shell main thread (`wmshell.main`), not the SystemUI main looper. `runOnViewThread` posts to the view's handler. Code comments say posting dock UI work to the main looper crashes SystemUI.
- The assistant `ContentObserver` is on a main-looper `Handler`; it forwards to `runOnViewThread`. The role listener and media session listener use `mContext.getMainExecutor()`.
- The AOSP HVAC toggle is posted to the main looper, because the HVAC overlay views belong to it.
- `launchHome` posts delayed work on the dock view: 350 ms (or 420 ms when an app or the grid was open) and 800 ms. T-Rex Home and Map post `LayoutVariantWatcher.restoreTrexMode` after 500 ms.

### Views it wires

Ids are resolved by name in the overlay package. Ids present in LauncherRRO's `oem_dock.xml`:

| View id in the overlay layout | Tap | Long-press | Method |
| --- | --- | --- | --- |
| `sysui_nav_home` | Home. In T-Rex, `trex_home`. | Reorder drag (`DockPins`) | `launchHome` / `launchTrexHome` |
| `sysui_footer_fullscreen_toggle` | `toggle_fullscreen`. In T-Rex, `trex_nav`. Content description is forced to "Map fullscreen". | Reorder drag (`DockPins`) | `toggleMapFullscreen` |
| `sysui_nav_all_apps` | TaskOpen for `panel_app_grid`, then start `AppGridActivity`. | Reorder drag (`DockPins`) | `launchAllApps` |
| `oem_launch_assistant` | Show the voice assistant session. Icon follows the selected assistant. | Reorder drag (`DockPins`) | `launchDefaultAssistant`, `bindAssistantIcon` |
| `oem_launch_hvac` | Open the Design climate panel, or the AOSP HVAC sheet. Debounced 400 ms. Content description forced to "Climate". | The code sets a long-click listener that calls `launchCarStatus`. On `oem_dock` it does not fire: `DockPins` installs a touch listener that consumes the gesture and arms a reorder drag instead (inferred from Android touch dispatch). | `launchClimate` |
| `oem_launch_vehicle` | In T-Rex, `trex_vehicle`. Then the Design vehicle panel, or `toggle_card_expand_stats` if Design is missing. | Reorder drag (`DockPins`) | `launchCarStatus` |
| `oem_launch_car_settings` | In T-Rex, `trex_split`. Then Car Settings `HomepageActivity`. | Reorder drag (`DockPins`) | `launchCarSettings` |
| `oem_dock_recent` | Not wired here. | | See [`DockPins`](#dockpins) |

`wireNavClick` sets the listener on both the "column" view and the icon so that either receives the tap. On `oem_dock` there are no column views, so the icon gets it.

Ids the class looks for that LauncherRRO's dock does not contain (older layouts; nothing happens if absent):

| View id | What it would do | Method |
| --- | --- | --- |
| `sysui_nav_home_column`, `sysui_nav_all_apps_column`, `sysui_nav_recent_column` | Larger hit targets for Home, All apps, Recent | `bindFooterNav` |
| `sysui_nav_recent` | Open `CarRecentsActivity` | `launchRecent` |
| `sysui_nav_pinned` | Climate on tap, vehicle on long-press. When absent, `oem_launch_hvac` takes this role. | `wireClickListeners` |
| `oem_hvac_nav_column`, `oem_launch_hvac_panel` | Climate on tap, vehicle on long-press | `wireClickListeners` |
| `sysui_footer_ux_scrim` | Shown while fully restricted | `applyUxRestrictions` |
| `oem_launch_phone`, `oem_launch_dialpad` | Bluetooth settings or Dialer in `app_panel` | `launchPhone`, `launchDialpad` |
| `oem_launch_media`, `oem_media_open_app` | Active media app in `app_panel` | `launchMedia` |
| `oem_launch_climate`, `oem_launch_car_status` | Same as Vehicle | `launchCarStatus` |
| `sysui_media_*`, `sysui_driver_hvac_*`, `sysui_passenger_hvac_*`, `oem_seat_heat`, `oem_seat_vent`, `oem_card_expand`, `oem_card_header`, `oem_phone_subtitle`, `oem_stats_range_*` | Media transport, HVAC setpoint, seat heat/vent, card expand, phone and range cards | `bindMediaControls`, `wireOptionalLaunches` |

### Events

Posted. All go through `dispatchScalableEvent`, which reflects `getApplicationContext().getWMComponent().getScalableUIEventDispatcher().executeEvent(event)`. If that reflection fails it falls back to `StateManager.handleEvent` and starts the returned animators itself (the code comment notes this may not update AutoDecor surfaces).

| Event | When | Notes |
| --- | --- | --- |
| `_System_OnHomeEvent` | Home in sets 0–2. Posted once immediately and again 350 ms (420 ms if an app or the grid was open) later. | The second post catches panels that missed the first. |
| `_System_TaskOpenEvent` panelId `map_panel` | Home, when neither `panel_app_grid` nor `launcher_app` is in `opened`. | Closes app hosts. |
| `_System_TaskOpenEvent` panelId `oem_phone_card` | In the delayed Home step (`ensurePhoneCardDialer`). | LauncherRRO has no `oem_phone_card` panel. |
| `_System_TaskOpenEvent` panelId `panel_app_grid` | All apps, before the grid activity starts. | Comment: without the dispatcher this becomes an empty event and the grid stays closed. |
| `toggle_fullscreen` | Map button in sets 0–2. | |
| `trex_home`, `trex_nav`, `trex_vehicle`, `trex_split` | Home, Map, Vehicle, Settings in set 3. | Posted by `LayoutVariantWatcher.selectTrexMode`, not by this class directly. Home and Map also call `LayoutVariantWatcher.restoreTrexMode` after 500 ms. |
| `toggle_card_expand_stats` | Vehicle when `com.test.design` is not installed. | No LauncherRRO panel listens for it. |
| `_System_TaskOpenEvent` panelId `app_panel` | `launchRecent`, `launchMedia`, `startComponentInAppPanel`. | Not reachable from LauncherRRO's dock. `launchRecent` calls `StateManager.handleEvent` directly, which builds animators without starting them. |

Listened to:

- `CarUxRestrictionsManager` (base class). Fully restricted = `isRequiresDistractionOptimization()` and `UX_RESTRICTIONS_FULLY_RESTRICTED`. Triggers `applyUxRestrictions`.
- VHAL connection (base class, `CarVhalSubscriptionHelper`). On connect, `applyVhalConnectedState` reads and subscribes to `HVAC_TEMPERATURE_SET`, `HVAC_TEMPERATURE_DISPLAY_UNITS`, `HVAC_SEAT_TEMPERATURE`, `HVAC_SEAT_VENTILATION`. This happens on the dock panel too, even though the dock has no HVAC views.
- `Settings.Secure` `voice_interaction_service` and `assistant` (all users), `RoleManager` holder changes for `ROLE_ASSISTANT` (all users), and broadcasts `ACTION_USER_SWITCHED` / `ACTION_USER_UNLOCKED`. Each one refreshes the assistant icon.
- Reads `StateManager.getPanelState` for `panel_app_grid`, `launcher_app` (variant `opened`) and `map_panel` (variant `fullscreen`, which LauncherRRO does not define; it is only used in a log line).
- Calls `LayoutVariantWatcher.isTrex(context)` on Home, Map, Vehicle, Settings to choose the T-Rex branch.

### System APIs and permissions

The class declares no permissions and checks none. It relies on running inside the platform-signed, privileged CarSystemUI process. Permission names below are the usual requirements for those APIs, not something the code states.

| API | Used for | Why |
| --- | --- | --- |
| `ScalableUIEventDispatcher.executeEvent` (reflected through `getWMComponent()`) | Every posted event | Controllers cannot compile against the dispatcher; a bare `StateManager.handleEvent` does not start the animators. |
| `StateManager.getPanelState` | Read the current variant of `panel_app_grid`, `launcher_app`, `map_panel` | Decide whether Home should let the apps slide closed before removing tasks. |
| `ActivityTaskManager.getInstance().getTasks / removeTask / resizeTask` (reflection) | `removeOverlayTasks`, `realignMapPanelIfNeeded`, `resizeMapsTask`, `isDialerInPhoneCard`, `removeMisplacedClimateTasks` | Remove tasks left over the home screen; force the Maps task bounds. Needs task-management permissions (`MANAGE_ACTIVITY_TASKS` / `REAL_GET_TASKS`, inferred). |
| `PendingIntent.getActivityAsUser` (reflection, `@SystemApi`), fallback `Context.startActivityAsUser` | Every activity launch | SystemUI runs as user 0. Activities must start as `ActivityManager.getCurrentUser()`. Needs cross-user permission (`INTERACT_ACROSS_USERS_FULL`, inferred). |
| `ServiceManager.getService("voiceinteraction")` → `IVoiceInteractionManagerService.showSessionForActiveService` (or `showSession`) by reflection | Assistant button | Same path as the stock CarSystemUI assistant button. Arguments are filled by type: empty `Bundle`, `0`, `false`, `null`. |
| `RoleManager` (`getRoleHoldersAsUser`, `addOnRoleHoldersChangedListenerAsUser`), `Settings.Secure.getStringForUser` | Assistant icon | Which assistant is selected for the foreground user. |
| `LauncherApps.getActivityList`, `PackageManager.getApplicationIcon` | Assistant icon | Launcher icon of the selected assistant. |
| `CarUxRestrictionsManager` | Disable buttons while driving | Distraction optimization. |
| `CarPropertyManager` via `CarVhalSubscriptionHelper` | HVAC, seat, `RANGE_REMAINING` | Only does visible work on older panels; see Events. |
| `HvacPanelOverlayViewController.toggle` (injected), or reflected from `mSysUIComponent.hvacPanelOverlayViewControllerProvider` | Climate fallback | Opens the stock HVAC bottom sheet when Design is not installed. |
| Broadcast `com.android.systemui.car.action.TOGGLE_HVAC_PANEL` | Last Climate fallback | Sent to the current user and to `UserHandle.SYSTEM`. |
| `MediaSessionManager`, `AudioManager.dispatchMediaKeyEvent`, `BluetoothAdapter` | Media and phone cards | Not used by the dock. |

### Hardcoded values to know about

A customer changing any of these must edit Java. None of them come from the overlay.

| Value | Where | Effect |
| --- | --- | --- |
| Panel ids `oem_dock`, `oem_canvas`, `oem_media_card`, `sysui_footer_media_panel`, `oem_phone_card`, `oem_car_status_card` | `getLayoutResourceName`, `bindViews`, `wireOptionalLaunches` | Choose the layout and which features bind. Any other panel id gets `car_sysui_scalable_footer`. |
| Panel ids `panel_app_grid`, `map_panel`, `launcher_app`, `app_panel`, `oem_phone_card` | Event payloads and variant checks | Must match the overlay's panel ids. |
| Variant names `opened`, `fullscreen` | `isPanelVariant`, `isMapPanelFullscreen` | Must match the overlay's variant ids. |
| `com.android.car.carlauncher/.AppGridActivity`, action `com.android.car.carlauncher.ACTION_APP_GRID` | `launchAllApps` | The app grid. |
| `com.test.design` and its `ClimatePanelActivity` / `VehiclePanelActivity` components and `com.test.design.action.OPEN_CLIMATE` / `OPEN_VEHICLE` | Base class constants, `launchClimate`, `launchCarStatus` | The Climate and Vehicle buttons. The overlay `role` strings for `launcher_climate_app` and `launcher_vehicle_app` must name the same components. |
| `com.android.car.settings/.common.CarSettingActivities$HomepageActivity` | `launchCarSettings` | Settings button. |
| `com.android.car.mockwidgets/.ClimateActivity` | `launchClimate` last fallback | Only if the HVAC broadcast throws. |
| `com.android.car.dialer/.ui.TelecomActivity` with extra `com.android.car.dialer.EXTRA_WIDGET_MODE` | `ensurePhoneCardDialer` | Started on Home if no Dialer task has `left >= 1200` px. |
| `com.google.android.apps.maps` | `resizeMapsTask`, `realignMapPanelIfNeeded`, `shouldRemoveHomeOverlayTask` | The Maps task that Home resizes. |
| Map rectangle (16, 72)–(700, 700) dp | `expectedMapPanelBounds` | Comment says it matches **OemDemoRRO** `map_panel.xml`. Not LauncherRRO's full-screen map. See the warning below. |
| 40 px tolerance; Dialer bounds `left >= 1200`, `width > 400`, `height > 200` px | `realignMapPanelIfNeeded`, `isDialerInPhoneCard` | Pixel thresholds tuned to the older layout. |
| Package list in `shouldRemoveHomeOverlayTask` | Home | Kept: Maps, SystemUI, `com.spotify.*`, `com.android.bluetooth`, `com.android.car.media`, `com.android.car.media.localmediaplayer`, CarLauncher (except `AppGrid` classes), Dialer, other `com.android.*` / `com.google.android.*`. Removed: `com.android.car.settings`, `com.test.design`, mockwidgets classes containing `Climate`, anything whose package contains `youtube`, `chrome`, `browser`, `webview`, and every other third-party package. |
| Content descriptions "Map fullscreen", "Climate", "HVAC", "Expand card" | `wireClickListeners`, `wireCardExpand` | Set in code. `DockPins` and `LayoutVariantWatcher` match dock buttons by content description, so these strings are behavior, not just accessibility. |
| `HVAC_TOGGLE_DEBOUNCE_MS` 400 ms | `launchClimate` | Ignores a second Climate tap within 400 ms. |
| 350 / 420 / 800 ms Home delays; 500 ms T-Rex restore | `launchHome`, `restoreTrexModeLater` | Timed against 350–450 ms panel slides. |
| `DEFAULT_RRO_PACKAGE` `com.android.systemui.rro.scalableUI.sysuiBars`; base-class fallbacks `oemDemo`, `sysuiBars`, `multiPanelLandscape` | Factory, base class | Used only when the controller XML has no `RroPackage`. LauncherRRO sets it. |
| `oem_canvas` background `0xFF0B0F14`, children `0xFF12161C` | `getView`, `bindViews` | Older overlays only. |

### Key methods

| Method | What it does |
| --- | --- |
| `Factory.create(panelId, metadata)` | Builds a controller per DecorPanel with values from the controller XML. |
| `getLayoutResourceName()` | Maps panel id to a layout name in the overlay. |
| `bindViews(root)` | Entry point after inflation. Calls the binders and, for `oem_dock`, `LayoutVariantWatcher.attachDock` and `DockPins.attach`. |
| `bindFooterNav`, `wireNavClick`, `wireClickListeners`, `wireOptionalLaunches`, `wireLaunch` | Find views by name and attach listeners. |
| `launchHome()` | Home in sets 0–2: post `_System_OnHomeEvent`, close app hosts, remove overlay tasks, resize Maps, post Home again, ensure Dialer. T-Rex: `launchTrexHome`. |
| `toggleMapFullscreen()` | Post `toggle_fullscreen`, or select `trex_nav` and remove overlay tasks. |
| `launchAllApps()` | Post TaskOpen for `panel_app_grid`, start `AppGridActivity` as the current user. |
| `launchDefaultAssistant()` | Show the active voice interaction session. |
| `launchClimate()` | Design climate panel, then injected AOSP HVAC toggle, then reflected toggle, then broadcast, then mockwidgets. |
| `launchCarStatus()`, `launchCarSettings()` | Vehicle and Settings, with the T-Rex mode first. |
| `removeOverlayTasks()` / `shouldRemoveHomeOverlayTask` | Remove tasks that would sit over the home screen. |
| `realignMapPanelIfNeeded()`, `resizeMapsTask(rect)` | Force the Maps task to `expectedMapPanelBounds()`; remove the Maps task if resize throws. |
| `bindAssistantIcon`, `refreshAssistantIcon`, `loadAssistantIcon` | Show the selected assistant's icon, fall back to `ic_dock_mic`, apply `LayoutVariantWatcher.applyAssistantGlyphTint`. |
| `dispatchScalableEvent(event)` | Post through the dispatcher, with a `StateManager` fallback. |
| `startAsForegroundUser(intent)` | Launch as `ActivityManager.getCurrentUser()`. |
| `applyUxRestrictions()` | Disable buttons and show scrims while fully restricted. |

### Things to watch

- **Home resizes Maps to the OemDemo rectangle.** `realignMapPanelIfNeeded` compares the Maps task with (16, 72)–(700, 700) dp. LauncherRRO's `map_panel` is full-screen, so the check fails and the code calls `resizeTask` to that smaller rectangle, then calls `resizeMapsTask` with it again at 350/420 ms and 800 ms. If `resizeTask` throws, it removes the Maps task. Whether the TaskView re-applies the panel bounds afterward is not visible in this code. [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md) and [../launcher/panels/map-panel.md](../launcher/panels/map-panel.md) describe this step as a repair; for LauncherRRO the target rectangle is wrong. Verify on device.
- **Home may start Dialer.** `ensurePhoneCardDialer` starts `TelecomActivity` whenever no Dialer task sits at `left >= 1200` px. LauncherRRO has no Dialer panel (`launcher_w_phone` hosts `com.scalableui.widgets.phone`), so on an image with Car Dialer installed this can start Dialer on each Home press, where the `DEFAULT` role would place it in `launcher_app` (inferred; not checked on device).
- **Home removes all third-party tasks** that are not in the keep list, not only the ones on screen.
- **Recent button wiring.** `launchRecent` is bound to `sysui_nav_recent`, which `oem_dock.xml` does not have. The dock's `oem_dock_recent` is handled by `DockPins`. [../launcher/docks/bottom-dock.md](../launcher/docks/bottom-dock.md) lists `launchRecent` for that button; the code does not.
- **Assistant path differs on the device.** The repo Java shows the assistant directly. The installed dex calls `AssistantDockIcon.prepare` and an `AssistLauncher.show` that has no source here (per `device-dex/systemui/README.md`).
- **Dead or unused code in this class:** `launchPinned`, `expectedMapFullscreenBounds`, `mLiveRangeBound` (written, never read), `mMediaPanelVisible` (only logged), and the empty Javadoc above `getTaskBounds` that describes `realignMapPanelIfNeeded`.
- **T-Rex mode is selected before the restriction check** in `launchCarStatus` and `launchCarSettings`. Under full restriction the panels move to `trex_vehicle` / `trex_split` but the activity start is blocked.

---

## `DockPins`

File: [`DockPins.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/DockPins.java). `public final class`, process-wide singleton.

### Why it is needed

The overlay can declare a fixed set of icons and a few wider poses (`pins_1` … `pins_4`, `pins_port_1` … `pins_port_4`). It cannot:

- know which app was used last, or which apps the user pinned,
- create an `ImageButton` at runtime with another app's icon,
- receive the app grid's pin broadcast,
- persist a pin list across reboot,
- handle a drag on an icon,
- post `dock_pins_N` so the capsule switches to the matching wider pose.

Without this class the `oem_dock_recent` slot keeps its placeholder (`ic_dock_recent` at alpha 0.45) and does nothing on tap, the app grid's Pin action has no effect, and the dock never widens.

### What it does

- **Recent slot.** About once a second it looks at the running tasks and shows the most recent app the user can launch from a launcher. Tapping it opens that app. Home, the map, the widget cards, Settings, HVAC, the assistant, permission dialogs, the resolver, and already-pinned apps never become the recent app. If no app qualifies the slot and the hairline before it are hidden. The choice survives a reboot.
- **Pins.** When the app grid broadcasts a pin, the app's icon is added after the recent slot, behind a new hairline divider. At most four pins. Pinning the app that is currently in the recent slot clears the slot. Tapping a pin opens the app.
- **Reorder.** Long-press any built-in icon or pin (not the recent slot), then drag along the dock. The icon grows to 1.3x, the others shift to show the gap, and the new order is saved on release. Built-in icons reorder among themselves; pins reorder among themselves.
- **Unpin.** Drag a pin more than 28 dp off the dock and release. Built-in icons cannot be removed this way.
- **Width.** After any change in pin count or orientation it posts `dock_pins_N` (landscape) or `dock_pins_port_N` (portrait) so the capsule switches pose. In layout set 1 (left rail) it posts nothing.
- All icons get an oval outline with an 8 dp shadow.

### Lifecycle

- **Created by** `CarSysuiScalableFooterController.bindViews` calling `DockPins.attach(root)`, only for panel id `oem_dock`. The first call creates `sInstance` and calls `start()`. Every call (including after a theme re-inflation) calls `bind(root)` to adopt the new row.
- **`start()`** registers one broadcast receiver for all users via reflected `registerReceiverAsUser(receiver, UserHandle.ALL, filter, SENDER_PERMISSION, mHandler, RECEIVER_EXPORTED)`, falling back to `registerReceiver` for the current user.
- **`bind(root)`** finds the dock `LinearLayout` (parent of `oem_dock_recent`, or a row with a "Home" button and at least five `ImageButton`s), turns off child clipping so the lifted icon is not cut, tags the recent slot, inserts the pin divider, installs the drag handler on every built-in button, restores pins, recent and order from preferences, and starts the poll.
- **Detach.** None. `stop()` exists but nothing calls it, and `sInstance` is never cleared. The receiver and the 1 s poll run for the life of the SystemUI process.

Threads:

- `mHandler` is a main-looper `Handler`. The receiver callbacks and the poll run there. The poll calls `getTasks` (a binder call) on the main looper every 1000 ms.
- All view changes are posted to `mRow` (the WM Shell thread that owns the dock).
- Activity starts and event posts happen on whichever thread runs the tap (the view thread).

Context: `mContext` is the dock view's context, which belongs to the overlay package. The class comment says that context cannot query other apps or keep a data directory, so `application()` reflects `ActivityThread.currentApplication()` for `SharedPreferences`, `LauncherApps`, and `PackageManager`.

### Views it wires

| View | Tap | Long-press / drag | Method |
| --- | --- | --- | --- |
| `oem_dock_recent` (found by id, else by content description "Recent app") | Launch the shown app into `launcher_app`. Empty listener when cleared. | Not draggable. | `showRecent`, `clearRecent`, `launchApp` |
| Pinned `ImageButton`s (created at runtime, tag `pin:<component>`) | Launch the pinned app into `launcher_app`. | Drag to reorder within pins. Drop more than 28 dp off the dock to unpin. | `createPinButton`, `onDockTouch`, `unpinByDrag` |
| Every other `ImageButton` in the row (Home, Map, All apps, Assistant, Climate, Vehicle, Settings) | Unchanged. `onDockTouch` calls `performClick()` on release, which runs the footer's listener. | Drag to reorder among the built-in buttons. | `installDrag`, `onDockTouch`, `finishReorder` |
| Pin divider (a `View` created at runtime, 1 × 30 dp, 10 dp margins) | None. | None. | `ensurePinDivider`, `updatePinDivider` |
| The divider immediately before the recent slot (from the layout) | None. | None. Hidden with the recent slot. | `setRecentDividerVisible` |

The touch listener returns `true` for every down, move, up and cancel. That replaces each button's own long-click handling (see the Climate long-press note in the footer section).

### Events

Posted, through reflected `ActivityThread.currentApplication().getWMComponent().getScalableUIEventDispatcher().executeEvent`. There is no `StateManager` fallback.

| Event | When |
| --- | --- |
| `dock_pins_0` … `dock_pins_4` | Landscape, set ≠ 1, pin count changed or orientation changed. Deduplicated against the last event posted. Only while the row `isShown()`. |
| `dock_pins_port_0` … `dock_pins_port_4` | Same, in portrait. |
| `_System_TaskOpenEvent` panelId `launcher_app` | Before starting a recent or pinned app. |

Listened to:

| Source | Name | Effect |
| --- | --- | --- |
| Broadcast (sender needs `com.android.car.docklib.permission.BROADCAST_SENDER`) | `com.android.car.docklib.events.PIN` | `pin(component)` |
| Broadcast | `com.android.car.docklib.events.UNPIN` | `unpin(component)` |
| Broadcast | `com.android.car.docklib.events.LAUNCH` | `showRecent(component)` |
| Extra | `EXTRA_COMPONENT` (`ComponentName` parcelable or flattened string) | The app to act on. |
| `Settings.Global` | `scalable_ui_layout_variant` | Read in `applyWidth`. `1` suppresses width events. |
| `Settings.Secure` (current user) | `voice_interaction_service`, then `assistant` | The selected assistant's package is excluded from the recent slot. |
| `Configuration.orientation` | | Chooses `dock_pins_` or `dock_pins_port_`; a change forces a re-post. |
| Task list (poll) | | Recent slot. |

### System APIs and permissions

| API | Used for | Why |
| --- | --- | --- |
| `ActivityTaskManager.getService().getTasks(16, …)` by reflection; fallback `ActivityManager.getRunningTasks(16)` | Recent slot | Find the most recent user app. Needs `REAL_GET_TASKS` / `MANAGE_ACTIVITY_TASKS` to see other apps' tasks (inferred). |
| `registerReceiverAsUser` (hidden, reflected) with `UserHandle.ALL` | Pin broadcasts | Receive pins from the app grid running as user 10. Needs `INTERACT_ACROSS_USERS_FULL` (inferred). |
| `PendingIntent.getActivityAsUser` (reflected), fallback reflected `Context.startActivityAsUser` | Launch recent and pinned apps | Start as `ActivityManager.getCurrentUser()`. |
| `LauncherApps.getActivityList(pkg, currentUser)` | `isUserApp`, `loadIcon` | Only launchable apps qualify; icons come from the launcher activity at display density, then `ActivityInfo.loadIcon`, then the application icon. |
| `PackageManager.getActivityInfo(...).loadLabel` | Content description of pins and recent | Accessibility label; falls back to the package name. |
| `SharedPreferences` `launcher_dock_pins` in the SystemUI application | Persistence | Keys `pins`, `order`, `recent`. |
| `ScalableUIEventDispatcher.executeEvent` (reflected) | Width and TaskOpen events | See GUIDE.md. |

### Hardcoded values to know about

| Value | Effect |
| --- | --- |
| `com.android.car.docklib.events.PIN` / `UNPIN` / `LAUNCH`, extra `EXTRA_COMPONENT`, permission `com.android.car.docklib.permission.BROADCAST_SENDER` | The contract with the app grid's Pin action. A different launcher must send these. |
| `MAX_PINS = 4` | Must match the overlay's `pins_1` … `pins_4` and `pins_port_1` … `pins_port_4` poses. A fifth pin is ignored with a log line. |
| Event prefixes `dock_pins_` and `dock_pins_port_` | Must match `launcher_dock.xml` transitions. |
| Panel id `launcher_app` | Where recent and pinned apps open. |
| `RRO_PACKAGE` `com.android.systemui.rro.scalableUI.launcher` | Used to resolve `oem_dock_recent` and `ic_dock_recent` by name. Hardcoded, not taken from the controller XML. |
| Content descriptions "Recent app" and "Home" | Fallback lookup of the recent slot, and recognition of the dock row. |
| Content descriptions of built-in buttons | Used as the saved order key (`keyOf`). Renaming a string in the overlay drops that button's saved position. |
| Ignored packages: `com.android.systemui`, `com.android.car.carlauncher`, `com.google.android.apps.maps`, `com.scalableui.widgets*`, `com.test.design`, `android`, `com.android.car.settings`, `com.android.car.hvac`, `com.google.android.carassistant`, the selected assistant, `com.android.permissioncontroller`, `com.google.android.permissioncontroller`, `com.android.packageinstaller`, `com.google.android.packageinstaller`, `com.android.intentresolver`, and every pinned package | Never shown in the recent slot. |
| `LAYOUT_SETTING` `scalable_ui_layout_variant`, value `1` | No width events on the left rail. |
| `POLL_MS` 1000 ms, task list size 16 | Recent slot refresh rate and depth. |
| `DRAG_SCALE` 1.3, lift `translationZ` 8 dp, unpin slack 28 dp, long-press = `ViewConfiguration.getLongPressTimeout()` | Drag feel. |
| Icon padding 4 dp (app icon) / 14 dp and alpha 0.45 (placeholder); fallback size 60 dp | Recent and pin sizing. Pin layout params are copied from the recent slot. |
| Shadow: elevation 8 dp, ambient `0xCC000000`, spot `0x99000000`; divider fallback color `0x33FFFFFF` | Visual constants. |
| `TAG_KEY = 0x5ca1ab1e` | Keyed view tag for the button key. The unkeyed tag belongs to `LayoutVariantWatcher`. The pin divider's unkeyed tag is an `int[]{width, height, margin, margin}` that `LayoutVariantWatcher` reads to rotate dividers on the rail. |

### Key methods

| Method | What it does |
| --- | --- |
| `attach(View root)` | Public entry. Creates the singleton once, then binds to the given dock. |
| `start()` | Registers the pin broadcast receiver. |
| `bind(root)` | Finds the row, prepares views, restores state, starts the poll. |
| `pin(component)` / `unpin(component)` | Add or remove a pin button, save, update divider and width. |
| `showRecent(component)` / `clearRecent()` | Fill or empty the recent slot, save to preferences. |
| `restorePins`, `restoreRecent`, `restoreOrder` | Rebuild state from preferences after inflation. |
| `topActivity()`, `taskComponents()`, `invokeGetTasks()` | Read running tasks in recency order and pick the first user app. |
| `isUserApp`, `ignored` | Filter for the recent slot. |
| `onDockTouch(button, event)` | Tap vs. long-press drag; preview, reorder, or unpin on release. |
| `nearestSlot`, `previewSlot`, `moveButton`, `rebuild` | Reorder mechanics within one group. |
| `placePinsAfterRecent`, `ensurePinDivider`, `updatePinDivider` | Keep the order recent slot → divider → pins. |
| `applyWidth()` | Post `dock_pins_N` / `dock_pins_port_N` when the count or orientation changes. |
| `launchApp(component)` | Post TaskOpen for `launcher_app`, start the app as the current user. |

### Things to watch

- **Not stopped.** The receiver and the 1 s `getTasks` poll on the main looper never stop. `stop()` and `updateRecentFromTasks()` are unused.
- **Shared across users (inferred).** Preferences live in the SystemUI application's data, and SystemUI runs as user 0, so pins, order and the recent app appear to be shared by every driver profile. Icons and launchability are checked against the current user.
- **Ignores UX restrictions.** The recent slot and pins are not disabled while driving. The footer disables only its own buttons. Whether a launched app is then blocked depends on CarService's activity blocking, not on this class.
- **Built-in buttons are reorderable.** Any long-press on Home, Map, and the others starts a drag, and the new order is saved. This replaces the footer's long-press on Climate.

---

## `AssistantDockIcon`

File: [`AssistantDockIcon.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon.java). `public final class`, static methods only.

### Why it is needed

The class comment says it is kept separate "so a prebuilt SystemUI can call `bind(View)` without rebuilding the whole footer controller". It covers two things the overlay cannot express:

- The dock's assistant button is a static `ic_dock_mic` in XML. Showing the selected assistant's own icon needs `Settings.Secure`, `RoleManager`, and `LauncherApps` for the current user.
- When the assistant opens over a launched app, that app stays visible behind the assistant UI. `prepare` removes it first.

In a SystemUI built from this repo's Java, nothing calls this class. `CarSysuiScalableFooterController` has its own assistant icon code (`bindAssistantIcon` and related methods) and shows the assistant without calling `prepare`. On the tablet, per `device-dex/systemui/README.md`, the patched footer's `launchDefaultAssistant` calls `AssistantDockIcon.prepare(ctx)` and then `AssistLauncher.show(ctx)`. `AssistLauncher` has no source in this repo. Without `prepare`, the last-used app is left behind the assistant overlay.

### What it does

- **`bind(root)`**: finds the `ImageView` whose content description is "Assistant", and sets its image to the selected assistant's launcher icon with 4 dp padding and no tint. If no icon is found it leaves the current image in place and clears the color filter. It keeps the icon current when the selection or the user changes.
- **`prepare(context)`**: before the assistant opens, finds the panel that hosts the most recent non-chrome app (by the task's parent/root task id), and removes every task in that panel. A task whose top package is in the keep list is left alone. The default keep list is `com.android.car.media`.

The code comment on the keep list explains why: removing the Media Center task kills the process that holds the last binding to the active media app's browser service. A paused source such as Spotify then destroys its media session about a second later, and the home media widget shows "Nothing playing".

### Lifecycle

- **Created by**: nothing in this repo. On the device, the patched footer calls `prepare` (README). `bind` is meant to be called with the dock root.
- **`bind`** stores the root and button in static fields, refreshes, and on first call starts watching (`watch()`). It adds an attach listener to the root: on re-attach it finds the button again and refreshes; on detach it drops the button reference but keeps the watchers, so that the watchers survive the brief detach during a user switch.
- **Detach.** `unbind()` exists but is private and never called. Observers, the role listener, the receiver, and the poll run for the life of the process.

Threads:

- A static main-looper `Handler` (`sMain`) receives broadcasts and runs the poll when there is no view.
- `refresh()` checks `onViewThread(button)` and re-posts itself to the button's handler if needed, since the dock lives on the WM Shell thread.
- The poll runs every 1500 ms on the view's handler and only refreshes when the user or the selected package changed.
- User-switch broadcasts refresh immediately and again after 400 ms.

### Views it wires

| View | Tap | Long-press | Method |
| --- | --- | --- | --- |
| `ImageView` with content description "Assistant" (`oem_launch_assistant` in LauncherRRO) | Not wired. The tap is the footer's. | Not wired. | `bind`, `refresh` |

### Events

Posts no Scalable UI events.

Listens to:

| Source | Name |
| --- | --- |
| `Settings.Secure` (all users, reflected `registerContentObserver(..., userId -1)`) | `voice_interaction_service`, `assistant` |
| `RoleManager` holder changes (all users), through a `java.lang.reflect.Proxy` of `OnRoleHoldersChangedListener` | `android.app.role.ASSISTANT` |
| Broadcasts for all users | `android.intent.action.USER_SWITCHED`, `ACTION_USER_UNLOCKED` |
| `Settings.Global` | `scalable_ui_assistant_keep_packages` (comma-separated), read in `prepare` |
| 1.5 s poll | Current user and selected assistant package |

### System APIs and permissions

Everything hidden is reached by reflection so the class compiles against the public SDK and can be dropped into a prebuilt dex. No permissions are declared or checked.

| API | Used for | Why |
| --- | --- | --- |
| `ActivityTaskManager.getService().getTasks(32, …)` and `removeTask(int)` | `prepare` | Find and clear the app panel's tasks. Reads hidden `TaskInfo` fields `topActivity`, `taskId`, `parentTaskId`, `rootTaskId`. Task-management permissions required (inferred). |
| `Settings.Secure.getStringForUser` | Selected assistant | Per-user setting. |
| `RoleManager.getRoleHoldersAsUser`, `addOnRoleHoldersChangedListenerAsUser` | Selected assistant when no VIS / assist component is set | The listener class is looked up as top-level `android.app.role.OnRoleHoldersChangedListener` first, then `RoleManager$OnRoleHoldersChangedListener`; the comment says this image exposes the top-level type. |
| `registerReceiverAsUser` with `UserHandle.ALL` | User switch | Refresh for the new driver. |
| `LauncherApps.getActivityList`, `PackageManager.getApplicationIcon` | Icon | Same order as the footer: first launcher activity icon, then application icon. |

### Hardcoded values to know about

| Value | Effect |
| --- | --- |
| Content description "Assistant" | How the button is found. Renaming `launcher_dock_assistant` in the overlay breaks `bind`. |
| `scalable_ui_assistant_keep_packages`, default `com.android.car.media` | Tasks kept by `prepare`. Change with `adb shell settings put global scalable_ui_assistant_keep_packages <pkg,pkg>`. The device patch hardcodes `com.android.car.media` and does not read the setting (README). |
| Chrome package list in `isChrome` | Same list as `DockPins.ignored` minus `com.google.android.carassistant`. These tasks are never treated as "the app card" in `prepare`. |
| `POLL_MS` 1500 ms, 400 ms post-switch refresh, 4 dp icon padding, task list size 32 | Timings and sizing. |

### Key methods

| Method | What it does |
| --- | --- |
| `prepare(Context)` | Remove tasks from the panel that hosts the most recent app, except keep-list packages. |
| `bind(View root)` | Find the assistant button, refresh its icon, start watching. |
| `refresh()` | Load the selected assistant's icon on the view thread and apply it. |
| `selectedPackage(userId)` | `voice_interaction_service`, then `assistant`, then the `ROLE_ASSISTANT` holder. |
| `watch()` / `unbind()` | Register / unregister observers, role listener, and receiver. `unbind` is never called. |
| `keepsAlive(context, pkg)` | Keep-list check for `prepare`. |
| `panelId(taskInfo)` | Parent task id, or root task id when it differs from the task id. |

### Things to watch

- **Unused in source builds.** No Java in this repo calls `prepare` or `bind`. Its behavior exists only on the patched device image. If CarSystemUI is rebuilt from this repo, the assistant opens over the last app without clearing it.
- **Two copies of the icon logic.** The footer and this class both swap the assistant icon. They differ: the footer falls back to `ic_dock_mic`, marks the button with a keyed tag for T-Rex chrome, and calls `LayoutVariantWatcher.applyAssistantGlyphTint`. This class does none of those. If both run, both watch the same settings.
- **`prepare` picks the first parented task it finds.** It does not check that the parent is `launcher_app`. It takes the first non-chrome, non-assistant task (in `getTasks` order) that has a parent or a distinct root, and clears that container. If a hosted card app outside the chrome list is the most recent task, its panel is the one cleared (inferred from the code; not observed).
