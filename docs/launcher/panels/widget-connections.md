# Connections widget

`launcher_w_connections` in `overlays/LauncherRRO/res/xml/launcher_w_connections.xml`. Plate: `launcher_w_connections_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.connections/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/connections/`.

Visible only in layout set 2, page 3, middle slot (media rectangle). `wpage_3` is alpha 1. The bottom slot on page 3 is empty.

This is not the header status pill. Wi-Fi and Bluetooth in the top-left pill open the stock quick-settings panels via `CarSysuiScalableHeaderController`. This widget is the connections card on the last column page.

Hidden in sets 0, 1, 3, and portrait. `layout_v2_away` while an app covers the column.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_3`.

Shared paging rules: [column-widgets.md](column-widgets.md).
