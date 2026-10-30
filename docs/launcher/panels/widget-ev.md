# EV widget

`launcher_w_ev` in `overlays/LauncherRRO/res/xml/launcher_w_ev.xml`. Plate: `launcher_w_ev_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.ev/.WidgetActivity`. Default `hidden`. The activity is the EV card under `Widgets/ev/`. The panel only places the window.

Visible only in layout set 2, page 1, top slot (the climate rectangle, top 81.5–362.5 dp, right edge). `wpage_1` is alpha 1. `layout_v2` and the other pages are alpha 0, parked below the screen until page 1.

Sets 0, 1, 3, and portrait never leave `hidden`. There is no transition on `layout_variant_0`, `layout_variant_3`, `trex_*`, or `orientation_portrait` that would show it. `layout_variant_2` is what brings it from `hidden` onto the column.

Covered by an app: `layout_v2_away`, which is `hidden`. Home or an empty app panel returns it to the current page.

XML places it. `LayoutVariantWatcher` posts `widget_page_1` when the rail is dragged. The EV readout itself is `Widgets/ev`, not SystemUI.

Shared paging rules: [column-widgets.md](column-widgets.md).
