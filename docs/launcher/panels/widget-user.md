# User widget

`launcher_w_user` in `overlays/LauncherRRO/res/xml/launcher_w_user.xml`. Plate: `launcher_w_user_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.user/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/user/`.

Visible only in layout set 2, page 2, middle slot (media rectangle). `wpage_2` is alpha 1.

This is not the header profile pill. The pill is DecorPanel `launcher_pill_right`, and its tap opens the stock profile switcher. This widget is an extra card in the paged column.

Hidden in sets 0, 1, 3, and portrait. `layout_v2_away` while an app covers the column.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_2`.

Shared paging rules: [column-widgets.md](column-widgets.md).
