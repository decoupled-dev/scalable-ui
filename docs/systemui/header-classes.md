# SystemUI classes: pills, temperature and vehicle data

These four classes run inside CarSystemUI and fill the five LauncherRRO DecorPanels that share one controller file, [`launcher_status_controller.xml`](../../overlays/LauncherRRO/res/xml/launcher_status_controller.xml):

| DecorPanel id | Panel file | Page |
| --- | --- | --- |
| `launcher_pill_left` | `launcher_pill_left.xml` | [status-pill.md](../launcher/docks/status-pill.md) |
| `launcher_pill_center` | `launcher_pill_center.xml` | [clock-pill.md](../launcher/docks/clock-pill.md) |
| `launcher_pill_right` | `launcher_pill_right.xml` | [profile-pill.md](../launcher/docks/profile-pill.md) |
| `sysui_driver_zone_panel` | `launcher_climate_left.xml` | [driver-temperature.md](../launcher/docks/driver-temperature.md) |
| `sysui_passenger_zone_panel` | `launcher_climate_right.xml` | [passenger-temperature.md](../launcher/docks/passenger-temperature.md) |

The controller file names `CarSysuiScalableHeaderController` and sets `RroPackage` to `com.android.systemui.rro.scalableUI.launcher`. One controller instance is created per panel, so five instances run at once. Each instance picks its layout by panel id.

Overlay XML gives these panels a rectangle, a layer and their poses. It draws the icons. It cannot open a quick-settings popup, toggle the theme, name the current user, show the camera/mic chips, or read and write the cabin temperature. That is the Java on this page.

Source: [`systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/). Shared base class, watchers and Dagger wiring: [core-classes.md](core-classes.md). How views are found by name: [../DYNAMIC_RRO_BINDING.md](../DYNAMIC_RRO_BINDING.md).

## Contents

| Class | Role |
| --- | --- |
| [`CarSysuiScalableHeaderController`](#carsysuiscalableheadercontroller) | Fills the three top pills and the two temperature pills: stock quick-control buttons, night mode, user name, privacy chips, HVAC +/- over VHAL. |
| [`HvacTemperatureUnits`](#hvactemperatureunits) | Converts the Celsius HVAC setpoint into pill text in °C or °F and computes the next setpoint for one press. |
| [`CarVhalSubscriptionHelper`](#carvhalsubscriptionhelper) | Owns one `Car` connection and `CarPropertyManager`; subscribe, read, clamped write, connect/disconnect callbacks. |
| [`PanelOutsideHost`](#paneloutsidehost) | Shows a quick-control popup from a full-screen host window so it is not cropped to the small pill window. |

---

## `CarSysuiScalableHeaderController`

[`.../wm/scalableui/panel/controller/CarSysuiScalableHeaderController.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController.java). Extends `CarSysuiScalableBarControllerBase` ([core-classes.md](core-classes.md)).

### Why it is needed

A DecorPanel has no activity. Something in SystemUI has to inflate a layout into its surface and attach behaviour. Without this class (library not linked, or the Dagger factory missing), all five panels are empty capsules or not drawn at all.

What XML alone could not do, by pill:

- **Status pill.** The four slots in `launcher_pill_left.xml` are placeholder `ImageButton`s. The real Wi-Fi, Bluetooth, display and volume popups belong to stock CarSystemUI (`CarSystemBarPanelButtonView` plus its quick-control panel). The stock top system bar is disabled in LauncherRRO, so those buttons exist nowhere unless this class inflates them and places them over the slots. The night-mode toggle needs `UiModeManager`. Without the class the icons are inert.
- **Clock pill.** Nothing. The `TextClock` updates itself. The class only chooses the layout.
- **Profile pill.** The user name needs `UserManager` (SystemUI runs as user 0; the pill must name the foreground user). The user switcher popup and the camera/mic privacy chips are stock SystemUI views with Dagger-created controllers. Without the class the pill shows the static avatar, no name change, no switcher and no chips.
- **Temperature pills.** XML cannot read or write a vehicle property. Without the class the readout stays at the placeholder `--°` and plus/minus do nothing.

### What it does

As the user sees it:

- Status pill: Wi-Fi, Bluetooth, brightness and volume icons open the stock quick-control popups. If the stock button cannot be found or hosted, the icon opens the matching Settings screen instead. The moon/sun icon switches dark/light theme; the icon shows the theme the next tap selects.
- Profile pill: shows the foreground user's name; tap opens the stock profile switcher (fallback: user settings). Camera and mic privacy chips appear to the left of the avatar while a sensor is in use; the pill reserves room for them only while at least one is shown.
- Driver / passenger temperature: the readout shows the cabin setpoint in the vehicle's display unit (°C with half degrees, or whole °F). Minus and plus step the setpoint one displayed unit. At the VHAL min or max the matching button is greyed (alpha 0.4) and disabled. All buttons grey out while VHAL is disconnected or the car is in a fully restricted UX state.
- Tapping anywhere else on a temperature pill (readout, background) starts an activity in package `com.test.design`: `ClimatePanelActivity` for the driver pill, `VehiclePanelActivity` for the passenger pill. See [Things to know](#things-to-know-about-the-temperature-pill-taps).

### Lifecycle

- **Created by**: CarSystemUI's `PanelControllerInitializer`, when it reads `launcher_status_controller.xml`. It resolves `ControllerName` with `Class.forName` and looks the class up in the Dagger map. `CarSysuiScalableBarControllerModule.provideScalableHeaderControllerFactory` ([integration/dagger](../../integration/dagger/CarSysuiScalableBarControllerModule.java)) puts `CarSysuiScalableHeaderController.Factory` there. `Factory.create(panelId, metadata)` builds one instance per panel id and reads `RroPackage` from the metadata (default `com.android.systemui.rro.scalableUI.sysuiBars`).
- **View**: `getView()` (base) resolves the overlay package, inflates `getLayoutResourceName()` from it, calls `bindViews(root)`, and attaches the lifecycle to the view's window attachment.
- **Attach**: base `onPanelAttached` starts a `CarVhalSubscriptionHelper`, registers for UX restrictions, then calls `onControllerAttached`: subscribes five HVAC properties, reads initial values, refreshes the readouts, and calls `OrientationLayoutWatcher.start(mContext)` and `LayoutVariantWatcher.start(mContext)`. Every header instance calls both `start` methods; the comment says one watcher serves every header instance (the singleton guard is in those classes, see [core-classes.md](core-classes.md)).
- **Detach / theme change / destroy**: base `onPanelDetached` stops the VHAL helper (unregisters everything, disconnects `Car`), unregisters UX restrictions, then `onControllerDetached` removes the main-thread host windows (posted to the main executor) and calls `unsubscribe` for the five properties. `refreshTheme()` detaches and drops the view; the panel calls `getView()` again and everything is rebound.
- **Threads**:
  - Decor views are attached on the WM Shell thread (base class comment). `bindViews`, click handlers, and therefore the VHAL writes in `adjustHvac` run on that thread.
  - Stock quick-control popups update on the SystemUI main thread. Hosting a stock button in the shell-thread decor view crashed SystemUI once the popup refreshed (comment in `wireStatusPills`). That is why stock buttons and privacy chips live in separate windows added from `mContext.getMainExecutor()`.
  - VHAL callbacks arrive on the main looper (the helper's `Car` uses a main-thread `Handler`) and are re-posted to the view thread with `runOnViewThread`.

### Layout chosen per panel id

`getLayoutResourceName()`:

| Panel id | Layout in the overlay |
| --- | --- |
| `oem_climate_card`, `sysui_driver_zone_panel` | `oem_climate_card` |
| `sysui_passenger_zone_panel` | `car_sysui_scalable_header_passenger_zone` |
| `launcher_pill_left` | `launcher_pill_left` |
| `launcher_pill_center` | `launcher_pill_center` |
| `launcher_pill_right` | `launcher_pill_right` |
| anything else | `car_sysui_scalable_header` (clock plus night-mode button) |

The panel id in the panel XML is therefore load-bearing. Renaming `sysui_driver_zone_panel` in `launcher_climate_left.xml` switches the panel to the fallback layout. Layout details: [../xml/launcher-resources.md#layouts](../xml/launcher-resources.md#layouts).

### Views it wires

`bindViews` runs, in order: `bindDriverZone`, `bindPassengerZone`, `bindClimateExtras`, `bindChromeScrim`, `wireClickListeners`, `wireDesignScreen`, `wireNightMode`, `wireStatusPills`. Each id is resolved by name with `resolveRroId` against the overlay package. A missing id is skipped, so every method runs for every panel and only acts on the ids that layout has.

| View id (overlay) | Pill | Tap behaviour | Method |
| --- | --- | --- | --- |
| `launcher_status_wifi_slot` / fallback `launcher_status_wifi` | Status | Stock `qc_connectivity_panel` popup; fallback `Settings.ACTION_WIFI_SETTINGS` | `wireStatusPills` → `bindMainThreadPanel` |
| `launcher_status_bluetooth_slot` / `launcher_status_bluetooth` | Status | Stock `qc_bluetooth_panel`; fallback `ACTION_BLUETOOTH_SETTINGS` | same |
| `launcher_status_brightness_slot` / `launcher_status_brightness` | Status | Stock `qc_display_panel`; fallback `ACTION_DISPLAY_SETTINGS` | same |
| `launcher_status_volume_slot` / `launcher_status_volume` | Status | Stock `qc_volume_panel`; fallback `ACTION_SOUND_SETTINGS` | same |
| `sysui_night_mode` | Status (also the fallback header layout) | `UiModeManager.setNightModeActivated(!night)`; icon `ic_status_day` / `ic_status_night`, content description `launcher_light_theme` / `launcher_dark_theme` | `wireNightMode`, `toggleNightMode` |
| (none) | Clock | None. `TextClock` updates itself. | — |
| `launcher_user_name` | Profile (any layout that has it) | None. Text set to the foreground user's name, `"Profile"` if unknown. Set once at bind time. | `wireUserProfile`, `currentUserName` |
| `launcher_user_anchor` / fallback `launcher_user_profile` | Profile | Stock `qc_profile_switcher` popup (from SystemUI layout `user_name_container`); fallback `Settings.ACTION_USER_SETTINGS` | `wireUserProfile` → `bindMainThreadPanel` |
| `launcher_privacy_chips` | Profile | Hosts stock `camera_privacy_chip` and `mic_privacy_chip`; their own controllers handle taps | `wirePrivacyChips`, `syncPrivacySpacer` |
| `sysui_driver_zone_root` | Driver temp | Root of `oem_climate_card`; see design-screen tap below | `bindDriverZone` |
| `sysui_driver_hvac_down` / `_up` | Driver temp | `adjustHvac(AREA_DRIVER, -1 / +1)` | `wireClickListeners` |
| `sysui_driver_hvac_temp` | Driver temp | Readout. `wireClickListeners` sets `launchClimatePanel`, then `wireDesignScreen` replaces it with `launchDesignScreen(ClimatePanelActivity)` | `updateHvacDisplay` |
| `oem_card_header` | Driver temp (0×0, `gone`) | Click `launchClimatePanel`, long-click `launchVehiclePanel`; click then replaced by `wireDesignScreen`. Not reachable while `gone`. | `wireClickListeners` |
| `sysui_passenger_zone_root` | Passenger temp | Root; see design-screen tap below | `bindPassengerZone` |
| `sysui_passenger_hvac_down` / `_up` | Passenger temp | `adjustHvac(AREA_PASSENGER, -1 / +1)` | `wireClickListeners` |
| `sysui_passenger_hvac_temp` | Passenger temp | Readout; tap → `launchDesignScreen(VehiclePanelActivity)` | `updateHvacDisplay` |

Ids the controller binds that LauncherRRO's layouts do not contain (they belong to the older OEM/MultiPanel climate card): `sysui_driver_seat_up/_down/_temp`, `sysui_passenger_seat_up/_down/_temp` (seat heat 0–3, `adjustSeat`), `oem_vent_defrost`, `oem_vent_face`, `oem_vent_feet` (`setFanDirection`), `oem_fan_speed` (`cycleFanSpeed`, 1–7 wrapping), `oem_card_expand` (`launchVehiclePanel`), `sysui_header_ux_scrim`, `sysui_header_vhal_scrim`. On LauncherRRO these are absent and skipped. Seat heat lives in the seats widget app instead.

#### How stock QS / status buttons are pulled into slots

`bindMainThreadPanel(root, slotName, fallbackName, stockTree, panelLayout, settingsAction)`:

1. `inflateSystemUiLayout("qc_status_icons_horizontal")` (or `"user_name_container"` for the profile) inflates a stock **SystemUI** layout, looked up with `getIdentifier(name, "layout", "com.android.systemui")`, with a null parent.
2. `detachPanelButton` walks that tree for a view whose class name ends in `CarSystemBarPanelButtonView` and whose private field `mPanelLayoutRes` (read by reflection) equals the id of `panelLayout` (`qc_connectivity_panel` etc.), and detaches it.
3. If the slot is not a `ViewGroup` or no button was found, the placeholder `fallbackName` gets a click listener that starts the Settings action for the current user (`openSettings`). Done.
4. Otherwise the slot is tagged `"main-hosted"` (prevents a second bind), the stock button is put in a new `FrameLayout` host, and a layout-change listener on the slot calls `placeMainThreadHost`.
5. `placeMainThreadHost` computes screen coordinates. A decor surface reports `getLocationOnScreen` as if the panel starts at the origin, so it adds the panel's current variant bounds, read by reflection: `StateManager.getPanelState(panelId).getCurrentVariant().getBounds()`. Then on the main executor:
   - `ensureMainThreadHost` adds the host as its own window: type `2017` (literal; `TYPE_STATUS_BAR_SUB_PANEL` in the platform, *inferred from the constant*), `FLAG_NOT_FOCUSABLE | FLAG_NOT_TOUCH_MODAL | FLAG_LAYOUT_IN_SCREEN`, translucent, gravity top-left, title `LauncherQcPanel`, `setTrustedOverlay()` by reflection. If adding fails it retries as `TYPE_APPLICATION_OVERLAY`. Before adding it gives every view in the host a fresh id (`assignUniqueIds`), because stock layouts share ids and the state controller refuses duplicates. Views whose class name ends in `PrivacyChip` keep their child ids (renumbering them broke the chip).
   - On first placement `initializeElements(host)` calls SystemUI's `CarSystemBarElementInitializer.initializeCarSystemBarElements(host)`. That is what binds the stock button to its popup. The initializer is obtained by reflection: application → field `mSysUIComponent` (or `mInitializer.mSysUIComponent`) → field `carSystemBarElementInitializerProvider` → `get()`.
   - `fadeStockChrome` sets alpha 0 and no background on the stock button. The stock button is invisible but takes the touch. The pill's own placeholder icon underneath is what the user sees.
   - If the window cannot be added, the fallback Settings listener is wired instead.
6. `LayoutVariantWatcher` finds these windows by the title `LauncherQcPanel` and moves them when the pills animate to another layout set (see [core-classes.md](core-classes.md)).

The privacy chips use the same host path (`placeMainThreadHost` with `hideChrome=false`): a horizontal `LinearLayout` with both chips (width `privacy_chip_width` from SystemUI, 56 dp fallback; 12 dp gap). A `GONE` spacer of the same width is added inside `launcher_privacy_chips`. A global-layout listener on the host (`syncPrivacySpacer`) shows the spacer only while a chip is visible, and sets `FLAG_NOT_TOUCHABLE` on the chip window while no chip is visible, so the window does not swallow taps on the avatar.

`bindStockPanelOrSettings` / `installStockPanel` are an older path that put the stock button directly into the slot view. Nothing calls `bindStockPanelOrSettings`; it is dead code.

#### Night mode

`wireNightMode` finds `sysui_night_mode`. The current state is read from `mContext.getResources().getConfiguration().uiMode & UI_MODE_NIGHT_MASK`. A tap calls `UiModeManager.setNightModeActivated(!night)` (the same call the stock dark-theme tile uses, per the code comment) and swaps the icon. The theme change makes the orchestrator call `refreshTheme()` on every controller, so the pills are rebuilt with the night resources. Nothing is persisted by this class.

#### Things to know about the temperature-pill taps

`wireDesignScreen` runs after `wireClickListeners`. For `sysui_driver_zone_panel` / `oem_climate_card` (Climate) and `sysui_passenger_zone_panel` / `oem_car_status_card` (Vehicle) it walks the whole tree and sets a click listener on every view, except an `ImageButton` that already has one. So:

- The plus/minus buttons keep `adjustHvac`.
- The readout listener `launchClimatePanel` set in `wireClickListeners` is overwritten. The readout, the root and any other view call `launchDesignScreen`, which does a plain `startActivityAsUser` of `com.test.design/...ClimatePanelActivity` (driver) or `...VehiclePanelActivity` (passenger), with no UX-restriction check, no installed-package check and no fallback. If the package is missing the start throws, is caught and logged (`launchDesignScreen failed`).
- `launchClimatePanel` (Design `OPEN_CLIMATE`, else broadcast `TOGGLE_HVAC_PANEL`) and `launchVehiclePanel` (Design `OPEN_VEHICLE`, else event `toggle_card_expand_climate`) are therefore not reachable from the LauncherRRO layouts: the readout listener is replaced, and `oem_card_header` is `gone` and `oem_card_expand` does not exist. [driver-temperature.md](../launcher/docks/driver-temperature.md) says the number "can open the climate panel"; in the Java it opens `com.test.design` `ClimatePanelActivity` directly.

### Events and listeners

| Kind | What | Where |
| --- | --- | --- |
| Event posted | `toggle_card_expand_climate`, only from `launchVehiclePanel` when `com.test.design` is missing. Posted with `ScalableUIEventDispatcher.executeEvent` obtained by reflection (`getWMComponent().getScalableUIEventDispatcher()`); fallback `StateManager.handleEvent` and starts the returned animators itself. No LauncherRRO panel listens for this event. | `dispatchScalableEvent` |
| Indirect | `orientation_portrait` / `orientation_landscape` and `layout_variant_N` are posted by the watchers this class starts, not by this class. | `onControllerAttached` |
| VHAL | `HVAC_TEMPERATURE_SET`, `HVAC_TEMPERATURE_DISPLAY_UNITS`, `HVAC_SEAT_TEMPERATURE`, `HVAC_FAN_DIRECTION`, `HVAC_FAN_SPEED`, on-change, through `mVhalHelper` (one helper and one `Car` connection per instance). Subscribed in `onControllerAttached` and again in `applyVhalConnectedState`, because attach can run before `CarPropertyManager` exists. | `mHvacCallback` |
| VHAL connection | `onVhalConnected` / `onVhalDisconnected` (base) → `applyVhalConnectedState` (hide `sysui_header_vhal_scrim`, resubscribe, reread, refresh) / `applyVhalDisconnectedState` (show scrim, disable buttons). | base + this class |
| UX restrictions | `CarUxRestrictionsManager` (base). Fully restricted → `sysui_header_ux_scrim` shown, all HVAC/seat/fan buttons disabled, design/climate launches refused (`launchClimatePanel`, `launchVehiclePanel` only). | `applyUxRestrictions` |
| View | Layout-change listeners on the status slots, the profile anchor and the chip container; global-layout listener on the chip host window. | `bindMainThreadPanel`, `wirePrivacyChips` |
| Not listened to | User switch. The user name is set at bind time only (*inferred*: it changes when the panel is rebuilt, e.g. on theme change). No `Settings` key is watched by this class. | — |

### Vehicle properties and permissions

Area ids are hardcoded: `AREA_DRIVER = VehicleAreaSeat.SEAT_ROW_1_LEFT` (`0x1`), `AREA_PASSENGER = VehicleAreaSeat.SEAT_ROW_1_RIGHT` (`0x4`). Permissions are not named in the code; the column gives the `CarPropertyManager` documentation requirement (*not from this repo*). CarSystemUI is platform-signed and is expected to hold them (*inferred*).

| Property | Read / write | Area id | Type / range used | Permission (platform docs) |
| --- | --- | --- | --- | --- |
| `HVAC_TEMPERATURE_SET` | Read (initial, before each step, after each write), write (`adjustHvac`), subscribe | Driver `0x1`, passenger `0x4` | Float, Celsius. Clamped to the area min/max from `CarPropertyConfig`. Config array read for the °C/°F step scale. | `android.car.permission.CONTROL_CAR_CLIMATE` |
| `HVAC_TEMPERATURE_DISPLAY_UNITS` | Read, subscribe | `0` (global) | Int; `VehicleUnit.FAHRENHEIT` → °F, anything else → °C | `CONTROL_CAR_CLIMATE` or `READ_CAR_DISPLAY_UNITS` |
| `HVAC_SEAT_TEMPERATURE` | Read, write (`adjustSeat`), subscribe | `0x1`, `0x4` | Int, clamped 0..3 in Java, then to config min/max | `CONTROL_CAR_CLIMATE` |
| `HVAC_FAN_DIRECTION` | Read, write (`setFanDirection`), subscribe | Driver `0x1` only | `CarHvacFanDirection.FACE / FLOOR / DEFROST` (bitmask for the active state) | `CONTROL_CAR_CLIMATE` |
| `HVAC_FAN_SPEED` | Read, write (`cycleFanSpeed`), subscribe | Driver `0x1` only | Int 1..7, wraps | `CONTROL_CAR_CLIMATE` |

On LauncherRRO only `HVAC_TEMPERATURE_SET` and `HVAC_TEMPERATURE_DISPLAY_UNITS` affect the screen; the other three are still subscribed and read because the code does not check whether their views exist.

Area-id caveat (*inferred*, check with `adb shell cmd car_service get-property-config`): a VHAL that declares HVAC zones as combined seat masks (for example `ROW_1_LEFT | ROW_2_LEFT`) does not have area `0x1` or `0x4`. Reads then return null, writes are rejected and logged, and change events for the combined area are ignored by `updateHvacDisplay`, so the pill stays at `--°`. Changing the area ids is a Java change.

Other permissions the class relies on (*platform requirements, inferred*; none are declared here): `MODIFY_DAY_NIGHT_MODE` for `setNightModeActivated`; `MANAGE_USERS` (or equivalent) for `UserManager.getUserInfo`; `INTERACT_ACROSS_USERS_FULL` for `startActivityAsUser` / `sendBroadcastAsUser` to the foreground user; `INTERNAL_SYSTEM_WINDOW` for window type 2017 and `setTrustedOverlay`.

### Hardcoded values to know about

All of these need a Java change; none can be overridden from the overlay except `RroPackage`.

| Value | Where | Meaning |
| --- | --- | --- |
| `com.android.systemui.rro.scalableUI.sysuiBars` | `DEFAULT_RRO_PACKAGE` | Overlay package when the controller XML has no `RroPackage`. LauncherRRO sets it. |
| `sysui_scalable_header_panel` | 1-arg constructor | Default panel id (not used by the factory). |
| Panel ids `oem_climate_card`, `sysui_driver_zone_panel`, `sysui_passenger_zone_panel`, `oem_car_status_card`, `launcher_pill_left`, `launcher_pill_center`, `launcher_pill_right` | `getLayoutResourceName`, `wireDesignScreen`, `wireClickListeners`, `wireStatusPills`, `wireUserProfile`, `wirePrivacyChips` | Behaviour is keyed on these exact strings. |
| Layout names in the table above | `getLayoutResourceName` | Looked up by name in the overlay. |
| Overlay ids: every id in the views table; drawables `ic_status_day`, `ic_status_night`, `oem_climate_btn`, `oem_climate_btn_active`; strings `launcher_light_theme`, `launcher_dark_theme` | `resolveRro*` | Renaming one in the overlay silently disconnects it. |
| Literal strings `"Light theme"`, `"Dark theme"`, `"Profile"`, `"Vehicle"`, `"Fan speed N"` | `updateNightModeIcon`, `currentUserName`, `wireClickListeners`, `refreshFanSpeedUi` | Untranslated fallbacks / content descriptions. |
| SystemUI layouts `qc_status_icons_horizontal`, `qc_connectivity_panel`, `qc_bluetooth_panel`, `qc_display_panel`, `qc_volume_panel`, `user_name_container`, `qc_profile_switcher`, `camera_privacy_chip`, `mic_privacy_chip`; dimen `privacy_chip_width` | `wireStatusPills`, `wireUserProfile`, `wirePrivacyChips` | Looked up in package `com.android.systemui`. A CarSystemUI build that renames them sends the pill to the Settings fallback. |
| Settings actions `ACTION_WIFI_SETTINGS`, `ACTION_BLUETOOTH_SETTINGS`, `ACTION_DISPLAY_SETTINGS`, `ACTION_SOUND_SETTINGS`, `ACTION_USER_SETTINGS` | `wireStatusPills`, `wireUserProfile` | Fallback screens. |
| Class-name suffixes `CarSystemBarPanelButtonView`, `PrivacyChip` | `findPanelButton`, `assignUniqueIds` | Matched with `endsWith`. |
| Reflection: field `mPanelLayoutRes`; fields `mSysUIComponent`, `mInitializer`, `carSystemBarElementInitializerProvider`; method `initializeCarSystemBarElements(ViewGroup)`; `StateManager.getPanelState` → `getCurrentVariant` → `getBounds`; `getWMComponent` → `getScalableUIEventDispatcher` → `executeEvent` | several | Private SystemUI internals. `carSystemBarElementInitializerProvider` is a Dagger-generated field name (*inferred*) and can change with the CarSystemUI build. |
| Window type `2017`, fallback `TYPE_APPLICATION_OVERLAY`; title `LauncherQcPanel`; view tag `"main-hosted"` | `ensureMainThreadHost`, `bindMainThreadPanel` | `LayoutVariantWatcher` matches the title. |
| `com.test.design`, `...glanceables.ClimatePanelActivity`, `...glanceables.VehiclePanelActivity`; actions `com.test.design.action.OPEN_CLIMATE`, `OPEN_VEHICLE` (base class constants) | `wireDesignScreen`, `launchClimatePanel`, `launchVehiclePanel` | Target of temperature-pill taps. A customer climate/vehicle app must be wired here. |
| Broadcast `com.android.systemui.car.action.TOGGLE_HVAC_PANEL` to package `com.android.systemui` | `launchClimatePanel` | Fallback to the stock HVAC panel. |
| Event `toggle_card_expand_climate` | `launchVehiclePanel` | Fallback event. |
| `SEAT_ROW_1_LEFT`, `SEAT_ROW_1_RIGHT` | `AREA_DRIVER`, `AREA_PASSENGER` | Left-hand-drive assumption. A right-hand-drive car shows driver on the left pill as the passenger setpoint (*inferred*). |
| Seat 0..3 step 1; fan 1..7; defaults 22.0 °C, seat 2, fan 3, `FACE` | constants and fields | Initial field values. Shown when VHAL returns nothing (see the note below). |
| 56 dp chip width fallback, 12 dp chip gap | `privacyChipWidth`, `privacyChipGap` | Profile pill spacing. |

Note on the defaults row: `onControllerAttached` calls `refreshAllDisplays()` even when no VHAL value was read, so the readout changes from `--°` to `22°` (or its °F equivalent) on attach regardless of VHAL. The `--°` placeholder is visible only before attach.

### Key methods

| Method | What it does |
| --- | --- |
| `Factory.create(panelId, metadata)` | One controller per panel; reads `RroPackage`. |
| `getLayoutResourceName()` | Panel id → overlay layout name. |
| `bindViews(root)` | Runs every bind/wire method below. |
| `wireStatusPills(root)` | Left pill: four stock quick-control buttons; then profile and privacy chips. |
| `bindMainThreadPanel(...)` | Moves a stock panel button into its own main-thread window over a slot, or wires the Settings fallback. |
| `placeMainThreadHost(...)` / `ensureMainThreadHost(...)` | Computes screen position from the panel's variant bounds; adds or updates the host window. |
| `initializeElements(group)` | Calls SystemUI's `CarSystemBarElementInitializer` by reflection so stock buttons and chips get their controllers. |
| `wirePrivacyChips(root)` / `syncPrivacySpacer(...)` | Hosts camera/mic chips; reserves pill space and toggles touchability while chips are visible. |
| `wireUserProfile(root)` / `currentUserName()` | Foreground user name; stock profile switcher. |
| `wireNightMode(root)` / `toggleNightMode(v)` | Dark/light toggle via `UiModeManager`. |
| `wireClickListeners()` | HVAC, seat, vent, fan buttons; climate header/readout listeners. |
| `wireDesignScreen(root)` | Makes the rest of each temperature pill open a `com.test.design` screen. |
| `adjustHvac(area, dir)` | Reads live setpoint, computes next step with `HvacTemperatureUnits`, clamps to VHAL range, skips the write at a bound, writes, rereads, updates text. |
| `adjustSeat`, `setFanDirection`, `cycleFanSpeed` | Other VHAL writes (no views on LauncherRRO). |
| `updateHvacDisplay(area, c)` / `refreshHvacButtons()` | Readout text; disables minus/plus at the VHAL min/max. |
| `readInitialValues()` / `readTemperatureDisplayUnit()` | Initial VHAL reads, display unit and step scale. |
| `applyUxRestrictions()`, `applyVhalConnectedState()`, `applyVhalDisconnectedState()` | Scrims and enabled state. |
| `dispatchScalableEvent(id)` | Posts an orchestrator event through the dispatcher (reflection). |
| `dumpControllerState(pw)` | Unit, both setpoints, seat, fan, layout name for `dumpsys`. |

---

## `HvacTemperatureUnits`

[`.../wm/scalableui/panel/controller/HvacTemperatureUnits.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits.java). Static utility, no state.

### Why it is needed

`HVAC_TEMPERATURE_SET` is always Celsius. The vehicle's display unit is a separate property, `HVAC_TEMPERATURE_DISPLAY_UNITS`. XML can only show a fixed string. Without this class the pill would show raw Celsius on a Fahrenheit car, or a naive `C × 9/5 + 32` that does not line up with the car's own climate screen (the class comment: that formula is one degree higher on the usual 17.5 °C = 60 °F range), and one press of plus would move 0.9 °F instead of one displayed degree.

### What it does

- `isFahrenheit(unit)`: true only for `VehicleUnit.FAHRENHEIT`.
- `format(celsius, fahrenheit, scale)`: pill text.
  - °F: `"%.0f°"` of the step-mapped Fahrenheit value: `minF + round((c − minC) / stepC) × stepF`. Without a scale, `c × 9/5 + 32`.
  - °C: whole numbers as `"22°"`, half steps as `"22.5°"` (avoids rounding 32.5 to 33).
  - Uses `Locale.getDefault()`.
- `nextSetpointCelsius(c, direction, fahrenheit, scale)`: snaps `c` to the Celsius step (`scale[1]`, default `0.5`) and adds `direction × step`. One Celsius config step is one displayed degree in either unit. The `fahrenheit` argument is not used.

`scale` is the four-value array from `CarVhalSubscriptionHelper.getHvacTemperatureScale()`: min °C, °C step, min °F, °F step.

### Lifecycle

None. Called from `CarSysuiScalableHeaderController` (`mHvacCallback`, `readTemperatureDisplayUnit`, `adjustHvac`, `updateHvacDisplay`) on whichever thread the caller is on.

### Views it wires / events / vehicle properties

None directly. It interprets values of `HVAC_TEMPERATURE_DISPLAY_UNITS` and `HVAC_TEMPERATURE_SET` that the header controller reads.

### Hardcoded values to know about

| Value | Meaning |
| --- | --- |
| `CELSIUS_STEP = 0.5f` | Step when the vehicle does not publish the six-value config array. |
| `"%.0f°"`, `"%.1f°"` | Pill text format; no unit letter. |
| `9/5 + 32` | Fallback conversion when no scale. |

### Key methods

| Method | What it does |
| --- | --- |
| `isFahrenheit(Integer)` | Display-unit test. |
| `format(float, boolean[, float[]])` | Setpoint → pill text. |
| `nextSetpointCelsius(float, int, boolean[, float[]])` | Next Celsius setpoint for one press. |
| `fahrenheitFromScale(float, float[])` | Step-index mapping to the °F scale (private). |

---

## `CarVhalSubscriptionHelper`

[`.../wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper.java).

### Why it is needed

The temperature pills need `CarPropertyManager`, which exists only after a `Car` connection is ready, can disappear when car service restarts, and throws on bad writes. An uncaught exception from a property write runs inside SystemUI and takes SystemUI down. The class comment and the device-dex notes say the write path was changed to catch a rejected write and log `Rejected float write` instead of crashing. Without the helper every controller would repeat connection handling, and a car-service restart would leave stale callbacks and dead buttons.

### What it does

- Opens a `Car` connection without waiting and reports connect/disconnect to listeners.
- Registers one callback per property id at `SENSOR_RATE_ONCHANGE`. Subscribing the same callback twice is a no-op; a different callback replaces the old one.
- Reads and writes float and int properties for an area id. Writes are clamped to the area min/max from `CarPropertyConfig` first; rejected writes return `false`.
- Exposes the area min/max (`getFloatRange`) and the HVAC step scale (`getHvacTemperatureScale`).
- On `stop()`, unregisters every callback and disconnects.

As the user sees it: the temperature buttons grey out when car service is not connected and come back when it reconnects; pressing plus at the maximum does nothing instead of crashing SystemUI.

### Lifecycle

- **Created by**: `CarSysuiScalableBarControllerBase` as a field (`mVhalHelper = new CarVhalSubscriptionHelper()`), one per controller instance. With five header panels plus the dock, that is one `Car` connection per DecorPanel controller (*counted from the code*; the base also opens a second `Car` for UX restrictions).
- **Start**: base `onPanelAttached` → `addConnectionListener(this)` then `start(context)`. `Car.createCar(context, mainHandler, CAR_WAIT_TIMEOUT_DO_NOT_WAIT, listener)`. If already connected, `onCarReady` runs immediately; the lifecycle listener may also report ready (subscribe is idempotent, so the second pass is harmless).
- **Stop**: base `onPanelDetached` → `removeConnectionListener`, `stop()`. `stop` runs before the subclass's `onControllerDetached`, so the header's own `unsubscribe` calls there find a null manager and return.
- **Car service death**: listener reports not-ready → `onCarDisconnected` clears the manager and the callback map (without unregistering) and notifies listeners. On reconnect, `onCarReady` notifies; the header resubscribes in `applyVhalConnectedState`.
- **Threads**: the lifecycle listener runs on the main looper (`mMainHandler`). Property callbacks are registered without an executor; delivery thread is car-service's default (*inferred: the `Car` handler, i.e. main*). Reads and writes are synchronous binder calls on the calling thread (the shell thread for button taps).

### Events and listeners

| Kind | What |
| --- | --- |
| Interface | `VhalConnectionListener.onVhalConnected()` / `onVhalDisconnected()`. `addConnectionListener` calls `onVhalConnected` at once if already connected. |
| Car | `Car.CarServiceLifecycleListener` (ready / not ready). |
| Properties | Whatever callers subscribe. The `areaId` argument of `subscribe` is ignored: registration is per property, all areas. |
| Events posted | None. |

`notifyDisconnected()` is also called on `CarNotConnectedException` during subscribe, read or write, and when `Car.createCar` throws.

### Vehicle properties and permissions

The helper is generic. The only property it names is `HVAC_TEMPERATURE_SET`, in `getHvacTemperatureScale`, which reads its config array (no value read; config access follows the property's read permission, `CONTROL_CAR_CLIMATE`, *per platform docs*). Config array layout used: `[0]` min °C×10, `[2]` °C step×10, `[3]` min °F×10, `[5]` °F step×10; returns `null` if fewer than six entries.

Error handling differs per method:

| Method | `CarNotConnectedException` | `SecurityException` | `IllegalArgumentException` | other |
| --- | --- | --- | --- | --- |
| `subscribe` | false, notify disconnected | false, logged | false, logged (callback stays in the map) | false |
| `getFloatProperty` | null, notify | null | null | null |
| `setFloatProperty` | false, notify | false | false, `Rejected float write` | false |
| `getIntProperty` | null, notify | **not caught** | **not caught** | **not caught** |
| `setIntProperty` | false, notify | false | false, `Rejected int write` | false |

`getIntProperty` is the odd one. The header calls it for `HVAC_TEMPERATURE_DISPLAY_UNITS`, `HVAC_SEAT_TEMPERATURE`, `HVAC_FAN_DIRECTION` and `HVAC_FAN_SPEED` on every attach. On a vehicle that does not support one of these or the area id, `CarPropertyManager` throws (*per its docs*), and that exception propagates out of `readInitialValues` into SystemUI (*inferred; not observed on the tablet, whose VHAL has these properties*).

### Hardcoded values to know about

| Value | Meaning |
| --- | --- |
| `Car.CAR_WAIT_TIMEOUT_DO_NOT_WAIT` | Does not block attach on car service. |
| `CarPropertyManager.SENSOR_RATE_ONCHANGE` | Rate for every subscription. |
| Config-array indexes 0, 2, 3, 5 and divide by 10 | HVAC scale layout assumed from the VHAL `HVAC_TEMPERATURE_SET` definition. |

### Key methods

| Method | What it does |
| --- | --- |
| `start(context)` / `stop()` | Open / close the `Car` connection; `stop` unregisters all callbacks. |
| `isConnected()` | Connected and manager present. |
| `addConnectionListener` / `removeConnectionListener` | Connection callbacks. |
| `subscribe(prop, area, cb)` / `unsubscribe(prop)` | On-change registration keyed by property id. |
| `getFloatProperty` / `getIntProperty` | Reads; null on failure (see table). |
| `setFloatProperty` / `setIntProperty` | Clamped writes; false on failure. |
| `getFloatRange(prop, area)` | `{min, max}` from config, or null. |
| `getHvacTemperatureScale()` | `{minC, stepC, minF, stepF}` or null. |

---

## `PanelOutsideHost`

[`.../systembar/panel/PanelOutsideHost.java`](../../systemui/CarSysuiScalableBarControllers/src/com/android/systemui/car/systembar/panel/PanelOutsideHost.java). Package `com.android.systemui.car.systembar.panel`, the same package as stock CarSystemUI's system-bar panel code. Static only.

### Why it is needed

A stock quick-control popup is a `PopupWindow` anchored to the button that opened it. In this design that button sits in a pill-sized window (a decor surface, or the main-thread host windows above), not in a full-width system bar. A popup anchored there is cropped to the pill or clamped to the wrong side. The device-dex notes: without this class a left-pill popup was clamped to the right because the surface is narrower than the panel. With variant 1 the pills are on the bottom edge and a popup opened below the anchor would be off-screen.

### What it does

`show(popup, anchor, xOff, yOff, gravity)`:

1. Gets (or creates) one full-screen host view on the default display.
2. Horizontal: if the anchor's centre is in the left half of the screen, the popup's left edge is 16 dp from the left; otherwise its right edge is 16 dp from the right. Popup width is `popup.getWidth()`, else the anchor width. The earlier `xOff` / `Gravity.RIGHT` computation is overwritten by this rule, so `xOff` and the horizontal part of `gravity` have no effect.
3. Vertical: by default just below the anchor plus `yOff` (`TOP|LEFT`). If the anchor's top is below the middle of the screen (variant 1 bottom pills), it uses `BOTTOM|LEFT` with `y = screenHeight − anchorTop + 16 dp`, so the popup's bottom edge sits 16 dp above the anchor.
4. `popup.setClippingEnabled(false)` and `popup.showAtLocation(host, gravity, x, y)`.
5. Logs `privacy panel at x,y ...` under tag `CarSysuiHeaderCtrl`.

As the user sees it: Wi-Fi/Bluetooth/volume/brightness popups open at the left edge under the status pill; the profile switcher and privacy panels open at the right edge under the profile pill; in layout set 1 they open above the bottom pills.

### Lifecycle

- **Who calls it**: no Java in this repo calls `PanelOutsideHost.show`. The device-dex notes say the class is in `classes5.dex` of the installed CarSystemUI alongside the header controller. The caller is stock CarSystemUI panel code, patched to call `show` instead of anchoring the popup itself (*inferred from the class comment "Matches PanelViewController.createPanel" and the package name; the call site is not in this repo or in `device-dex/systemui/smali/`*). An AOSP-tree build needs the same call added to the stock panel controller, or this class is inert.
- **Host window**: created lazily on first `show`, stored in a static `sHost`, recreated if no longer attached, never removed. Built from the application context with `createWindowContext(defaultDisplay, 2008, null)`.
- **Threads**: none of its own. Runs on the caller's thread; `wm.addView` binds the host to that thread's looper (*inferred: the main thread, where stock quick-control panels run*).

### Views it wires

One plain `View` added with `WindowManager`:

| Attribute | Value |
| --- | --- |
| Size | `MATCH_PARENT × MATCH_PARENT` |
| Type | `2008` (`TYPE_SYSTEM_DIALOG`; the comment says this matches `PanelViewController.createPanel`) |
| Flags | `FLAG_NOT_FOCUSABLE`, `FLAG_NOT_TOUCHABLE`, `FLAG_NOT_TOUCH_MODAL`, `FLAG_LAYOUT_IN_SCREEN` |
| Format / gravity | `TRANSLUCENT`, `TOP|LEFT` |
| Title | `scalable-panel-host` |
| Trusted overlay | `setTrustedOverlay()` by reflection (hidden API, accepted because SystemUI is platform-signed) |

The trusted-overlay flag matters: the comment says an untrusted overlay blocks touches to the map, widgets and apps even though the window is `NOT_TOUCHABLE`. If the reflection fails it is only logged, and touches below the full-screen window can then be blocked (*per the comment*).

### Events and listeners

None. No orchestrator events, no settings, no VHAL.

### Vehicle properties and permissions

No vehicle properties. Adding a type-2008 window and `setTrustedOverlay` need system-window privileges (`INTERNAL_SYSTEM_WINDOW`, *platform requirement, inferred*), which platform-signed SystemUI has.

### Hardcoded values to know about

| Value | Meaning |
| --- | --- |
| `TYPE_SYSTEM_DIALOG = 2008` | Host window type. |
| `Display.DEFAULT_DISPLAY` | Popups always go to display 0. |
| 16 dp | Edge margin and gap above a bottom anchor; matches the pill edge inset. |
| `screen.x / 2`, `screen.y / 2` | Left/right and top/bottom decision. |
| `"scalable-panel-host"`, log tag `CarSysuiHeaderCtrl` | Window title, log tag. |

### Key methods

| Method | What it does |
| --- | --- |
| `show(popup, anchor, xOff, yOff, gravity)` | Positions and shows the popup from the full-screen host. |
| `ensureHost(context)` | Creates or returns the static full-screen host window. |
| `markTrustedOverlay(lp)` | Calls hidden `setTrustedOverlay()` by reflection. |
