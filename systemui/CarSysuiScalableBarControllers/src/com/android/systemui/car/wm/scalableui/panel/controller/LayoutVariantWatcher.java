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

import android.content.Context;
import android.database.ContentObserver;
import android.hardware.display.DisplayManager;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;
import android.view.Display;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.LinearLayout;

import java.lang.ref.WeakReference;

/**
 * Posts {@code layout_variant_0} … {@code layout_variant_3} from
 * {@code Settings.Global} {@code scalable_ui_layout_variant}.
 *
 * <p>Each value is a landscape chrome set. {@code 0} is the current layout
 * (dock on the bottom, status pills on top, widgets on the right). {@code 1}
 * is the left-rail test (dock on the left, status pills on the bottom).
 * {@code 2} and {@code 3} are reserved: the event is posted, and panel XML
 * can add bounds for them later. Portrait keeps the shared portrait variants.
 *
 * <p>Switch with {@code adb shell settings put global scalable_ui_layout_variant N}.
 * Landscape rotation lands on the default variant first; {@link
 * OrientationLayoutWatcher} then calls {@link #onOrientationApplied} so the
 * selected set is applied again.
 */
public final class LayoutVariantWatcher extends ContentObserver implements Runnable {

    public static final String SETTING = "scalable_ui_layout_variant";
    /** Inclusive range is 0..3. */
    public static final int VARIANT_COUNT = 4;
    /** Test set: nav dock on the left, so its icons stack vertically. */
    private static final int VARIANT_DOCK_LEFT = 1;

    private static final String TAG = "LayoutVariant";

    private static LayoutVariantWatcher sInstance;
    private static WeakReference<LinearLayout> sDock;

    private final Context mContext;
    private final Handler mHandler;
    private boolean mReady;
    private int mDockTries;

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
        Log.i(TAG, "watching " + SETTING + "=" + getVariant(app));
        handler.postDelayed(watcher, 2000);
    }

    /**
     * On the dock's thread this stacks or restores the icons. On the main
     * thread it searches for the dock and hops over to the dock's thread.
     */
    @Override
    public void run() {
        LinearLayout dock = sDock != null ? sDock.get() : null;
        if (dock != null && dock.getHandler() != null
                && dock.getHandler().getLooper() == Looper.myLooper()) {
            applyDockOrientation(mContext, dock);
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
        }
        watcher.applyDockOrientation();
    }

    /** oem_dock root. Variant 1 stacks its icons; every other case stays a row. */
    public static void attachDock(View root) {
        if (!(root instanceof LinearLayout)) {
            return;
        }
        LinearLayout dock = (LinearLayout) root;
        sDock = new WeakReference<>(dock);
        applyDockOrientation(root.getContext(), dock);
    }

    @Override
    public void onChange(boolean selfChange) {
        if (mReady && !isPortrait(mContext)) {
            postCurrent();
        }
        applyDockOrientation();
    }

    private void postCurrent() {
        int variant = getVariant(mContext);
        String event = "layout_variant_" + variant;
        Log.i(TAG, "event=" + event);
        dispatch(event);
    }

    private void applyDockOrientation() {
        LinearLayout dock = sDock != null ? sDock.get() : null;
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
            if (home && buttons >= 5) {
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
        // 2 and 3 have no bounds yet, so leave the icon stack as it is.
        if (variant != 0 && variant != VARIANT_DOCK_LEFT && !portrait) {
            return;
        }
        boolean vertical = variant == VARIANT_DOCK_LEFT && !portrait;
        try {
            applyDockOrientationOnViewThread(dock, vertical);
        } catch (Throwable t) {
            Log.w(TAG, "dock orientation failed", t);
        }
    }

    private static void applyDockOrientationOnViewThread(LinearLayout dock, boolean vertical) {
        dock.setOrientation(vertical ? LinearLayout.VERTICAL : LinearLayout.HORIZONTAL);
        for (int i = 0; i < dock.getChildCount(); i++) {
            View child = dock.getChildAt(i);
            if (child instanceof ImageButton) {
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
}
