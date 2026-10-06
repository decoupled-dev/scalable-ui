# Lights widget

`launcher_w_lights` in `overlays/LauncherRRO/res/xml/launcher_w_lights.xml`. Plate: `launcher_w_lights_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.lights/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/lights/`.

Visible only in layout set 2, page 1, middle slot (media rectangle, top 377.5–658.5 dp). `wpage_1` is alpha 1.

Hidden in sets 0, 1, 3, and portrait. `layout_variant_2` moves it from `hidden` to the column at alpha 0 until page 1. An open app sends it to `layout_v2_away`.

XML chooses the slot. `LayoutVariantWatcher` posts the page event and owns the rail.

Shared paging rules: [column-widgets.md](column-widgets.md).
