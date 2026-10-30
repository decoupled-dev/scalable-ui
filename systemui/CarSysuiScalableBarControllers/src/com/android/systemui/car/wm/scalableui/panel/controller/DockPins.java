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

import android.app.ActivityManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.Outline;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Looper;
import android.os.UserHandle;
import android.provider.Settings;
import android.util.Log;
import android.view.HapticFeedbackConstants;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewOutlineProvider;
import android.widget.ImageButton;
import android.widget.LinearLayout;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * Pinned apps and the last-used slot on {@code oem_dock}.
 *
 * <p>The app grid's Pin action broadcasts {@code com.android.car.docklib.events.PIN}
 * with a {@code ComponentName} in {@code EXTRA_COMPONENT}. Pinned icons sit in
 * their own group after a divider, past the recent slot. A long-press drags an
 * icon within its own group. The recent slot stays put and shows the last
 * launchable app. Home, permission dialogs, and the other dock chrome do not
 * replace it. The choice is kept across reboot, so the first paint after boot
 * is still the app from the previous cycle.
 */
public final class DockPins {
    private static final String TAG = "DockPins";
    private static final String PREFS = "launcher_dock_pins";
    private static final String PREF_PINS = "pins";
    private static final String PREF_ORDER = "order";
    private static final String PREF_RECENT = "recent";
    private static final String ACTION_PIN = "com.android.car.docklib.events.PIN";
    private static final String ACTION_UNPIN = "com.android.car.docklib.events.UNPIN";
    private static final String ACTION_LAUNCH = "com.android.car.docklib.events.LAUNCH";
    private static final String EXTRA_COMPONENT = "EXTRA_COMPONENT";
    private static final String SENDER_PERMISSION =
            "com.android.car.docklib.permission.BROADCAST_SENDER";
    private static final String LAYOUT_SETTING = "scalable_ui_layout_variant";
    private static final String RRO_PACKAGE =
            "com.android.systemui.rro.scalableUI.launcher";
    private static final int MAX_PINS = 4;
    /** Keyed tag. The unkeyed tag is owned by {@code LayoutVariantWatcher}. */
    private static final int TAG_KEY = 0x5ca1ab1e;
    private static final String KEY_RECENT = "recent";
    private static final long POLL_MS = 1000L;
    /** Icon grows while it is being dragged, then settles on release. */
    private static final float DRAG_SCALE = 1.3f;

    private static DockPins sInstance;

    private final Context mContext;
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private LinearLayout mRow;
    private ImageButton mRecent;
    private ComponentName mRecentComponent;
    private int mPinCount;
    private int mOrientation = -1;
    private String mWidthEvent = "";
    private View mPinDivider;
    private ImageButton mDragButton;
    private float mDragDownX;
    private float mDragDownY;
    private float mGrabX;
    private float mGrabY;
    private int mPendingSlot = -1;
    private boolean mReordering;
    private boolean mReceiverRegistered;
    private final List<String> mPins = new ArrayList<>();
    /** Package names of {@link #mPins}, published for the task poll thread. */
    private volatile String[] mPinnedPackages = new String[0];

    private final BroadcastReceiver mReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent == null || intent.getAction() == null) {
                return;
            }
            final String action = intent.getAction();
            final ComponentName component = componentExtra(intent);
            Log.i(TAG, "dock event " + action + " " + component);
            if (component == null || mRow == null) {
                return;
            }
            mRow.post(new Runnable() {
                @Override
                public void run() {
                    try {
                        if (ACTION_PIN.equals(action)) {
                            pin(component);
                        } else if (ACTION_UNPIN.equals(action)) {
                            unpin(component);
                        } else if (ACTION_LAUNCH.equals(action)) {
                            showRecent(component);
                        }
                    } catch (Throwable t) {
                        Log.w(TAG, "dock event failed", t);
                    }
                }
            });
        }
    };

    private final Runnable mPoll = new Runnable() {
        @Override
        public void run() {
            if (mRow == null) {
                return;
            }
            final ComponentName top = topActivity();
            final int orientation = mContext.getResources().getConfiguration().orientation;
            mRow.post(new Runnable() {
                @Override
                public void run() {
                    try {
                        // Home and system dialogs are not a recent app. Keep the
                        // last launchable app, including the one saved last boot.
                        if (top != null) {
                            showRecent(top);
                        } else if (mRecentComponent != null && !isUserApp(mRecentComponent)) {
                            ComponentName fallback = topActivity();
                            if (fallback != null) {
                                showRecent(fallback);
                            } else {
                                clearRecent();
                            }
                        }
                        if (orientation != mOrientation) {
                            mOrientation = orientation;
                            mWidthEvent = "";
                        }
                        applyWidth();
                    } catch (Throwable t) {
                        Log.w(TAG, "dock refresh failed", t);
                    }
                }
            });
            mHandler.postDelayed(this, POLL_MS);
        }
    };

    /** Arms after a still long-press. The decor surface never delivers a system drop. */
    private final Runnable mArmReorder = new Runnable() {
        @Override
        public void run() {
            if (mDragButton == null || mRow == null) {
                return;
            }
            mReordering = true;
            mPendingSlot = -1;
            mDragButton.setPressed(false);
            liftDragged(mDragButton);
            mDragButton.performHapticFeedback(HapticFeedbackConstants.LONG_PRESS);
        }
    };

    private DockPins(Context context) {
        mContext = context;
    }

    /** Binds the dock row. Safe to call again after a theme inflation. */
    public static void attach(View root) {
        if (root == null) {
            return;
        }
        Context context = root.getContext();
        if (sInstance == null) {
            sInstance = new DockPins(context);
            try {
                sInstance.start();
            } catch (Throwable t) {
                Log.w(TAG, "dock listener failed", t);
            }
        }
        try {
            sInstance.bind(root);
        } catch (Throwable t) {
            Log.w(TAG, "dock bind failed", t);
        }
    }

    private void start() {
        IntentFilter filter = new IntentFilter();
        filter.addAction(ACTION_PIN);
        filter.addAction(ACTION_UNPIN);
        filter.addAction(ACTION_LAUNCH);
        try {
            Method register = Context.class.getMethod(
                    "registerReceiverAsUser",
                    BroadcastReceiver.class,
                    UserHandle.class,
                    IntentFilter.class,
                    String.class,
                    Handler.class,
                    int.class);
            register.invoke(mContext, mReceiver, userHandleAll(), filter, SENDER_PERMISSION,
                    mHandler, Context.RECEIVER_EXPORTED);
            mReceiverRegistered = true;
            Log.i(TAG, "listening for pin broadcasts");
        } catch (Throwable t) {
            Log.w(TAG, "registerReceiverAsUser failed", t);
            try {
                mContext.registerReceiver(mReceiver, filter, SENDER_PERMISSION, mHandler,
                        Context.RECEIVER_EXPORTED);
                mReceiverRegistered = true;
            } catch (Throwable t2) {
                Log.w(TAG, "registerReceiver failed", t2);
            }
        }
    }

    private void stop() {
        mHandler.removeCallbacks(mPoll);
        if (mReceiverRegistered) {
            try {
                mContext.unregisterReceiver(mReceiver);
            } catch (Throwable ignored) {
            }
            mReceiverRegistered = false;
        }
    }

    private View recentButton(View root) {
        int recentId = overlayId(root.getContext(), "oem_dock_recent");
        View recent = recentId != 0 ? root.findViewById(recentId) : null;
        if (recent == null) {
            recent = findDescribed(root, "Recent app");
        }
        return recent;
    }

    private int overlayId(Context context, String name) {
        String[] packages = new String[] {
                RRO_PACKAGE,
                context.getPackageName()
        };
        for (String pkg : packages) {
            try {
                Context overlay = context.createPackageContext(pkg, 0);
                int id = overlay.getResources().getIdentifier(name, "id", pkg);
                if (id != 0) {
                    return id;
                }
            } catch (Throwable ignored) {
            }
        }
        return 0;
    }

    private LinearLayout findRow(View root) {
        View recent = recentButton(root);
        if (recent != null && recent.getParent() instanceof LinearLayout) {
            return (LinearLayout) recent.getParent();
        }
        if (root instanceof LinearLayout && isDockRow((LinearLayout) root)) {
            return (LinearLayout) root;
        }
        if (root instanceof android.view.ViewGroup) {
            android.view.ViewGroup group = (android.view.ViewGroup) root;
            for (int i = 0; i < group.getChildCount(); i++) {
                LinearLayout found = findRow(group.getChildAt(i));
                if (found != null) {
                    return found;
                }
            }
        }
        return null;
    }

    private static boolean isDockRow(LinearLayout row) {
        int buttons = 0;
        boolean home = false;
        for (int i = 0; i < row.getChildCount(); i++) {
            View child = row.getChildAt(i);
            if (!(child instanceof ImageButton)) {
                continue;
            }
            buttons++;
            if ("Home".contentEquals(child.getContentDescription())) {
                home = true;
            }
        }
        return home && buttons >= 5;
    }

    private static View findDescribed(View root, String description) {
        if (description.contentEquals(root.getContentDescription() == null
                ? "" : root.getContentDescription())) {
            return root;
        }
        if (root instanceof android.view.ViewGroup) {
            android.view.ViewGroup group = (android.view.ViewGroup) root;
            for (int i = 0; i < group.getChildCount(); i++) {
                View found = findDescribed(group.getChildAt(i), description);
                if (found != null) {
                    return found;
                }
            }
        }
        return null;
    }

    private void bind(View root) {
        LinearLayout row = findRow(root);
        if (row == null) {
            Log.w(TAG, "dock root is not a row");
            return;
        }
        mRow = row;
        row.setClipChildren(false);
        row.setClipToPadding(false);
        if (row.getParent() instanceof android.view.ViewGroup) {
            android.view.ViewGroup parent = (android.view.ViewGroup) row.getParent();
            parent.setClipChildren(false);
            parent.setClipToPadding(false);
        }
        View recent = recentButton(row);
        mRecent = recent instanceof ImageButton ? (ImageButton) recent : null;
        if (mRecent != null) {
            mRecent.setTag(TAG_KEY, KEY_RECENT);
        }
        ensurePinDivider();
        for (int i = 0; i < row.getChildCount(); i++) {
            View child = row.getChildAt(i);
            if (!(child instanceof ImageButton)) {
                continue;
            }
            ImageButton button = (ImageButton) child;
            applyIconShadow(button);
            if (button != mRecent) {
                keyOf(button);
                installDrag(button);
            }
        }
        restorePins();
        restoreRecent();
        restoreOrder();
        placePinsAfterRecent();
        mHandler.removeCallbacks(mPoll);
        mHandler.post(mPoll);
        Log.i(TAG, "dock bound pins=" + mPins.size()
                + " slot=" + (mRecent != null)
                + " recent=" + mRecentComponent);
    }

    private void pin(ComponentName component) {
        String flat = component.flattenToString();
        if (mPins.contains(flat)) {
            return;
        }
        if (mPins.size() >= MAX_PINS) {
            Log.w(TAG, "dock full, ignoring " + flat);
            return;
        }
        mPins.add(flat);
        publishPins();
        savePins();
        if (mRecentComponent != null
                && component.getPackageName().equals(mRecentComponent.getPackageName())) {
            clearRecent();
        }
        if (mRow != null) {
            ImageButton button = createPinButton(component);
            mRow.addView(button);
            installDrag(button);
            placePinsAfterRecent();
            mPinCount = mPins.size();
            updatePinDivider();
            applyWidth();
        }
    }

    private void unpin(ComponentName component) {
        String flat = component.flattenToString();
        if (!mPins.remove(flat)) {
            return;
        }
        publishPins();
        savePins();
        if (mRow == null) {
            return;
        }
        String key = pinKey(flat);
        for (int i = mRow.getChildCount() - 1; i >= 0; i--) {
            View child = mRow.getChildAt(i);
            if (child instanceof ImageButton && key.equals(keyOf((ImageButton) child))) {
                mRow.removeViewAt(i);
            }
        }
        mPinCount = mPins.size();
        updatePinDivider();
        saveOrder();
        applyWidth();
    }

    private void restorePins() {
        mPins.clear();
        if (mRow != null) {
            for (int i = mRow.getChildCount() - 1; i >= 0; i--) {
                View child = mRow.getChildAt(i);
                if (!(child instanceof ImageButton)) {
                    continue;
                }
                String key = keyOf((ImageButton) child);
                if (key.startsWith("pin:")) {
                    mRow.removeViewAt(i);
                }
            }
        }
        String saved = prefs().getString(PREF_PINS, "");
        if (saved == null || saved.isEmpty()) {
            mPinCount = 0;
            publishPins();
            return;
        }
        for (String flat : saved.split(",")) {
            if (flat.isEmpty() || mPins.size() >= MAX_PINS) {
                continue;
            }
            ComponentName component = ComponentName.unflattenFromString(flat);
            if (component == null) {
                continue;
            }
            mPins.add(flat);
            if (mRow != null) {
                ImageButton button = createPinButton(component);
                mRow.addView(button);
                installDrag(button);
            }
        }
        mPinCount = mPins.size();
        publishPins();
        placePinsAfterRecent();
        updatePinDivider();
    }

    private ImageButton createPinButton(ComponentName component) {
        ImageButton button = new ImageButton(mRow != null ? mRow.getContext() : mContext);
        button.setTag(TAG_KEY, pinKey(component.flattenToString()));
        if (mRecent != null && mRecent.getBackground() != null
                && mRecent.getBackground().getConstantState() != null) {
            button.setBackground(mRecent.getBackground().getConstantState().newDrawable().mutate());
        }
        button.setScaleType(ImageButton.ScaleType.FIT_CENTER);
        button.setPadding(dp(4), dp(4), dp(4), dp(4));
        int size = mRecent != null ? mRecent.getLayoutParams().width
                : dp(60);
        if (size <= 0) {
            size = dp(60);
        }
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(size, size);
        if (mRecent != null
                && mRecent.getLayoutParams() instanceof LinearLayout.LayoutParams) {
            LinearLayout.LayoutParams src =
                    (LinearLayout.LayoutParams) mRecent.getLayoutParams();
            lp = new LinearLayout.LayoutParams(src);
        }
        button.setLayoutParams(lp);
        Drawable icon = loadIcon(component);
        if (icon != null) {
            button.setImageDrawable(icon);
        } else {
            Log.w(TAG, "no icon for " + component);
        }
        CharSequence label = loadLabel(component);
        button.setContentDescription(label);
        final ComponentName launch = component;
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                launchApp(launch);
            }
        });
        applyIconShadow(button);
        return button;
    }

    /** Soft shadow hugging the circular icon, kept light so the glyph stays solid. */
    private void applyIconShadow(ImageButton button) {
        button.setOutlineProvider(new ViewOutlineProvider() {
            @Override
            public void getOutline(View view, Outline outline) {
                int width = view.getWidth();
                int height = view.getHeight();
                if (width <= 0 || height <= 0) {
                    return;
                }
                outline.setOval(0, 0, width, height);
            }
        });
        button.setElevation(dp(8));
        button.setOutlineAmbientShadowColor(0xCC000000);
        button.setOutlineSpotShadowColor(0x99000000);
        button.setStateListAnimator(null);
    }

    private void installDrag(final ImageButton button) {
        button.setLongClickable(true);
        button.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return onDockTouch(button, event);
            }
        });
    }

    /**
     * Follows the finger after a long-press and commits the new index on release.
     * Removing a view mid-gesture cancels the touch, so the row is rebuilt only
     * when the finger lifts. Pins stay in the pin group. The recent slot stays put.
     */
    private boolean onDockTouch(ImageButton button, MotionEvent event) {
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
                if (mReordering) {
                    return false;
                }
                mDragButton = button;
                mDragDownX = event.getRawX();
                mDragDownY = event.getRawY();
                mGrabX = event.getX();
                mGrabY = event.getY();
                mReordering = false;
                mPendingSlot = -1;
                button.setPressed(true);
                if (button.getParent() != null) {
                    button.getParent().requestDisallowInterceptTouchEvent(true);
                }
                button.removeCallbacks(mArmReorder);
                button.postDelayed(mArmReorder, ViewConfiguration.getLongPressTimeout());
                return true;
            case MotionEvent.ACTION_MOVE:
                if (mDragButton != button) {
                    return false;
                }
                float dx = event.getRawX() - mDragDownX;
                float dy = event.getRawY() - mDragDownY;
                int slop = ViewConfiguration.get(button.getContext()).getScaledTouchSlop();
                if (!mReordering) {
                    if (dx * dx + dy * dy > (float) slop * slop) {
                        button.removeCallbacks(mArmReorder);
                    }
                    return true;
                }
                boolean vertical = mRow.getOrientation() == LinearLayout.VERTICAL;
                button.setTranslationX(vertical ? 0f : dx);
                button.setTranslationY(vertical ? dy : 0f);
                mPendingSlot = nearestSlot(groupOf(button), fingerX(button, event),
                        fingerY(button, event));
                previewSlot(button, mPendingSlot);
                return true;
            case MotionEvent.ACTION_UP:
                button.removeCallbacks(mArmReorder);
                button.setPressed(false);
                if (mReordering && mDragButton == button) {
                    mPendingSlot = nearestSlot(groupOf(button), fingerX(button, event),
                            fingerY(button, event));
                    if (isPin(button) && droppedOffDock(event)) {
                        unpinByDrag(button);
                        return true;
                    }
                    finishReorder(button);
                    return true;
                }
                mDragButton = null;
                button.performClick();
                return true;
            case MotionEvent.ACTION_CANCEL:
                button.removeCallbacks(mArmReorder);
                resetTranslations(button);
                button.setPressed(false);
                if (mDragButton == button) {
                    mReordering = false;
                    mDragButton = null;
                }
                return true;
            default:
                return false;
        }
    }

    private void finishReorder(ImageButton button) {
        int slot = mPendingSlot;
        resetTranslations(button);
        mReordering = false;
        mDragButton = null;
        mPendingSlot = -1;
        if (slot >= 0) {
            moveButton(button, slot);
        }
        if (isPin(button)) {
            syncPinsFromRow();
        }
        saveOrder();
        Log.i(TAG, "reorder " + keyOf(button) + " -> " + slot);
    }

    /** Drag a pinned icon off the dock to remove it. Built-in dock icons stay. */
    private void unpinByDrag(ImageButton button) {
        resetTranslations(button);
        mReordering = false;
        mDragButton = null;
        mPendingSlot = -1;
        String key = keyOf(button);
        if (!key.startsWith("pin:")) {
            return;
        }
        ComponentName component = ComponentName.unflattenFromString(key.substring("pin:".length()));
        Log.i(TAG, "unpin by drag " + component);
        if (component != null) {
            unpin(component);
        }
    }

    private float fingerX(ImageButton button, MotionEvent event) {
        return button.getLeft() + mGrabX + (event.getRawX() - mDragDownX);
    }

    private float fingerY(ImageButton button, MotionEvent event) {
        return button.getTop() + mGrabY + (event.getRawY() - mDragDownY);
    }

    private boolean droppedOffDock(MotionEvent event) {
        if (mRow == null) {
            return false;
        }
        boolean vertical = mRow.getOrientation() == LinearLayout.VERTICAL;
        int slack = dp(28);
        if (vertical) {
            float x = fingerX(mDragButton, event);
            return x < -slack || x > mRow.getWidth() + slack;
        }
        float y = fingerY(mDragButton, event);
        return y < -slack || y > mRow.getHeight() + slack;
    }

    /** Nudge the other icons so the gap shows where the dragged one will land. */
    private void previewSlot(ImageButton dragged, int slot) {
        List<ImageButton> group = groupOf(dragged);
        int from = group.indexOf(dragged);
        if (from < 0) {
            return;
        }
        boolean vertical = mRow.getOrientation() == LinearLayout.VERTICAL;
        int step = vertical ? dragged.getHeight() : dragged.getWidth();
        if (group.size() >= 2) {
            ImageButton first = group.get(0);
            ImageButton second = group.get(1);
            int gap = vertical
                    ? second.getTop() - first.getTop()
                    : second.getLeft() - first.getLeft();
            if (gap > 0) {
                step = gap;
            }
        }
        for (int i = 0; i < group.size(); i++) {
            ImageButton other = group.get(i);
            if (other == dragged) {
                continue;
            }
            int dir = 0;
            if (from < slot && i > from && i <= slot) {
                dir = -1;
            } else if (slot < from && i >= slot && i < from) {
                dir = 1;
            }
            float delta = dir * step;
            if (vertical) {
                other.setTranslationX(0f);
                other.setTranslationY(delta);
            } else {
                other.setTranslationX(delta);
                other.setTranslationY(0f);
            }
        }
    }

    private void resetTranslations(ImageButton dragged) {
        if (dragged != null) {
            for (ImageButton other : groupOf(dragged)) {
                other.setTranslationX(0f);
                other.setTranslationY(0f);
            }
            dragged.setTranslationX(0f);
            dragged.setTranslationY(0f);
            settleDragged(dragged);
        }
    }

    private void liftDragged(ImageButton button) {
        button.setTranslationZ(dp(8));
        button.setScaleX(DRAG_SCALE);
        button.setScaleY(DRAG_SCALE);
    }

    private void settleDragged(ImageButton button) {
        button.setTranslationZ(0f);
        button.setScaleX(1f);
        button.setScaleY(1f);
    }

    /** Hairline between the recent slot and the pinned apps. Hidden when nothing is pinned. */
    private void ensurePinDivider() {
        if (mRow == null || mRecent == null) {
            return;
        }
        if (mPinDivider == null || mPinDivider.getParent() != mRow) {
            View divider = new View(mRow.getContext());
            divider.setImportantForAccessibility(View.IMPORTANT_FOR_ACCESSIBILITY_NO);
            int width = dp(1);
            int height = dp(30);
            int margin = dp(10);
            View sample = sampleDivider();
            if (sample != null && sample.getBackground() != null
                    && sample.getBackground().getConstantState() != null) {
                divider.setBackground(
                        sample.getBackground().getConstantState().newDrawable().mutate());
            } else {
                divider.setBackgroundColor(0x33FFFFFF);
            }
            boolean vertical = mRow.getOrientation() == LinearLayout.VERTICAL;
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                    vertical ? height : width, vertical ? width : height);
            if (vertical) {
                lp.topMargin = margin;
                lp.bottomMargin = margin;
            } else {
                lp.setMarginStart(margin);
                lp.setMarginEnd(margin);
            }
            divider.setLayoutParams(lp);
            // Horizontal spec. LayoutVariantWatcher rotates dividers from this tag.
            divider.setTag(new int[] {width, height, margin, margin});
            mPinDivider = divider;
        }
        placePinsAfterRecent();
        updatePinDivider();
    }

    private View sampleDivider() {
        for (int i = 0; i < mRow.getChildCount(); i++) {
            View child = mRow.getChildAt(i);
            if (!(child instanceof ImageButton) && child != mPinDivider
                    && child.getBackground() != null) {
                return child;
            }
        }
        return null;
    }

    /** Recent slot, then the pin divider, then every pinned icon. */
    private void placePinsAfterRecent() {
        if (mRow == null || mRecent == null || mPinDivider == null) {
            return;
        }
        List<ImageButton> pins = pinButtons();
        int recentIndex = mRow.indexOfChild(mRecent);
        if (recentIndex < 0) {
            return;
        }
        if (mPinDivider.getParent() == mRow) {
            mRow.removeView(mPinDivider);
        }
        for (int i = 0; i < pins.size(); i++) {
            mRow.removeView(pins.get(i));
        }
        int insert = mRow.indexOfChild(mRecent) + 1;
        mRow.addView(mPinDivider, insert);
        for (int i = 0; i < pins.size(); i++) {
            mRow.addView(pins.get(i), insert + 1 + i);
        }
    }

    private void updatePinDivider() {
        if (mPinDivider == null) {
            return;
        }
        mPinDivider.setVisibility(mPins.isEmpty() ? View.GONE : View.VISIBLE);
    }

    private void restoreRecent() {
        String flat = prefs().getString(PREF_RECENT, null);
        ComponentName component = flat == null
                ? null : ComponentName.unflattenFromString(flat);
        // A permission sheet or other chrome may have been saved earlier.
        // Prefer that only when it is a real app; otherwise take the newest
        // launchable task still in the stack from the previous cycle.
        if (!isUserApp(component)) {
            component = topActivity();
        }
        if (component != null) {
            showRecent(component);
        } else {
            clearRecent();
        }
    }

    /** Empty recent slot. Used when the last app is already a dock icon. */
    private void clearRecent() {
        mRecentComponent = null;
        prefs().edit().remove(PREF_RECENT).apply();
        if (mRecent == null) {
            return;
        }
        Drawable placeholder = recentPlaceholder();
        if (placeholder != null) {
            mRecent.setImageDrawable(placeholder);
        }
        mRecent.setPadding(dp(14), dp(14), dp(14), dp(14));
        mRecent.setAlpha(0.45f);
        mRecent.setContentDescription("Recent app");
        mRecent.setVisibility(View.GONE);
        setRecentDividerVisible(false);
        mRecent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {}
        });
    }

    /** The hairline that sits immediately before the recent slot. */
    private void setRecentDividerVisible(boolean visible) {
        if (mRow == null || mRecent == null) {
            return;
        }
        int index = mRow.indexOfChild(mRecent);
        if (index <= 0) {
            return;
        }
        View previous = mRow.getChildAt(index - 1);
        if (previous instanceof ImageButton || previous == mPinDivider) {
            return;
        }
        previous.setVisibility(visible ? View.VISIBLE : View.GONE);
    }

    private Drawable recentPlaceholder() {
        String[] packages = new String[] { RRO_PACKAGE, mContext.getPackageName() };
        for (int i = 0; i < packages.length; i++) {
            try {
                Context overlay = mContext.createPackageContext(packages[i], 0);
                int id = overlay.getResources().getIdentifier(
                        "ic_dock_recent", "drawable", packages[i]);
                if (id != 0) {
                    return overlay.getDrawable(id);
                }
            } catch (Throwable ignored) {
            }
        }
        return null;
    }

    private void showRecent(ComponentName component) {
        if (!isUserApp(component)) {
            return;
        }
        mRecentComponent = component;
        prefs().edit().putString(PREF_RECENT, component.flattenToString()).apply();
        if (mRecent == null) {
            return;
        }
        Drawable icon = loadIcon(component);
        if (icon == null) {
            Log.w(TAG, "no recent icon for " + component);
            return;
        }
        mRecent.setImageDrawable(icon);
        mRecent.setPadding(dp(4), dp(4), dp(4), dp(4));
        mRecent.setContentDescription(loadLabel(component));
        mRecent.setAlpha(1f);
        mRecent.setVisibility(View.VISIBLE);
        setRecentDividerVisible(true);
        mRecent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                launchApp(component);
            }
        });
    }

    private void updateRecentFromTasks() {
        ComponentName top = topActivity();
        if (top != null) {
            showRecent(top);
        }
    }

    private ComponentName topActivity() {
        for (ComponentName component : taskComponents()) {
            if (isUserApp(component)) {
                return component;
            }
        }
        return null;
    }

    /** Tasks in recency order, including the map and the cards. */
    private List<ComponentName> taskComponents() {
        List<ComponentName> components = new ArrayList<ComponentName>();
        Object result = invokeGetTasks();
        if (!(result instanceof List)) {
            return components;
        }
        for (Object item : (List<?>) result) {
            ComponentName component = taskComponent(item);
            if (component != null) {
                components.add(component);
            }
        }
        return components;
    }

    private Object invokeGetTasks() {
        try {
            Class<?> atm = Class.forName("android.app.ActivityTaskManager");
            Object service = atm.getMethod("getService").invoke(null);
            Method chosen = null;
            for (Method method : service.getClass().getMethods()) {
                if (!"getTasks".equals(method.getName())) {
                    continue;
                }
                Class<?>[] params = method.getParameterTypes();
                if (params.length >= 1 && params[0] == int.class) {
                    chosen = method;
                    if (params.length == 4) {
                        break;
                    }
                }
            }
            if (chosen != null) {
                Class<?>[] params = chosen.getParameterTypes();
                Object[] args = new Object[params.length];
                for (int i = 0; i < params.length; i++) {
                    if (params[i] == int.class) {
                        args[i] = Integer.valueOf(i == 0 ? 16 : -1);
                    } else if (params[i] == boolean.class) {
                        args[i] = Boolean.TRUE;
                    } else {
                        args[i] = null;
                    }
                }
                return chosen.invoke(service, args);
            }
        } catch (Throwable t) {
            Log.w(TAG, "getTasks failed", t);
        }
        try {
            ActivityManager am = application().getSystemService(ActivityManager.class);
            if (am != null) {
                return am.getRunningTasks(16);
            }
        } catch (Throwable t) {
            Log.w(TAG, "getRunningTasks failed", t);
        }
        return null;
    }

    private static ComponentName taskComponent(Object info) {
        if (info instanceof ActivityManager.RunningTaskInfo) {
            return ((ActivityManager.RunningTaskInfo) info).topActivity;
        }
        try {
            Object value = info.getClass().getField("topActivity").get(info);
            if (value instanceof ComponentName) {
                return (ComponentName) value;
            }
        } catch (Throwable ignored) {
        }
        return null;
    }

    /** Skip chrome, and anything the dock already shows as a built-in or pinned icon. */
    private boolean ignored(ComponentName component) {
        String pkg = component.getPackageName();
        if (pkg == null) {
            return true;
        }
        if ("com.android.systemui".equals(pkg)
                || "com.android.car.carlauncher".equals(pkg)
                || "com.google.android.apps.maps".equals(pkg)
                || pkg.startsWith("com.scalableui.widgets")
                || "com.test.design".equals(pkg)
                || "android".equals(pkg)
                || "com.android.car.settings".equals(pkg)
                || "com.android.car.hvac".equals(pkg)
                || "com.google.android.carassistant".equals(pkg)
                || pkg.equals(assistantPackage())
                || "com.android.permissioncontroller".equals(pkg)
                || "com.google.android.permissioncontroller".equals(pkg)
                || "com.android.packageinstaller".equals(pkg)
                || "com.google.android.packageinstaller".equals(pkg)
                || "com.android.intentresolver".equals(pkg)) {
            return true;
        }
        String[] pinned = mPinnedPackages;
        for (int i = 0; i < pinned.length; i++) {
            if (pkg.equals(pinned[i])) {
                return true;
            }
        }
        return false;
    }

    /** Selected assistant, so its icon stays on the assistant button only. */
    private String assistantPackage() {
        int userId = currentUserId();
        String flat = secureSetting("voice_interaction_service", userId);
        if (flat == null || flat.length() == 0) {
            flat = secureSetting("assistant", userId);
        }
        if (flat == null || flat.length() == 0) {
            return "";
        }
        ComponentName component = ComponentName.unflattenFromString(flat);
        return component == null ? "" : component.getPackageName();
    }

    private String secureSetting(String key, int userId) {
        try {
            Method get = Settings.Secure.class.getMethod(
                    "getStringForUser",
                    android.content.ContentResolver.class, String.class, int.class);
            Object value = get.invoke(null, application().getContentResolver(), key,
                    Integer.valueOf(userId));
            if (value instanceof String) {
                return (String) value;
            }
        } catch (Throwable ignored) {
        }
        return Settings.Secure.getString(application().getContentResolver(), key);
    }

    /** An app the user can launch, not a dialog or another dock button. */
    private boolean isUserApp(ComponentName component) {
        if (component == null || ignored(component)) {
            return false;
        }
        String pkg = component.getPackageName();
        try {
            android.content.pm.LauncherApps apps =
                    application().getSystemService(android.content.pm.LauncherApps.class);
            if (apps == null) {
                return true;
            }
            java.util.List<android.content.pm.LauncherActivityInfo> list =
                    apps.getActivityList(pkg, userHandle(currentUserId()));
            return list != null && !list.isEmpty();
        } catch (Throwable t) {
            Log.w(TAG, "launcher check failed for " + pkg, t);
            return false;
        }
    }

    private void publishPins() {
        String[] packages = new String[mPins.size()];
        for (int i = 0; i < mPins.size(); i++) {
            ComponentName pin = ComponentName.unflattenFromString(mPins.get(i));
            packages[i] = pin == null ? "" : pin.getPackageName();
        }
        mPinnedPackages = packages;
    }

    private void launchApp(ComponentName component) {
        Log.i(TAG, "launch " + component);
        try {
            dispatchEvent("_System_TaskOpenEvent", "launcher_app");
        } catch (Throwable t) {
            Log.w(TAG, "TaskOpen launcher_app failed", t);
        }
        Intent intent = new Intent(Intent.ACTION_MAIN);
        intent.setComponent(component);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        int userId = currentUserId();
        UserHandle user = userHandle(userId);
        try {
            Method getPi = android.app.PendingIntent.class.getMethod(
                    "getActivityAsUser",
                    Context.class, int.class, Intent.class, int.class,
                    android.os.Bundle.class, UserHandle.class);
            Object pi = getPi.invoke(null, application(), 0, intent,
                    android.app.PendingIntent.FLAG_IMMUTABLE
                            | android.app.PendingIntent.FLAG_UPDATE_CURRENT,
                    null, user);
            if (pi instanceof android.app.PendingIntent) {
                ((android.app.PendingIntent) pi).send();
                return;
            }
        } catch (Throwable t) {
            Log.w(TAG, "PendingIntent launch failed", t);
        }
        try {
            Method start = Context.class.getMethod(
                    "startActivityAsUser", Intent.class, UserHandle.class);
            start.invoke(application(), intent, user);
        } catch (Throwable t) {
            Log.w(TAG, "startActivityAsUser failed", t);
        }
    }

    private void applyWidth() {
        if (mRow == null || !mRow.isShown()) {
            return;
        }
        int variant = 0;
        try {
            variant = android.provider.Settings.Global.getInt(
                    mContext.getContentResolver(), LAYOUT_SETTING, 0);
        } catch (Throwable ignored) {
        }
        if (variant == 1) {
            mWidthEvent = "rail";
            return;
        }
        boolean portrait = mContext.getResources().getConfiguration().orientation
                == Configuration.ORIENTATION_PORTRAIT;
        String event = (portrait ? "dock_pins_port_" : "dock_pins_") + mPinCount;
        if (event.equals(mWidthEvent)) {
            return;
        }
        mWidthEvent = event;
        dispatch(event);
    }

    private void dispatch(String eventId) {
        try {
            Class<?> builderClass = Class.forName(
                    "com.android.car.scalableui.model.Event$Builder");
            Object builder = builderClass.getConstructor(String.class).newInstance(eventId);
            execute(builderClass.getMethod("build").invoke(builder));
        } catch (Throwable t) {
            Log.w(TAG, "event " + eventId + " failed", t);
        }
    }

    private void dispatchEvent(String eventId, String panelId) throws Exception {
        Class<?> builderClass = Class.forName("com.android.car.scalableui.model.Event$Builder");
        Object builder = builderClass.getConstructor(String.class).newInstance(eventId);
        builderClass.getMethod("setPanelId", String.class).invoke(builder, panelId);
        execute(builderClass.getMethod("build").invoke(builder));
    }

    private void execute(Object event) throws Exception {
        Class<?> eventClass = Class.forName("com.android.car.scalableui.model.Event");
        Object app = Class.forName("android.app.ActivityThread")
                .getMethod("currentApplication").invoke(null);
        if (app == null) {
            throw new IllegalStateException("no application");
        }
        Object wm = app.getClass().getMethod("getWMComponent").invoke(app);
        Object dispatcher = wm.getClass().getMethod("getScalableUIEventDispatcher").invoke(wm);
        dispatcher.getClass().getMethod("executeEvent", eventClass).invoke(dispatcher, event);
    }

    /** Index of the icon whose center is closest to the finger. */
    private int nearestSlot(List<ImageButton> group, float x, float y) {
        boolean vertical = mRow.getOrientation() == LinearLayout.VERTICAL;
        float pos = vertical ? y : x;
        int best = 0;
        float bestDist = Float.MAX_VALUE;
        for (int i = 0; i < group.size(); i++) {
            View child = group.get(i);
            float mid = vertical
                    ? (child.getTop() + child.getBottom()) / 2f
                    : (child.getLeft() + child.getRight()) / 2f;
            float dist = Math.abs(pos - mid);
            if (dist < bestDist) {
                bestDist = dist;
                best = i;
            }
        }
        return best;
    }

    private void moveButton(ImageButton dragged, int slot) {
        List<ImageButton> buttons = groupOf(dragged);
        int from = buttons.indexOf(dragged);
        if (from < 0 || slot == from) {
            return;
        }
        if (slot < 0) {
            slot = 0;
        }
        if (slot >= buttons.size()) {
            slot = buttons.size() - 1;
        }
        buttons.remove(from);
        if (slot > buttons.size()) {
            slot = buttons.size();
        }
        buttons.add(slot, dragged);
        rebuild(buttons);
    }

    private void restoreOrder() {
        String saved = prefs().getString(PREF_ORDER, null);
        if (saved == null || saved.isEmpty() || mRow == null) {
            return;
        }
        List<ImageButton> current = mainButtons();
        List<ImageButton> ordered = new ArrayList<>();
        for (String key : saved.split(",")) {
            for (int i = 0; i < current.size(); i++) {
                if (key.equals(keyOf(current.get(i)))) {
                    ordered.add(current.remove(i));
                    break;
                }
            }
        }
        ordered.addAll(current);
        rebuild(ordered);
    }

    /** Replaces only the slots that belong to {@code ordered}. Recent and the other group stay. */
    private void rebuild(List<ImageButton> ordered) {
        if (mRow == null || ordered.isEmpty()) {
            return;
        }
        boolean pins = isPin(ordered.get(0));
        List<View> structure = new ArrayList<>();
        int next = 0;
        int count = mRow.getChildCount();
        for (int i = 0; i < count; i++) {
            View child = mRow.getChildAt(i);
            boolean inGroup = pins ? isPinView(child) : isMainView(child);
            if (inGroup && next < ordered.size()) {
                structure.add(ordered.get(next));
                next++;
            } else if (!inGroup) {
                structure.add(child);
            }
        }
        while (next < ordered.size()) {
            structure.add(ordered.get(next));
            next++;
        }
        mRow.removeAllViews();
        for (View child : structure) {
            if (child.getParent() instanceof android.view.ViewGroup) {
                ((android.view.ViewGroup) child.getParent()).removeView(child);
            }
            mRow.addView(child);
        }
    }

    private List<ImageButton> groupOf(ImageButton button) {
        return isPin(button) ? pinButtons() : mainButtons();
    }

    /** Dock icons the user can rearrange. The recent slot and pinned apps are excluded. */
    private List<ImageButton> mainButtons() {
        List<ImageButton> buttons = new ArrayList<>();
        if (mRow == null) {
            return buttons;
        }
        for (int i = 0; i < mRow.getChildCount(); i++) {
            View child = mRow.getChildAt(i);
            if (isMainView(child)) {
                buttons.add((ImageButton) child);
            }
        }
        return buttons;
    }

    private List<ImageButton> pinButtons() {
        List<ImageButton> buttons = new ArrayList<>();
        if (mRow == null) {
            return buttons;
        }
        for (int i = 0; i < mRow.getChildCount(); i++) {
            View child = mRow.getChildAt(i);
            if (isPinView(child)) {
                buttons.add((ImageButton) child);
            }
        }
        return buttons;
    }

    private void syncPinsFromRow() {
        mPins.clear();
        for (ImageButton button : pinButtons()) {
            String key = keyOf(button);
            if (key.startsWith("pin:")) {
                mPins.add(key.substring("pin:".length()));
            }
        }
        savePins();
        publishPins();
        mPinCount = mPins.size();
    }

    private boolean isMainView(View child) {
        return child instanceof ImageButton && child != mRecent && !isPinView(child);
    }

    private boolean isPinView(View child) {
        return child instanceof ImageButton && isPin((ImageButton) child);
    }

    private boolean isPin(ImageButton button) {
        return keyOf(button).startsWith("pin:");
    }

    private void saveOrder() {
        StringBuilder builder = new StringBuilder();
        for (ImageButton button : mainButtons()) {
            if (builder.length() > 0) {
                builder.append(',');
            }
            builder.append(keyOf(button));
        }
        prefs().edit().putString(PREF_ORDER, builder.toString()).apply();
    }

    private void savePins() {
        StringBuilder builder = new StringBuilder();
        for (String flat : mPins) {
            if (builder.length() > 0) {
                builder.append(',');
            }
            builder.append(flat);
        }
        prefs().edit().putString(PREF_PINS, builder.toString()).apply();
    }

    private static String keyOf(ImageButton button) {
        Object tag = button.getTag(TAG_KEY);
        if (tag instanceof String) {
            return (String) tag;
        }
        CharSequence desc = button.getContentDescription();
        String key = desc == null ? "icon" : desc.toString();
        button.setTag(TAG_KEY, key);
        return key;
    }

    private static String pinKey(String flat) {
        return "pin:" + flat;
    }

    private static ComponentName componentExtra(Intent intent) {
        Object extra = intent.getParcelableExtra(EXTRA_COMPONENT);
        if (extra instanceof ComponentName) {
            return (ComponentName) extra;
        }
        String flat = intent.getStringExtra(EXTRA_COMPONENT);
        if (flat != null) {
            return ComponentName.unflattenFromString(flat);
        }
        return null;
    }

    private Drawable loadIcon(ComponentName component) {
        Context app = application();
        UserHandle user = userHandle(currentUserId());
        try {
            android.content.pm.LauncherApps apps =
                    app.getSystemService(android.content.pm.LauncherApps.class);
            if (apps != null) {
                java.util.List<android.content.pm.LauncherActivityInfo> list =
                        apps.getActivityList(component.getPackageName(), user);
                int density = app.getResources().getDisplayMetrics().densityDpi;
                android.content.pm.LauncherActivityInfo match = null;
                if (list != null) {
                    for (android.content.pm.LauncherActivityInfo info : list) {
                        if (component.equals(info.getComponentName())) {
                            match = info;
                            break;
                        }
                        if (match == null) {
                            match = info;
                        }
                    }
                }
                if (match != null) {
                    return match.getIcon(density);
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "launcher icon failed for " + component, t);
        }
        PackageManager packages = app.getPackageManager();
        try {
            return packages.getActivityInfo(component, 0).loadIcon(packages);
        } catch (Throwable t) {
            Log.w(TAG, "activity icon failed for " + component, t);
        }
        try {
            return packages.getApplicationIcon(component.getPackageName());
        } catch (Throwable t) {
            Log.w(TAG, "app icon failed for " + component, t);
        }
        return null;
    }

    private CharSequence loadLabel(ComponentName component) {
        PackageManager packages = application().getPackageManager();
        try {
            return packages.getActivityInfo(component, 0).loadLabel(packages);
        } catch (Throwable ignored) {
        }
        return component.getPackageName();
    }

    /** SystemUI application. The dock view context is the overlay package, which
     *  cannot query other apps or keep a data directory. */
    private Context application() {
        try {
            Object app = Class.forName("android.app.ActivityThread")
                    .getMethod("currentApplication").invoke(null);
            if (app instanceof Context) {
                Context context = (Context) app;
                Context application = context.getApplicationContext();
                return application != null ? application : context;
            }
        } catch (Throwable ignored) {
        }
        return mContext;
    }

    private android.content.SharedPreferences prefs() {
        return application().getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    private static int currentUserId() {
        try {
            Method method = ActivityManager.class.getMethod("getCurrentUser");
            Object value = method.invoke(null);
            if (value instanceof Integer) {
                return (Integer) value;
            }
        } catch (Throwable t) {
            Log.w(TAG, "getCurrentUser failed", t);
        }
        return 0;
    }

    private static UserHandle userHandle(int userId) {
        try {
            Method of = UserHandle.class.getMethod("of", int.class);
            Object value = of.invoke(null, Integer.valueOf(userId));
            if (value instanceof UserHandle) {
                return (UserHandle) value;
            }
        } catch (Throwable t) {
            Log.w(TAG, "UserHandle.of failed", t);
        }
        return android.os.Process.myUserHandle();
    }

    private static UserHandle userHandleAll() {
        try {
            Object value = UserHandle.class.getField("ALL").get(null);
            if (value instanceof UserHandle) {
                return (UserHandle) value;
            }
        } catch (Throwable t) {
            Log.w(TAG, "UserHandle.ALL failed", t);
        }
        return userHandle(-1);
    }

    private int dp(int value) {
        return (int) (value * mContext.getResources().getDisplayMetrics().density + 0.5f);
    }
}
