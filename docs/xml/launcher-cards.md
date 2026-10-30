# LauncherRRO panel XML: widget cards

This page covers the 22 card files in `overlays/LauncherRRO/res/xml/`: 11 cards, each paired with a plate. For the orchestrator itself (variants, transitions, who posts events) read [GUIDE.md](../launcher/GUIDE.md) first.

**Card + plate.** Every card is a pair of windows with the same geometry and the same transitions:

- The card is a **TaskPanel** on layer 12 that hosts an activity.
- The plate is a **DecorPanel** on layer 11 with role `@layout/launcher_widget_card_bg`. That layout is a `FrameLayout` with the `launcher_widget_card_bg` drawable: a solid `launcher_surface` fill, a 16 dp corner and a `launcher_stroke` border. The plate has no controller, so it is only an opaque rectangle. It keeps the map from showing through if the hosted window is translucent.
- The card bounds use the `*_in` dimens, which sit 1.5 dp inside the plate on every edge (1 dp in `values-night/dimens.xml`). The task corner is 14.5 dp (15 dp at night) against the plate's 16 dp, so the plate's stroke shows around the card like a border.
- `config.xml` lists all plates in `window_states` before the cards. Each card's activity is started at boot by a `config_default_activities` row.

Because each pair is two files, any bounds or transition change must be made in both files.

**Two groups of cards.**

- **Home cards** (`launcher_widget_climate`, `_media`, `_stats`) host `com.test.design` glanceables. They are visible by default in sets 0 and 1. They also have portrait, set 2 and T-Rex (set 3) poses.
- **Column widgets** (`launcher_w_*`) host the `Widgets/` apps (`com.scalableui.widgets.*`). They default to `hidden` and appear only in set 2.

**Paging in set 2.** The right column has three slots. Each slot reuses one home-card rectangle:

| Slot | Plate top–bottom (dp) | Card top–bottom (dp) |
| --- | --- | --- |
| Top | 80–364 | 81.5–362.5 |
| Middle | 376–660 | 377.5–658.5 |
| Bottom | 672–956 | 673.5–954.5 |

All slots are 464 dp wide. The left edge is 480 dp in from the right edge of the canvas and the right edge keeps a 16 dp margin. A card has alpha 1 only on its own page:

| Page | Top | Middle | Bottom |
| --- | --- | --- | --- |
| 0 (`layout_v2`) | climate | media | stats |
| 1 (`wpage_1`) | ev | lights | phone |
| 2 (`wpage_2`) | seats | user | clock |
| 3 (`wpage_3`) | apps | connections | empty |

Cards that are not on the current page wait off-screen at alpha 0. Cards from earlier pages wait above the screen (`launcher_v2_above_*`, plate −320 to −36 dp). Cards from later pages wait below it (`launcher_v2_below_*`, plate 1100–1384 dp). Switching pages slides cards between those positions over 350 ms.

`LayoutVariantWatcher` posts `widget_page_0`…`widget_page_3` from its drag rail. The rail is a 48 dp `TYPE_SYSTEM_DIALOG` window, not overlay XML. `WIDGET_PAGE_COUNT` is 4. The column pages and the rail are described in [column-widgets.md](../launcher/panels/column-widgets.md) and [GUIDE.md § Variant 2 pages](../launcher/GUIDE.md#variant-2-pages).

## Contents

| File | Card | Type | Purpose |
| --- | --- | --- | --- |
| [`launcher_widget_climate.xml`](#resxmllauncher_widget_climatexml) | climate | TaskPanel | Climate glanceable; top of the column, page 0, T-Rex left |
| [`launcher_widget_climate_bg.xml`](#resxmllauncher_widget_climate_bgxml) | climate | DecorPanel | Plate under the climate card |
| [`launcher_widget_media.xml`](#resxmllauncher_widget_mediaxml) | media | TaskPanel | Media glanceable; middle of the column, page 0, T-Rex centre |
| [`launcher_widget_media_bg.xml`](#resxmllauncher_widget_media_bgxml) | media | DecorPanel | Plate under the media card |
| [`launcher_widget_stats.xml`](#resxmllauncher_widget_statsxml) | stats | TaskPanel | Vehicle/driving-stats glanceable; bottom of the column, page 0, T-Rex right |
| [`launcher_widget_stats_bg.xml`](#resxmllauncher_widget_stats_bgxml) | stats | DecorPanel | Plate under the stats card |
| [`launcher_w_ev.xml`](#resxmllauncher_w_evxml) | ev | TaskPanel | EV widget, set 2 page 1 top |
| [`launcher_w_ev_bg.xml`](#resxmllauncher_w_ev_bgxml) | ev | DecorPanel | Plate under ev |
| [`launcher_w_lights.xml`](#resxmllauncher_w_lightsxml) | lights | TaskPanel | Lights widget, page 1 middle |
| [`launcher_w_lights_bg.xml`](#resxmllauncher_w_lights_bgxml) | lights | DecorPanel | Plate under lights |
| [`launcher_w_phone.xml`](#resxmllauncher_w_phonexml) | phone | TaskPanel | Phone widget, page 1 bottom |
| [`launcher_w_phone_bg.xml`](#resxmllauncher_w_phone_bgxml) | phone | DecorPanel | Plate under phone |
| [`launcher_w_seats.xml`](#resxmllauncher_w_seatsxml) | seats | TaskPanel | Seats widget, page 2 top |
| [`launcher_w_seats_bg.xml`](#resxmllauncher_w_seats_bgxml) | seats | DecorPanel | Plate under seats |
| [`launcher_w_user.xml`](#resxmllauncher_w_userxml) | user | TaskPanel | User widget, page 2 middle |
| [`launcher_w_user_bg.xml`](#resxmllauncher_w_user_bgxml) | user | DecorPanel | Plate under user |
| [`launcher_w_clock.xml`](#resxmllauncher_w_clockxml) | clock | TaskPanel | Clock widget, page 2 bottom |
| [`launcher_w_clock_bg.xml`](#resxmllauncher_w_clock_bgxml) | clock | DecorPanel | Plate under clock |
| [`launcher_w_apps.xml`](#resxmllauncher_w_appsxml) | apps | TaskPanel | App-shortcut widget, page 3 top |
| [`launcher_w_apps_bg.xml`](#resxmllauncher_w_apps_bgxml) | apps | DecorPanel | Plate under apps |
| [`launcher_w_connections.xml`](#resxmllauncher_w_connectionsxml) | connections | TaskPanel | Connections widget, page 3 middle |
| [`launcher_w_connections_bg.xml`](#resxmllauncher_w_connections_bgxml) | connections | DecorPanel | Plate under connections |

---

## `res/xml/launcher_widget_climate.xml`

- **Type:** TaskPanel, id `launcher_climate`, `displayId="0"`, default variant `visible`.
- **Layer:** 12. Corner `launcher_widget_task_corner` (14.5 dp). `Focus onTransition="false"`. `Restart policy="LAST" maxRetry="3"`.
- **Role:** `@string/launcher_climate_component` = `com.test.design/.presentation.ivi.glanceables.ClimateHomePanelActivity`. It is started at boot by `config_default_activities`. This is not the dock climate app (`ClimatePanelActivity` in `launcher_climate_app`).

**Purpose in the UI.** This is the climate glanceable card at the top of the right card column, over the map. It is the top card on page 0 of set 2 and the left card of the T-Rex home row. In portrait it is the left card of the bottom row. When an app, the app grid or fullscreen map covers the column, it slides off the right edge.

**Variants.** The numbers are card bounds (`*_in` dimens, light theme). Horizontal positions anchored to `100%` are measured from the right edge of the canvas.

| Variant | Position / size | Visible / alpha |
| --- | --- | --- |
| `base` | Top slot. Left edge 478.5 dp in from the right edge, right edge 17.5 dp in from it. Top 81.5 dp, bottom 362.5 dp (about 461×281 dp). | inherits / 1.0 |
| `visible` | `base` (sets 0 and 1, boot pose) | true / 1.0 |
| `hidden` | `base` | false / 0.0 |
| `apps_open` | Same top/bottom. Moved past the right edge: left 37.5 dp past the right edge, right 498.5 dp past it. | true / 0.0 |
| `portrait` | Absolute dp: 17.5–351.5 across, 1376.5–1593.5 down | true / 1.0 |
| `portrait_apps_open` | Same x as `portrait`, y 1708.5–1926.5 (below the portrait screen) | true / 0.0 |
| `layout_v2` | Same as `base`; set 2 page 0 | true / 1.0 |
| `wpage_1`, `wpage_2`, `wpage_3` | Above the screen (`launcher_v2_above_*`, −318.5 to −37.5 dp) | true / 0.0 |
| `layout_v2_away` | Same as `apps_open` | true / 0.0 |
| `layout_v3_home` | T-Rex row, left: 59.5–576.5 dp across, 391.5–672.5 dp down | true / 1.0 |
| `layout_v3_away`, `layout_v3_away_home` | Both are the same as `apps_open`. The names only record where to go back to (see below). | true / 0.0 |

The card never uses `isVisible="false"` when it moves off-screen; it only sets alpha 0. Because of that the hosted activity stays resumed. Only `hidden`, which setup uses, stops it.

**What moves it.** The covering panels are `panel_app_grid`, `launcher_app`, `launcher_climate_app`, `launcher_vehicle_app` and `launcher_settings_app`. A `_System_TaskOpenEvent` or `_System_TaskPanelEmptyEvent` for one of them is listed below as "app opens" or "app panel empties".

| Event | Posted by | Effect |
| --- | --- | --- |
| `_System_EnterSuwEvent` | system | Any variant goes to `hidden`. The first entry has no `fromVariant`. |
| `_System_ExitSuwEvent` | system | `hidden` goes to `visible`. |
| App opens (`_System_TaskOpenEvent`) | system | `visible`, `hidden` or `apps_open` go to `apps_open` over 400 ms. `portrait` goes to `portrait_apps_open`. `layout_v2` or `wpage_N` go to `layout_v2_away`. In T-Rex, `layout_v3_home` goes to `layout_v3_away_home` for the grid, `launcher_app` or the climate app, and to `layout_v3_away` for the vehicle or settings app. |
| `_System_OnHomeEvent` | system | `apps_open` or `hidden` go to `visible`. `portrait_apps_open` goes to `portrait`. `layout_v2_away` goes to `layout_v2`. Home has no T-Rex transition. |
| App panel empties (`_System_TaskPanelEmptyEvent`) | system | `apps_open` goes to `visible`. `portrait_apps_open` goes to `portrait`. `layout_v2_away` goes to `layout_v2`. In T-Rex this applies only for `launcher_app` and `launcher_climate_app`: `layout_v3_away_home` goes back to `layout_v3_home`, and `layout_v3_away` stays where it is. |
| `_System_TaskOpenEvent` for `map_panel` | system | `apps_open`, `portrait_apps_open` and `layout_v2_away` come back, to `visible`, `portrait` and `layout_v2`. |
| `_System_UserSwitchComplete` | system | Snaps back to the resting pose with duration 0. `apps_open` goes to `visible`, `layout_v2_away` to `layout_v2`, `portrait_apps_open` to `portrait`. |
| `toggle_fullscreen` | `CarSysuiScalableFooterController.toggleMapFullscreen` (dock map button, sets 0–2) | `visible`, `hidden`, `layout_v2` or `wpage_N` go to `apps_open` or `layout_v2_away`. `portrait` goes to `portrait_apps_open`. |
| `orientation_portrait` / `orientation_landscape` | `OrientationLayoutWatcher` | Every landscape pose maps to `portrait` or `portrait_apps_open`. Landscape returns only to `visible` or `apps_open`. `OrientationLayoutWatcher` then calls `LayoutVariantWatcher.onOrientationApplied`, which posts the selected `layout_variant_N` again. |
| `layout_variant_0`, `_1` | `LayoutVariantWatcher` | Set 2 or T-Rex poses go to `visible`. From `layout_v2_away` the card goes to `apps_open` with duration 0. |
| `layout_variant_2` | `LayoutVariantWatcher` | `visible`, `hidden` or `layout_v3_*` go to `layout_v2`. `apps_open` goes to `layout_v2_away`. Set 2 poses stay where they are. |
| `layout_variant_3` | `LayoutVariantWatcher` | `visible`, `hidden`, `apps_open`, set 2 poses or `layout_v2_away` go to `layout_v3_home`. |
| `widget_page_0`…`_3` | `LayoutVariantWatcher` rail; it posts the current page again when the column stops being covered | Moves between `layout_v2` and `wpage_1..3`, including from `layout_v2_away`. |
| `trex_nav`, `trex_vehicle`, `trex_split` / `trex_home` | `LayoutVariantWatcher.selectTrexMode`, called from the footer | `layout_v3_home` or `layout_v3_away_home` go to `layout_v3_away`. `trex_home` brings either away pose back to `layout_v3_home`. |

Notes and things that are unclear from the XML:

- **Second fullscreen toggle.** `toggle_fullscreen` has no transition from `apps_open` back to `visible`. On the second press the map returns to `opened`, but in sets 0 and 1 the card stays off-screen until Home, an app panel empties, or `map_panel` opens a task. In set 2 the rail's re-post of `widget_page_N` brings the column back.
- **Home in set 2.** Home and an empty app panel send `layout_v2_away` to `layout_v2`, which is page 0. The current page is restored only when `LayoutVariantWatcher`'s 400 ms rail tick posts `widget_page_<current>` again. The existing panel docs say "returns to the page it was on", which is true only after that tick.
- **Hidden card and an app.** The card moves from `hidden` to `apps_open` (visible, alpha 0) when an app opens. That includes the setup-wizard case.

**Related.** [climate-card.md](../launcher/panels/climate-card.md), [GUIDE.md](../launcher/GUIDE.md), plate [`launcher_widget_climate_bg.xml`](#resxmllauncher_widget_climate_bgxml), and the controller source in `systemui/CarSysuiScalableBarControllers/` (`LayoutVariantWatcher.java`, `OrientationLayoutWatcher.java`, `CarSysuiScalableFooterController.java`). The activity is in the external `com.test.design` app, not in this repo.

## `res/xml/launcher_widget_climate_bg.xml`

- **Type:** DecorPanel, id `launcher_widget_climate_bg`, default variant `visible`, layer 11, role `@layout/launcher_widget_card_bg`, corner `launcher_widget_corner` (16 dp). There is no `Restart` element and no controller.
- **Geometry:** the plate uses the dimens without `_in`. The top slot is 80–364 dp, the left edge is 480 dp in from the right edge, the right edge is 16 dp in, and the size is 464×284 dp. T-Rex left is 58–578 × 390–674 dp. Portrait is 16–353 × 1375–1595 dp. Off-screen is 36 / −500 dp past the right edge, and above the screen is −320 to −36 dp.
- **Variants and transitions:** the same variant ids, alpha and visibility as the card, and the same transition list line for line. See [`launcher_widget_climate.xml`](#resxmllauncher_widget_climatexml).

---

## `res/xml/launcher_widget_media.xml`

- **Type:** TaskPanel, id `launcher_media`, default variant `visible`. The rest is the same as climate: layer 12, corner 14.5 dp, focus off, `Restart LAST ×3`.
- **Role:** `@string/launcher_media_component` = `com.test.design/.presentation.ivi.glanceables.MediaHomePanelActivity`. It is started at boot.

**Purpose in the UI.** This is the media glanceable in the middle of the right column, and the centre card of the T-Rex home row. The dock has no media button, so this card is the home-screen playback UI. It moves with the other two home cards.

**Variants.** This file has the same variant set as climate, with these slot changes:

| Variant | Position / size | Visible / alpha |
| --- | --- | --- |
| `base` / `visible` / `layout_v2` | Middle slot, 377.5–658.5 dp down, same right-edge anchors as climate | true / 1.0 |
| `hidden` | middle slot | false / 0.0 |
| `apps_open`, `layout_v2_away`, `layout_v3_away*` | Middle slot rows, off past the right edge | true / 0.0 |
| `portrait` / `portrait_apps_open` | Centre portrait card, 366.5–700.5 dp across; rows as climate | true / 1.0, 0.0 |
| `wpage_1..3` | Above the screen | true / 0.0 |
| `layout_v3_home` | T-Rex row centre, 595.5–1112.5 × 391.5–672.5 dp | true / 1.0 |

**What moves it.** The transitions are identical to [climate](#resxmllauncher_widget_climatexml), including the same covering-panel list (the climate app counts as a cover here too) and the same oddities.

**Related.** [media-card.md](../launcher/panels/media-card.md) and plate [`launcher_widget_media_bg.xml`](#resxmllauncher_widget_media_bgxml).

## `res/xml/launcher_widget_media_bg.xml`

- **Type:** DecorPanel `launcher_widget_media_bg`, layer 11, role `@layout/launcher_widget_card_bg`, corner 16 dp, default `visible`.
- **Geometry:** the middle slot is 376–660 dp. T-Rex centre is 594–1114 dp. Portrait centre is 365–702 dp.
- **Variants and transitions:** the same as the card. See [`launcher_widget_media.xml`](#resxmllauncher_widget_mediaxml).

---

## `res/xml/launcher_widget_stats.xml`

- **Type:** TaskPanel, id `launcher_stats`, default variant `visible`. The rest is the same as climate: layer 12, corner 14.5 dp, focus off, `Restart LAST ×3`. Unlike the other two home cards, this file has no header comment.
- **Role:** `@string/launcher_stats_component` = `com.test.design/.presentation.ivi.glanceables.VehicleHomePanelActivity`. It is started at boot. This is not the dock Vehicle app (`VehiclePanelActivity` in `launcher_vehicle_app`).

**Purpose in the UI.** This is the vehicle/driving-stats glanceable at the bottom of the right column. It is the right card of the T-Rex home row and the right card of the portrait row.

**Variants.** This file has the same variant set as climate, with these slot changes:

| Variant | Position / size | Visible / alpha |
| --- | --- | --- |
| `base` / `visible` / `layout_v2` | Bottom slot, 673.5–954.5 dp down | true / 1.0 |
| `hidden` | bottom slot | false / 0.0 |
| `apps_open`, `layout_v2_away`, `layout_v3_away*` | Bottom slot rows, off past the right edge | true / 0.0 |
| `portrait` / `portrait_apps_open` | Right portrait card, 715.5–1049.5 dp across | true / 1.0, 0.0 |
| `wpage_1..3` | Above the screen | true / 0.0 |
| `layout_v3_home` | T-Rex row right, 1131.5–1648.5 × 391.5–672.5 dp | true / 1.0 |

**What moves it.** The transitions are identical to [climate](#resxmllauncher_widget_climatexml).

**Related.** [stats-card.md](../launcher/panels/stats-card.md) and plate [`launcher_widget_stats_bg.xml`](#resxmllauncher_widget_stats_bgxml).

## `res/xml/launcher_widget_stats_bg.xml`

- **Type:** DecorPanel `launcher_widget_stats_bg`, layer 11, role `@layout/launcher_widget_card_bg`, corner 16 dp, default `visible`.
- **Geometry:** the bottom slot is 672–956 dp. T-Rex right is 1130–1650 dp. Portrait right is 714–1051 dp.
- **Variants and transitions:** the same as the card. See [`launcher_widget_stats.xml`](#resxmllauncher_widget_statsxml).

---

## `res/xml/launcher_w_ev.xml`

This section describes behaviour that all eight `launcher_w_*` cards share. The sections after it list only what differs.

- **Type:** TaskPanel, id `launcher_w_ev`, `displayId="0"`, default variant **`hidden`**.
- **Layer:** 12. Corner 14.5 dp, focus off, `Restart LAST ×3`. `base` alpha is 0.
- **Role:** `@string/launcher_w_ev_component` = `com.scalableui.widgets.ev/.WidgetActivity`. It is started at boot by `config_default_activities`, so it is already running before set 2 is selected.

**Purpose in the UI.** This is the EV card in the paged column of set 2. It is fully visible only on page 1, in the top slot. In sets 0, 1 and 3 and in portrait it is not shown. The card draws itself from `Widgets/ev`; the panel supplies only the rectangle.

**Variants.**

| Variant | Position / size | Visible / alpha |
| --- | --- | --- |
| `base` | Below the screen (`launcher_v2_below_*`, 1101.5–1382.5 dp), same right-edge anchors as the column | inherits / 0.0 |
| `hidden` | `base` (boot pose; sets 0, 1, 3 and portrait) | false / 0.0 |
| `layout_v2` | `base`; set 2 page 0, parked below | true / 0.0 |
| `wpage_1` | Top slot, 81.5–362.5 dp | true / 1.0 |
| `wpage_2`, `wpage_3` | Above the screen, −318.5 to −37.5 dp | true / 0.0 |
| `layout_v2_away` | Same as `hidden` | false / 0.0 |

There are no portrait, T-Rex or `apps_open` variants. Unlike the home cards, `layout_v2_away` really hides the window (`isVisible="false"`). An app opening in set 2 therefore stops the widget activity, while the home cards stay resumed at alpha 0.

**What moves it.** In this table, "app opens" and "app panel empties" mean the same five covering panels as for the home cards.

| Event | Posted by | Effect |
| --- | --- | --- |
| `layout_variant_2` | `LayoutVariantWatcher` | `hidden` goes to `layout_v2` over 350 ms. Set 2 poses stay where they are. |
| `layout_variant_0`, `_1`, `_3` | `LayoutVariantWatcher` | Every set 2 pose goes to `hidden`. From `layout_v2_away` the duration is 0. |
| `widget_page_0`…`_3` | `LayoutVariantWatcher` rail | Moves between `layout_v2` and `wpage_1..3`. From `layout_v2_away` it goes straight to the requested page. |
| App opens (`_System_TaskOpenEvent`), `toggle_fullscreen` | system / `CarSysuiScalableFooterController` | `layout_v2` or `wpage_N` go to `layout_v2_away` over 400 ms. |
| `_System_OnHomeEvent`, app panel empties, `_System_TaskOpenEvent` for `map_panel` | system | `layout_v2_away` goes to `layout_v2`. That is the page 0 pose; the rail tick then posts the current page again. |
| `orientation_portrait` | `OrientationLayoutWatcher` | Every set 2 pose goes to `hidden`. There is no `orientation_landscape` transition; `onOrientationApplied` posts `layout_variant_2` again, which brings the card back. |
| `_System_EnterSuwEvent` | system | Set 2 poses go to `hidden`. There is no `_System_ExitSuwEvent` transition. |
| `_System_UserSwitchComplete` | system | Set 2 poses stay where they are. `layout_v2_away` goes to `layout_v2`. |

No `trex_*` event moves this card.

**Related.** [widget-ev.md](../launcher/panels/widget-ev.md), [column-widgets.md](../launcher/panels/column-widgets.md), module `Widgets/ev/`, and plate [`launcher_w_ev_bg.xml`](#resxmllauncher_w_ev_bgxml).

## `res/xml/launcher_w_ev_bg.xml`

- **Type:** DecorPanel `launcher_w_ev_bg`, layer 11, role `@layout/launcher_widget_card_bg`, corner 16 dp, default `hidden`.
- **Geometry:** plate dimens (`launcher_v2_below_*` 1100–1384 dp, top slot 80–364 dp, above the screen −320 to −36 dp).
- **Variants and transitions:** the same as the card. See [`launcher_w_ev.xml`](#resxmllauncher_w_evxml).

---

## `res/xml/launcher_w_lights.xml`

- **Type:** TaskPanel `launcher_w_lights`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.lights/.WidgetActivity`.

**Purpose in the UI.** This is the lights card, shown on set 2 page 1 in the middle slot.

**Variants.** `hidden`, `layout_v2` (below the screen, alpha 0), `wpage_2` and `wpage_3` (above the screen) and `layout_v2_away` are the same as [ev](#resxmllauncher_w_evxml). `wpage_1` is the middle slot, 377.5–658.5 dp, alpha 1.

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-lights.md](../launcher/panels/widget-lights.md), `Widgets/lights/`, and plate [`launcher_w_lights_bg.xml`](#resxmllauncher_w_lights_bgxml).

## `res/xml/launcher_w_lights_bg.xml`

DecorPanel `launcher_w_lights_bg`, layer 11, plate layout, 16 dp corner, default `hidden`. `wpage_1` is the middle slot, 376–660 dp. Everything else follows [lights](#resxmllauncher_w_lightsxml).

---

## `res/xml/launcher_w_phone.xml`

- **Type:** TaskPanel `launcher_w_phone`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.phone/.WidgetActivity`.

**Purpose in the UI.** This is the phone card, shown on set 2 page 1 in the bottom slot.

**Variants.** These are the same as [ev](#resxmllauncher_w_evxml), except that `wpage_1` is the bottom slot, 673.5–954.5 dp, alpha 1.

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-phone.md](../launcher/panels/widget-phone.md), `Widgets/phone/`, and plate [`launcher_w_phone_bg.xml`](#resxmllauncher_w_phone_bgxml).

## `res/xml/launcher_w_phone_bg.xml`

DecorPanel `launcher_w_phone_bg`, layer 11, plate layout, default `hidden`. `wpage_1` is the bottom slot, 672–956 dp. Everything else follows [phone](#resxmllauncher_w_phonexml).

---

## `res/xml/launcher_w_seats.xml`

- **Type:** TaskPanel `launcher_w_seats`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.seats/.WidgetActivity`.

**Purpose in the UI.** This is the seats card, shown on set 2 page 2 in the top slot.

**Variants.**

| Variant | Position | Visible / alpha |
| --- | --- | --- |
| `hidden`, `layout_v2_away` | below the screen | false / 0.0 |
| `layout_v2`, `wpage_1` | below the screen | true / 0.0 |
| `wpage_2` | top slot, 81.5–362.5 dp | true / 1.0 |
| `wpage_3` | above the screen | true / 0.0 |

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-seats.md](../launcher/panels/widget-seats.md), `Widgets/seats/`, and plate [`launcher_w_seats_bg.xml`](#resxmllauncher_w_seats_bgxml).

## `res/xml/launcher_w_seats_bg.xml`

DecorPanel `launcher_w_seats_bg`, layer 11, plate layout, default `hidden`. `wpage_2` is the top slot, 80–364 dp. Everything else follows [seats](#resxmllauncher_w_seatsxml).

---

## `res/xml/launcher_w_user.xml`

- **Type:** TaskPanel `launcher_w_user`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.user/.WidgetActivity`.

**Purpose in the UI.** This is the user/profile card, shown on set 2 page 2 in the middle slot.

**Variants.** These match [seats](#resxmllauncher_w_seatsxml), except that `wpage_2` is the middle slot, 377.5–658.5 dp, alpha 1.

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-user.md](../launcher/panels/widget-user.md), `Widgets/user/`, and plate [`launcher_w_user_bg.xml`](#resxmllauncher_w_user_bgxml).

## `res/xml/launcher_w_user_bg.xml`

DecorPanel `launcher_w_user_bg`, layer 11, plate layout, default `hidden`. `wpage_2` is the middle slot, 376–660 dp. Everything else follows [user](#resxmllauncher_w_userxml).

---

## `res/xml/launcher_w_clock.xml`

- **Type:** TaskPanel `launcher_w_clock`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.clock/.WidgetActivity`.

**Purpose in the UI.** This is the clock card, shown on set 2 page 2 in the bottom slot.

**Variants.** These match [seats](#resxmllauncher_w_seatsxml), except that `wpage_2` is the bottom slot, 673.5–954.5 dp, alpha 1.

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-clock.md](../launcher/panels/widget-clock.md), `Widgets/clock/`, and plate [`launcher_w_clock_bg.xml`](#resxmllauncher_w_clock_bgxml).

## `res/xml/launcher_w_clock_bg.xml`

DecorPanel `launcher_w_clock_bg`, layer 11, plate layout, default `hidden`. `wpage_2` is the bottom slot, 672–956 dp. Everything else follows [clock](#resxmllauncher_w_clockxml).

---

## `res/xml/launcher_w_apps.xml`

- **Type:** TaskPanel `launcher_w_apps`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.apps/.WidgetActivity`. The Gradle module is `Widgets/applauncher/`; its namespace and applicationId are `com.scalableui.widgets.apps`.

**Purpose in the UI.** This is the app-shortcut card, shown on set 2 page 3 in the top slot. It is not the app grid (`panel_app_grid`, opened by the dock All apps button).

**Variants.**

| Variant | Position | Visible / alpha |
| --- | --- | --- |
| `hidden`, `layout_v2_away` | below the screen | false / 0.0 |
| `layout_v2`, `wpage_1`, `wpage_2` | below the screen | true / 0.0 |
| `wpage_3` | top slot, 81.5–362.5 dp | true / 1.0 |

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-apps.md](../launcher/panels/widget-apps.md), `Widgets/applauncher/`, and plate [`launcher_w_apps_bg.xml`](#resxmllauncher_w_apps_bgxml).

## `res/xml/launcher_w_apps_bg.xml`

DecorPanel `launcher_w_apps_bg`, layer 11, plate layout, default `hidden`. `wpage_3` is the top slot, 80–364 dp. Everything else follows [apps](#resxmllauncher_w_appsxml).

---

## `res/xml/launcher_w_connections.xml`

- **Type:** TaskPanel `launcher_w_connections`, layer 12, default `hidden`.
- **Role:** `com.scalableui.widgets.connections/.WidgetActivity`.

**Purpose in the UI.** This is the connections card, shown on set 2 page 3 in the middle slot. It is the last card. The bottom slot on page 3 is empty, so the map shows there.

**Variants.** These match [apps](#resxmllauncher_w_appsxml), except that `wpage_3` is the middle slot, 377.5–658.5 dp, alpha 1.

**What moves it.** The transitions are identical to [ev](#resxmllauncher_w_evxml).

**Related.** [widget-connections.md](../launcher/panels/widget-connections.md), `Widgets/connections/`, and plate [`launcher_w_connections_bg.xml`](#resxmllauncher_w_connections_bgxml).

## `res/xml/launcher_w_connections_bg.xml`

DecorPanel `launcher_w_connections_bg`, layer 11, plate layout, default `hidden`. `wpage_3` is the middle slot, 376–660 dp. Everything else follows [connections](#resxmllauncher_w_connectionsxml).
