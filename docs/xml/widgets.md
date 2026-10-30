# Widgets app XML

This page covers every tracked XML file under [`Widgets/`](../../Widgets/README.md): the Gradle project that builds eight privileged AAOS apps whose `WidgetActivity` is hosted in a Scalable UI TaskPanel as a home-screen card (unit 464 x 284 dp, scaling 1x1 to 2x2). Read [`Widgets/README.md`](../../Widgets/README.md) first for sizes and component names.

Two kinds of app live here:

- **View-based (Java)**: `clock`, `user`, `applauncher` (package `com.scalableui.widgets.apps`), `connections`. Each has a `res/layout/widget.xml` that styles itself with the shared drawables, colors, and text styles from `car-prop`.
- **Compose (Kotlin)**: `ev`, `lights`, `phone`, `seats`. They have no layout XML. Their UI comes from `widget-ui` ([`WidgetChrome.kt`](../../Widgets/widget-ui/src/main/java/com/scalableui/widgets/ui/WidgetChrome.kt), [`WidgetIcons.kt`](../../Widgets/widget-ui/src/main/java/com/scalableui/widgets/ui/WidgetIcons.kt)), which hard-codes its colors and icons in Kotlin. From `car-prop` they use only the theme `Theme.Widget.Panel`.

Every app module depends on `car-prop` (`implementation(project(":car-prop"))` in each `build.gradle.kts`), so the `car-prop` resources merge into every APK. The components are bound to panels by `overlays/LauncherRRO/res/values/config.xml` and `overlays/LauncherRRO/res/values/strings.xml`.

All eight app manifests share one template. It is described once under [ev](#evsrcmainandroidmanifestxml); the other manifest sections list only what differs.

## Contents

| File | Purpose |
| --- | --- |
| [`car-prop/src/main/AndroidManifest.xml`](#car-propsrcmainandroidmanifestxml) | Empty library manifest |
| [`car-prop/src/main/res/color/widget_chip_text.xml`](#car-propsrcmainrescolorwidget_chip_textxml) | Selected/unselected chip text color (unused) |
| [`car-prop/src/main/res/color/widget_tile_icon_blue.xml`](#car-propsrcmainrescolorwidget_tile_icon_bluexml) | Tile icon tint: blue when selected, white otherwise |
| [`car-prop/src/main/res/color/widget_tile_state_blue.xml`](#car-propsrcmainrescolorwidget_tile_state_bluexml) | Tile state text: blue when selected, muted otherwise |
| [`car-prop/src/main/res/drawable/ic_widget_apps.xml`](#car-propsrcmainresdrawableic_widget_appsxml) | 3x3 grid icon for the Apps card header |
| [`car-prop/src/main/res/drawable/ic_widget_bluetooth.xml`](#car-propsrcmainresdrawableic_widget_bluetoothxml) | Bluetooth icon |
| [`car-prop/src/main/res/drawable/ic_widget_car.xml`](#car-propsrcmainresdrawableic_widget_carxml) | Car icon (unused) |
| [`car-prop/src/main/res/drawable/ic_widget_clock.xml`](#car-propsrcmainresdrawableic_widget_clockxml) | Clock icon for the Clock card header |
| [`car-prop/src/main/res/drawable/ic_widget_moon.xml`](#car-propsrcmainresdrawableic_widget_moonxml) | Moon icon in the Clock card's night pill |
| [`car-prop/src/main/res/drawable/ic_widget_user.xml`](#car-propsrcmainresdrawableic_widget_userxml) | Person icon for the User card |
| [`car-prop/src/main/res/drawable/ic_widget_wifi.xml`](#car-propsrcmainresdrawableic_widget_wifixml) | Wi-Fi icon |
| [`car-prop/src/main/res/drawable/widget_bg_cool.xml`](#car-propsrcmainresdrawablewidget_bg_coolxml) | Blue diagonal card background (Connections) |
| [`car-prop/src/main/res/drawable/widget_bg_night.xml`](#car-propsrcmainresdrawablewidget_bg_nightxml) | Navy diagonal card background (Clock) |
| [`car-prop/src/main/res/drawable/widget_bg_stats.xml`](#car-propsrcmainresdrawablewidget_bg_statsxml) | Slate diagonal card background (User) |
| [`car-prop/src/main/res/drawable/widget_bg_warm.xml`](#car-propsrcmainresdrawablewidget_bg_warmxml) | Brown diagonal card background (Apps) |
| [`car-prop/src/main/res/drawable/widget_chip.xml`](#car-propsrcmainresdrawablewidget_chipxml) | Chip shape, off state |
| [`car-prop/src/main/res/drawable/widget_chip_bg.xml`](#car-propsrcmainresdrawablewidget_chip_bgxml) | Chip on/off selector (unused) |
| [`car-prop/src/main/res/drawable/widget_chip_on.xml`](#car-propsrcmainresdrawablewidget_chip_onxml) | Chip shape, on state |
| [`car-prop/src/main/res/drawable/widget_pill.xml`](#car-propsrcmainresdrawablewidget_pillxml) | Translucent rounded pill (Clock night pill) |
| [`car-prop/src/main/res/drawable/widget_tile.xml`](#car-propsrcmainresdrawablewidget_tilexml) | Tile shape, off state; also the Apps cell background |
| [`car-prop/src/main/res/drawable/widget_tile_bg.xml`](#car-propsrcmainresdrawablewidget_tile_bgxml) | Tile on/off selector (Connections tiles) |
| [`car-prop/src/main/res/drawable/widget_tile_on.xml`](#car-propsrcmainresdrawablewidget_tile_onxml) | Tile shape, on state |
| [`car-prop/src/main/res/values-night/colors.xml`](#car-propsrcmainresvalues-nightcolorsxml) | Night color overrides (same values as day) |
| [`car-prop/src/main/res/values/colors.xml`](#car-propsrcmainresvaluescolorsxml) | Shared color palette |
| [`car-prop/src/main/res/values/styles.xml`](#car-propsrcmainresvaluesstylesxml) | Shared text styles (`Widget.*`) |
| [`car-prop/src/main/res/values/themes.xml`](#car-propsrcmainresvaluesthemesxml) | `Theme.Widget.Panel`, transparent window theme for every app |
| [`widget-ui/src/main/AndroidManifest.xml`](#widget-uisrcmainandroidmanifestxml) | Empty library manifest |
| [`ev/src/main/AndroidManifest.xml`](#evsrcmainandroidmanifestxml) | EV app manifest (the shared template) |
| [`ev/src/main/res/values/strings.xml`](#evsrcmainresvaluesstringsxml) | App label "EV" |
| [`lights/src/main/AndroidManifest.xml`](#lightssrcmainandroidmanifestxml) | Lights app manifest |
| [`lights/src/main/res/values/strings.xml`](#lightssrcmainresvaluesstringsxml) | App label "Lights" |
| [`phone/src/main/AndroidManifest.xml`](#phonesrcmainandroidmanifestxml) | Phone app manifest |
| [`phone/src/main/res/values/strings.xml`](#phonesrcmainresvaluesstringsxml) | App label "Phone" |
| [`seats/src/main/AndroidManifest.xml`](#seatssrcmainandroidmanifestxml) | Seats app manifest |
| [`seats/src/main/res/values/strings.xml`](#seatssrcmainresvaluesstringsxml) | App label "Seats" |
| [`user/src/main/AndroidManifest.xml`](#usersrcmainandroidmanifestxml) | User app manifest |
| [`user/src/main/res/layout/widget.xml`](#usersrcmainreslayoutwidgetxml) | User card: icon, driver name, vehicle line |
| [`user/src/main/res/values/strings.xml`](#usersrcmainresvaluesstringsxml) | App label "User" |
| [`clock/src/main/AndroidManifest.xml`](#clocksrcmainandroidmanifestxml) | Clock app manifest |
| [`clock/src/main/res/layout/widget.xml`](#clocksrcmainreslayoutwidgetxml) | Clock card: time, date, day/night pill |
| [`clock/src/main/res/values/strings.xml`](#clocksrcmainresvaluesstringsxml) | App label "Clock" |
| [`applauncher/src/main/AndroidManifest.xml`](#applaunchersrcmainandroidmanifestxml) | Apps app manifest |
| [`applauncher/src/main/res/layout/app_cell.xml`](#applaunchersrcmainreslayoutapp_cellxml) | One app cell: icon and label |
| [`applauncher/src/main/res/layout/widget.xml`](#applaunchersrcmainreslayoutwidgetxml) | Apps card: header, empty text, cell grid container |
| [`applauncher/src/main/res/values/strings.xml`](#applaunchersrcmainresvaluesstringsxml) | App label "Apps" |
| [`connections/src/main/AndroidManifest.xml`](#connectionssrcmainandroidmanifestxml) | Connections app manifest |
| [`connections/src/main/res/layout/widget.xml`](#connectionssrcmainreslayoutwidgetxml) | Connections card: Wi-Fi and Bluetooth toggle tiles |
| [`connections/src/main/res/values/strings.xml`](#connectionssrcmainresvaluesstringsxml) | App label "Connections" |
| [`permissions/privapp-permissions-com.scalableui.widgets.apps.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsappsxml) | Allowlist for Apps |
| [`permissions/privapp-permissions-com.scalableui.widgets.clock.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsclockxml) | Allowlist for Clock |
| [`permissions/privapp-permissions-com.scalableui.widgets.connections.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsconnectionsxml) | Allowlist for Connections |
| [`permissions/privapp-permissions-com.scalableui.widgets.ev.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsevxml) | Allowlist for EV |
| [`permissions/privapp-permissions-com.scalableui.widgets.lights.xml`](#permissionsprivapp-permissions-comscalableuiwidgetslightsxml) | Allowlist for Lights |
| [`permissions/privapp-permissions-com.scalableui.widgets.phone.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsphonexml) | Allowlist for Phone |
| [`permissions/privapp-permissions-com.scalableui.widgets.seats.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsseatsxml) | Allowlist for Seats |
| [`permissions/privapp-permissions-com.scalableui.widgets.user.xml`](#permissionsprivapp-permissions-comscalableuiwidgetsuserxml) | Allowlist for User |

---

## car-prop (shared)

`car-prop` is an Android library (namespace `com.scalableui.widgets.carprop`). Its Java side is [`CarProps.java`](../../Widgets/car-prop/src/main/java/com/scalableui/widgets/carprop/CarProps.java), a thin `CarPropertyManager` wrapper. Its resource side is the shared look for the view-based cards. Because every app module depends on it, these resources are merged into all eight APKs.

### `car-prop/src/main/AndroidManifest.xml`

- **What it is**: an empty `<manifest />`.
- **Purpose in the UI**: none. AGP needs a manifest for the library; the namespace comes from `build.gradle.kts`.
- **Key contents**: nothing.
- **Used by**: the Gradle build only.

### `car-prop/src/main/res/color/widget_chip_text.xml`

- **What it is**: color state list. `state_selected` gives `@color/widget_accent`, otherwise `@color/widget_text`.
- **Purpose in the UI**: chip label color that turns blue when the chip is selected.
- **Key contents**: two `<item>`s.
- **Used by**: nothing. No layout or source references it. It looks like a leftover from a chip control that no current card uses.

### `car-prop/src/main/res/color/widget_tile_icon_blue.xml`

- **What it is**: color state list. Selected gives `@color/widget_accent_blue`, otherwise `@color/widget_text` (white).
- **Purpose in the UI**: the large Wi-Fi and Bluetooth icons on the Connections card turn blue when that radio is on.
- **Key contents**: two `<item>`s.
- **Used by**: `connections/src/main/res/layout/widget.xml` (`android:tint` on both tile icons, which use `duplicateParentState` so they follow the tile's selected state).

### `car-prop/src/main/res/color/widget_tile_state_blue.xml`

- **What it is**: color state list. Selected gives `@color/widget_accent_blue`, otherwise `@color/widget_muted`.
- **Purpose in the UI**: the "On"/"Off" text under each Connections tile is blue when on and muted white when off.
- **Key contents**: two `<item>`s.
- **Used by**: `connections/src/main/res/layout/widget.xml` (`wifi_state`, `bluetooth_state`).

### `car-prop/src/main/res/drawable/ic_widget_apps.xml`

- **What it is**: 24 dp white vector, a 3x3 grid of squares (the Material "apps" shape).
- **Purpose in the UI**: header icon on the Apps card, tinted gold.
- **Key contents**: one white `<path>`; color comes from the layout's `android:tint`.
- **Used by**: `applauncher/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/ic_widget_bluetooth.xml`

- **What it is**: 24 dp white Bluetooth vector.
- **Purpose in the UI**: icon on the Connections card's Bluetooth tile.
- **Key contents**: one white `<path>`.
- **Used by**: `connections/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/ic_widget_car.xml`

- **What it is**: 24 dp white car vector.
- **Purpose in the UI**: none at present.
- **Key contents**: one white `<path>`.
- **Used by**: nothing. No layout or source references it.

### `car-prop/src/main/res/drawable/ic_widget_clock.xml`

- **What it is**: 24 dp white clock-face vector (ring plus hands, `fillType="evenOdd"` on the ring).
- **Purpose in the UI**: header icon on the Clock card, tinted gold.
- **Key contents**: two white `<path>`s.
- **Used by**: `clock/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/ic_widget_moon.xml`

- **What it is**: 24 dp white crescent moon vector.
- **Purpose in the UI**: leading icon inside the Clock card's Day/Night pill, tinted gold through `drawableTint`.
- **Key contents**: one white `<path>`.
- **Used by**: `clock/src/main/res/layout/widget.xml` (`android:drawableStart` on `@id/night`).

### `car-prop/src/main/res/drawable/ic_widget_user.xml`

- **What it is**: 24 dp white person vector.
- **Purpose in the UI**: the User card uses it twice: small in the header and at 72 dp in the center, both tinted mint.
- **Key contents**: one white `<path>`.
- **Used by**: `user/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/ic_widget_wifi.xml`

- **What it is**: 24 dp white Wi-Fi fan vector.
- **Purpose in the UI**: Connections card header icon (tinted blue) and the Wi-Fi tile icon (tinted by selector).
- **Key contents**: one white `<path>`.
- **Used by**: `connections/src/main/res/layout/widget.xml` (twice).

### `car-prop/src/main/res/drawable/widget_bg_cool.xml`

- **What it is**: rectangle `<shape>` with a 135 degree linear gradient from `#FF1E3348` to `#FF142230`.
- **Purpose in the UI**: full-bleed blue background of the Connections card. No corners: the TaskPanel clips the window.
- **Key contents**: one `<gradient>`. The same two colors are the `Seats` palette in `WidgetChrome.kt`.
- **Used by**: `connections/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/widget_bg_night.xml`

- **What it is**: rectangle with a 135 degree gradient `#FF1B2838` to `#FF101820`.
- **Purpose in the UI**: navy background of the Clock card.
- **Key contents**: one `<gradient>`.
- **Used by**: `clock/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/widget_bg_stats.xml`

- **What it is**: rectangle with a 135 degree gradient `#FF22303C` to `#FF141C24`.
- **Purpose in the UI**: slate background of the User card.
- **Key contents**: one `<gradient>`. The same colors are the `Ev` palette in `WidgetChrome.kt`.
- **Used by**: `user/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/widget_bg_warm.xml`

- **What it is**: rectangle with a 135 degree gradient `#FF483428` to `#FF2A1E18`.
- **Purpose in the UI**: warm brown background of the Apps card.
- **Key contents**: one `<gradient>`. The same colors are the `Lights` palette in `WidgetChrome.kt`.
- **Used by**: `applauncher/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/widget_chip.xml`

- **What it is**: rectangle, solid `@color/widget_control` (`#14FFFFFF`), 10 dp corners.
- **Purpose in the UI**: off state of a chip.
- **Key contents**: `<solid>`, `<corners>`.
- **Used by**: only `widget_chip_bg.xml`, which is itself unused.

### `car-prop/src/main/res/drawable/widget_chip_bg.xml`

- **What it is**: `<selector>`: `widget_chip_on` when selected, else `widget_chip`.
- **Purpose in the UI**: chip background that lights up when selected.
- **Key contents**: two `<item>`s.
- **Used by**: nothing. No layout or source references it.

### `car-prop/src/main/res/drawable/widget_chip_on.xml`

- **What it is**: rectangle, solid `@color/widget_chip_on` (`#337EC8FF`), 10 dp corners.
- **Purpose in the UI**: on state of a chip.
- **Key contents**: `<solid>`, `<corners>`. The drawable and the color share the name `widget_chip_on`; that is legal because they are different resource types.
- **Used by**: only `widget_chip_bg.xml` (unused).

### `car-prop/src/main/res/drawable/widget_pill.xml`

- **What it is**: rectangle, solid `#28FFFFFF`, 14 dp corners.
- **Purpose in the UI**: translucent pill behind the Clock card's Day/Night label.
- **Key contents**: `<solid>`, `<corners>`. It is not a selector, so it looks the same in both states.
- **Used by**: `clock/src/main/res/layout/widget.xml`.

### `car-prop/src/main/res/drawable/widget_tile.xml`

- **What it is**: rectangle, solid `#14FFFFFF`, 20 dp corners, 1 dp `#28FFFFFF` stroke.
- **Purpose in the UI**: faint glass tile. Off state of the Connections tiles, and the background of each app cell on the Apps card.
- **Key contents**: `<solid>`, `<corners>`, `<stroke>`.
- **Used by**: `widget_tile_bg.xml`, `applauncher/src/main/res/layout/app_cell.xml`.

### `car-prop/src/main/res/drawable/widget_tile_bg.xml`

- **What it is**: `<selector>`: `widget_tile_on` when selected, else `widget_tile`.
- **Purpose in the UI**: Connections tiles turn blue when Wi-Fi or Bluetooth is on. `WidgetActivity.java` calls `setSelected(...)` on the tile.
- **Key contents**: two `<item>`s.
- **Used by**: `connections/src/main/res/layout/widget.xml` (`@id/wifi`, `@id/bluetooth`).

### `car-prop/src/main/res/drawable/widget_tile_on.xml`

- **What it is**: rectangle, solid `#337EC8FF` (20% blue), 20 dp corners, 1.5 dp `#807EC8FF` stroke.
- **Purpose in the UI**: on state of a toggle tile.
- **Key contents**: `<solid>`, `<corners>`, `<stroke>`.
- **Used by**: `widget_tile_bg.xml`.

### `car-prop/src/main/res/values-night/colors.xml`

- **What it is**: night-mode qualifier overrides for six colors: `widget_card`, `widget_text`, `widget_muted`, `widget_control`, `widget_accent`, `widget_chip_on`.
- **Purpose in the UI**: in practice none. Every value is identical to the default in `values/colors.xml`, so switching to night mode changes nothing. It may be a placeholder for a future night palette; the file does not say.
- **Key contents**: six `<color>`s.
- **Used by**: the resource system when the UI mode is night; same consumers as `values/colors.xml`.

### `car-prop/src/main/res/values/colors.xml`

- **What it is**: the shared color palette. The comment says cards sit on the map and match the dark washes of the climate, media, and vehicle cards.
- **Purpose in the UI**: text, accent, and control colors for the view-based cards.
- **Key contents**:

  | Color | Value | Referenced by |
  | --- | --- | --- |
  | `widget_card` | `#FF141C24` | `widget_panel` alias only |
  | `widget_panel` | `@color/widget_card` | nothing |
  | `widget_text` | `#FFFFFFFF` | theme, styles, `app_cell.xml`, color selectors |
  | `widget_muted` | `#B3FFFFFF` | theme (`textColorSecondary`), `Widget.Caption`, `widget_tile_state_blue` |
  | `widget_control` | `#14FFFFFF` | `widget_chip.xml` (unused chain) |
  | `widget_accent` | `#FF7EC8FF` | `widget_chip_text.xml` (unused) |
  | `widget_chip_on` | `#337EC8FF` | `widget_chip_on.xml` drawable (unused chain) |
  | `widget_accent_mint` | `#FF8EE6C5` | User layout |
  | `widget_accent_gold` | `#FFE8B86D` | Clock and Apps layouts |
  | `widget_accent_green` | `#FF7DCEA0` | nothing |
  | `widget_accent_blue` | `#FF7EC8FF` | Connections layout, blue color selectors |
  | `widget_hairline` | `#33FFFFFF` | nothing |

  The Compose cards do not read these; `WidgetChrome.kt` repeats the same hex values as Kotlin constants (for example `MutedColor = 0xB3FFFFFF`, `Hairline = 0x33FFFFFF`).
- **Used by**: the files listed in the table.

### `car-prop/src/main/res/values/styles.xml`

- **What it is**: text styles under the parent `Widget` (`@android:style/TextAppearance`).
- **Purpose in the UI**: consistent type sizes for the view-based cards.
- **Key contents**:

  | Style | Look | Used by |
  | --- | --- | --- |
  | `Widget.Header` | 16 sp bold all caps, letter spacing 0.08 | card titles in clock, user, applauncher, connections |
  | `Widget.Hero` | 44 sp bold white | User `@id/name` |
  | `Widget.Time` | 60 sp bold white | Clock `@id/time` |
  | `Widget.Stat` | 28 sp bold white | nothing |
  | `Widget.Caption` | 16 sp muted | Clock date, User vehicle, Apps empty text |
  | `Widget.Label` | 18 sp bold white | nothing |
  | `Widget.TileTitle` | 20 sp bold white | Connections "Wi-Fi" / "Bluetooth" |

- **Used by**: the layouts in the table.

### `car-prop/src/main/res/values/themes.xml`

- **What it is**: `Theme.Widget.Panel`, parent `android:Theme.Material.NoActionBar`.
- **Purpose in the UI**: makes every widget window transparent so the card background (or the panel's plate) shows through, with no preview window, no dim, and white text by default.
- **Key contents**: transparent `windowBackground` and `colorBackground`, `windowIsTranslucent=true`, `backgroundDimEnabled=false`, `windowContentOverlay=@null`, transparent status and navigation bars, `windowDisablePreview=true`, `textColor`/`textColorPrimary` = `widget_text`, `textColorSecondary` = `widget_muted`.
- **Used by**: all eight app manifests, on `<application>` and on both activities.

---

## widget-ui

`widget-ui` is a Compose library (namespace `com.scalableui.widgets.ui`) with the shared card chrome: `WidgetScreen`, `WidgetPalettes`, `IconTile`, `StatPair`, `CallLine`, `Muted`, and `WidgetIcons`. It has no resource XML. Its colors and icons are defined in Kotlin, not in `car-prop`.

### `widget-ui/src/main/AndroidManifest.xml`

- **What it is**: an empty `<manifest />`.
- **Purpose in the UI**: none. It is required for the library module.
- **Key contents**: nothing.
- **Used by**: the Gradle build. The library is a dependency of `ev`, `lights`, `phone`, `seats`.

---

## ev

Compose app `com.scalableui.widgets.ev`. [`WidgetActivity.kt`](../../Widgets/ev/src/main/java/com/scalableui/widgets/ev/WidgetActivity.kt) shows battery percent (`EV_BATTERY_LEVEL` / `INFO_EV_BATTERY_CAPACITY`), range in km (`RANGE_REMAINING`), and two tap tiles that toggle `EV_CHARGE_PORT_OPEN` and `EV_CHARGE_SWITCH`.

### `ev/src/main/AndroidManifest.xml`

- **What it is**: the app manifest. The other seven apps use the same structure.
- **Purpose in the UI**: declares the card activity that a LauncherRRO TaskPanel hosts, plus a separate launcher entry.
- **Key contents**:
  - `<uses-feature android.hardware.type.automotive required="true">`.
  - Permissions: `android.car.permission.CAR_ENERGY` (battery level, charge state) and `android.car.permission.CAR_INFO` (`INFO_EV_BATTERY_CAPACITY`).
  - `<application>`: label `@string/app_name`, theme `@style/Theme.Widget.Panel`, `supportsRtl`.
  - `.WidgetActivity`: `exported`, `launchMode="singleTask"`, `taskAffinity="com.scalableui.widgets.ev.widget"`, `resizeableActivity="true"`, `excludeFromRecents="true"`, `configChanges="orientation|screenSize|screenLayout|smallestScreenSize|keyboardHidden|density"` so a panel resize (1x1 to 2x2) or density change does not recreate it. Meta-data `distractionOptimized=true` so it can run while driving. No intent filter: it is started by component name from the panel.
  - `.MainActivity`: same flags but `taskAffinity="...ev.main"`, not excluded from Recents, and has the `MAIN` / `LAUNCHER` / `APP_AUTOMOTIVE` filter. The separate affinity keeps a launcher tap from taking over the hosted widget task (as the README says). In code `MainActivity` is an empty subclass of `WidgetActivity`, defined in the same `.kt` file.
  - Unclear point: the tiles write `EV_CHARGE_PORT_OPEN` and `EV_CHARGE_SWITCH`. In AOSP, writing those normally needs `CONTROL_CAR_ENERGY_PORTS` and `CONTROL_CAR_ENERGY`, and neither is declared here. `CarProps.setBoolean` swallows the exception, so a denied write would fail silently. This has not been checked on a device.
- **Used by**: the build; `overlays/LauncherRRO/res/values/config.xml` binds `com.scalableui.widgets.ev/.WidgetActivity`.

### `ev/src/main/res/values/strings.xml`

`app_name` = "EV". Used by the manifest `android:label`. The card title "EV" is a literal in `WidgetActivity.kt`, not this string.

---

## lights

Compose app `com.scalableui.widgets.lights`. [`WidgetActivity.kt`](../../Widgets/lights/src/main/java/com/scalableui/widgets/lights/WidgetActivity.kt) shows a 2x2 grid of tiles (Cabin, Headlights, High beam, Hazards) that read and toggle `CABIN_LIGHTS_SWITCH`, `HEADLIGHTS_SWITCH`, `HIGH_BEAM_LIGHTS_SWITCH`, `HAZARD_LIGHTS_SWITCH` between 0 and 1.

### `lights/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.lights.widget` / `.main`.
- **Purpose in the UI**: hosts the Lights card.
- **Key contents**: permissions `android.car.permission.CONTROL_CAR_INTERIOR_LIGHTS` (cabin) and `android.car.permission.CONTROL_CAR_EXTERIOR_LIGHTS` (headlights, high beam, hazards). Whether these also cover reading every switch on this build is not verified; `CarProps` returns `null` on any failure, and the tile then shows as off.
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.lights/.WidgetActivity`.

### `lights/src/main/res/values/strings.xml`

`app_name` = "Lights". Used by the manifest label.

---

## phone

Compose app `com.scalableui.widgets.phone`. [`WidgetActivity.kt`](../../Widgets/phone/src/main/java/com/scalableui/widgets/phone/WidgetActivity.kt) queries `CallLog.Calls` and shows up to three recent calls (name or number plus time), or "No recent calls".

### `phone/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.phone.widget` / `.main`.
- **Purpose in the UI**: hosts the Phone card.
- **Key contents**: permission `android.permission.READ_CALL_LOG`. This is a runtime permission. The activity requests it at first composition, and `Widgets/scripts/deploy-all.sh` also runs `pm grant ... READ_CALL_LOG` after reboot.
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.phone/.WidgetActivity`.

### `phone/src/main/res/values/strings.xml`

`app_name` = "Phone". Used by the manifest label.

---

## seats

Compose app `com.scalableui.widgets.seats`. [`WidgetActivity.kt`](../../Widgets/seats/src/main/java/com/scalableui/widgets/seats/WidgetActivity.kt) shows three Material3 sliders (Slide, Height, Recline) for the driver seat (`SEAT_ROW_1_LEFT`). They write `SEAT_FORE_AFT_POS`, `SEAT_HEIGHT_POS`, and `SEAT_BACKREST_ANGLE_1_POS`, with ranges taken from the property config (`CarProps.intRange`).

### `seats/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.seats.widget` / `.main`.
- **Purpose in the UI**: hosts the Seats card.
- **Key contents**: permission `android.car.permission.CONTROL_CAR_SEATS` (read and write the seat positions).
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.seats/.WidgetActivity`.

### `seats/src/main/res/values/strings.xml`

`app_name` = "Seats". Used by the manifest label.

---

## user

View-based Java app `com.scalableui.widgets.user`. [`WidgetActivity.java`](../../Widgets/user/src/main/java/com/scalableui/widgets/user/WidgetActivity.java) shows the current Android user name (`UserManager.getUserName()`, falling back to "Driver") and a make/model line from `INFO_MAKE` / `INFO_MODEL`. Placeholder values such as "Toy Vehicle" or "cuttlefish" are filtered out.

### `user/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.user.widget` / `.main`. `MainActivity.java` is an empty subclass of `WidgetActivity`.
- **Purpose in the UI**: hosts the User card.
- **Key contents**: permission `android.car.permission.CAR_INFO` (`INFO_MAKE`, `INFO_MODEL`).
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.user/.WidgetActivity`.

### `user/src/main/res/layout/widget.xml`

- **What it is**: the User card layout, a vertical `LinearLayout` with background `@drawable/widget_bg_stats` and 18/16 dp padding.
- **Purpose in the UI**: a mint "USER" header, then a centered 72 dp person icon, the driver name in large type, and an optional vehicle caption.
- **Key contents**:
  - Header row: `ImageView` `@drawable/ic_widget_user` tinted `widget_accent_mint`, and a `TextView` styled `Widget.Header` with the literal text "User".
  - Center column (`layout_weight=1`, centered): 72 dp `ic_widget_user` icon; `@+id/name` (`Widget.Hero`, default text "Driver", single line, ellipsized); `@+id/vehicle` (`Widget.Caption`, `visibility="gone"` until a real make/model is known).
- **Used by**: `WidgetActivity.java` (`setContentView(R.layout.widget)`, `R.id.name`, `R.id.vehicle`).

### `user/src/main/res/values/strings.xml`

`app_name` = "User". Used by the manifest label. The layout header uses a hard-coded "User" instead.

---

## clock

View-based Java app `com.scalableui.widgets.clock`. [`WidgetActivity.java`](../../Widgets/clock/src/main/java/com/scalableui/widgets/clock/WidgetActivity.java) updates the time and long date once a second from the system clock, and listens to `VehiclePropertyIds.NIGHT_MODE` to set the pill to "Night" or "Day".

### `clock/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.clock.widget` / `.main`. `MainActivity.java` is an empty subclass.
- **Purpose in the UI**: hosts the Clock card.
- **Key contents**: permission `android.car.permission.CAR_INFO`. Unclear point: the only vehicle property the code reads is `NIGHT_MODE`, and in AOSP that property is guarded by `CAR_EXTERIOR_ENVIRONMENT`, not `CAR_INFO`. If the read is denied, `getBoolean` returns `null` and the pill shows "Night —". This has not been checked on a device.
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.clock/.WidgetActivity`.

### `clock/src/main/res/layout/widget.xml`

- **What it is**: the Clock card layout, a vertical `LinearLayout` with background `@drawable/widget_bg_night`.
- **Purpose in the UI**: a gold "CLOCK" header, a large centered time with the date under it, and a Day/Night pill at the bottom.
- **Key contents**:
  - Header: `ic_widget_clock` tinted `widget_accent_gold` and a `Widget.Header` text "Clock".
  - Center (`layout_weight=1`): `@+id/time` (`Widget.Time`, 60 sp, placeholder `--:--`), `@+id/date` (`Widget.Caption`).
  - `@+id/night`: `TextView` with background `@drawable/widget_pill`, `drawableStart` `@drawable/ic_widget_moon` tinted gold, gold bold 16 sp text, default "Night".
  - Note: the code calls `night.setSelected(...)`, but neither `widget_pill` nor the text color is a selector, so the selected state has no visible effect. Only the text changes. If `CarProps` fails to construct, the exception message is written into this pill.
- **Used by**: `WidgetActivity.java` (`R.layout.widget`, `R.id.time`, `R.id.date`, `R.id.night`).

### `clock/src/main/res/values/strings.xml`

`app_name` = "Clock". Used by the manifest label.

---

## applauncher

View-based Java app, package and namespace `com.scalableui.widgets.apps` (module name `applauncher`). [`WidgetActivity.java`](../../Widgets/applauncher/src/main/java/com/scalableui/widgets/apps/WidgetActivity.java) queries all `ACTION_MAIN` + `CATEGORY_LAUNCHER` activities with `MATCH_ALL`, sorts them by label, and shows the first four (`SHOWN = 4`) as a 2x2 grid of cells on each `onResume`. The cells are not clickable in the current code; the card only displays apps.

### `applauncher/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.apps.widget` / `.main`. `MainActivity.java` is an empty subclass.
- **Purpose in the UI**: hosts the Apps card.
- **Key contents**: permission `android.permission.QUERY_ALL_PACKAGES`. Without it, package visibility rules on API 30+ would hide most other apps from `queryIntentActivities`. No car permission is declared, and none is needed.
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.apps/.WidgetActivity`.

### `applauncher/src/main/res/layout/app_cell.xml`

- **What it is**: one horizontal `LinearLayout` cell, 72 dp tall, background `@drawable/widget_tile`, 14 dp side padding.
- **Purpose in the UI**: a single app entry on the Apps card: icon on the left, name on the right.
- **Key contents**: `@+id/icon` (40 dp `ImageView`, `fitCenter`); `@+id/label` (bold 18 sp, `@color/widget_text`, single line, ellipsized, weight 1).
- **Used by**: `WidgetActivity.java` (`inflate(R.layout.app_cell, row, false)`, then `R.id.icon` / `R.id.label`). The code overrides the cell's layout params to weight 1 inside a row, so the cell's own 72 dp height is replaced by `MATCH_PARENT`.

### `applauncher/src/main/res/layout/widget.xml`

- **What it is**: the Apps card layout, a vertical `LinearLayout` with background `@drawable/widget_bg_warm`.
- **Purpose in the UI**: a gold "APPS" header above a grid of up to four app cells, or "No launcher apps" when the query returns nothing.
- **Key contents**: header row (`ic_widget_apps` tinted `widget_accent_gold`, `Widget.Header` text "Apps"); `@+id/empty` (`Widget.Caption`, "No launcher apps", `gone` by default); `@+id/list` (empty vertical `LinearLayout`, weight 1, that the code fills with horizontal rows of cells).
- **Used by**: `WidgetActivity.java` (`R.layout.widget`, `R.id.list`, `R.id.empty`).

### `applauncher/src/main/res/values/strings.xml`

`app_name` = "Apps". Used by the manifest label. The header text and empty message in `widget.xml` are hard-coded literals.

---

## connections

View-based Java app `com.scalableui.widgets.connections`. [`WidgetActivity.java`](../../Widgets/connections/src/main/java/com/scalableui/widgets/connections/WidgetActivity.java) shows Wi-Fi and Bluetooth on/off, refreshes on `WIFI_STATE_CHANGED_ACTION` / `BluetoothAdapter.ACTION_STATE_CHANGED`, and toggles each radio on tap (`WifiManager.setWifiEnabled`, `BluetoothAdapter.enable/disable`, both deprecated APIs).

### `connections/src/main/AndroidManifest.xml`

- **What it is**: app manifest, same template as [ev](#evsrcmainandroidmanifestxml) with affinities `com.scalableui.widgets.connections.widget` / `.main`. `MainActivity.java` is an empty subclass.
- **Purpose in the UI**: hosts the Connections card.
- **Key contents**: permissions `android.permission.ACCESS_WIFI_STATE` (read `isWifiEnabled`), `android.permission.CHANGE_WIFI_STATE` (`setWifiEnabled`), and `android.permission.BLUETOOTH_CONNECT` (`isEnabled`, `enable`, `disable`). `BLUETOOTH_CONNECT` is a runtime permission: the activity requests it in `onStart`, and `deploy-all.sh` runs `pm grant`.
- **Used by**: build; LauncherRRO binds `com.scalableui.widgets.connections/.WidgetActivity`.

### `connections/src/main/res/layout/widget.xml`

- **What it is**: the Connections card layout, a vertical `LinearLayout` with background `@drawable/widget_bg_cool`.
- **Purpose in the UI**: a blue "CONNECTIONS" header above two side-by-side toggle tiles, Wi-Fi and Bluetooth. Each tile shows a 52 dp icon, a title, and "On"/"Off". The tile turns blue when the radio is on.
- **Key contents**:
  - Header: `ic_widget_wifi` tinted `widget_accent_blue`, `Widget.Header` text "Connections".
  - `@+id/wifi` and `@+id/bluetooth`: clickable, focusable vertical `LinearLayout`s, weight 1 each, background `@drawable/widget_tile_bg`. Each holds an `ImageView` tinted `@color/widget_tile_icon_blue`, a `Widget.TileTitle` label, and a state `TextView` (`@+id/wifi_state`, `@+id/bluetooth_state`, 17 sp, `@color/widget_tile_state_blue`, default "Off"). The icon and state text use `duplicateParentState="true"`, so the tile's `selected` state drives their colors.
- **Used by**: `WidgetActivity.java` (`R.layout.widget`, `R.id.wifi`, `R.id.bluetooth`, `R.id.wifi_state`, `R.id.bluetooth_state`; `setSelected` on the tiles).

### `connections/src/main/res/values/strings.xml`

`app_name` = "Connections". Used by the manifest label.

---

## Permissions

`Widgets/permissions/` holds one `privapp-permissions-<package>.xml` per app. Each is a `<permissions><privapp-permissions package="...">` block that lists the permissions the system may grant to that privileged app. `Widgets/scripts/deploy-all.sh` pushes each APK to `/system/priv-app/Widgets<Name>/` and its file to `/system/etc/permissions/`, then reboots so the grants apply. The CLAUDE.md warns that a privileged app without its allowlist can crash-loop the device.

Each file lists exactly the `<uses-permission>` set of its manifest. The allowlist only matters for permissions with privileged protection. Normal permissions (for example the Wi-Fi state ones) are granted anyway. Runtime permissions (`READ_CALL_LOG`, `BLUETOOTH_CONNECT`) still need a user or `pm grant` grant, which `deploy-all.sh` does after the reboot. The files do not say which of their entries are actually privileged.

### `permissions/privapp-permissions-com.scalableui.widgets.apps.xml`

Grants `android.permission.QUERY_ALL_PACKAGES` to `com.scalableui.widgets.apps`, so the Apps card can list every launcher activity.

### `permissions/privapp-permissions-com.scalableui.widgets.clock.xml`

Grants `android.car.permission.CAR_INFO` to `com.scalableui.widgets.clock`. The code reads only `NIGHT_MODE`; see the permission note under the [clock manifest](#clocksrcmainandroidmanifestxml).

### `permissions/privapp-permissions-com.scalableui.widgets.connections.xml`

Grants `android.permission.BLUETOOTH_CONNECT`, `android.permission.ACCESS_WIFI_STATE`, and `android.permission.CHANGE_WIFI_STATE` to `com.scalableui.widgets.connections`, for reading and toggling Wi-Fi and Bluetooth.

### `permissions/privapp-permissions-com.scalableui.widgets.ev.xml`

Grants `android.car.permission.CAR_ENERGY` and `android.car.permission.CAR_INFO` to `com.scalableui.widgets.ev`, for battery level, capacity, range, and charge-port/charge state. No write permission for the Port/Charge tiles is listed; see the [ev manifest](#evsrcmainandroidmanifestxml).

### `permissions/privapp-permissions-com.scalableui.widgets.lights.xml`

Grants `android.car.permission.CONTROL_CAR_INTERIOR_LIGHTS` and `android.car.permission.CONTROL_CAR_EXTERIOR_LIGHTS` to `com.scalableui.widgets.lights`, for the cabin, headlight, high-beam, and hazard switches.

### `permissions/privapp-permissions-com.scalableui.widgets.phone.xml`

Grants `android.permission.READ_CALL_LOG` to `com.scalableui.widgets.phone`, for the recent-calls list. Because it is a runtime permission, `deploy-all.sh` also grants it with `pm grant`.

### `permissions/privapp-permissions-com.scalableui.widgets.seats.xml`

Grants `android.car.permission.CONTROL_CAR_SEATS` to `com.scalableui.widgets.seats`, for reading and moving the driver seat slide, height, and recline.

### `permissions/privapp-permissions-com.scalableui.widgets.user.xml`

Grants `android.car.permission.CAR_INFO` to `com.scalableui.widgets.user`, for `INFO_MAKE` / `INFO_MODEL` on the vehicle line.
