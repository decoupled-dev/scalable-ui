# SystemUI classes: base, layout watchers and integration

This page covers the shared plumbing of `systemui/CarSysuiScalableBarControllers`: the controller base class and its two interfaces, the two watchers that post layout events, and the three files that link the library into CarSystemUI. The header and footer controllers that build on these are documented separately.

Read [GUIDE.md](../launcher/GUIDE.md) first for panels, variants and events, and [DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md) for why views are resolved by name from the overlay package.

Statements here come from the code. Anything marked *(inferred)* is a reading of the code that has not been checked on a device or against AOSP sources outside this repo.

Remember that the tablet runs a patched prebuilt CarSystemUI (see `device-dex/systemui/README.md` in the main repo). Editing these Java files changes nothing on the device until the smali is rebuilt or CarSystemUI is rebuilt from an AOSP tree.

## Contents

Java sources live in [`systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/).

| File | Role |
| --- | --- |
| [`CarSysuiScalableBarControllerBase.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase.java) | Abstract base for DecorPanel controllers: inflates the layout from the RRO, drives attach/detach, VHAL and UX-restriction hooks. |
| [`ScalableDecorPanelController.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/ScalableDecorPanelController.java) | Interface that adds attach/detach hooks and a panel id to AOSP `DecorPanelController`. |
| [`SysuiDumpable.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/SysuiDumpable.java) | One-method `dump(PrintWriter, String[])` interface mirroring SystemUI `Dumpable`. |
| [`LayoutVariantWatcher.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher.java) | Turns `scalable_ui_layout_variant` into `layout_variant_N`, runs T-Rex modes, the variant-2 widget rail, dock orientation, and window placement for privacy/status hit targets. |
| [`OrientationLayoutWatcher.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher.java) | Posts `orientation_portrait` / `orientation_landscape` on display rotation. |
| [`Android.bp`](../../systemui/CarSysuiScalableBarControllers/Android.bp) | Soong `java_library` `CarSysuiScalableBarControllers`. |
| [`CarSysuiScalableBarControllerModule.java`](../../integration/dagger/CarSysuiScalableBarControllerModule.java) | Dagger module that registers the header and footer controller factories, keyed by class. |
| [`car_systemui_android.bp.snippet`](../../integration/car_systemui_android.bp.snippet) | Comment-only checklist for editing CarSystemUI's `Android.bp` and `PanelControllerModule`. |

---

## `CarSysuiScalableBarControllerBase`

### Why it is needed

AOSP `DecorPanel` only calls `getView()`, `refreshTheme()` and `destroy()` on its controller. It never tells the controller when the view is on screen. Without this base, each controller would have to repeat: finding the overlay package, inflating its layout from that package, resolving view ids by name, starting and stopping VHAL subscriptions, and listening to driving restrictions. `CarSysuiScalableHeaderController` and `CarSysuiScalableFooterController` both extend it; nothing else in the library does.

### What it does

- `getView()` resolves an RRO `Context`, looks up `getLayoutResourceName()` as a `layout` in that package, inflates it, and calls `bindViews(root)`. If the layout is not found it logs `Layout not found in RRO: <name>` and returns an empty `View`; `bindViews` is not called.
- It turns window attachment into `onPanelAttached()` / `onPanelDetached()` (see Lifecycle).
- `resolveRroId`, `resolveRroString`, `resolveRroDrawable` call `getIdentifier(name, type, rroPackage)`. They return 0 or `null` when the name is absent, so a controller can bind only the views an overlay actually contains.
- On attach it connects a `CarVhalSubscriptionHelper` (in the `vhal/` subpackage) and a `CarUxRestrictionsManager` listener. It forwards VHAL connect/disconnect and "fully restricted" changes to abstract hooks, always on the view's thread.
- `startDesignPanel(action, component)` starts an activity in the `com.test.design` package for the current user. It refuses when fully restricted or when that package is not installed.
- `dump()` prints one status line, then calls `dumpControllerState(pw)`.

RRO package resolution order (`resolveRroContext`):

1. `mRroPackage`, which the subclass factory reads from the controller XML `<RroPackage>` tag (LauncherRRO sets `com.android.systemui.rro.scalableUI.launcher` in `launcher_dock_controller.xml` and `launcher_status_controller.xml`).
2. The static `RRO_PACKAGE_FALLBACKS` list, skipping the one already tried.
3. The SystemUI context itself, with an error log. Layout lookup then normally fails and an empty view is returned *(inferred)*.

A package only counts as found if `createPackageContext` succeeds **and** the layout name exists in it.

### Lifecycle

- Created by the subclass `Factory.create(panelId, metadata)`, which `PanelControllerInitializer` calls through the Dagger map (see the module section).
- `getView()` registers a `View.OnAttachStateChangeListener` on the root: attach calls `onPanelAttached()`, detach calls `onPanelDetached()`. Because WM Shell may attach the view before the listener exists or never deliver the callback, `getView()` also calls `onPanelAttached()` immediately if already attached, otherwise posts it with `mView.post`. `mAttached` guards against double entry.
- `onPanelAttached()`: VHAL helper `addConnectionListener` + `start`, register UX restrictions (creates its own `android.car.Car`, reads current restrictions once), then `onControllerAttached()`.
- `onPanelDetached()`: VHAL helper stop, UX listener unregister and `Car.disconnect()`, then `onControllerDetached()`.
- `refreshTheme()` detaches and drops the cached view and RRO context; `DecorPanel` calls `getView()` again to inflate a fresh one (per the code comment).
- `destroy()` detaches and drops the view.
- Threads: DecorPanel views live on the WM Shell thread (comment: "wmshell.main"). `runOnViewThread(r)` posts to `mView` when there is one, otherwise to `mContext.getMainExecutor()`. VHAL and UX callbacks use it.

### Events

Posts none and listens to no `Settings` keys. It listens to:

- `CarUxRestrictionsManager`: "fully restricted" means `isRequiresDistractionOptimization()` and the `UX_RESTRICTIONS_FULLY_RESTRICTED` bit. Only a change of that boolean calls `applyUxRestrictions()`.
- `CarVhalSubscriptionHelper.VhalConnectionListener`: `onVhalConnected` / `onVhalDisconnected` call `applyVhalConnectedState()` / `applyVhalDisconnectedState()`.

### Direct view changes

Only helpers that subclasses call:

- `setViewEnabled(view, enabled)`: `setEnabled` plus alpha 1.0 or 0.4.
- `setScrimVisible(scrim, visible)`: `VISIBLE` or `GONE`.

No view id is hardcoded in this class.

### Hardcoded values to know about

| Value | Where used |
| --- | --- |
| `com.android.systemui.rro.scalableUI.oemDemo`, `com.android.systemui.rro.scalableUI.sysuiBars`, `com.android.systemui.rro.scalableUI.multiPanelLandscape` | `RRO_PACKAGE_FALLBACKS`. None of these overlays exist in this worktree (only `LauncherRRO` and `CarLauncherThemeRRO` do), so LauncherRRO depends on its `<RroPackage>` tag. |
| `com.test.design` and the `com.test.design.action.OPEN_CLIMATE/MEDIA/VEHICLE/MAP` actions | `DESIGN_*` constants for `startDesignPanel`. |
| `com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity`, `...MediaPanelActivity`, `...VehiclePanelActivity`, `com.test.design/.presentation.ivi.map.MapActivity`, `com.test.design/.MainActivity` | Explicit components for the Design screens. |
| `FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP`, `CATEGORY_DEFAULT` | Design launches. |
| `PendingIntent.getActivityAsUser` via reflection, then `startActivityAsUser` | Launch path for the current user (`ActivityManager.getCurrentUser()`). |
| Alpha 0.4 | Disabled views. |
| Log tag `CarSysuiScalableBar` | All base logging. |

### Key methods

| Method | Purpose |
| --- | --- |
| `getView()` | Inflate from the RRO, bind, hook attach/detach. |
| `onPanelAttached()` / `onPanelDetached()` | Start/stop VHAL and UX; call subclass hooks. Idempotent. |
| `refreshTheme()` / `destroy()` | Drop the cached view after detaching. |
| `configOrDefault(metadata, key, def)` | Read a string from the parsed controller XML, with default. |
| `resolveRroId/String/Drawable(name)` | Name lookup in the RRO package, 0/`null` if absent. |
| `runOnViewThread(r)` | Post to the decor view's thread. |
| `startDesignPanel(action, component)` | Launch a `com.test.design` screen for the current user. |
| Abstract: `getLayoutResourceName`, `bindViews`, `onControllerAttached`, `onControllerDetached`, `applyUxRestrictions`, `applyVhalConnectedState`, `applyVhalDisconnectedState`, `dumpControllerState` | Subclass responsibilities. |

---

## `ScalableDecorPanelController`

### Why it is needed

AOSP `com.android.car.scalableui.panel.DecorPanelController` has no attach/detach or id methods. This interface names those three methods so the base class (and anything else) has a typed contract for them. Without it the base would still work, since it implements the methods itself; the interface is the declared contract, not a runtime requirement *(inferred)*.

### What it does

Extends `DecorPanelController` with:

- `void onPanelAttached()`: view attached; start subscriptions.
- `void onPanelDetached()`: view detached; release all subscriptions.
- `String getPanelId()`: the panel `id` from XML.

### Lifecycle

No state. `DecorPanel` does not call these methods; implementations drive them from `View.OnAttachStateChangeListener` (Javadoc).

### Events

None.

### Direct view changes

None.

### Hardcoded values to know about

None.

### Key methods

| Method | Purpose |
| --- | --- |
| `onPanelAttached()` | Attach hook. |
| `onPanelDetached()` | Detach hook. |
| `getPanelId()` | Panel id. |

---

## `SysuiDumpable`

### Why it is needed

It lets controllers expose state in the shape of SystemUI's `com.android.systemui.Dumpable` without the library depending on SystemUI classes. Without it, `dump()` on the base would just be an unshared method.

Nothing in this repo registers controllers with SystemUI's `DumpManager` (no `DumpManager` or `registerDumpable` reference in the repo). The Javadoc says this is for `dumpsys activity service SystemUI`, but the output appears there only if something in CarSystemUI registers it *(inferred)*.

### What it does

One method: `void dump(PrintWriter pw, String[] args)`. The base prints `CarSysuiScalableBarController{panelId=…, rroPackage=…, attached=…, vhalConnected=…, fullyRestricted=…}` and then `dumpControllerState(pw)`, which the header and footer implement.

### Lifecycle

None.

### Events

None.

### Direct view changes

None.

### Hardcoded values to know about

None.

### Key methods

| Method | Purpose |
| --- | --- |
| `dump(pw, args)` | Write controller state. |

---

## `LayoutVariantWatcher`

### Why it is needed

The panel XML in LauncherRRO has transitions on `layout_variant_0` … `layout_variant_3`, `widget_page_0` … `widget_page_3`, and `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` (34, 22 and 12 files respectively). The orchestrator does not post any of these. Without this class:

- `adb shell settings put global scalable_ui_layout_variant N` does nothing, because nobody reads the setting or posts `layout_variant_N`.
- Set 1 keeps a horizontal dock inside a tall, narrow panel. The dock orientation is a Java change, not an XML pose.
- Set 2 has no scrollbar and no way to post `widget_page_N`, so only page 0 is reachable.
- Set 3 has no way to post `trex_*` from the dock, and the pill backgrounds and icon tints never change.
- After a theme change or a return to landscape, panels stay on their default variant instead of the selected set.
- The invisible status hit targets and the mic/camera chip windows stay where they were before a pill moved. The code comment says the status windows then sit over the dock and swallow the Home tap.

### What it does

1. Reads `Settings.Global.scalable_ui_layout_variant`. Values outside 0..3 (and a missing setting) read as 0.
2. In landscape, posts `layout_variant_<N>`. Portrait never posts it.
3. Finds the dock and sets its `LinearLayout` orientation: vertical only for set 1 in landscape, horizontal otherwise.
4. In set 3 (landscape), restyles pills and tints icons ("T-Rex chrome"). It undoes this when leaving set 3.
5. Tracks the current T-Rex mode for the footer: `selectTrexMode` posts and remembers it, `restoreTrexMode` posts it again.
6. In set 2 (landscape), adds a 48 dp scrollbar window. Dragging it posts `widget_page_<0..3>`. The window hides while an app or the grid covers the column or the map is fullscreen.
7. Repositions some WindowManager windows that sit over the pills (mic/camera chip, profile tap target, four status slots) to the pills' current panel bounds.

### Lifecycle

- **Created** by `LayoutVariantWatcher.start(context)`, called from `CarSysuiScalableHeaderController.onControllerAttached()`. Every header instance calls it; the static `sInstance` makes only the first one count. It uses `context.getApplicationContext()` when available.
- **Registers**: a `ContentObserver` on `Settings.Global.getUriFor("scalable_ui_layout_variant")` and `registerComponentCallbacks` on the application context. Both use a `Handler` on the main looper.
- **Never unregisters.** `onControllerDetached()` in the header does not stop it, and there is no stop method. It lives for the SystemUI process.
- **Dock link**: `CarSysuiScalableFooterController.bindViews` calls `attachDock(root)` for panel id `oem_dock` (LauncherRRO's `launcher_dock.xml`). The watcher keeps a `WeakReference` to the dock and adds itself as the dock's attach listener. If no dock was handed over, `findDock()` searches all windows by reflection (see Hardcoded values).
- **Threads**: the observer, the rail ticker and `dispatch` run on the SystemUI main looper. The dock and decor views belong to the WM Shell thread. `applyDockOrientation()` posts itself to `dock.getHandler()` when it is on the wrong looper. `run()` checks the current looper to decide which half of its work to do. `placePrivacyChip()` reads view positions on the decor thread, then posts back to the main handler to call `WindowManager.updateViewLayout`.
- **Ready flag**: `mReady` is false until the first `onOrientationApplied`. Until then a settings change does not post `layout_variant_N`; it only re-applies the dock orientation.

### Events

Posted (all through `dispatch`, see below):

| Event | Trigger | Timing |
| --- | --- | --- |
| `layout_variant_<N>` | `onOrientationApplied(false)` (landscape) from `OrientationLayoutWatcher` | Immediately after the orientation event. This is the first post after boot, about 2 s after the header attaches. |
| `layout_variant_<N>` | Setting changed (`onChange`) | Immediately, only if `mReady` and landscape. |
| `layout_variant_<N>` | `onConfigurationChanged` (any configuration change; the comment mentions night mode) | 400 ms later, then once more 700 ms after that (`mThemePasses = 2`), landscape only. Does not check `mReady`. |
| `layout_variant_<N>` | The tracked dock view detaches (theme rebuild) | Same 400 ms + 700 ms pair. |
| `widget_page_<N>` | Rail drag crosses into another page (`stepWidgetPage`) | Immediately, per page change. Blocked unless set 2, landscape, column not covered, map not in `nav`. |
| `widget_page_<current>` | Entering set 2 with a remembered page > 0 (`syncWidgetRail`) | With the `layout_variant_2` post. |
| `widget_page_<current>` | Rail ticker sees the column go from covered to uncovered | Ticker runs every 400 ms while the rail exists. |
| `trex_home` / `trex_nav` / `trex_vehicle` / `trex_split` | `selectTrexMode(event)` from the footer dock buttons | Immediately; ignored unless set 3 and landscape. |
| Last T-Rex mode | `restoreTrexMode()` | Footer calls it via `restoreTrexModeLater()` with `mView.postDelayed(…, 500)`. |

Notes:

- `postCurrent()` in set 3 resets the remembered mode to `trex_home` but does not post `trex_home`; it posts `layout_variant_3`.
- Rotation to portrait (`onOrientationApplied(true)`) resets the widget page to 0 and removes the rail.
- Because `onConfigurationChanged` fires on any configuration change, a rotation probably triggers both the orientation path and the 400 ms/700 ms reapply *(inferred)*.

`dispatch(eventId)` reaches the dispatcher through reflection: `getApplicationContext().getWMComponent().getScalableUIEventDispatcher().executeEvent(new Event.Builder(id).build())`. If any reflection step throws, it logs a warning and falls back to `StateManager.handleEvent(event)` and starts every animator in the returned `PanelTransaction` itself. The fallback skips anything else the dispatcher does around `handleEvent` *(inferred)*.

Listened to:

- `Settings.Global` `scalable_ui_layout_variant` (`ContentObserver`).
- `ComponentCallbacks.onConfigurationChanged` on the application context.
- `View.OnAttachStateChangeListener` on the dock (detach only).
- `OrientationLayoutWatcher` calling `onOrientationApplied(portrait)`.
- Polled every 400 ms while the rail exists: current variant names of `map_panel` and the five covering panels, via `StateManager.getPanelState(id).getCurrentVariant().getIdName()` by reflection.

### Direct view changes

These do not go through panel XML.

**Dock orientation** (`applyDockOrientationOnViewThread`). On the dock `LinearLayout`:

- `setOrientation(VERTICAL)` for set 1 in landscape, else `HORIZONTAL`.
- Each `ImageButton` child: horizontal `marginStart`/`marginEnd` become `topMargin`/`bottomMargin`, and back. The original pair is saved in `View.setTag(int[2])` on first sight.
- Each other child with positive `LinearLayout.LayoutParams` width and height (dividers): width and height swap, margins move the same way. The original `{width, height, marginStart, marginEnd}` is saved in `View.setTag(int[4])`. `DockPins` writes the same `int[4]` tag on dividers it creates.
- Any other code that sets a plain tag on a dock child would collide with these saved arrays *(inferred)*.

**T-Rex chrome** (`applyTrexChrome`), run on the decor thread when in set 3, and once more when leaving it (`mTrexChrome`). It walks every view in `WindowManagerGlobal.mViews` and `mWindowlessRoots`:

- The parent of every `TextClock` that already has a background gets `launcher_pill_bg_v3` (T-Rex) or `launcher_dock_bg` (other sets).
- Every `ImageButton` whose content description is in the colour table gets a `SRC_IN` colour filter in T-Rex (drawable mutated first) and has it cleared otherwise. A button that shows a selected assistant's own icon is skipped and cleared (`isAssistantAppIcon`: a non-framework id whose `getTag(id)` is `Boolean.TRUE`; the footer sets that tag).
- For buttons that are not dock icons, the nearest `LinearLayout` ancestor with a background, up to 4 levels up, gets the pill background.
- Views with ids `sysui_driver_zone_root`, `sysui_passenger_zone_root`, `launcher_user_profile` that already have a background get the pill background.
- Drawables and ids are resolved with `getIdentifier(…, context.getPackageName())`. From `attachDock` the context is the dock view's context, which is the RRO context. From the watcher's own paths it is the SystemUI application context, whose package is `com.android.systemui`. Names that exist only in LauncherRRO may resolve to 0 on those paths, in which case backgrounds are left unchanged and only the tints apply *(inferred)*.
- `applyAssistantGlyphTint(button)` is the footer's entry point for the assistant button alone.

**Window placement** (`placePrivacyChip`, `updatePrivacyWindow`, `moveStatusWindows`). Bounds come from `StateManager.getPanelState(id).getCurrentVariant().getBounds()`. View positions are converted with `screenPoint()` because decor surfaces report locations as if the panel started at the origin.

- Windows considered: entries in `WindowManagerGlobal.mViews` whose `WindowManager.LayoutParams` title is `LauncherQcPanel` (created by the header controller).
- A window containing a class ending in `MicPrivacyChip` or `CameraPrivacyChip` moves to the anchor `launcher_privacy_chips` inside panel `launcher_pill_right`.
- Of the remaining windows with height ≥ 90 px, the one with the largest `x` moves to anchor `launcher_user_anchor` (profile tap target).
- Windows shorter than 90 px are sorted by `x` and matched, left to right, to the four `STATUS_SLOTS` views in panel `launcher_pill_left`. Each gets that view's screen position and size.
- After a settings change, orientation event or theme rebuild, `mFollowPasses = 8` repeats this every 120 ms on the dock's handler, so the windows follow the 350 ms pill transition (comment).

**Widget rail window** (`showWidgetRail` / `hideWidgetRail`): a Java-drawn view added with `WindowManager.addView`, not a panel.

- Type 2008 (`TYPE_SYSTEM_DIALOG`) from `createWindowContext`. Flags `NOT_FOCUSABLE | NOT_TOUCH_MODAL | LAYOUT_IN_SCREEN`, `TRANSLUCENT`, gravity top/start, title `launcher_widget_rail`. `setTrustedOverlay()` is called by reflection if available.
- Size 48 dp × 876 dp at x = display real width − 528 dp, y = 80 dp.
- Draws a 6 dp track (colour `0x33FFFFFF`) inset 12 dp top and bottom, and a 24 × 72 dp thumb (`0xF2FFFFFF`, `0xFFFFFFFF` while dragging). Content description `Widget pages`.
- Touch anywhere on the track moves the thumb; the page is `(thumb centre − track top) / track span × 4`.
- The ticker sets the rail `GONE` while covered and `VISIBLE` otherwise.

### Hardcoded values to know about

| Value | Meaning |
| --- | --- |
| `scalable_ui_layout_variant` (`SETTING`) | `Settings.Global` key. Range 0..3 (`VARIANT_COUNT = 4`). |
| `1`, `2`, `3` | Dock-left set, widget-column set, T-Rex set. |
| `layout_variant_`, `widget_page_`, `trex_home`, `trex_nav`, `trex_vehicle`, `trex_split` | Event names. |
| `WIDGET_PAGE_COUNT = 4` | Pages 0..3. |
| `map_panel` with variant `nav` or `portrait_nav` | Map fullscreen; hides the rail. |
| `launcher_app`, `launcher_climate_app`, `launcher_vehicle_app`, `launcher_settings_app`, `panel_app_grid` | Panels that cover the column when their variant is `opened`, `layout_v1` or `portrait_opened` (variants containing `closed`, `hidden` or `behind` are skipped). |
| `launcher_pill_right`, `launcher_pill_left` | Panel ids used for bounds. |
| `launcher_privacy_chips`, `launcher_user_anchor`, `launcher_status_wifi_slot`, `launcher_status_bluetooth_slot`, `launcher_status_brightness_slot`, `launcher_status_volume_slot` | View entry names searched in windowless roots. |
| `LauncherQcPanel` | Window title of the header's hit-target windows. |
| `MicPrivacyChip`, `CameraPrivacyChip` | Class-name suffixes. |
| 90 px | Height split between profile host and status-slot windows. |
| `launcher_pill_bg_v3`, `launcher_dock_bg` | T-Rex / normal pill background drawables. |
| `sysui_driver_zone_root`, `sysui_passenger_zone_root`, `launcher_user_profile` | Ids restyled in T-Rex. |
| Dock detection | A `LinearLayout`, attached, with ≥ 5 `ImageButton` children, one with content description exactly `Home`. |
| Content descriptions and T-Rex colours | `Wi-Fi` `0xFF4DA3FF`; `Bluetooth` `0xFF5B8DEF`; `Volume` `0xFF7C6BF2`; `Brightness` `0xFFF5A524`; `Dark theme`/`Light theme` `0xFF8E9AAF`; `Decrease temperature`/`Increase temperature` `0xFF4FC3F7`; `Home` `0xFF5B8DEF`; `Map fullscreen` `0xFF3DDC97`; `All apps` `0xFFF5A524`; `Assistant` `0xFFE85D75`; `Climate` `0xFF4FC3F7`; `Vehicle` `0xFF7C6BF2`; `Car settings` `0xFF8E9AAF`. These are English strings; a translated content description would not match *(inferred)*. |
| Dock icon descriptions | `Home`, `Map fullscreen`, `All apps`, `Assistant`, `Climate`, `Vehicle`, `Car settings` (pill background not applied to these). |
| Timings | 2000 ms start delay; dock search retried up to 8 times at 1000 ms; theme reapply 400 ms then 700 ms; follow passes 8 × 120 ms; rail ticker 400 ms. |
| Reflection targets | `android.view.WindowManagerGlobal.getInstance`, fields `mViews` and `mWindowlessRoots` (each root's `getView()`); `com.android.car.scalableui.manager.StateManager.getPanelState`; `getWMComponent().getScalableUIEventDispatcher()`. A platform change to any of these makes that feature log and do nothing. |
| Portrait | Rotation 0 or 180. A missing `DisplayManager` or display counts as portrait. |
| Log tag `LayoutVariant` | Note that CLAUDE.md's logcat filter lists `LayoutVariantWatcher`, which does not match this tag. |

### Key methods

| Method | Purpose |
| --- | --- |
| `start(Context)` | Create the single instance, register observer and callbacks, schedule the first dock pass. |
| `onOrientationApplied(boolean portrait)` | Called by `OrientationLayoutWatcher`. Marks ready; landscape posts the set, portrait drops the rail. |
| `attachDock(View)` | Footer hands over `oem_dock`; applies orientation and chrome at once. |
| `isTrex(Context)` | True for set 3 in landscape. Used by the footer to change dock button meaning. |
| `selectTrexMode(String)` | Remember and post a `trex_*` event. |
| `restoreTrexMode()` | Post the remembered `trex_*` event again. |
| `applyAssistantGlyphTint(ImageButton)` | T-Rex tint for the assistant button, unless it shows an app icon. |
| `onChange` / `onConfigurationChanged` / `onViewDetachedFromWindow` | Setting change, theme or config change, dock rebuilt. |
| `postCurrent()` | Post `layout_variant_N` and sync the rail. |
| `applyDockOrientation(...)` | Find the dock, hop to its thread, set orientation and chrome. |
| `placePrivacyChip()` / `updatePrivacyWindow()` / `moveStatusWindows()` | Reposition the header's hit-target windows. |
| `syncWidgetRail` / `stepWidgetPage` / `showWidgetRail` / `hideWidgetRail` | Variant-2 paging. |
| `getVariant(Context)` | Read and clamp the setting. |
| `dispatch(String)` | Post through `ScalableUIEventDispatcher`, with a `StateManager` fallback. |

---

## `OrientationLayoutWatcher`

### Why it is needed

The orchestrator does not emit an orientation event (class Javadoc). LauncherRRO panels move between landscape and portrait variants on `orientation_portrait` (34 files) and `orientation_landscape` (18 files). Without this class, rotating the device leaves every panel on its landscape geometry. It is also what makes `LayoutVariantWatcher` ready and posts the first `layout_variant_N` after boot.

### What it does

On start, and whenever the default display changes, it reads the rotation. Rotation 0 or 180 is portrait, 90 or 270 is landscape. When the result differs from the last one applied (or nothing has been applied yet), it posts `orientation_portrait` or `orientation_landscape`, then calls `LayoutVariantWatcher.onOrientationApplied(portrait)`. The comment explains that landscape lands every panel on its default variant, so the selected layout set has to be posted again afterwards.

The portrait/landscape mapping is fixed by rotation number, not by display width and height. It is correct only for a display whose natural orientation is portrait, as the Javadoc states *(inferred)*.

### Lifecycle

- Created by `OrientationLayoutWatcher.start(context)`, called from `CarSysuiScalableHeaderController.onControllerAttached()` just before `LayoutVariantWatcher.start`. The static `sStarted` flag makes only the first call count. It keeps the passed context, not the application context.
- Registers a `DisplayManager.DisplayListener` on a main-looper `Handler`, and posts itself with a 2000 ms delay for the first check.
- `sStarted` is set before the `DisplayManager` null check. If `DisplayManager` is missing, the watcher never registers and never retries.
- Never unregisters. Lives for the SystemUI process.

### Events

| Event | Trigger | Timing |
| --- | --- | --- |
| `orientation_portrait` / `orientation_landscape` | First check | 2000 ms after `start`. Always posts once, whatever the rotation. |
| Same | `onDisplayChanged(DEFAULT_DISPLAY)` with a portrait/landscape flip | Immediately. Changes that keep the same orientation (for example 90 to 270) post nothing. |

Listened to: `DisplayManager.DisplayListener.onDisplayChanged` for `Display.DEFAULT_DISPLAY` only. `onDisplayAdded` and `onDisplayRemoved` are empty.

`dispatch` is the same reflective `executeEvent` call with the `StateManager.handleEvent` fallback as in `LayoutVariantWatcher` (the code is duplicated).

### Direct view changes

None. Dock orientation after rotation is done by `LayoutVariantWatcher.onOrientationApplied`.

### Hardcoded values to know about

| Value | Meaning |
| --- | --- |
| `orientation_portrait`, `orientation_landscape` | Event names. |
| `START_DELAY_MS = 2000` | First check, so `window_states` has finished loading (comment). |
| `Surface.ROTATION_0`, `ROTATION_180` | Treated as portrait. |
| Log tag `OrientationLayout` | |

### Key methods

| Method | Purpose |
| --- | --- |
| `start(Context)` | Register once and schedule the first check. |
| `onDisplayChanged(int)` | Re-check on default display changes. |
| `run()` | Delayed first check. |
| `apply()` | Compute orientation, post if changed, notify `LayoutVariantWatcher`. |
| `dispatch(String)` | Post through the dispatcher, with fallback. |

---

## `Android.bp` (`CarSysuiScalableBarControllers`)

### Why it is needed

CarSystemUI cannot construct a controller class it was not built with. This file makes the controller sources a Soong module that CarSystemUI can link.

### What it does

```
java_library {
    name: "CarSysuiScalableBarControllers",
    srcs: ["src/**/*.java"],
    libs: ["android.car", "car-scalable-ui-lib"],
}
```

- Compiles every Java file under `src/`, including `vhal/CarVhalSubscriptionHelper.java` and the header, footer, `DockPins` and `AssistantDockIcon` classes.
- `android.car` and `car-scalable-ui-lib` are `libs`, so compile-time only; they are not bundled. CarSystemUI must provide `car-scalable-ui-lib` at runtime, which is why the snippet lists it in CarSystemUI's `static_libs`.
- The library does not depend on CarSystemUI classes. It reaches the event dispatcher by reflection (`getWMComponent()`), which is why the Dagger module is a separate file that lives inside CarSystemUI.
- The factories use `PanelControllerParser.RRO_PACKAGE_TAG`, `PRIMARY_MEDIA_COMPONENT_TAG` and `MEDIA_PANEL_ID_TAG` from `car-scalable-ui-lib`. A tree whose `car-scalable-ui-lib` lacks those constants will not compile this library *(inferred from the imports; not checked against AOSP)*.

### Lifecycle and registration

Build-time only. The module must be visible to Soong, which it is when the repo sits in the AOSP tree (for example under `vendor/`).

### What fails if skipped

- Module not in the tree: CarSystemUI's `static_libs: ["CarSysuiScalableBarControllers"]` fails at Soong analysis with an unknown module.
- Module present but not in CarSystemUI's `static_libs`: CarSystemUI compiles without the classes, and the Dagger module does not compile because it references them. If the Dagger module is also left out, the controller XML names a class that is not in the APK *(inferred: `Class.forName` in `PanelControllerInitializer` fails)*.

Note: `scalableui_packages.mk` also adds `CarSysuiScalableBarControllers` to `PRODUCT_PACKAGES`. That installs nothing CarSystemUI uses; only the `static_libs` link puts the classes in the APK *(inferred)*.

---

## `CarSysuiScalableBarControllerModule`

### Why it is needed

The controller XML in LauncherRRO names `CarSysuiScalableHeaderController` and `CarSysuiScalableFooterController` in `<ControllerName>`. Per the module comment, `PanelControllerInitializer` resolves that name with `Class.forName` and then looks it up in a `Map<Class<?>, Provider<DecorPanelController.Factory<?>>>`. Without this module there is no entry for either class, so the initializer cannot construct the controller and the DecorPanel gets no view from this library. The behaviour of the initializer in that case is AOSP code not in this repo *(not verified)*.

### What it does

A Dagger `@Module` with two `@Provides @IntoMap @ClassKey(...)` bindings:

| Key | Factory | Injected |
| --- | --- | --- |
| `CarSysuiScalableHeaderController.class` | `new CarSysuiScalableHeaderController.Factory(context)` | `Context` |
| `CarSysuiScalableFooterController.class` | `new CarSysuiScalableFooterController.Factory(context, hvacPanelOverlayViewController::toggle)` | `Context`, `HvacPanelOverlayViewController` |

The footer gets the AOSP HVAC panel toggle so the dock fan button can open `HvacPanelOverlay`. Each factory reads `RroPackage` (and for the footer `PrimaryMediaComponent`, `MediaPanelId`) from the parsed `PanelControllerMetadata`, so the overlay controls the wiring. Without `<RroPackage>`, both factories default to `com.android.systemui.rro.scalableUI.sysuiBars`, which is not in this worktree.

### Lifecycle and registration

- The file declares package `com.android.systemui.car.wm.scalableui.panel.controller`. It is not compiled by the library; it must be copied into CarSystemUI next to `PanelControllerModule.java`.
- `PanelControllerModule`'s `@Module(includes = {...})` must list `CarSysuiScalableBarControllerModule.class`.
- `HvacPanelOverlayViewController` (`com.android.systemui.car.hvac`) must be injectable in the graph where `PanelControllerModule` is installed.

### What fails if skipped

| Step skipped | Result |
| --- | --- |
| File not copied | Nothing references it; no bindings; controllers not constructed. |
| Copied but not in `includes` | Compiles, but Dagger ignores the module; same result as above. |
| `HvacPanelOverlayViewController` not bound in that graph | Dagger compile error (missing binding). |
| Only the header or footer binding kept | That one controller's panels get no view. In LauncherRRO the header drives the pills and temperature pills and also starts both watchers, so without it no `layout_variant_N`, `orientation_*` or `trex_*` event is ever posted. |

The step list in the file's header comment ends with "enable OemDemo `window_states_pleos` arrays (or run `scripts/deploy_ui.sh --mode pleos`)". OemDemoRRO is not in this worktree; for LauncherRRO, enabling `com.android.systemui.rro.scalableUI.launcher` is the equivalent step.

---

## `car_systemui_android.bp.snippet`

### Why it is needed

It is the only written record of the two edits CarSystemUI needs. It is not a build file; everything in it is a comment.

### What it does

1. Shows `CarSystemUI-core-defaults` with `"car-scalable-ui-lib"` and `"CarSysuiScalableBarControllers"` in `static_libs`, and says to do the same for the test defaults.
2. Shows `PanelControllerModule` with `@Module(includes = { MinimizedControlsPanelModule.class, CarSysuiScalableBarControllerModule.class })`.
3. Says to rebuild CarSystemUI and switch OemDemoRRO to `window_states_pleos` / `config_default_activities_pleos`, or run `./scripts/deploy_ui.sh --mode pleos`.

It also says the change "landed on branch scalable-ui-dev in this tree" and gives the vendor path `vendor/tcs/ScalableUI/systemui/CarSysuiScalableBarControllers`. CLAUDE.md gives `vendor/aospstack/ScalableUI`. Use the path where the repo actually sits in your tree.

### What fails if skipped

| Step skipped | Result |
| --- | --- |
| `CarSysuiScalableBarControllers` not in core `static_libs` | Controller classes missing from the APK; the copied Dagger module does not compile. |
| Not in test `static_libs` | CarSystemUI test targets that compile the same Dagger graph fail to compile *(inferred)*. |
| `car-scalable-ui-lib` not in `static_libs` | The library compiled against it only as `libs`; at runtime its classes would be missing *(inferred; stock CarSystemUI with Scalable UI normally already links it)*. |
| Module not in `includes` | See the module section. |

---

## Integration checklist

To link the library into CarSystemUI in an AOSP tree (Android 15, `packages/apps/Car/SystemUI`):

1. Place this repo in the tree (for example `vendor/aospstack/ScalableUI`) so Soong sees `systemui/CarSysuiScalableBarControllers/Android.bp`.
2. Check that `car-scalable-ui-lib` in your tree has `PanelControllerParser.RRO_PACKAGE_TAG`, `PRIMARY_MEDIA_COMPONENT_TAG` and `MEDIA_PANEL_ID_TAG`, and `ScalableUIEventDispatcher.executeEvent(Event)` reachable through `getWMComponent().getScalableUIEventDispatcher()`. The library relies on all of these.
3. In CarSystemUI's `Android.bp`, add `"car-scalable-ui-lib"` (if absent) and `"CarSysuiScalableBarControllers"` to `static_libs` of `CarSystemUI-core-defaults`, and to the test defaults.
4. Copy `integration/dagger/CarSysuiScalableBarControllerModule.java` into CarSystemUI next to `PanelControllerModule.java`. Keep the package `com.android.systemui.car.wm.scalableui.panel.controller`, or change it to match `PanelControllerModule` if that lives elsewhere.
5. Add `CarSysuiScalableBarControllerModule.class` to the `includes` of `PanelControllerModule`'s `@Module` annotation.
6. Add the product makefile hook so CarSystemUI and the overlays ship (`scalableui_packages.mk` in this worktree).
7. Build: `m CarSystemUI LauncherRRO` (plus the other packages you need).
8. Install CarSystemUI to the path `pm path com.android.systemui` reports (on tangorpro, check both `/system_ext/priv-app/CarSystemUI/` and `/system/priv-app/CarSystemUI/`). Back up the installed APK first.
9. Enable `com.android.systemui.rro.scalableUI.launcher` for users 0 and 10, make sure no other `window_states` owner is enabled, then `adb shell stop && adb shell start`.
10. Verify: `adb logcat -s OrientationLayout LayoutVariant CarSysuiScalableBar` should show an `event=orientation_landscape` line and an `event=layout_variant_N` line about 2 s after the pills attach. Then `adb shell settings put global scalable_ui_layout_variant 1` should log `event=layout_variant_1` and stack the dock vertically.
