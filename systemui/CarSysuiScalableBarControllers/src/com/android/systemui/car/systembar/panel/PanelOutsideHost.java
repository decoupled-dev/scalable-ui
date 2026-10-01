package com.android.systemui.car.systembar.panel;

import android.content.Context;
import android.graphics.PixelFormat;
import android.hardware.display.DisplayManager;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.PopupWindow;

/**
 * The privacy chip lives in a small decor surface. A popup anchored to that
 * surface is cropped to the pill, so the quick-control panel is shown from a
 * full-screen host window instead.
 */
public final class PanelOutsideHost {
    /** Matches PanelViewController.createPanel (TYPE_SYSTEM_DIALOG). */
    private static final int TYPE_SYSTEM_DIALOG = 2008;
    private static View sHost;

    private PanelOutsideHost() {}

    public static void show(PopupWindow popup, View anchor, int xOff, int yOff, int gravity) {
        if (popup == null || anchor == null) {
            return;
        }
        View host = ensureHost(anchor.getContext());
        int[] loc = new int[2];
        anchor.getLocationOnScreen(loc);
        int popupWidth = popup.getWidth();
        if (popupWidth <= 0) {
            popupWidth = anchor.getWidth();
        }
        Display display = anchor.getContext().getSystemService(DisplayManager.class)
                .getDisplay(Display.DEFAULT_DISPLAY);
        android.graphics.Point screen = new android.graphics.Point();
        display.getRealSize(screen);

        int abs = Gravity.getAbsoluteGravity(gravity, anchor.getLayoutDirection());
        int x = loc[0] + xOff;
        if ((abs & Gravity.HORIZONTAL_GRAVITY_MASK) == Gravity.RIGHT) {
            x = loc[0] + anchor.getWidth() - popupWidth + xOff;
        }
        int y = loc[1] + anchor.getHeight() + yOff;
        int margin = Math.round(16f * anchor.getResources().getDisplayMetrics().density);
        // The panel is wider than any pill, so it follows the side the anchor
        // sits on: left-pill controls open on the left edge, the profile pill
        // on the right edge. The 16dp margin matches the pill edge inset.
        int anchorCenter = loc[0] + anchor.getWidth() / 2;
        if (anchorCenter < screen.x / 2) {
            x = margin;
        } else {
            x = Math.max(0, screen.x - popupWidth - margin);
        }
        if (y < 0) {
            y = 0;
        }
        popup.setClippingEnabled(false);
        Log.i("CarSysuiHeaderCtrl", "privacy panel at " + x + "," + y
                + " size " + popupWidth + " screen " + screen.x
                + " anchor " + loc[0] + "," + loc[1]);
        popup.showAtLocation(host, Gravity.TOP | Gravity.LEFT, x, y);
    }

    private static View ensureHost(Context context) {
        if (sHost != null && sHost.isAttachedToWindow()) {
            return sHost;
        }
        Context app = context.getApplicationContext();
        if (app == null) {
            app = context;
        }
        Display display = app.getSystemService(DisplayManager.class)
                .getDisplay(Display.DEFAULT_DISPLAY);
        Context windowContext = app.createWindowContext(display, TYPE_SYSTEM_DIALOG, null);
        WindowManager wm = windowContext.getSystemService(WindowManager.class);
        View host = new View(windowContext);
        WindowManager.LayoutParams lp = new WindowManager.LayoutParams(
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.MATCH_PARENT,
                TYPE_SYSTEM_DIALOG,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
                        | WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
                        | WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
                        | WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
                PixelFormat.TRANSLUCENT);
        lp.gravity = Gravity.TOP | Gravity.LEFT;
        lp.setTitle("scalable-panel-host");
        // Untrusted overlays block touches to the map, widgets, and apps even
        // when the window itself is NOT_TOUCHABLE. This host only anchors
        // popups; it must not take part in hit testing.
        markTrustedOverlay(lp);
        wm.addView(host, lp);
        sHost = host;
        return host;
    }

    /** Hidden API. SystemUI is platform-signed, so the flag is accepted. */
    private static void markTrustedOverlay(WindowManager.LayoutParams lp) {
        try {
            lp.getClass().getMethod("setTrustedOverlay").invoke(lp);
        } catch (Throwable t) {
            Log.w("CarSysuiHeaderCtrl", "setTrustedOverlay", t);
        }
    }
}
