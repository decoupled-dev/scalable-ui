# Phone widget

`launcher_w_phone` in `overlays/LauncherRRO/res/xml/launcher_w_phone.xml`. Plate: `launcher_w_phone_bg`.

TaskPanel, layer 12, role `com.scalableui.widgets.phone/.WidgetActivity`. Default `hidden`. UI lives in `Widgets/phone/`.

Visible only in layout set 2, page 1, bottom slot (stats rectangle, top 673.5–954.5 dp). `wpage_1` is alpha 1.

This is not the old `oem_phone_card` dialer path still present in `CarSysuiScalableFooterController.ensurePhoneCardDialer`. The launcher overlay does not register `oem_phone_card`. The phone surface on this layout is this widget, and only on set 2 page 1.

Hidden in sets 0, 1, 3, and portrait. App-open uses `layout_v2_away`.

XML chooses the slot. `LayoutVariantWatcher` posts `widget_page_1`.

Shared paging rules: [column-widgets.md](column-widgets.md).
