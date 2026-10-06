/*
 * Copyright (C) 2026 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.systemui.car.wm.scalableui.panel.controller;

import android.content.ComponentCallbacks;
import android.content.Context;
import android.content.res.Configuration;
import android.database.ContentObserver;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PixelFormat;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.graphics.Point;
import android.graphics.Rect;
import android.hardware.display.DisplayManager;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ImageButton;
import android.widget.LinearLayout;

import java.lang.ref.WeakReference;

/**
 * Posts {@code layout_variant_0} … {@code layout_variant_3} from
 * {@code Settings.Global} {@code scalable_ui_layout_variant}.
 *
 * <p>Each value is a landscape chrome set. {@code 0} is the current layout
 * (dock on the bottom, status pills on top, three widgets on the right).
 * {@code 1} is the left-rail test (dock on the left, status pills on the
 * bottom). {@code 2} keeps that chrome. The right column holds all eleven
 * widgets (the three home cards plus the eight widget apps), three on screen
 * at a time. A scrollbar in the gap beside the column changes the page.
 * {@code 3} is T-Rex. Home is wallpaper plus the three cards in a row.
 * Nav is a full-screen map. Vehicle fills the area between the pills and
 * the dock. Settings splits the screen with the map on the left. The dock
 * selects those modes with {@code trex_home}, {@code trex_nav},
 * {@code trex_vehicle}, and {@code trex_split}. Portrait keeps
 * the shared portrait variants.
 *
 * <p>Switch with {@code adb shell settings put global scalable_ui_layout_variant N}.
 * Landscape rotation lands on the default variant first; {@link
 * OrientationLayoutWatcher} then calls {@link #onOrientationApplied} so the
 * selected set is applied again.
 */
public final class LayoutVariantWatcher extends ContentObserver
        implements Runnable, ComponentCallbacks, View.OnAttachStateChangeListener {

    public static final String SETTING = "scalable_ui_layout_variant";
    /** Inclusive range is 0..3. */
    public static final int VARIANT_COUNT = 4;
    /** Test set: nav dock on the left, so its icons stack vertically. */
    private static final int VARIANT_DOCK_LEFT = 1;
    /** Right column of all 11 widgets, three visible. */
    private static final int VARIANT_WIDGET_COLUMN = 2;
    /** T-Rex: wallpaper home, fullscreen map, fullscreen vehicle, 50/50 settings. */
    private static final int VARIANT_TREX = 3;
    public static final String TREX_HOME = "trex_home";
    public static final String TREX_NAV = "trex_nav";
    public static final String TREX_VEHICLE = "trex_vehicle";
    public static final String TREX_SPLIT = "trex_split";
    /** Pages of three. The last page has the remaining two. */
    private static final int WIDGET_PAGE_COUNT = 4;
    private static final int TYPE_SYSTEM_DIALOG = 2008;

    private static final String TAG = "LayoutVariant";

    private static LayoutVariantWatcher sInstance;
    private static WeakReference<LinearLayout> sDock;
    private static LinearLayout sListeningDock;

    private static final String PRIVACY_ANCHOR = "launcher_privacy_chips";
    private static final String PROFILE_PANEL = "launcher_pill_right";
    private static final String STATUS_PANEL = "launcher_pill_left";
    /** Invisible quick-control hit targets hosted over the left status pill. */
    private static final String[] STATUS_SLOTS = {
            "launcher_status_wifi_slot",
            "launcher_status_bluetooth_slot",
            "launcher_status_brightness_slot",
            "launcher_status_volume_slot"
    };

    private final Context mContext;
    private final Handler mHandler;
    private boolean mReady;
    private int mDockTries;
    /** Extra passes so the mic chip follows the pill after the 350ms transition. */
    private int mFollowPasses;
    private int mPrivacyX;
    private int mPrivacyY;
    private int mPrivacyH;
    private boolean mHasProfile;
    private int mProfileX;
    private int mProfileY;
    private int mProfileH;
    /** Screen rects of the status hit targets, filled on the decor thread. */
    private int mStatusCount;
    private final int[] mStatusX = new int[STATUS_SLOTS.length];
    private final int[] mStatusY = new int[STATUS_SLOTS.length];
    private final int[] mStatusW = new int[STATUS_SLOTS.length];
    private final int[] mStatusH = new int[STATUS_SLOTS.length];
    private boolean mPrivacyPosted;
    /** Theme refresh rebuilds the dock horizontal and resets panels to the default. */
    private boolean mReapplyVariant;
    private int mThemePasses;
    /** Which trio is in the variant-2 column. Reset when leaving that set. */
    private int mWidgetPage;
    /** T-Rex screen to restore after an app grid, launched app, or climate card closes. */
    private String mTrexMode = TREX_HOME;
    /** Pill background and icon tints are applied only while this stays true. */
    private boolean mTrexChrome;
    private boolean mColumnWasCovered;
    private View mWidgetRail;
    private WindowManager mWidgetWm;
    private final Runnable mRailTick = new Runnable() {
        @Override
        public void run() {
            if (mWidgetRail == null) {
                return;
            }
            boolean variant2 = getVariant(mContext) == VARIANT_WIDGET_COLUMN
                    && !isPortrait(mContext);
            boolean covered = widgetColumnCovered() || mapInNavigation();
            if (variant2 && mColumnWasCovered && !covered) {
                dispatch("widget_page_" + mWidgetPage);
            }
            mColumnWasCovered = covered;
            mWidgetRail.setVisibility(variant2 && !covered ? View.VISIBLE : View.GONE);
            mHandler.postDelayed(this, 400);
        }
    };

    private LayoutVariantWatcher(Context context, Handler handler) {
        super(handler);
        mContext = context;
        mHandler = handler;
    }

    /** Registers one observer. Extra header controllers share it. */
    public static void start(Context context) {
        if (sInstance != null || context == null) {
            return;
        }
        Context app = context.getApplicationContext();
        if (app == null) {
            app = context;
        }
        Handler handler = new Handler(Looper.getMainLooper());
        LayoutVariantWatcher watcher = new LayoutVariantWatcher(app, handler);
        sInstance = watcher;
        Uri uri = Settings.Global.getUriFor(SETTING);
        app.getContentResolver().registerContentObserver(uri, false, watcher);
        app.registerComponentCallbacks(watcher);
        Log.i(TAG, "watching " + SETTING + "=" + getVariant(app));
        handler.postDelayed(watcher, 2000);
    }

    /**
     * On the dock's thread this stacks or restores the icons. On the main
     * thread it searches for the dock and hops over to the dock's thread.
     */
    @Override
    public void run() {
        if (mPrivacyPosted && Looper.myLooper() == mHandler.getLooper()) {
            mPrivacyPosted = false;
            updatePrivacyWindow(mPrivacyX, mPrivacyY, mPrivacyH);
            return;
        }
        if (mReapplyVariant && Looper.myLooper() == mHandler.getLooper()) {
            if (!isPortrait(mContext)) {
                postCurrent();
            }
            mThemePasses--;
            if (mThemePasses > 0) {
                mHandler.postDelayed(this, 700);
            } else {
                mReapplyVariant = false;
            }
        }
        LinearLayout dock = cachedDock();
        if (dock != null && dock.getHandler() != null
                && dock.getHandler().getLooper() == Looper.myLooper()) {
            watchDock(dock);
            applyDockOrientation(mContext, dock);
            placePrivacyChip();
            if (mFollowPasses > 0) {
                mFollowPasses--;
                dock.postDelayed(this, 120);
            }
            return;
        }
        applyDockOrientation();
    }

    /**
     * Called after an orientation event has been posted. Landscape reapplies
     * the selected set. Portrait leaves the shared portrait variants in place
     * and puts the dock icons back in a row.
     */
    public static void onOrientationApplied(boolean portrait) {
        LayoutVariantWatcher watcher = sInstance;
        if (watcher == null) {
            return;
        }
        watcher.mReady = true;
        if (!portrait) {
            watcher.postCurrent();
        } else {
            watcher.mWidgetPage = 0;
            watcher.hideWidgetRail();
        }
        watcher.mFollowPasses = 8;
        watcher.applyDockOrientation();
    }

    /** oem_dock root. Variant 1 stacks its icons; every other case stays a row. */
    public static void attachDock(View root) {
        if (!(root instanceof LinearLayout)) {
            return;
        }
        LinearLayout dock = (LinearLayout) root;
        sDock = new WeakReference<>(dock);
        watchDock(dock);
        applyDockOrientation(root.getContext(), dock);
    }

    /** Theme refresh detaches the dock and inflates a new horizontal one. */
    @Override
    public void onViewAttachedToWindow(View v) {}

    @Override
    public void onViewDetachedFromWindow(View v) {
        if (sListeningDock == v) {
            sListeningDock = null;
        }
        LinearLayout cached = sDock != null ? sDock.get() : null;
        if (cached != v) {
            return;
        }
        sDock = null;
        mDockTries = 0;
        mFollowPasses = 8;
        mReapplyVariant = true;
        mThemePasses = 2;
        Log.i(TAG, "dock rebuilt, reapplying variant");
        mHandler.postDelayed(this, 400);
    }

    private static void watchDock(LinearLayout dock) {
        if (sListeningDock == dock || sInstance == null) {
            return;
        }
        if (sListeningDock != null) {
            sListeningDock.removeOnAttachStateChangeListener(sInstance);
        }
        sListeningDock = dock;
        dock.addOnAttachStateChangeListener(sInstance);
    }

    @Override
    public void onChange(boolean selfChange) {
        if (mReady && !isPortrait(mContext)) {
            postCurrent();
        }
        mFollowPasses = 8;
        applyDockOrientation();
    }

    /**
     * Night mode rebuilds every decor view from XML, which is a horizontal
     * row, and the panel reset lands on the default variant. Replay the
     * selected set once the new dock exists.
     */
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        sDock = null;
        mDockTries = 0;
        mFollowPasses = 8;
        mReapplyVariant = true;
        mThemePasses = 2;
        Log.i(TAG, "theme changed, reapplying variant");
        mHandler.postDelayed(this, 400);
    }

    @Override
    public void onLowMemory() {}

    private void postCurrent() {
        int variant = getVariant(mContext);
        if (variant == VARIANT_TREX) {
            mTrexMode = TREX_HOME;
        }
        String event = "layout_variant_" + variant;
        Log.i(TAG, "event=" + event);
        dispatch(event);
        syncWidgetRail(variant);
    }

    /** True while landscape T-Rex is the selected chrome set. */
    public static boolean isTrex(Context context) {
        return context != null && getVariant(context) == VARIANT_TREX && !isPortrait(context);
    }

    /** Dock selection inside T-Rex. No-op for configs 0–2. */
    public static void selectTrexMode(String event) {
        LayoutVariantWatcher watcher = sInstance;
        if (watcher == null || !isTrex(watcher.mContext) || event == null) {
            return;
        }
        watcher.mTrexMode = event;
        Log.i(TAG, "trex mode " + event);
        watcher.dispatch(event);
    }

    /**
     * Re-post the T-Rex mode that was current before a grid, launched app, or
     * climate card covered it. The panel XML also returns there on its own
     * when the overlay empties; this covers the dock closing those tasks.
     */
    public static void restoreTrexMode() {
        LayoutVariantWatcher watcher = sInstance;
        if (watcher == null || !isTrex(watcher.mContext)) {
            return;
        }
        watcher.dispatch(watcher.mTrexMode);
    }

    private static LinearLayout cachedDock() {
        LinearLayout dock = sDock != null ? sDock.get() : null;
        if (dock != null && !dock.isAttachedToWindow()) {
            sDock = null;
            return null;
        }
        return dock;
    }

    private void applyDockOrientation() {
        LinearLayout dock = cachedDock();
        if (dock == null) {
            dock = findDock();
            if (dock != null) {
                sDock = new WeakReference<>(dock);
                Log.i(TAG, "found dock");
            }
        }
        if (dock == null) {
            if (mDockTries < 8) {
                mDockTries++;
                mHandler.postDelayed(this, 1000);
            }
            return;
        }
        // Decor panels are created on wmshell.main. Touching them from the
        // systemui main looper throws CalledFromWrongThreadException.
        Handler viewHandler = dock.getHandler();
        if (viewHandler != null && viewHandler.getLooper() != Looper.myLooper()) {
            viewHandler.post(this);
            return;
        }
        applyDockOrientation(mContext, dock);
    }

    /** The nav dock is the row whose buttons include Home. */
    private static LinearLayout findDock() {
        try {
            Class<?> clazz = Class.forName("android.view.WindowManagerGlobal");
            Object global = clazz.getMethod("getInstance").invoke(null);
            LinearLayout dock = findDockInList(global, clazz, "mViews");
            if (dock != null) {
                return dock;
            }
            java.lang.reflect.Field roots = clazz.getDeclaredField("mWindowlessRoots");
            roots.setAccessible(true);
            Object value = roots.get(global);
            if (!(value instanceof java.util.List)) {
                return null;
            }
            for (Object item : (java.util.List<?>) value) {
                if (item == null) {
                    continue;
                }
                Object view = item.getClass().getMethod("getView").invoke(item);
                if (view instanceof View) {
                    dock = findDockIn((View) view);
                    if (dock != null) {
                        return dock;
                    }
                }
            }
            Log.i(TAG, "dock not found");
        } catch (Throwable t) {
            Log.w(TAG, "dock search failed", t);
        }
        return null;
    }

    private static LinearLayout findDockInList(Object global, Class<?> clazz, String fieldName)
            throws Exception {
        java.lang.reflect.Field field = clazz.getDeclaredField(fieldName);
        field.setAccessible(true);
        Object value = field.get(global);
        if (!(value instanceof java.util.List)) {
            return null;
        }
        for (Object item : (java.util.List<?>) value) {
            if (item instanceof View) {
                LinearLayout dock = findDockIn((View) item);
                if (dock != null) {
                    return dock;
                }
            }
        }
        return null;
    }

    private static LinearLayout findDockIn(View view) {
        if (view instanceof LinearLayout) {
            LinearLayout row = (LinearLayout) view;
            int buttons = 0;
            boolean home = false;
            for (int i = 0; i < row.getChildCount(); i++) {
                View child = row.getChildAt(i);
                if (!(child instanceof ImageButton)) {
                    continue;
                }
                buttons++;
                CharSequence desc = child.getContentDescription();
                if (desc != null && "Home".contentEquals(desc)) {
                    home = true;
                }
            }
            if (home && buttons >= 5 && row.isAttachedToWindow()) {
                return row;
            }
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                LinearLayout dock = findDockIn(group.getChildAt(i));
                if (dock != null) {
                    return dock;
                }
            }
        }
        return null;
    }

    private static void applyDockOrientation(Context context, LinearLayout dock) {
        if (context == null || dock == null) {
            return;
        }
        int variant = getVariant(context);
        boolean portrait = isPortrait(context);
        boolean vertical = variant == VARIANT_DOCK_LEFT && !portrait;
        boolean trex = variant == VARIANT_TREX && !portrait;
        try {
            applyDockOrientationOnViewThread(dock, vertical);
            LayoutVariantWatcher watcher = sInstance;
            if (watcher != null && (trex || watcher.mTrexChrome)) {
                applyTrexChrome(context, trex);
                watcher.mTrexChrome = trex;
            }
        } catch (Throwable t) {
            Log.w(TAG, "dock orientation failed", t);
        }
    }

    private static void applyDockOrientationOnViewThread(LinearLayout dock, boolean vertical) {
        dock.setOrientation(vertical ? LinearLayout.VERTICAL : LinearLayout.HORIZONTAL);
        for (int i = 0; i < dock.getChildCount(); i++) {
            View child = dock.getChildAt(i);
            if (child instanceof ImageButton) {
                applyIconGap(child, vertical);
                continue;
            }
            if (!(child.getLayoutParams() instanceof LinearLayout.LayoutParams)) {
                continue;
            }
            LinearLayout.LayoutParams lp = (LinearLayout.LayoutParams) child.getLayoutParams();
            int[] spec = dividerSpec(child, lp);
            if (spec == null) {
                continue;
            }
            if (vertical) {
                lp.width = spec[1];
                lp.height = spec[0];
                lp.topMargin = spec[2];
                lp.bottomMargin = spec[3];
                lp.setMarginStart(0);
                lp.setMarginEnd(0);
            } else {
                lp.width = spec[0];
                lp.height = spec[1];
                lp.topMargin = 0;
                lp.bottomMargin = 0;
                lp.setMarginStart(spec[2]);
                lp.setMarginEnd(spec[3]);
            }
            child.setLayoutParams(lp);
        }
    }

    /** The horizontal dock's start/end margins become the vertical gaps. */
    private static void applyIconGap(View child, boolean vertical) {
        if (!(child.getLayoutParams() instanceof LinearLayout.LayoutParams)) {
            return;
        }
        LinearLayout.LayoutParams lp = (LinearLayout.LayoutParams) child.getLayoutParams();
        int[] spec = iconGap(child, lp);
        if (vertical) {
            lp.topMargin = spec[0];
            lp.bottomMargin = spec[1];
            lp.setMarginStart(0);
            lp.setMarginEnd(0);
        } else {
            lp.topMargin = 0;
            lp.bottomMargin = 0;
            lp.setMarginStart(spec[0]);
            lp.setMarginEnd(spec[1]);
        }
        child.setLayoutParams(lp);
    }

    /** marginStart, marginEnd captured from the horizontal dock icon. */
    private static int[] iconGap(View child, LinearLayout.LayoutParams lp) {
        Object tag = child.getTag();
        if (tag instanceof int[]) {
            int[] saved = (int[]) tag;
            if (saved.length == 2) {
                return saved;
            }
        }
        int[] spec = new int[] {lp.getMarginStart(), lp.getMarginEnd()};
        child.setTag(spec);
        return spec;
    }

    /**
     * T-Rex pills use a 16dp surface and colored glyphs. Configs 0–2 keep the
     * capsule and the white icons. Must run on the decor thread.
     */
    private static void applyTrexChrome(Context context, boolean trex) {
        int bg = context.getResources().getIdentifier(
                trex ? "launcher_pill_bg_v3" : "launcher_dock_bg",
                "drawable", context.getPackageName());
        visitDecorViews(view -> {
            if (view instanceof android.widget.TextClock && view.getParent() instanceof View) {
                View parent = (View) view.getParent();
                if (bg != 0 && parent.getBackground() != null) {
                    parent.setBackgroundResource(bg);
                }
            }
            if (!(view instanceof ImageButton)) {
                return;
            }
            ImageButton button = (ImageButton) view;
            CharSequence desc = button.getContentDescription();
            int color = trexIconColor(desc == null ? null : desc.toString());
            if (color == 0) {
                return;
            }
            if (trex) {
                Drawable icon = button.getDrawable();
                if (icon != null) {
                    button.setImageDrawable(icon.mutate());
                }
                button.setColorFilter(color, PorterDuff.Mode.SRC_IN);
            } else {
                button.clearColorFilter();
            }
            if (!isDockIcon(desc == null ? null : desc.toString()) && bg != 0) {
                View pill = pillRoot(button);
                if (pill != null) {
                    pill.setBackgroundResource(bg);
                }
            }
        });
        if (bg == 0) {
            return;
        }
        int driver = context.getResources().getIdentifier(
                "sysui_driver_zone_root", "id", context.getPackageName());
        int passenger = context.getResources().getIdentifier(
                "sysui_passenger_zone_root", "id", context.getPackageName());
        int profile = context.getResources().getIdentifier(
                "launcher_user_profile", "id", context.getPackageName());
        final int background = bg;
        visitDecorViews(view -> {
            int id = view.getId();
            if (id == View.NO_ID || view.getBackground() == null) {
                return;
            }
            if ((driver != 0 && id == driver) || (passenger != 0 && id == passenger)
                    || (profile != 0 && id == profile)) {
                view.setBackgroundResource(background);
            }
        });
    }

    /** Status and temperature glyphs sit inside the pill; dock glyphs do not. */
    private static View pillRoot(View button) {
        View current = button;
        for (int i = 0; i < 4; i++) {
            if (!(current.getParent() instanceof View)) {
                return null;
            }
            current = (View) current.getParent();
            if (current instanceof android.widget.LinearLayout && current.getBackground() != null) {
                return current;
            }
        }
        return null;
    }

    private static int trexIconColor(String desc) {
        if (desc == null) {
            return 0;
        }
        switch (desc) {
            case "Wi-Fi":
                return 0xFF4DA3FF;
            case "Bluetooth":
                return 0xFF5B8DEF;
            case "Volume":
                return 0xFF7C6BF2;
            case "Brightness":
                return 0xFFF5A524;
            case "Dark theme":
            case "Light theme":
                return 0xFF8E9AAF;
            case "Decrease temperature":
            case "Increase temperature":
                return 0xFF4FC3F7;
            case "Home":
                return 0xFF5B8DEF;
            case "Map fullscreen":
                return 0xFF3DDC97;
            case "All apps":
                return 0xFFF5A524;
            case "Assistant":
                return 0xFFE85D75;
            case "Climate":
                return 0xFF4FC3F7;
            case "Vehicle":
                return 0xFF7C6BF2;
            case "Car settings":
                return 0xFF8E9AAF;
            default:
                return 0;
        }
    }

    private static boolean isDockIcon(String desc) {
        if (desc == null) {
            return false;
        }
        switch (desc) {
            case "Home":
            case "Map fullscreen":
            case "All apps":
            case "Assistant":
            case "Climate":
            case "Vehicle":
            case "Car settings":
                return true;
            default:
                return false;
        }
    }

    private interface DecorVisitor {
        void onView(View view);
    }

    private static void visitDecorViews(DecorVisitor visitor) {
        try {
            Class<?> clazz = Class.forName("android.view.WindowManagerGlobal");
            Object global = clazz.getMethod("getInstance").invoke(null);
            visitDecorList(global, clazz, "mViews", visitor);
            java.lang.reflect.Field roots = clazz.getDeclaredField("mWindowlessRoots");
            roots.setAccessible(true);
            Object value = roots.get(global);
            if (!(value instanceof java.util.List)) {
                return;
            }
            for (Object item : (java.util.List<?>) value) {
                if (item == null) {
                    continue;
                }
                Object view = item.getClass().getMethod("getView").invoke(item);
                if (view instanceof View) {
                    visitDecor((View) view, visitor);
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "trex chrome search failed", t);
        }
    }

    private static void visitDecorList(Object global, Class<?> clazz, String fieldName,
            DecorVisitor visitor) throws Exception {
        java.lang.reflect.Field field = clazz.getDeclaredField(fieldName);
        field.setAccessible(true);
        Object value = field.get(global);
        if (!(value instanceof java.util.List)) {
            return;
        }
        for (Object item : (java.util.List<?>) value) {
            if (item instanceof View) {
                visitDecor((View) item, visitor);
            }
        }
    }

    private static void visitDecor(View view, DecorVisitor visitor) {
        visitor.onView(view);
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                visitDecor(group.getChildAt(i), visitor);
            }
        }
    }

    /**
     * The mic and camera chips are a window aligned to the profile pill.
     * Decor bounds move without relayout, so the window is placed again from
     * the pill's current bounds. Must run on the decor thread.
     */
    private void placePrivacyChip() {
        try {
            Rect bounds = panelBounds(PROFILE_PANEL);
            if (bounds.isEmpty()) {
                return;
            }
            View privacy = findNamedView(PRIVACY_ANCHOR);
            if (privacy != null && privacy.getHeight() > 0) {
                int[] xy = screenPoint(privacy, bounds);
                mPrivacyX = xy[0];
                mPrivacyY = xy[1];
                mPrivacyH = privacy.getHeight();
            }
            View profile = findNamedView("launcher_user_anchor");
            mHasProfile = profile != null && profile.getHeight() > 0;
            if (mHasProfile) {
                int[] xy = screenPoint(profile, bounds);
                mProfileX = xy[0];
                mProfileY = xy[1];
                mProfileH = profile.getHeight();
            }
            placeStatusSlots();
            if (mPrivacyPosted) {
                return;
            }
            mPrivacyPosted = true;
            mHandler.post(this);
        } catch (Throwable t) {
            Log.w(TAG, "privacy chip place failed", t);
        }
    }

    /**
     * Wifi, Bluetooth, brightness, and volume are invisible windows. A leash
     * move does not relayout them, so after the left pill leaves the bottom
     * they stay over the dock and swallow the Home tap.
     */
    private void placeStatusSlots() {
        Rect bounds = panelBounds(STATUS_PANEL);
        if (bounds.isEmpty()) {
            mStatusCount = 0;
            return;
        }
        int count = 0;
        for (int i = 0; i < STATUS_SLOTS.length; i++) {
            View slot = findNamedView(STATUS_SLOTS[i]);
            if (slot == null || slot.getWidth() <= 0 || slot.getHeight() <= 0) {
                continue;
            }
            int[] xy = screenPoint(slot, bounds);
            mStatusX[count] = xy[0];
            mStatusY[count] = xy[1];
            mStatusW[count] = slot.getWidth();
            mStatusH[count] = slot.getHeight();
            count++;
        }
        mStatusCount = count;
    }

    /** Decor surfaces report location as if the panel starts at the origin. */
    private static int[] screenPoint(View anchor, Rect bounds) {
        int[] loc = new int[2];
        anchor.getLocationOnScreen(loc);
        int[] origin = new int[2];
        View panelRoot = anchor.getRootView();
        if (panelRoot != null) {
            panelRoot.getLocationOnScreen(origin);
        }
        return new int[] {
                bounds.left + loc[0] - origin[0],
                bounds.top + loc[1] - origin[1]
        };
    }

    private void updatePrivacyWindow(int x, int y, int height) {
        try {
            WindowManager wm = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
            if (wm == null) {
                return;
            }
            View profileHost = null;
            int profileHostX = Integer.MIN_VALUE;
            for (View host : launcherPanelWindows()) {
                WindowManager.LayoutParams lp =
                        (WindowManager.LayoutParams) host.getLayoutParams();
                if (containsMicOrCameraChip(host)) {
                    moveWindow(wm, host, lp, x, y, height, "privacy");
                    continue;
                }
                // The profile tap target is the other tall panel on this pill.
                // Status-slot windows are shorter.
                if (lp.height >= 90 && lp.x >= profileHostX) {
                    profileHost = host;
                    profileHostX = lp.x;
                }
            }
            if (mHasProfile && profileHost != null) {
                moveWindow(wm, profileHost,
                        (WindowManager.LayoutParams) profileHost.getLayoutParams(),
                        mProfileX, mProfileY, mProfileH, "profile");
            }
            moveStatusWindows(wm);
        } catch (Throwable t) {
            Log.w(TAG, "privacy chip update failed", t);
        }
    }

    /** Short LauncherQcPanel windows are the status slots, left to right. */
    private void moveStatusWindows(WindowManager wm) {
        if (mStatusCount <= 0) {
            return;
        }
        View[] hosts = new View[STATUS_SLOTS.length];
        int found = 0;
        java.util.List<View> windows;
        try {
            windows = launcherPanelWindows();
        } catch (Throwable t) {
            Log.w(TAG, "status windows", t);
            return;
        }
        for (View host : windows) {
            if (containsMicOrCameraChip(host)) {
                continue;
            }
            WindowManager.LayoutParams lp =
                    (WindowManager.LayoutParams) host.getLayoutParams();
            if (lp.height >= 90 || found >= hosts.length) {
                continue;
            }
            hosts[found] = host;
            found++;
        }
        for (int i = 1; i < found; i++) {
            View host = hosts[i];
            int x = ((WindowManager.LayoutParams) host.getLayoutParams()).x;
            int j = i;
            while (j > 0 && ((WindowManager.LayoutParams) hosts[j - 1].getLayoutParams()).x > x) {
                hosts[j] = hosts[j - 1];
                j--;
            }
            hosts[j] = host;
        }
        int[] order = new int[mStatusCount];
        for (int i = 0; i < mStatusCount; i++) {
            order[i] = i;
        }
        for (int i = 1; i < mStatusCount; i++) {
            int slot = order[i];
            int x = mStatusX[slot];
            int j = i;
            while (j > 0 && mStatusX[order[j - 1]] > x) {
                order[j] = order[j - 1];
                j--;
            }
            order[j] = slot;
        }
        int n = found < mStatusCount ? found : mStatusCount;
        for (int i = 0; i < n; i++) {
            int slot = order[i];
            View host = hosts[i];
            WindowManager.LayoutParams lp =
                    (WindowManager.LayoutParams) host.getLayoutParams();
            if (lp.x == mStatusX[slot] && lp.y == mStatusY[slot]
                    && lp.width == mStatusW[slot] && lp.height == mStatusH[slot]) {
                continue;
            }
            lp.x = mStatusX[slot];
            lp.y = mStatusY[slot];
            lp.width = mStatusW[slot];
            lp.height = mStatusH[slot];
            wm.updateViewLayout(host, lp);
            Log.i(TAG, "status slot -> " + lp.x + "," + lp.y
                    + " " + lp.width + "x" + lp.height);
        }
    }

    private static void moveWindow(WindowManager wm, View host, WindowManager.LayoutParams lp,
            int x, int y, int height, String label) {
        if (lp.x == x && lp.y == y && lp.height == height) {
            return;
        }
        lp.x = x;
        lp.y = y;
        lp.height = height;
        wm.updateViewLayout(host, lp);
        Log.i(TAG, label + " chip -> " + x + "," + y + " h=" + height);
    }

    private static java.util.List<View> launcherPanelWindows() throws Exception {
        java.util.ArrayList<View> hosts = new java.util.ArrayList<>();
        Class<?> clazz = Class.forName("android.view.WindowManagerGlobal");
        Object global = clazz.getMethod("getInstance").invoke(null);
        java.lang.reflect.Field field = clazz.getDeclaredField("mViews");
        field.setAccessible(true);
        Object value = field.get(global);
        if (!(value instanceof java.util.List)) {
            return hosts;
        }
        for (Object item : (java.util.List<?>) value) {
            if (!(item instanceof View)) {
                continue;
            }
            View view = (View) item;
            if (!(view.getLayoutParams() instanceof WindowManager.LayoutParams)) {
                continue;
            }
            WindowManager.LayoutParams lp = (WindowManager.LayoutParams) view.getLayoutParams();
            if ("LauncherQcPanel".contentEquals(String.valueOf(lp.getTitle()))) {
                hosts.add(view);
            }
        }
        return hosts;
    }

    private static View findNamedView(String entryName) {
        try {
            Class<?> clazz = Class.forName("android.view.WindowManagerGlobal");
            Object global = clazz.getMethod("getInstance").invoke(null);
            java.lang.reflect.Field roots = clazz.getDeclaredField("mWindowlessRoots");
            roots.setAccessible(true);
            Object value = roots.get(global);
            if (!(value instanceof java.util.List)) {
                return null;
            }
            for (Object item : (java.util.List<?>) value) {
                if (item == null) {
                    continue;
                }
                Object view = item.getClass().getMethod("getView").invoke(item);
                if (view instanceof View) {
                    View named = findNamed((View) view, entryName);
                    if (named != null) {
                        return named;
                    }
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "anchor search failed " + entryName, t);
        }
        return null;
    }

    private static View findNamed(View view, String entryName) {
        if (entryName.equals(entryNameOf(view))) {
            return view;
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                View named = findNamed(group.getChildAt(i), entryName);
                if (named != null) {
                    return named;
                }
            }
        }
        return null;
    }

    private static String entryNameOf(View view) {
        int id = view.getId();
        if (id == View.NO_ID) {
            return null;
        }
        try {
            return view.getResources().getResourceEntryName(id);
        } catch (Throwable t) {
            return null;
        }
    }

    private static boolean containsMicOrCameraChip(View view) {
        String name = view.getClass().getName();
        if (name.endsWith("MicPrivacyChip") || name.endsWith("CameraPrivacyChip")) {
            return true;
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                if (containsMicOrCameraChip(group.getChildAt(i))) {
                    return true;
                }
            }
        }
        return false;
    }

    private static Rect panelBounds(String panelId) {
        try {
            Class<?> stateManager = Class.forName(
                    "com.android.car.scalableui.manager.StateManager");
            Object state = stateManager.getMethod("getPanelState", String.class)
                    .invoke(null, panelId);
            if (state != null) {
                Object variant = state.getClass().getMethod("getCurrentVariant").invoke(state);
                if (variant != null) {
                    Object bounds = variant.getClass().getMethod("getBounds").invoke(variant);
                    if (bounds instanceof Rect && !((Rect) bounds).isEmpty()) {
                        return new Rect((Rect) bounds);
                    }
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "panel bounds " + panelId, t);
        }
        return new Rect();
    }

    /** Width, height, marginStart, marginEnd captured from the horizontal dock. */
    private static int[] dividerSpec(View child, LinearLayout.LayoutParams lp) {
        Object tag = child.getTag();
        if (tag instanceof int[]) {
            int[] saved = (int[]) tag;
            if (saved.length == 4) {
                return saved;
            }
        }
        if (lp.width <= 0 || lp.height <= 0) {
            return null;
        }
        int[] spec = new int[] {lp.width, lp.height, lp.getMarginStart(), lp.getMarginEnd()};
        child.setTag(spec);
        return spec;
    }

    static int getVariant(Context context) {
        if (context == null) {
            return 0;
        }
        int variant = Settings.Global.getInt(context.getContentResolver(), SETTING, 0);
        if (variant < 0 || variant >= VARIANT_COUNT) {
            return 0;
        }
        return variant;
    }

    private static boolean isPortrait(Context context) {
        DisplayManager displays = context.getSystemService(DisplayManager.class);
        if (displays == null) {
            return true;
        }
        Display display = displays.getDisplay(Display.DEFAULT_DISPLAY);
        if (display == null) {
            return true;
        }
        int rotation = display.getRotation();
        return rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_180;
    }

    private void dispatch(String eventId) {
        try {
            Object app = mContext.getApplicationContext();
            Object wm = app.getClass().getMethod("getWMComponent").invoke(app);
            Object dispatcher = wm.getClass()
                    .getMethod("getScalableUIEventDispatcher").invoke(wm);
            Object event = new com.android.car.scalableui.model.Event.Builder(eventId).build();
            dispatcher.getClass()
                    .getMethod("executeEvent", com.android.car.scalableui.model.Event.class)
                    .invoke(dispatcher, event);
        } catch (Throwable t) {
            Log.w(TAG, "EventDispatcher.executeEvent(" + eventId + ") failed", t);
            try {
                com.android.car.scalableui.model.PanelTransaction tx =
                        com.android.car.scalableui.manager.StateManager.handleEvent(
                                new com.android.car.scalableui.model.Event.Builder(eventId)
                                        .build());
                if (tx != null) {
                    for (java.util.Map.Entry<String, android.animation.Animator> e
                            : tx.getAnimators()) {
                        if (e.getValue() != null) {
                            e.getValue().start();
                        }
                    }
                }
            } catch (Throwable t2) {
                Log.w(TAG, eventId + " fallback failed", t2);
            }
        }
    }

    /**
     * Variant 2 keeps three cards in the right column. A scrollbar sits in
     * the gap between the map and the cards. Dragging it changes the page.
     * It hides while the map is fullscreen.
     */
    private void syncWidgetRail(int variant) {
        if (variant != VARIANT_WIDGET_COLUMN || isPortrait(mContext)) {
            mWidgetPage = 0;
            mColumnWasCovered = false;
            hideWidgetRail();
            return;
        }
        showWidgetRail();
        if (mWidgetPage > 0) {
            dispatch("widget_page_" + mWidgetPage);
        }
    }

    private void stepWidgetPage(int delta) {
        if (getVariant(mContext) != VARIANT_WIDGET_COLUMN || isPortrait(mContext)
                || widgetColumnCovered() || mapInNavigation()) {
            return;
        }
        int next = mWidgetPage + delta;
        if (next == mWidgetPage || next < 0 || next >= WIDGET_PAGE_COUNT) {
            return;
        }
        mWidgetPage = next;
        Log.i(TAG, "widget page " + mWidgetPage);
        dispatch("widget_page_" + mWidgetPage);
        if (mWidgetRail != null) {
            mWidgetRail.invalidate();
        }
    }

    /** Map fullscreen (the dock navigation button) hides the widget column. */
    private boolean mapInNavigation() {
        String name = panelVariantName("map_panel");
        return "nav".equals(name) || "portrait_nav".equals(name);
    }

    private boolean widgetColumnCovered() {
        String[] panels = {
                "launcher_app",
                "launcher_climate_app",
                "launcher_vehicle_app",
                "launcher_settings_app",
                "panel_app_grid"
        };
        for (String panel : panels) {
            String name = panelVariantName(panel);
            if (name == null || name.contains("closed") || name.contains("hidden")
                    || name.contains("behind")) {
                continue;
            }
            if ("opened".equals(name) || "layout_v1".equals(name)
                    || "portrait_opened".equals(name)) {
                return true;
            }
        }
        return false;
    }

    private String panelVariantName(String panelId) {
        try {
            Class<?> stateManager = Class.forName(
                    "com.android.car.scalableui.manager.StateManager");
            Object state = stateManager.getMethod("getPanelState", String.class)
                    .invoke(null, panelId);
            if (state == null) {
                return null;
            }
            Object variant = state.getClass().getMethod("getCurrentVariant").invoke(state);
            if (variant == null) {
                return null;
            }
            Object name = variant.getClass().getMethod("getIdName").invoke(variant);
            return name instanceof String ? (String) name : null;
        } catch (Throwable t) {
            return null;
        }
    }

    private int dp(float value) {
        return Math.round(value * mContext.getResources().getDisplayMetrics().density);
    }

    private void showWidgetRail() {
        if (mWidgetRail != null) {
            mWidgetRail.invalidate();
            return;
        }
        try {
            DisplayManager displays = mContext.getSystemService(DisplayManager.class);
            Display display = displays == null ? null
                    : displays.getDisplay(Display.DEFAULT_DISPLAY);
            if (display == null) {
                return;
            }
            Point size = new Point();
            display.getRealSize(size);
            // 48dp gutter beside the column, full card stack. Dragging it
            // pages the widgets. It does not cover the cards.
            int railW = dp(48);
            int x = size.x - dp(528);
            int y = dp(80);
            int height = dp(876);
            Context windowContext = mContext.createWindowContext(display, TYPE_SYSTEM_DIALOG, null);
            mWidgetWm = windowContext.getSystemService(WindowManager.class);
            WidgetRail rail = new WidgetRail(windowContext);
            WindowManager.LayoutParams lp = new WindowManager.LayoutParams(
                    railW, height, TYPE_SYSTEM_DIALOG,
                    WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
                            | WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
                            | WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
                    PixelFormat.TRANSLUCENT);
            lp.gravity = Gravity.TOP | Gravity.START;
            lp.x = x;
            lp.y = y;
            lp.setTitle("launcher_widget_rail");
            try {
                lp.getClass().getMethod("setTrustedOverlay").invoke(lp);
            } catch (Throwable ignored) {
            }
            mWidgetWm.addView(rail, lp);
            mWidgetRail = rail;
            mHandler.removeCallbacks(mRailTick);
            mHandler.post(mRailTick);
            Log.i(TAG, "widget rail " + x + "," + y + " " + railW + "x" + height);
        } catch (Throwable t) {
            Log.w(TAG, "widget rail failed", t);
            mWidgetRail = null;
            mWidgetWm = null;
        }
    }

    private void hideWidgetRail() {
        mHandler.removeCallbacks(mRailTick);
        View rail = mWidgetRail;
        WindowManager wm = mWidgetWm;
        mWidgetRail = null;
        mWidgetWm = null;
        if (rail == null || wm == null) {
            return;
        }
        try {
            wm.removeView(rail);
        } catch (Throwable t) {
            Log.w(TAG, "remove widget rail", t);
        }
    }

    /**
     * Scrollbar for the variant-2 column. It fills the gutter beside the
     * cards. Dragging the thumb, or the track, changes the page.
     */
    private final class WidgetRail extends View {
        private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private boolean mDragging;
        private float mGrabOffset;
        private float mDragY;

        WidgetRail(Context context) {
            super(context);
            setClickable(true);
            setContentDescription("Widget pages");
        }

        private float density() {
            return getResources().getDisplayMetrics().density;
        }

        private float trackTop() {
            return 12 * density();
        }

        private float trackBottom() {
            return getHeight() - 12 * density();
        }

        private float thumbHeight() {
            return 72 * density();
        }

        private float thumbCenterForPage(int page) {
            float span = trackBottom() - trackTop();
            float slot = span / WIDGET_PAGE_COUNT;
            return trackTop() + slot * (page + 0.5f);
        }

        private int pageForCenter(float center) {
            float span = trackBottom() - trackTop();
            if (span <= 0) {
                return 0;
            }
            int page = (int) ((center - trackTop()) / span * WIDGET_PAGE_COUNT);
            if (page < 0) {
                return 0;
            }
            if (page >= WIDGET_PAGE_COUNT) {
                return WIDGET_PAGE_COUNT - 1;
            }
            return page;
        }

        private float clampThumb(float center) {
            float half = thumbHeight() / 2f;
            float min = trackTop() + half;
            float max = trackBottom() - half;
            if (center < min) {
                return min;
            }
            if (center > max) {
                return max;
            }
            return center;
        }

        @Override
        protected void onDraw(Canvas canvas) {
            float d = density();
            float cx = getWidth() / 2f;
            float top = trackTop();
            float bottom = trackBottom();
            mPaint.setStyle(Paint.Style.FILL);
            mPaint.setColor(0x33FFFFFF);
            canvas.drawRoundRect(cx - 3 * d, top, cx + 3 * d, bottom, 3 * d, 3 * d, mPaint);
            float cy = clampThumb(mDragging ? mDragY : thumbCenterForPage(mWidgetPage));
            float half = thumbHeight() / 2f;
            mPaint.setColor(mDragging ? 0xFFFFFFFF : 0xF2FFFFFF);
            canvas.drawRoundRect(cx - 12 * d, cy - half, cx + 12 * d, cy + half,
                    12 * d, 12 * d, mPaint);
        }

        private void applyDrag(float y) {
            mDragY = clampThumb(y - mGrabOffset);
            stepWidgetPage(pageForCenter(mDragY) - mWidgetPage);
            invalidate();
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            switch (event.getActionMasked()) {
                case MotionEvent.ACTION_DOWN: {
                    float center = thumbCenterForPage(mWidgetPage);
                    if (Math.abs(event.getY() - center) <= thumbHeight() / 2f) {
                        mGrabOffset = event.getY() - center;
                    } else {
                        mGrabOffset = 0;
                    }
                    mDragging = true;
                    applyDrag(event.getY());
                    return true;
                }
                case MotionEvent.ACTION_MOVE:
                    if (mDragging) {
                        applyDrag(event.getY());
                    }
                    return true;
                case MotionEvent.ACTION_UP:
                case MotionEvent.ACTION_CANCEL:
                    mDragging = false;
                    invalidate();
                    return true;
                default:
                    return true;
            }
        }
    }
}
