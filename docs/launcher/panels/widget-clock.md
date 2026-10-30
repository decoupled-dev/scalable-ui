# Clock widget

`launcher_w_clock` in `overlays/LauncherRRO/res/xml/launcher_w_clock.xml`. Plate: `launcher_w_clock_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.clock/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/clock/`.

Visible only in layout set 2, page 2, bottom slot (stats rectangle). `wpage_2` is alpha 1.

This is not the time in the header. That time is a `TextClock` inside DecorPanel `launcher_pill_center`, which is visible in every set. This widget is a larger clock card on page 2 only.

Hidden in sets 0, 1, 3, and portrait. `layout_v2_away` while an app covers the column.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_2`. The `TextClock` in the pill needs no panel transition and no widget process.

Shared paging rules: [column-widgets.md](column-widgets.md).
