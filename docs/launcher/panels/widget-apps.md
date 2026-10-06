# Apps widget

`launcher_w_apps` in `overlays/LauncherRRO/res/xml/launcher_w_apps.xml`. Plate: `launcher_w_apps_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.apps/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/applauncher/` (package `com.scalableui.widgets.apps`).

Visible only in layout set 2, page 3, top slot (climate rectangle). `wpage_3` is alpha 1. Page 3 has no bottom card, so this page shows two widgets: this one and connections.

This is not the app grid. The grid is `panel_app_grid`, opened by the dock All apps button, on the right half of the screen, in every layout set. This widget is a card of app shortcuts inside the paged column.

Hidden in sets 0, 1, 3, and portrait. `layout_v2_away` while an app covers the column.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_3`.

Shared paging rules: [column-widgets.md](column-widgets.md).
