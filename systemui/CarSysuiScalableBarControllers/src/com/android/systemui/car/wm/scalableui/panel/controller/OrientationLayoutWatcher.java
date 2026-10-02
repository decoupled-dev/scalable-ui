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
import android.hardware.display.DisplayManager;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.Display;
import android.view.Surface;

/**
 * Posts {@code orientation_portrait} or {@code orientation_landscape} when the
 * default display rotates. This panel's natural orientation is portrait, so
 * rotation 0 and 180 are portrait and 90 and 270 are landscape.
 *
 * <p>The orchestrator does not emit an orientation event. Panel XML listens
 * for these two names and moves each panel between its landscape and portrait
 * variants. The first post is delayed so {@code window_states} has finished
 * loading. A later rotation posts again.
 */
public final class OrientationLayoutWatcher implements DisplayManager.DisplayListener, Runnable {

    private static final String TAG = "OrientationLayout";
    private static final long START_DELAY_MS = 2000L;

    private static boolean sStarted;

    private final Context mContext;
    private boolean mApplied;
    private boolean mPortrait;

    private OrientationLayoutWatcher(Context context) {
        mContext = context;
    }

    /** Registers one listener. Extra header controllers share it. */
    public static void start(Context context) {
        if (sStarted || context == null) {
            return;
        }
        sStarted = true;
        OrientationLayoutWatcher watcher = new OrientationLayoutWatcher(context);
        DisplayManager displays = context.getSystemService(DisplayManager.class);
        if (displays == null) {
            Log.w(TAG, "DisplayManager missing");
            return;
        }
        Handler handler = new Handler(Looper.getMainLooper());
        displays.registerDisplayListener(watcher, handler);
        handler.postDelayed(watcher, START_DELAY_MS);
    }

    @Override
    public void onDisplayAdded(int displayId) {
    }

    @Override
    public void onDisplayRemoved(int displayId) {
    }

    @Override
    public void onDisplayChanged(int displayId) {
        if (displayId == Display.DEFAULT_DISPLAY) {
            apply();
        }
    }

    @Override
    public void run() {
        apply();
    }

    private void apply() {
        DisplayManager displays = mContext.getSystemService(DisplayManager.class);
        if (displays == null) {
            return;
        }
        Display display = displays.getDisplay(Display.DEFAULT_DISPLAY);
        if (display == null) {
            return;
        }
        int rotation = display.getRotation();
        boolean portrait = rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_180;
        if (mApplied && mPortrait == portrait) {
            return;
        }
        mApplied = true;
        mPortrait = portrait;
        String event = portrait ? "orientation_portrait" : "orientation_landscape";
        Log.i(TAG, "rotation=" + rotation + " event=" + event);
        dispatch(event);
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
