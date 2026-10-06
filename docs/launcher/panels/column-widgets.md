# Column widgets

Eight TaskPanels that exist for layout set 2. In sets 0, 1, 3, and in portrait they stay at the default pose `hidden` (not visible, alpha 0). They have no T-Rex pose and no portrait pose.

Each one is started at boot by a `config_default_activities` row, so the activity is alive before the user ever opens set 2. Entering set 2 runs `layout_variant_2`, which moves the panel from `hidden` to `layout_v2`. `layout_v2` is on the column's geometry but still alpha 0, except for the three home cards. The visible page is then chosen by `widget_page_N`.

Each task has a matching DecorPanel plate (`launcher_w_<name>_bg`) at layer 11. The task is layer 12. The plate copies the transitions and has no controller. Both files must stay in step.

The activity is a `WidgetActivity` under `Widgets/<name>/`. That code draws the card. It does not choose the rectangle. SystemUI does not draw these cards.

Paging is `LayoutVariantWatcher`. A 48 dp window (`TYPE_SYSTEM_DIALOG`) sits in the gap at the left of the column. Dragging it posts `widget_page_0` … `widget_page_3`. The rail is not in the overlay XML. Hiding it while an app covers the column is also that class (`widgetColumnCovered`, `mapInNavigation`).

Slots, top to bottom, reuse the climate / media / stats rectangles. A card that is off the current page sits above the screen or below it at alpha 0.

| Panel | Activity package | Visible on | Slot |
| --- | --- | --- | --- |
| `launcher_w_ev` | `com.scalableui.widgets.ev` | page 1 | top |
| `launcher_w_lights` | `com.scalableui.widgets.lights` | page 1 | middle |
| `launcher_w_phone` | `com.scalableui.widgets.phone` | page 1 | bottom |
| `launcher_w_seats` | `com.scalableui.widgets.seats` | page 2 | top |
| `launcher_w_user` | `com.scalableui.widgets.user` | page 2 | middle |
| `launcher_w_clock` | `com.scalableui.widgets.clock` | page 2 | bottom |
| `launcher_w_apps` | `com.scalableui.widgets.apps` | page 3 | top |
| `launcher_w_connections` | `com.scalableui.widgets.connections` | page 3 | middle |

Page 3 has no bottom card. Page 0 is climate, media, and stats, documented separately. On pages 1–3 those three sit above the screen at alpha 0.

`layout_v2_away` is `hidden`. TaskOpen for the app grid or any of the four app panels (`launcher_app`, climate, vehicle, settings) goes there. Empty-panel and Home return the card to the page it was on.

## XML and SystemUI, for every one of these

| Change | Where |
| --- | --- |
| Which page and which slot | The widget's `launcher_w_*.xml` and its `_bg` file. Alpha 1 on `wpage_N` plus the top/bottom dimens is the whole placement. |
| Register the window and start the activity | `window_states` and `config_default_activities` in `config.xml`. A new widget that is missing from `window_states` never gets a surface. |
| Card contents, car-property reads, icons | `Widgets/<name>/`. |
| The scrollbar, the page count, hiding the rail | `LayoutVariantWatcher`. `WIDGET_PAGE_COUNT` is 4. |
| Show them in set 0 or in T-Rex | New variants and transitions in the panel XML, on events that Java already posts (`layout_variant_0`, `trex_home`, …). No Java change unless the trigger itself is new. |

Per-widget notes: [ev](widget-ev.md), [lights](widget-lights.md), [phone](widget-phone.md), [seats](widget-seats.md), [user](widget-user.md), [clock](widget-clock.md), [apps](widget-apps.md), [connections](widget-connections.md).
