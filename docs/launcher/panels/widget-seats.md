# Seats widget

`launcher_w_seats` in `overlays/LauncherRRO/res/xml/launcher_w_seats.xml`. Plate: `launcher_w_seats_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.seats/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/seats/`.

Visible only in layout set 2, page 2, top slot (climate rectangle). `wpage_2` is alpha 1. On page 1 it is parked below the screen at alpha 0, which is why the first swipe does not show it yet.

Hidden in sets 0, 1, 3, and portrait. `layout_v2_away` while an app covers the column.

Seat heat on the old OEM climate card is a different control (`adjustSeat` in the header controller) and is not in the launcher temperature pills. This widget is the seats UI.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_2`.

Shared paging rules: [column-widgets.md](column-widgets.md).
