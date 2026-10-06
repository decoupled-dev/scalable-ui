# Launcher layout: how the panels and docks work

This is the Launcher runtime overlay (`overlays/LauncherRRO`, package `com.android.systemui.rro.scalableUI.launcher`). It replaces the stock system bars with a map, a right-hand card column, three header pills, a bottom dock, and two temperature pills.

The screen is not one Android layout. It is a list of windows. Each window is declared in its own XML file and registered in `overlays/LauncherRRO/res/values/config.xml` under `window_states`. SystemUI's Scalable UI orchestrator loads that list, creates one surface per entry, and moves those surfaces when events arrive.

Landscape canvas is 2560×1600 at 240 dpi, about 1707×1067 dp. Portrait is the same panel turned, 1067×1707 dp. Percent positions (`50%`, `100%`) are resolved against the landscape canvas, so every portrait variant uses absolute dp instead of `100%`.

Per-surface detail is in [panels/](panels/) and [docks/](docks/).

## Two kinds of window

**TaskPanel** hosts an activity. The `role` attribute is the component name (or the special role `DEFAULT`). When that activity starts, the framework puts its task inside this panel and resizes the task to the panel's current bounds. `config_default_activities` in `config.xml` starts the home cards and the map into their panels at boot.

**DecorPanel** has no activity. A controller class inflates an ordinary layout into the surface. The dock, the three header pills, and the two temperature pills are DecorPanels. The gray plates under the cards are also DecorPanels: they exist so the map cannot show through the rounded card.

A DecorPanel names its controller in XML:

```xml
<DecorPanel id="oem_dock" controller="@xml/launcher_dock_controller" ...>
```

`launcher_dock_controller.xml` only names a class that must already exist inside CarSystemUI:

`com.android.systemui.car.wm.scalableui.panel.controller.CarSysuiScalableFooterController`

The header pills and both temperature pills use `launcher_status_controller.xml`, which names `CarSysuiScalableHeaderController`. The controller looks at the panel id and picks the layout (`oem_dock`, `launcher_pill_left`, `oem_climate_card`, and so on).

## A variant is one pose

Each panel lists named variants. A variant is a complete pose: bounds, layer, alpha, visibility, corner radius, and, for the map, the safe area and insets sent to Maps.

`defaultVariant` is the pose at boot. `parent="@id/base"` means the child inherits anything it does not override. Changing bounds in a child variant is how a card slides from the right column to off-screen.

Transitions are the only way a panel changes pose:

```xml
<Transition onEvent="toggle_fullscreen"
    fromVariant="@id/opened" toVariant="@id/nav"
    duration="350"/>
```

The orchestrator matches `onEvent`. If `fromVariant` is set, the transition runs only while the panel is already in that pose. One event is delivered to every panel. Each panel that has a matching transition moves. Panels with no matching transition stay where they are. That is why opening the app grid is not a single layout file: `panel_app_grid`, `map_panel`, and every card each have their own transition on `_System_TaskOpenEvent` with `panelId=panel_app_grid`.

## Who posts an event

| Event | Posted by | What listens |
| --- | --- | --- |
| `_System_TaskOpenEvent` with a `panelId` | The framework, when a task is placed in that panel. The dock also posts one for `panel_app_grid` before it starts the app grid. | Every panel that should react to that surface opening. |
| `_System_TaskPanelEmptyEvent` | The framework, when the last task leaves a panel. | The empty panel closes. The map returns from `app_open`. |
| `_System_OnHomeEvent` | The framework on Home, and the dock Home button. | App surfaces close. The map returns to the home pose. |
| `_System_EnterSuwEvent` / `_System_ExitSuwEvent` | The framework during setup. | Chrome hides, then returns. |
| `_System_BeforeUserSwitch` / `_System_UserSwitchComplete` | The framework. | The map hides for the switch, then returns. |
| `layout_variant_0` … `layout_variant_3` | `LayoutVariantWatcher` | Every panel that has a pose for that chrome set. |
| `trex_home`, `trex_nav`, `trex_vehicle`, `trex_split` | `LayoutVariantWatcher.selectTrexMode`, called from the dock | T-Rex poses only. Ignored in sets 0–2. |
| `widget_page_0` … `widget_page_3` | `LayoutVariantWatcher` when the variant-2 rail is dragged | The eleven cards. |
| `orientation_portrait` / `orientation_landscape` | `OrientationLayoutWatcher` | Every panel with a portrait pose. |
| `toggle_fullscreen` | Dock navigation button, sets 0–2 | Map, cards, app grid, launched apps. |
| `dock_pins_0` … `dock_pins_4`, `dock_pins_port_*` | `DockPins` | The bottom dock width only. |

`LayoutVariantWatcher`, `OrientationLayoutWatcher`, `DockPins`, `CarSysuiScalableFooterController`, and `CarSysuiScalableHeaderController` all live in:

`systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/`

They post by calling `ScalableUIEventDispatcher.executeEvent`. A direct `StateManager.handleEvent` builds the animators and does not start them, so the controllers go through the dispatcher.

The same classes are also patched as smali under `device-dex/systemui/smali/` when the running image is a prebuilt `CarSystemUI.apk` and is not rebuilt from this Java. A Java edit does nothing on that image until the matching smali is rebuilt into the APK.

## Where XML is enough, and where SystemUI code is required

**XML only, in `overlays/LauncherRRO`.** Use this when some event already exists and the change is a pose.

- Add or move a variant's bounds, layer, alpha, corner, visibility, map insets.
- Add a `<Transition>` on an event the table above already posts.
- Register a new panel by adding its file to `window_states`.
- Bind an activity to a panel with `role` and, for boot, a `config_default_activities` row.
- Change a DecorPanel's pixels: `res/layout/oem_dock.xml`, the pill layouts, `oem_climate_card.xml`, drawables, dimens, colors.
- Add the opaque plate under a card. The plate is a second DecorPanel with the same transitions as the TaskPanel and a lower layer. No controller logic.

After an XML-only change, rebuild and enable the overlay. No SystemUI class changes.

**SystemUI Java is required** when nothing currently posts the event, or when the behavior is not a pose.

- A new dock or pill button that launches an app, posts an event, or talks to the vehicle.
- A new event name. XML can listen for `widget_page_4`, but nothing sends it until `LayoutVariantWatcher` (or another controller) calls `executeEvent`.
- Reading `Settings.Global` `scalable_ui_layout_variant` and broadcasting `layout_variant_N`.
- Detecting rotation. The orchestrator does not emit an orientation event. `OrientationLayoutWatcher` does, from `DisplayManager`.
- The variant-2 scrollbar. It is a `TYPE_SYSTEM_DIALOG` window drawn in Java, not a panel. Dragging it posts `widget_page_N` and hides itself while an app covers the column or the map is in the `nav` pose.
- Dock pins: which apps are pinned, the recent slot, drag-off-to-unpin, and the `dock_pins_N` event. XML only widens the capsule for a count it is given.
- Variant 1 icon direction. XML moves the dock to a left rail (`layout_v1`). `LayoutVariantWatcher.applyDockOrientation` sets the row to `VERTICAL` and retunes the gaps. XML cannot stack those children.
- T-Rex dock chrome (corner radius and icon tint) is applied in Java on top of the XML bounds.
- Status Wi-Fi, Bluetooth, volume, and brightness. The pill layout has empty slots. The header controller pulls the stock quick-settings buttons into those slots. `LayoutVariantWatcher` then moves the stock popup windows so they stay on the slot after the pill animates. Night mode is `UiModeManager.setNightModeActivated` in the header controller.
- Driver and passenger temperature. Plus and minus call the HVAC VHAL from the header controller. The number on the pill is that subscription. XML draws the buttons.
- Home, All apps, map, assistant, climate, vehicle, settings, and recent. All of that is `CarSysuiScalableFooterController`. XML draws the icons and animates whatever event the controller posts.
- Routing a task into a chosen panel is the framework, once `role` matches the component. Choosing *which* component to start, and posting `trex_vehicle` or `trex_split` before the start, is the footer controller.
- The card's own UI (EV gauges, seat heat, the clock face) is the widget app under `Widgets/`, not SystemUI and not the panel XML. The panel only supplies the window rectangle.

A practical test: if the sentence is "when X happens, this rectangle should be over there," and X is already posted, edit the panel XML. If the sentence is "the user tapped something" or "watch this setting," edit the controller, then add the XML transition that listens for the event you post.

## The four landscape sets

`Settings.Global` `scalable_ui_layout_variant` is an integer 0–3. `LayoutVariantWatcher` posts `layout_variant_N` about two seconds after start, again whenever the setting changes, and again after a theme change or a return to landscape. Portrait ignores the number and uses the portrait variants.

```bash
adb shell settings put global scalable_ui_layout_variant 0
```

**0 — current layout.** Dock centered on the bottom. Status, clock, and profile pills along the top. Driver temperature at the bottom left, passenger temperature at the bottom right. Map full-screen, with insets so Maps draws its own controls clear of the pills, the dock, and the right column. Three cards stacked on the right: climate, media, driving stats. The other eight widget apps stay created and invisible.

**1 — left rail.** Same three cards and the same map. The dock moves to a vertical rail on the left (bounds from XML, icon direction from Java). Along the bottom, left to right: driver temperature (116–356 dp), status pill (368–736 dp), clock (still centered, about 777–930 dp on the 1707 dp canvas), profile, passenger temperature at the right edge. Opened apps start at 116 dp so they clear the rail.

**2 — paged column.** Chrome matches set 0 (dock on the bottom, pills on the top). The right column holds all eleven cards, three visible at a time. A 48 dp rail in the gap beside the column pages them. See the page table below.

**3 — T-Rex.** Header pills and temperature pills stay where set 0 puts them, with a 16 dp corner instead of a capsule. The dock stays on the bottom; Java restyles its background and icons. The dock buttons then mean four modes, posted as `trex_home`, `trex_nav`, `trex_vehicle`, and `trex_split`. The eight extra widgets stay hidden. The three home cards are visible only in `trex_home`.

| T-Rex mode | Dock button | Map | Cards | Full app |
| --- | --- | --- | --- | --- |
| `trex_home` | Home | Hidden. Wallpaper shows through. | Climate, media, stats in one centered row. | Closed. |
| `trex_nav` | Map | Full screen, insets clear the pills and the dock. | Hidden. | Closed. |
| `trex_vehicle` | Vehicle | Hidden. | Hidden. | `launcher_vehicle_app` fills the area between the pills and the dock, square corners. |
| `trex_split` | Settings | Left half, 8 dp gutter. | Hidden. | `launcher_settings_app` is the right half, between the pills and the dock. |

Opening All apps or a launched app on top of T-Rex uses `layout_v3_away` / `layout_v3_app_*` poses. When that surface closes, `LayoutVariantWatcher` posts the remembered T-Rex mode again (the dock waits 500 ms so the empty-panel event does not land mid-transition).

### Variant 2 pages

Three slots, top to bottom, reuse the climate / media / stats rectangles (80–364 dp, 376–660 dp, 672–956 dp from the top). Cards that are not on the current page sit just above the screen (`launcher_v2_above_*`) or just below it (`launcher_v2_below_*`) at alpha 0, so the next page can slide in. The activities keep running.

| Page | Top | Middle | Bottom |
| --- | --- | --- | --- |
| 0 | Climate | Media | Stats |
| 1 | EV | Lights | Phone |
| 2 | Seats | User | Clock |
| 3 | Apps | Connections | empty |

Page 3 has two cards because there are eleven cards and four pages of three. `widget_page_0` is the same pose as the initial `layout_v2` variant, which is why page 0 does not use the name `wpage_0`.

The rail hides while `map_panel` is in `nav` or `portrait_nav`, and while any of `launcher_app`, `launcher_climate_app`, `launcher_vehicle_app`, `launcher_settings_app`, or `panel_app_grid` is in an opened pose. When the cover goes away, Java posts the current page again so the column returns.

## What the user actually does in set 0

**Home** (`sysui_nav_home`). Footer posts `_System_OnHomeEvent`. The app grid and any launched app slide closed (450 ms). The map returns to `opened`. Cards that had slid off-screen come back. In T-Rex this button posts `trex_home` instead.

**Map** (`sysui_footer_fullscreen_toggle`). In sets 0–2 the footer posts `toggle_fullscreen`. The map goes to `nav` (full width; widgets and the app grid leave). A second press returns to `opened`. Pills and temperature stay. In T-Rex this button posts `trex_nav`.

**All apps** (`sysui_nav_all_apps`). Footer posts `_System_TaskOpenEvent` for `panel_app_grid`, then starts `AppGridActivity`. The grid slides in from the right to the right half. Cards slide off the right edge. The map surface stays full-screen; its insets shrink so Maps' own buttons sit in the uncovered left half. Tapping an icon starts that app. The grid's `newTaskLaunchPolicy="DEFAULT"` sends the new task to `launcher_app` (role `DEFAULT`), which is a card over almost the whole canvas. The grid then closes.

**Assistant** (`oem_launch_assistant`). Footer starts the default assistant. No panel moves.

**Climate** (`oem_launch_hvac`). Footer starts `com.test.design` `ClimatePanelActivity`. Its role matches `launcher_climate_app`, so the task opens there, full canvas card, layer 24. This is a different activity from the climate *card* (`ClimateHomePanelActivity` in `launcher_climate`).

**Vehicle** (`oem_launch_vehicle`). Same pattern with `VehiclePanelActivity` and `launcher_vehicle_app`. In T-Rex the footer also posts `trex_vehicle` before the launch.

**Settings** (`oem_launch_car_settings`). Starts Car Settings `HomepageActivity` into `launcher_settings_app`. In T-Rex the footer also posts `trex_split`.

**Recent** (`oem_dock_recent`). Footer launches the last foreground app. `DockPins` appends pinned icons after this slot and posts `dock_pins_N` so the capsule grows. Dragging a pin off the dock removes it. That logic is Java. The wider bounds are XML.

Climate, vehicle, and settings each have their own panel so switching among them does not drop two tasks into `launcher_app` side by side. The one that loses focus goes to variant `behind` (same bounds, layer 19, not visible) and the new one opens on layer 24. Home, the app grid, the map button, and an empty panel all finish by closing them.

## Activity lifecycle inside a panel

A TaskPanel does not invent a lifecycle. The hosted app is a normal Android activity, in its own process, embedded by a `TaskView`. `onCreate`, `onStart`, `onResume`, `onPause`, `onStop`, and `onDestroy` still mean what they mean for any activity. DecorPanels (the dock and the pills) have no activity at all. They are views inside the SystemUI process.

What changes is *when* those callbacks run, because several tasks are on screen together and because hiding a panel is not the same as finishing the task.

**Started once, then reused.** `config_default_activities` starts the map and the cards at boot. The eight widget activities are `singleTask` with their own `taskAffinity`, so a later show uses that same instance. `<Restart policy="LAST">` on the panel relaunches the last activity if the process is killed. A panel transition does not call `onDestroy`.

**Several activities are resumed at once.** A normal full-screen window pauses the previous activity. Here each visible TaskView is its own task, and visible tasks stay resumed together. Maps, the climate card, the media card, and the stats card can all be in `onResume` at the same time. Only the focused panel receives key events. Card panels set `Focus onTransition="false"`, so a bounds animation does not pull focus onto the card. Touches inside the card's rectangle still go to that activity.

**Hiding the panel stops the activity. It does not destroy it.** `Visibility isVisible="false"` (`hidden`, and the `behind` / `closed` poses that use it) removes the TaskView from the hierarchy. The activity goes `onPause` → `onStop`. The task stays. The next time the pose becomes visible, the same instance gets `onRestart` → `onStart` → `onResume`. There is no second `onCreate`. That is the state of the eight widgets in layout sets 0, 1, and 3: created at boot, then stopped while the panel is `hidden`.

**Alpha 0 is not a stop.** Variant 2 parks the cards that are off the current page with `isVisible="true"`, alpha 0, and bounds just above or below the screen. The task is still visible to the window organizer, so those activities stay started and can keep drawing into an off-screen surface. That is why a page change is a slide of windows that are already alive, not a cold start. `layout_v2_away` is the exception: it parents `hidden`, so a covering app does stop them.

**A resize is a configuration change, not a new instance.** Animating bounds changes `screenSize` / `screenLayout`. The widget manifests declare `android:configChanges` for those, and `android:resizeableActivity="true"`. The activity stays in `onResume` and gets `onConfigurationChanged`. It is not destroyed and recreated for the 350 ms slide. An activity that does not declare those `configChanges` would go through the normal destroy-and-create path on every resize.

**The task is finished only when it actually leaves.** `_System_TaskPanelEmptyEvent` is posted by the Scalable UI framework, not by the overlay, when the last task inside one panel is removed. The event token is `panelId` of the panel that just became empty. Back, `finish()`, a crash, or `ActivityTaskManager.removeTask` on that last task all do it. Hiding the panel (`closed`, `behind`, alpha 0) does not: the task is still there, so this event does not fire. Home is a separate event, `_System_OnHomeEvent`. Home only produces an empty event afterward if `removeOverlayTasks` actually deletes the task.

Dialogs and the keyboard belong to the task, so they are clipped to the panel rectangle. They do not cover the rest of the display the way they would over a normal full-screen window.

## Layers, from back to front

| Layer | Surfaces |
| --- | --- |
| 0 | `home_panel`. CarLauncher, parked off the left edge, invisible. It exists so the HOME role does not paint the stock launcher on top of the map. |
| 2 | `map_panel`. |
| 11 | Card plates (`*_bg` DecorPanels). |
| 12 | Card TaskPanels. |
| 16 | `panel_app_grid`. |
| 19 | Climate, vehicle, and settings while `behind` or `closed`. |
| 20 | `launcher_app`. |
| 24 | Climate, vehicle, or settings while `opened`. |
| 30 | Dock, header pills, temperature pills. |

Chrome stays above every app. An opened climate/vehicle/settings card sits above a generic launched app so those three replace it instead of sharing the screen with it.

## Map insets versus bounds

`map_panel` bounds stay at 0–100% in the normal landscape poses, including while a card or the app grid is open. `SafeBounds` and `Insets` are a message to Maps: draw your zoom and recenter controls inside this rectangle. The map surface itself is still full-screen, which is why cards can sit on top of it. `nav` keeps full bounds and clears the side inset so the controls may use the full width. T-Rex `layout_v3_split` is the exception: the map bounds become the left half.

`app_open` changes insets to the launched-app card's margins. The map is still full-screen underneath that card.

## Portrait

`OrientationLayoutWatcher` treats rotation 0 and 180 as portrait and 90 and 270 as landscape, and posts `orientation_portrait` or `orientation_landscape`. After landscape it asks `LayoutVariantWatcher` to reapply set 0–3, because the rotation itself lands every panel on its default landscape pose first.

Portrait is one shared arrangement, independent of the layout-variant number:

- The three header pills sit in one group at the top.
- The map fills the portrait canvas. Its bottom inset clears the widget row.
- The three home cards sit in a row just above the dock. The eight extra widgets have no portrait pose; they stay hidden.
- Temperature pills sit above that row.
- The dock stays centered on the bottom and still widens with `dock_pins_port_N`.
- The app grid and launched apps slide up from below the screen.

## File map

| Concern | Path |
| --- | --- |
| Which windows exist, and which activities start in them | `overlays/LauncherRRO/res/values/config.xml` |
| One window's poses and transitions | `overlays/LauncherRRO/res/xml/<panel>.xml` |
| Dock and pill pixels | `overlays/LauncherRRO/res/layout/` |
| Shared sizes | `overlays/LauncherRRO/res/values/dimens.xml` |
| Component names and roles | `overlays/LauncherRRO/res/values/strings.xml` |
| Dock taps, Home, All apps, map toggle, climate, vehicle, settings | `CarSysuiScalableFooterController.java` |
| Pills, night mode, temperature, stock status buttons | `CarSysuiScalableHeaderController.java` |
| Sets 0–3, T-Rex modes, widget rail | `LayoutVariantWatcher.java` |
| Rotation events | `OrientationLayoutWatcher.java` |
| Pinned dock icons and dock width events | `DockPins.java` |
| Card contents for the eight extra widgets | `Widgets/<name>/` |
| Same controllers inside a prebuilt SystemUI | `device-dex/systemui/smali/` |
