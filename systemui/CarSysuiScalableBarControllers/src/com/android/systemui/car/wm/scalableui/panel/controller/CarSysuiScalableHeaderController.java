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
import android.app.UiModeManager;
import android.car.VehicleAreaSeat;
import android.car.hardware.CarHvacFanDirection;
import android.car.VehiclePropertyIds;
import android.car.hardware.CarPropertyValue;
import android.car.hardware.property.CarPropertyManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.UserInfo;
import android.content.res.Configuration;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.os.UserHandle;
import android.os.UserManager;
import android.provider.Settings;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.car.scalableui.loader.xml.parser.PanelControllerParser;
import com.android.car.scalableui.model.PanelControllerMetadata;
import com.android.car.scalableui.panel.DecorPanelController;

import java.io.PrintWriter;
import java.lang.reflect.Field;

/**
 * Controller for the Pleos dual-zone header (driver + passenger HVAC and seat temperature).
 * Inflates RRO layouts via dynamic binding; all bounds are declared in panel XML variants.
 */
public class CarSysuiScalableHeaderController extends CarSysuiScalableBarControllerBase {

    private static final String TAG = "CarSysuiHeaderCtrl";
    private static final String DEFAULT_RRO_PACKAGE =
            "com.android.systemui.rro.scalableUI.sysuiBars";
    private static final int SEAT_TEMP_STEP = 1;
    private static final int SEAT_TEMP_MIN = 0;
    private static final int SEAT_TEMP_MAX = 3;

    private static final int AREA_DRIVER = VehicleAreaSeat.SEAT_ROW_1_LEFT;
    private static final int AREA_PASSENGER = VehicleAreaSeat.SEAT_ROW_1_RIGHT;

    private float mDriverHvacTemp = 22.0f;
    private float mPassengerHvacTemp = 22.0f;
    /** {@code HVAC_TEMPERATURE_SET} stays Celsius; the pill follows this. */
    private boolean mFahrenheit;
    /** min C, step C, min F, step F from the HVAC config array. */
    private float[] mTempScale;
    private int mDriverSeatTemp = 2;
    private int mPassengerSeatTemp = 2;

    // Driver zone views
    private View mDriverZoneRoot;
    private TextView mDriverHvacTempText;
    private ImageButton mDriverHvacUp;
    private ImageButton mDriverHvacDown;
    private TextView mDriverSeatTempText;
    private ImageButton mDriverSeatUp;
    private ImageButton mDriverSeatDown;

    // Passenger zone views
    private View mPassengerZoneRoot;
    private TextView mPassengerHvacTempText;
    private ImageButton mPassengerHvacUp;
    private ImageButton mPassengerHvacDown;
    private TextView mPassengerSeatTempText;
    private ImageButton mPassengerSeatUp;
    private ImageButton mPassengerSeatDown;

    // Fan direction / speed (climate card)
    private View mVentDefrost;
    private View mVentFace;
    private View mVentFeet;
    private View mFanSpeedBtn;
    private int mFanDirection = CarHvacFanDirection.FACE;
    private int mFanSpeed = 3;
    private static final int FAN_SPEED_MIN = 1;
    private static final int FAN_SPEED_MAX = 7;

    // Chrome scrims
    private View mHeaderUxScrim;
    private View mHeaderVhalScrim;
    private final java.util.ArrayList<View> mMainThreadHosts = new java.util.ArrayList<View>();
    

    private final CarPropertyManager.CarPropertyEventCallback mHvacCallback =
            new CarPropertyManager.CarPropertyEventCallback() {
                @Override
                public void onChangeEvent(CarPropertyValue value) {
                    if (value == null) {
                        return;
                    }
                    int area = value.getAreaId();
                    int prop = value.getPropertyId();
                    Object raw = value.getValue();
                    if (prop == VehiclePropertyIds.HVAC_TEMPERATURE_SET && raw instanceof Float) {
                        float temp = (Float) raw;
                        runOnViewThread(() -> updateHvacDisplay(area, temp));
                    } else if (prop == VehiclePropertyIds.HVAC_TEMPERATURE_DISPLAY_UNITS
                            && raw instanceof Integer) {
                        boolean fahrenheit = HvacTemperatureUnits.isFahrenheit((Integer) raw);
                        runOnViewThread(() -> {
                            mFahrenheit = fahrenheit;
                            refreshAllDisplays();
                        });
                    } else if (prop == VehiclePropertyIds.HVAC_SEAT_TEMPERATURE
                            && raw instanceof Integer) {
                        int seatTemp = (Integer) raw;
                        runOnViewThread(() -> updateSeatDisplay(area, seatTemp));
                    } else if (prop == VehiclePropertyIds.HVAC_FAN_DIRECTION
                            && raw instanceof Integer && area == AREA_DRIVER) {
                        int dir = (Integer) raw;
                        runOnViewThread(() -> updateFanDirectionUi(dir));
                    } else if (prop == VehiclePropertyIds.HVAC_FAN_SPEED
                            && raw instanceof Integer && area == AREA_DRIVER) {
                        int speed = (Integer) raw;
                        runOnViewThread(() -> {
                            mFanSpeed = speed;
                            refreshFanSpeedUi();
                        });
                    }
                }

                @Override
                public void onErrorEvent(int propertyId, int zone) {
                    Log.e(TAG, "VHAL error property=" + propertyId + " zone=" + zone);
                }
            };

    public CarSysuiScalableHeaderController(Context context) {
        this(context, "sysui_scalable_header_panel", DEFAULT_RRO_PACKAGE);
    }

    public CarSysuiScalableHeaderController(Context context, String panelId, String rroPackage) {
        super(context, panelId, rroPackage);
    }

    /**
     * Creates header controllers from the parsed panel controller XML; the
     * RroPackage tag overrides the built-in default overlay package.
     */
    public static class Factory
            implements DecorPanelController.Factory<CarSysuiScalableHeaderController> {
        private final Context mContext;

        public Factory(Context context) {
            mContext = context;
        }

        @Override
        public CarSysuiScalableHeaderController create(String panelId,
                PanelControllerMetadata metadata) {
            return new CarSysuiScalableHeaderController(
                    mContext,
                    panelId,
                    configOrDefault(metadata, PanelControllerParser.RRO_PACKAGE_TAG,
                            DEFAULT_RRO_PACKAGE));
        }
    }

    @Override
    protected String getLayoutResourceName() {
        if ("oem_climate_card".equals(mPanelId)
                || "sysui_driver_zone_panel".equals(mPanelId)) {
            // oem_climate_card.xml panel id is sysui_driver_zone_panel — use OEM layout.
            return "oem_climate_card";
        }
        if ("sysui_passenger_zone_panel".equals(mPanelId)) {
            return "car_sysui_scalable_header_passenger_zone";
        }
        if ("launcher_pill_left".equals(mPanelId)) {
            return "launcher_pill_left";
        }
        if ("launcher_pill_center".equals(mPanelId)) {
            return "launcher_pill_center";
        }
        if ("launcher_pill_right".equals(mPanelId)) {
            return "launcher_pill_right";
        }
        return "car_sysui_scalable_header";
    }

    @Override
    protected void bindViews(View root) {
        bindDriverZone(root);
        bindPassengerZone(root);
        bindClimateExtras(root);
        bindChromeScrim(root);
        wireClickListeners();
        wireDesignScreen(root);
        wireNightMode(root);
        wireStatusPills(root);
    }

    /**
     * Status-pill control that toggles day and night the same way the stock
     * dark-theme quick-settings tile does: {@link UiModeManager#setNightModeActivated}.
     * The icon shows the theme the next tap will switch to.
     */
    private void wireNightMode(View root) {
        if (root == null) {
            return;
        }
        int id = resolveRroId("sysui_night_mode");
        if (id == 0) {
            return;
        }
        View button = root.findViewById(id);
        if (button == null) {
            return;
        }
        updateNightModeIcon(button, isNightMode());
        button.setOnClickListener(v -> toggleNightMode(v));
    }

    private void toggleNightMode(View button) {
        UiModeManager uiModeManager = mContext.getSystemService(UiModeManager.class);
        if (uiModeManager == null) {
            return;
        }
        boolean enableNight = !isNightMode();
        uiModeManager.setNightModeActivated(enableNight);
        updateNightModeIcon(button, enableNight);
    }

    private boolean isNightMode() {
        int uiMode = mContext.getResources().getConfiguration().uiMode;
        return (uiMode & Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES;
    }

    private void updateNightModeIcon(View button, boolean night) {
        if (button instanceof ImageView) {
            int drawable = resolveRroDrawable(night ? "ic_status_day" : "ic_status_night");
            if (drawable != 0) {
                try {
                    ((ImageView) button).setImageResource(drawable);
                } catch (RuntimeException e) {
                    Log.w(TAG, "night mode icon", e);
                }
            }
        }
        String label = resolveRroString(night ? "launcher_light_theme" : "launcher_dark_theme");
        button.setContentDescription(label != null ? label : (night ? "Light theme" : "Dark theme"));
    }

    /**
     * Left pill opens the stock connectivity, Bluetooth, display, and volume
     * quick-control panels. The right pill opens the stock profile switcher and hosts the stock
     * camera and mic privacy chips. The top system bar stays disabled. Day/night
     * stays a local toggle via {@link #wireNightMode}. If a stock panel cannot be
     * created, that icon falls back to the matching Settings screen.
     */
    private void wireStatusPills(View root) {
        if (root == null) {
            return;
        }
        if ("launcher_pill_left".equals(mPanelId)) {
            View stockBar = inflateSystemUiLayout("qc_status_icons_horizontal");
            // Quick-control popups update on the main thread. Decor panels attach
            // on the shell thread, so a panel opened from a pill crashes SystemUI.
            // The stock button lives in its own window, aligned to the decor slot,
            // and is not drawn. The pill layout is the only chrome.
            bindMainThreadPanel(root, "launcher_status_wifi_slot",
                    "launcher_status_wifi", stockBar, "qc_connectivity_panel",
                    Settings.ACTION_WIFI_SETTINGS);
            bindMainThreadPanel(root, "launcher_status_bluetooth_slot",
                    "launcher_status_bluetooth", stockBar, "qc_bluetooth_panel",
                    Settings.ACTION_BLUETOOTH_SETTINGS);
            bindMainThreadPanel(root, "launcher_status_brightness_slot",
                    "launcher_status_brightness", stockBar, "qc_display_panel",
                    Settings.ACTION_DISPLAY_SETTINGS);
            bindMainThreadPanel(root, "launcher_status_volume_slot",
                    "launcher_status_volume", stockBar, "qc_volume_panel",
                    Settings.ACTION_SOUND_SETTINGS);
        }
        wireUserProfile(root);
        wirePrivacyChips(root);
    }

    /**
     * Puts the stock panel button in a window owned by the main thread, aligned
     * to the pill slot. Quick-control updates run on that thread; hosting the
     * button on the shell thread crashes once the panel content refreshes.
     * The stock view is not drawn. The decor pill stays the only visible chrome.
     */
    private void bindMainThreadPanel(View root, String slotName, String fallbackName,
            View stockTree, String panelLayout, String settingsAction) {
        int slotId = resolveRroId(slotName);
        View slot = slotId == 0 ? null : root.findViewById(slotId);
        View panel = stockTree == null ? null : detachPanelButton(stockTree, panelLayout);
        if (!(slot instanceof ViewGroup) || panel == null) {
            wireSettingsButton(root, fallbackName, settingsAction);
            return;
        }
        if ("main-hosted".equals(String.valueOf(slot.getTag()))) {
            return;
        }
        slot.setTag("main-hosted");
        if (panel.getParent() instanceof ViewGroup) {
            ((ViewGroup) panel.getParent()).removeView(panel);
        }
        panel.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        panel.setMinimumWidth(0);
        panel.setMinimumHeight(0);
        panel.setBackground(null);
        panel.setClickable(true);
        FrameLayout host = new FrameLayout(mContext);
        host.addView(panel);
        View.OnLayoutChangeListener layout = (v, left, top, right, bottom, ol, ot, or, ob) ->
                placeMainThreadHost(slot, host, right - left, bottom - top,
                        fallbackName, settingsAction, true);
        slot.addOnLayoutChangeListener(layout);
        if (slot.getWidth() > 0 && slot.getHeight() > 0) {
            placeMainThreadHost(slot, host, slot.getWidth(), slot.getHeight(),
                    fallbackName, settingsAction, true);
        }
        Log.i(TAG, "main-thread panel " + panelLayout + " -> " + slotName);
    }

    private void placeMainThreadHost(View anchor, View host, int width, int height,
            String fallbackName, String settingsAction, boolean hideChrome) {
        if (width <= 0 || height <= 0 || anchor == null) {
            return;
        }
        // Decor surfaces report getLocationOnScreen as if the panel starts at
        // the origin. The leash is actually at the panel's decor bounds.
        int[] loc = new int[2];
        anchor.getLocationOnScreen(loc);
        int[] origin = new int[2];
        View panelRoot = anchor.getRootView();
        if (panelRoot != null) {
            panelRoot.getLocationOnScreen(origin);
        }
        Rect bounds = decorPanelBounds();
        final int x = bounds.left + loc[0] - origin[0];
        final int y = bounds.top + loc[1] - origin[1];
        Log.i(TAG, "place " + mPanelId + " local=" + loc[0] + "," + loc[1]
                + " bounds=" + bounds + " -> " + x + "," + y
                + " " + width + "x" + height);
        mContext.getMainExecutor().execute(() -> {
            if (!ensureMainThreadHost(host, x, y, width, height)) {
                Log.e(TAG, "main-thread host failed");
                if (fallbackName != null && settingsAction != null) {
                    anchor.post(() -> wireSettingsButton(anchor.getRootView(),
                            fallbackName, settingsAction));
                }
                return;
            }
            if (host.getTag() == null) {
                if (!initializeElements((ViewGroup) host)) {
                    removeMainThreadHost(host);
                    return;
                }
                host.setTag(Boolean.TRUE);
                Log.i(TAG, "main-thread panel ready");
            }
            if (hideChrome) {
                fadeStockChrome(host);
            }
        });
    }

    /** Screen bounds of this decor panel. Empty if the state is not ready yet. */
    private Rect decorPanelBounds() {
        try {
            Object state = com.android.car.scalableui.manager.StateManager.class
                    .getMethod("getPanelState", String.class)
                    .invoke(null, mPanelId);
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
            Log.w(TAG, "decorPanelBounds", t);
        }
        return new Rect();
    }

    private static void fadeStockChrome(View host) {
        if (!(host instanceof ViewGroup)) {
            return;
        }
        ViewGroup group = (ViewGroup) host;
        for (int i = 0; i < group.getChildCount(); i++) {
            View child = group.getChildAt(i);
            child.setAlpha(0f);
            child.setBackground(null);
        }
    }

    private boolean ensureMainThreadHost(View host, int x, int y, int width, int height) {
        WindowManager wm = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
        if (wm == null) {
            return false;
        }
        if (host.getParent() != null) {
            WindowManager.LayoutParams lp = (WindowManager.LayoutParams) host.getLayoutParams();
            lp.x = x;
            lp.y = y;
            lp.width = width;
            lp.height = height;
            try {
                wm.updateViewLayout(host, lp);
                return true;
            } catch (Throwable t) {
                Log.w(TAG, "update panel host", t);
                return false;
            }
        }
        WindowManager.LayoutParams lp = new WindowManager.LayoutParams(
                width, height,
                2017,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
                        | WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
                        | WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
                PixelFormat.TRANSLUCENT);
        lp.gravity = Gravity.TOP | Gravity.START;
        lp.x = x;
        lp.y = y;
        lp.alpha = 1f;
        lp.setTitle("LauncherQcPanel");
        try {
            lp.getClass().getMethod("setTrustedOverlay").invoke(lp);
        } catch (Throwable t) {
            Log.w(TAG, "setTrustedOverlay", t);
        }
        // Stock layouts share ids. The state controller refuses a second
        // view with the same id, so each host window gets its own ids.
        assignUniqueIds(host);
        if (!addHostView(wm, host, lp)) {
            lp.type = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY;
            if (!addHostView(wm, host, lp)) {
                return false;
            }
        }
        mMainThreadHosts.add(host);
        return true;
    }

    private boolean addHostView(WindowManager wm, View host, WindowManager.LayoutParams lp) {
        try {
            wm.addView(host, lp);
            return true;
        } catch (Throwable t) {
            Log.w(TAG, "window type " + lp.type + " failed", t);
            return false;
        }
    }

    private void removeMainThreadHost(View host) {
        WindowManager wm = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
        try {
            if (wm != null && host.getParent() != null) {
                wm.removeView(host);
            }
        } catch (Throwable t) {
            Log.w(TAG, "remove panel host", t);
        }
        mMainThreadHosts.remove(host);
    }

    private static void assignUniqueIds(View view) {
        view.setId(View.generateViewId());
        // PrivacyChip resolves its own children by id (setOnClickListener does
        // requireViewById). Rewriting those ids makes the chip controller's
        // onInit throw "ID does not reference a View inside this View", and the
        // whole chip window is then torn down. Only the chip root gets a new id.
        if (view.getClass().getName().endsWith("PrivacyChip")) {
            return;
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                assignUniqueIds(group.getChildAt(i));
            }
        }
    }

    private void removeMainThreadHosts() {
        java.util.ArrayList<View> hosts = new java.util.ArrayList<View>(mMainThreadHosts);
        for (View host : hosts) {
            removeMainThreadHost(host);
        }
    }

    /**
     * Moves the stock {@code CarSystemBarPanelButtonView} for {@code panelLayout}
     * into the pill slot and lets SystemUI bind its quick-control popup.
     * The popup anchors to that button, so the button has to live in the slot.
     * {@code invisibleHitTarget} keeps the pill's own icon and label visible and
     * uses the stock button only as the touch target.
     */
    private void bindStockPanelOrSettings(View root, String slotName, String fallbackName,
            View stockTree, String panelLayout, String settingsAction,
            boolean invisibleHitTarget) {
        int slotId = resolveRroId(slotName);
        View slot = slotId == 0 ? null : root.findViewById(slotId);
        View panel = stockTree == null ? null : detachPanelButton(stockTree, panelLayout);
        if (slot instanceof ViewGroup && panel != null
                && installStockPanel((ViewGroup) slot, panel, fallbackName, invisibleHitTarget)) {
            Log.i(TAG, "stock panel " + panelLayout + " -> " + slotName);
            return;
        }
        if (panel != null && panel.getParent() instanceof ViewGroup) {
            ((ViewGroup) panel.getParent()).removeView(panel);
        }
        wireSettingsButton(root, fallbackName, settingsAction);
    }

    private boolean installStockPanel(ViewGroup slot, View panel, String fallbackName,
            boolean invisibleHitTarget) {
        int fallbackId = resolveRroId(fallbackName);
        View fallback = fallbackId == 0 ? null : slot.findViewById(fallbackId);
        if (fallback != null) {
            fallback.setVisibility(invisibleHitTarget ? View.VISIBLE : View.GONE);
        }
        panel.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        panel.setMinimumWidth(0);
        panel.setMinimumHeight(0);
        panel.setBackground(null);
        // Profile keeps the pill's own icon and name. The stock button is only
        // the touch target, because the popup anchors to the button view itself.
        panel.setAlpha(invisibleHitTarget ? 0f : 1f);
        slot.addView(panel);
        if (initializeElements(slot)) {
            panel.setBackground(null);
            if (invisibleHitTarget) {
                panel.setAlpha(0f);
            }
            return true;
        }
        slot.removeView(panel);
        if (fallback != null) {
            fallback.setVisibility(View.VISIBLE);
        }
        return false;
    }

    /** @return the stock panel button, detached from {@code stockTree}. */
    private View detachPanelButton(View stockTree, String panelLayout) {
        int panelLayoutId = mContext.getResources().getIdentifier(
                panelLayout, "layout", "com.android.systemui");
        if (panelLayoutId == 0) {
            Log.e(TAG, "SystemUI panel layout missing: " + panelLayout);
            return null;
        }
        View button = findPanelButton(stockTree, panelLayoutId);
        if (button == null) {
            Log.e(TAG, "panel button missing: " + panelLayout);
            return null;
        }
        if (button.getParent() instanceof ViewGroup) {
            ((ViewGroup) button.getParent()).removeView(button);
        }
        return button;
    }

    private View findPanelButton(View view, int panelLayoutId) {
        if (view.getClass().getName().endsWith("CarSystemBarPanelButtonView")) {
            try {
                Field field = view.getClass().getDeclaredField("mPanelLayoutRes");
                field.setAccessible(true);
                if (field.getInt(view) == panelLayoutId) {
                    return view;
                }
            } catch (Throwable t) {
                Log.w(TAG, "mPanelLayoutRes", t);
            }
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                View found = findPanelButton(group.getChildAt(i), panelLayoutId);
                if (found != null) {
                    return found;
                }
            }
        }
        return null;
    }

    private boolean initializeElements(ViewGroup group) {
        Object initializer = systemBarElementInitializer();
        if (initializer == null) {
            Log.e(TAG, "system bar element initializer unavailable");
            return false;
        }
        try {
            initializer.getClass()
                    .getMethod("initializeCarSystemBarElements", ViewGroup.class)
                    .invoke(initializer, group);
            return true;
        } catch (Throwable t) {
            Log.e(TAG, "initializeCarSystemBarElements failed", t);
            return false;
        }
    }

    private void wireSettingsButton(View root, String name, String action) {
        int id = resolveRroId(name);
        if (id == 0) {
            return;
        }
        View button = root.findViewById(id);
        if (button == null) {
            return;
        }
        button.setOnClickListener(v -> openSettings(action));
    }

    private void openSettings(String action) {
        Intent intent = new Intent(action);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        int userId = ActivityManager.getCurrentUser();
        try {
            mContext.startActivityAsUser(intent, UserHandle.of(userId));
            Log.i(TAG, "openSettings " + action + " user=" + userId);
        } catch (Throwable t) {
            Log.e(TAG, "openSettings failed " + action, t);
        }
    }

    private void wireUserProfile(View root) {
        int nameId = resolveRroId("launcher_user_name");
        if (nameId != 0) {
            View nameView = root.findViewById(nameId);
            if (nameView instanceof TextView) {
                ((TextView) nameView).setText(currentUserName());
            }
        }
        if (!"launcher_pill_right".equals(mPanelId)) {
            return;
        }
        View profileTree = inflateSystemUiLayout("user_name_container");
        bindMainThreadPanel(root, "launcher_user_anchor", "launcher_user_profile",
                profileTree, "qc_profile_switcher", Settings.ACTION_USER_SETTINGS);
    }

    /**
     * Hosts the stock camera and microphone privacy chips in the profile pill.
     * Their view controllers track sensor privacy and app-op usage, pick the
     * status-bar icons, and open the same quick-control panels as the system bar.
     * The top system bar stays disabled.
     */
    private void wirePrivacyChips(View root) {
        if (!"launcher_pill_right".equals(mPanelId)) {
            return;
        }
        int containerId = resolveRroId("launcher_privacy_chips");
        if (containerId == 0) {
            return;
        }
        View container = root.findViewById(containerId);
        if (!(container instanceof ViewGroup)) {
            return;
        }
        ViewGroup group = (ViewGroup) container;
        if ("main-hosted".equals(String.valueOf(group.getTag()))) {
            return;
        }
        View camera = inflateSystemUiLayout("camera_privacy_chip");
        View mic = inflateSystemUiLayout("mic_privacy_chip");
        int chipWidth = privacyChipWidth();
        int chipGap = privacyChipGap();
        android.widget.LinearLayout host = new android.widget.LinearLayout(mContext);
        host.setOrientation(android.widget.LinearLayout.HORIZONTAL);
        host.setGravity(Gravity.CENTER_VERTICAL);
        int span = 0;
        if (camera != null) {
            host.addView(camera, chipLayoutParams(chipWidth));
            span += chipWidth;
        }
        if (mic != null) {
            android.widget.LinearLayout.LayoutParams micParams = chipLayoutParams(chipWidth);
            if (span > 0) {
                micParams.setMarginStart(chipGap);
                span += chipGap;
            }
            host.addView(mic, micParams);
            span += chipWidth;
        }
        if (span == 0) {
            return;
        }
        group.setTag("main-hosted");
        // Reserves room in the pill for the chips. Collapsed while both chips
        // are hidden so the avatar and name stay centered in the capsule.
        final View spacer = new View(mContext);
        spacer.setVisibility(View.GONE);
        group.addView(spacer, chipLayoutParams(span));
        final int hostWidth = span;
        View.OnLayoutChangeListener layout = (v, l, t, r, b, ol, ot, or, ob) ->
                placeMainThreadHost(group, host, hostWidth, group.getHeight(),
                        null, null, false);
        group.addOnLayoutChangeListener(layout);
        if (group.getHeight() > 0) {
            placeMainThreadHost(group, host, hostWidth, group.getHeight(),
                    null, null, false);
        }
        // The chip controllers toggle visibility on the main thread, which
        // relayouts the host window. Mirror that onto the shell-thread spacer.
        host.getViewTreeObserver().addOnGlobalLayoutListener(
                () -> syncPrivacySpacer(host, spacer));
        Log.i(TAG, "privacy chips hosted on main thread");
    }

    /**
     * Shows the reserved chip slot only while at least one chip is drawn.
     * While the slot is collapsed the chip window overlaps the avatar, so it
     * is also made untouchable; otherwise it would swallow profile taps.
     * Runs on the main thread (host window layout).
     */
    private void syncPrivacySpacer(ViewGroup host, View spacer) {
        boolean anyShown = false;
        for (int i = 0; i < host.getChildCount(); i++) {
            View chip = host.getChildAt(i);
            if (chip.getVisibility() == View.VISIBLE && chip.getAlpha() > 0.01f) {
                anyShown = true;
                break;
            }
        }
        final int visibility = anyShown ? View.VISIBLE : View.GONE;
        if (spacer.getVisibility() != visibility) {
            spacer.post(() -> spacer.setVisibility(visibility));
        }
        ViewGroup.LayoutParams params = host.getLayoutParams();
        if (!(params instanceof WindowManager.LayoutParams) || host.getParent() == null) {
            return;
        }
        WindowManager.LayoutParams lp = (WindowManager.LayoutParams) params;
        int flags = anyShown
                ? lp.flags & ~WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
                : lp.flags | WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE;
        if (flags == lp.flags) {
            return;
        }
        lp.flags = flags;
        WindowManager wm = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
        if (wm == null) {
            return;
        }
        try {
            wm.updateViewLayout(host, lp);
        } catch (Throwable t) {
            Log.w(TAG, "privacy chip host touchability", t);
        }
    }

    private View inflateSystemUiLayout(String layoutName) {
        int layoutId = mContext.getResources().getIdentifier(
                layoutName, "layout", "com.android.systemui");
        if (layoutId == 0) {
            Log.e(TAG, "SystemUI layout missing: " + layoutName);
            return null;
        }
        try {
            // Null parent: the pill is an overlay view, and generating layout
            // params from it cannot resolve SystemUI dimens on the chip.
            return LayoutInflater.from(mContext).inflate(layoutId, null);
        } catch (Throwable t) {
            Log.e(TAG, "inflate " + layoutName, t);
            return null;
        }
    }

    private int privacyChipWidth() {
        int id = mContext.getResources().getIdentifier(
                "privacy_chip_width", "dimen", "com.android.systemui");
        if (id != 0) {
            return mContext.getResources().getDimensionPixelSize(id);
        }
        return (int) android.util.TypedValue.applyDimension(
                android.util.TypedValue.COMPLEX_UNIT_DIP, 56,
                mContext.getResources().getDisplayMetrics());
    }

    /** Space between the camera and mic chips when both are showing. */
    private int privacyChipGap() {
        return (int) android.util.TypedValue.applyDimension(
                android.util.TypedValue.COMPLEX_UNIT_DIP, 12,
                mContext.getResources().getDisplayMetrics());
    }

    private static android.widget.LinearLayout.LayoutParams chipLayoutParams(int width) {
        return new android.widget.LinearLayout.LayoutParams(
                width, ViewGroup.LayoutParams.MATCH_PARENT);
    }

    /**
     * The privacy-chip controllers and their panels are created by SystemUI's
     * dagger graph. This library cannot depend on those classes, so the
     * initializer is read from the running SystemUI component.
     */
    private Object systemBarElementInitializer() {
        try {
            Object app = mContext.getApplicationContext();
            Object component = null;
            try {
                component = readField(app, "mSysUIComponent");
            } catch (NoSuchFieldException ignored) {
                Object initializer = readField(app, "mInitializer");
                component = readField(initializer, "mSysUIComponent");
            }
            if (component == null) {
                return null;
            }
            Object provider = readField(component, "carSystemBarElementInitializerProvider");
            if (provider == null) {
                return null;
            }
            return provider.getClass().getMethod("get").invoke(provider);
        } catch (Throwable t) {
            Log.e(TAG, "systemBarElementInitializer", t);
            return null;
        }
    }

    private static Object readField(Object target, String name) throws ReflectiveOperationException {
        for (Class<?> type = target.getClass(); type != null; type = type.getSuperclass()) {
            try {
                Field field = type.getDeclaredField(name);
                field.setAccessible(true);
                return field.get(target);
            } catch (NoSuchFieldException ignored) {
                // Walk to the superclass.
            }
        }
        throw new NoSuchFieldException(name);
    }

    private String currentUserName() {
        try {
            UserManager userManager = mContext.getSystemService(UserManager.class);
            if (userManager != null) {
                // SystemUI runs as user 0 ("System User"). The pill should name
                // the foreground user, which is the driver profile.
                UserInfo info = userManager.getUserInfo(ActivityManager.getCurrentUser());
                if (info != null && info.name != null && !info.name.isEmpty()) {
                    return info.name;
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "currentUserName", t);
        }
        return "Profile";
    }

    /** Opens the design climate or vehicle screen when the card is tapped. */
    private void wireDesignScreen(View root) {
        String className = null;
        if ("sysui_driver_zone_panel".equals(mPanelId)
                || "oem_climate_card".equals(mPanelId)) {
            className = "com.test.design.presentation.ivi.glanceables.ClimatePanelActivity";
        } else if ("sysui_passenger_zone_panel".equals(mPanelId)
                || "oem_car_status_card".equals(mPanelId)) {
            className = "com.test.design.presentation.ivi.glanceables.VehiclePanelActivity";
        }
        if (className == null || root == null) {
            return;
        }
        final String component = className;
        wireDesignClick(root, v -> launchDesignScreen(component));
    }

    /** Keep HVAC +/- listeners. Every other tap opens the design screen. */
    private void wireDesignClick(View view, View.OnClickListener listener) {
        boolean keepHvac = view instanceof ImageButton && view.hasOnClickListeners();
        if (!keepHvac) {
            view.setOnClickListener(listener);
        }
        if (view instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) view;
            for (int i = 0; i < group.getChildCount(); i++) {
                wireDesignClick(group.getChildAt(i), listener);
            }
        }
    }

    private void launchDesignScreen(String className) {
        Intent intent = new Intent();
        intent.setComponent(new ComponentName("com.test.design", className));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        int userId = ActivityManager.getCurrentUser();
        try {
            mContext.startActivityAsUser(intent, UserHandle.of(userId));
            Log.i(TAG, "launchDesignScreen " + className + " user=" + userId);
        } catch (Throwable t) {
            Log.e(TAG, "launchDesignScreen failed " + className, t);
        }
    }

    private void bindClimateExtras(View root) {
        mVentDefrost = findButton(root, "oem_vent_defrost");
        mVentFace = findButton(root, "oem_vent_face");
        mVentFeet = findButton(root, "oem_vent_feet");
        mFanSpeedBtn = findButton(root, "oem_fan_speed");
        if (mFanSpeedBtn == null) {
            int id = resolveRroId("oem_fan_speed");
            mFanSpeedBtn = id != 0 ? root.findViewById(id) : null;
        }
    }

    private void bindDriverZone(View root) {
        int rootId = resolveRroId("sysui_driver_zone_root");
        mDriverZoneRoot = rootId != 0 ? root.findViewById(rootId) : null;

        int hvacTempId = resolveRroId("sysui_driver_hvac_temp");
        mDriverHvacTempText = hvacTempId != 0 ? root.findViewById(hvacTempId) : null;
        mDriverHvacUp = findButton(root, "sysui_driver_hvac_up");
        mDriverHvacDown = findButton(root, "sysui_driver_hvac_down");

        int seatTempId = resolveRroId("sysui_driver_seat_temp");
        mDriverSeatTempText = seatTempId != 0 ? root.findViewById(seatTempId) : null;
        mDriverSeatUp = findButton(root, "sysui_driver_seat_up");
        mDriverSeatDown = findButton(root, "sysui_driver_seat_down");
    }

    private void bindPassengerZone(View root) {
        int rootId = resolveRroId("sysui_passenger_zone_root");
        mPassengerZoneRoot = rootId != 0 ? root.findViewById(rootId) : null;

        int hvacTempId = resolveRroId("sysui_passenger_hvac_temp");
        mPassengerHvacTempText = hvacTempId != 0 ? root.findViewById(hvacTempId) : null;
        mPassengerHvacUp = findButton(root, "sysui_passenger_hvac_up");
        mPassengerHvacDown = findButton(root, "sysui_passenger_hvac_down");

        int seatTempId = resolveRroId("sysui_passenger_seat_temp");
        mPassengerSeatTempText = seatTempId != 0 ? root.findViewById(seatTempId) : null;
        mPassengerSeatUp = findButton(root, "sysui_passenger_seat_up");
        mPassengerSeatDown = findButton(root, "sysui_passenger_seat_down");
    }

    private void bindChromeScrim(View root) {
        int uxId = resolveRroId("sysui_header_ux_scrim");
        mHeaderUxScrim = uxId != 0 ? root.findViewById(uxId) : null;
        int vhalId = resolveRroId("sysui_header_vhal_scrim");
        mHeaderVhalScrim = vhalId != 0 ? root.findViewById(vhalId) : null;
    }

    private ImageButton findButton(View root, String name) {
        int id = resolveRroId(name);
        return id != 0 ? root.findViewById(id) : null;
    }

    private void wireClickListeners() {
        if (mDriverHvacUp != null) {
            mDriverHvacUp.setOnClickListener(v -> adjustHvac(AREA_DRIVER, 1));
        }
        if (mDriverHvacDown != null) {
            mDriverHvacDown.setOnClickListener(v -> adjustHvac(AREA_DRIVER, -1));
        }
        if (mDriverSeatUp != null) {
            mDriverSeatUp.setOnClickListener(v -> adjustSeat(AREA_DRIVER, SEAT_TEMP_STEP));
        }
        if (mDriverSeatDown != null) {
            mDriverSeatDown.setOnClickListener(v -> adjustSeat(AREA_DRIVER, -SEAT_TEMP_STEP));
        }
        if (mPassengerHvacUp != null) {
            mPassengerHvacUp.setOnClickListener(v -> adjustHvac(AREA_PASSENGER, 1));
        }
        if (mPassengerHvacDown != null) {
            mPassengerHvacDown.setOnClickListener(v -> adjustHvac(AREA_PASSENGER, -1));
        }
        if (mPassengerSeatUp != null) {
            mPassengerSeatUp.setOnClickListener(v -> adjustSeat(AREA_PASSENGER, SEAT_TEMP_STEP));
        }
        if (mPassengerSeatDown != null) {
            mPassengerSeatDown.setOnClickListener(
                    v -> adjustSeat(AREA_PASSENGER, -SEAT_TEMP_STEP));
        }
        if (mVentDefrost != null) {
            mVentDefrost.setOnClickListener(
                    v -> setFanDirection(CarHvacFanDirection.DEFROST));
        }
        if (mVentFace != null) {
            mVentFace.setOnClickListener(
                    v -> setFanDirection(CarHvacFanDirection.FACE));
        }
        if (mVentFeet != null) {
            mVentFeet.setOnClickListener(
                    v -> setFanDirection(CarHvacFanDirection.FLOOR));
        }
        if (mFanSpeedBtn != null) {
            mFanSpeedBtn.setOnClickListener(v -> cycleFanSpeed());
        }
        // Climate card: tap header / big temp → Design ClimatePanel (AOSP HVAC fallback).
        if ("oem_climate_card".equals(mPanelId)
                || "sysui_driver_zone_panel".equals(mPanelId)) {
            if (mDriverHvacTempText != null) {
                mDriverHvacTempText.setClickable(true);
                mDriverHvacTempText.setFocusable(true);
                mDriverHvacTempText.setOnClickListener(v -> launchClimatePanel());
            }
            View header = findClickable(mView != null ? mView : mDriverZoneRoot, "oem_card_header");
            if (header == null && mDriverZoneRoot != null) {
                // Prefer first child row (title) when id not present yet.
                if (mDriverZoneRoot instanceof android.view.ViewGroup) {
                    android.view.ViewGroup vg = (android.view.ViewGroup) mDriverZoneRoot;
                    if (vg.getChildCount() > 0) {
                        header = vg.getChildAt(0);
                    }
                }
            }
            if (header != null) {
                header.setClickable(true);
                header.setFocusable(true);
                header.setOnClickListener(v -> launchClimatePanel());
                header.setOnLongClickListener(v -> {
                    launchVehiclePanel();
                    return true;
                });
            }
            View expand = findClickable(mView != null ? mView : mDriverZoneRoot, "oem_card_expand");
            if (expand != null) {
                expand.setOnClickListener(v -> launchVehiclePanel());
                expand.setContentDescription("Vehicle");
            }
        }
    }

    private View findClickable(View root, String name) {
        if (root == null) {
            return null;
        }
        int id = resolveRroId(name);
        View view = id != 0 ? root.findViewById(id) : null;
        if (view != null) {
            view.setClickable(true);
            view.setFocusable(true);
        }
        return view;
    }

    /**
     * Opens Design ClimatePanel via OPEN_CLIMATE; falls back to AOSP HVAC overlay.
     */
    private void launchClimatePanel() {
        if (mFullyRestricted) {
            return;
        }
        if (startDesignPanel(DESIGN_ACTION_OPEN_CLIMATE, DESIGN_CLIMATE_COMPONENT)) {
            Log.i(TAG, "launchClimatePanel → Design ClimatePanelActivity");
            return;
        }
        int userId = ActivityManager.getCurrentUser();
        Log.i(TAG, "launchClimatePanel → TOGGLE_HVAC_PANEL user=" + userId);
        Intent toggle = new Intent("com.android.systemui.car.action.TOGGLE_HVAC_PANEL");
        toggle.setPackage("com.android.systemui");
        toggle.addFlags(Intent.FLAG_RECEIVER_FOREGROUND);
        try {
            mContext.sendBroadcastAsUser(toggle, UserHandle.of(userId));
        } catch (Exception e) {
            Log.w(TAG, "sendBroadcastAsUser failed, trying sendBroadcast", e);
            try {
                mContext.sendBroadcast(toggle);
            } catch (Exception e2) {
                Log.w(TAG, "TOGGLE_HVAC_PANEL failed", e2);
            }
        }
    }

    /** Opens Design VehiclePanel via OPEN_VEHICLE. */
    private void launchVehiclePanel() {
        if (mFullyRestricted) {
            return;
        }
        if (startDesignPanel(DESIGN_ACTION_OPEN_VEHICLE, DESIGN_VEHICLE_COMPONENT)) {
            Log.i(TAG, "launchVehiclePanel → Design VehiclePanelActivity");
            return;
        }
        Log.w(TAG, "launchVehiclePanel: Design package missing");
        dispatchScalableEvent("toggle_card_expand_climate");
    }

    private void dispatchScalableEvent(String eventId) {
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

    @Override
    protected void onControllerAttached() {
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_TEMPERATURE_DISPLAY_UNITS, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_DIRECTION, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_SPEED, 0, mHvacCallback);
        readInitialValues();
        refreshAllDisplays();
        // One watcher for every header instance. It posts orientation_portrait
        // or orientation_landscape so panel variants follow the display.
        OrientationLayoutWatcher.start(mContext);
        // Posts layout_variant_N from Settings.Global scalable_ui_layout_variant.
        LayoutVariantWatcher.start(mContext);
    }

    @Override
    protected void onControllerDetached() {
        mContext.getMainExecutor().execute(this::removeMainThreadHosts);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_TEMPERATURE_DISPLAY_UNITS);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_FAN_DIRECTION);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_FAN_SPEED);
    }

    private void readInitialValues() {
        readTemperatureDisplayUnit();
        Float driverTemp = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, AREA_DRIVER);
        if (driverTemp != null) {
            mDriverHvacTemp = driverTemp;
        }
        Float passengerTemp = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, AREA_PASSENGER);
        if (passengerTemp != null) {
            mPassengerHvacTemp = passengerTemp;
        }
        Integer driverSeat = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, AREA_DRIVER);
        if (driverSeat != null) {
            mDriverSeatTemp = driverSeat;
        }
        Integer passengerSeat = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, AREA_PASSENGER);
        if (passengerSeat != null) {
            mPassengerSeatTemp = passengerSeat;
        }
        Integer fanDir = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_FAN_DIRECTION, AREA_DRIVER);
        if (fanDir != null) {
            mFanDirection = fanDir;
        }
        Integer fanSpeed = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_FAN_SPEED, AREA_DRIVER);
        if (fanSpeed != null) {
            mFanSpeed = fanSpeed;
        }
    }

    private void readTemperatureDisplayUnit() {
        mFahrenheit = HvacTemperatureUnits.isFahrenheit(mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_DISPLAY_UNITS, 0));
        mTempScale = mVhalHelper.getHvacTemperatureScale();
        Log.i(TAG, "HVAC display unit=" + (mFahrenheit ? "F" : "C"));
    }

    private void adjustHvac(int area, int direction) {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        float current = area == AREA_DRIVER ? mDriverHvacTemp : mPassengerHvacTemp;
        Float live = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
        if (live != null) {
            current = live;
        }
        float next = clampHvac(area, HvacTemperatureUnits.nextSetpointCelsius(
                current, direction, mFahrenheit, mTempScale));
        // Already at the VHAL bound. Writing past it makes CarPropertyManager throw
        // IllegalStateException and crash SystemUI.
        if (Math.abs(next - current) < 0.01f) {
            updateHvacDisplay(area, current);
            return;
        }
        if (mVhalHelper.setFloatProperty(VehiclePropertyIds.HVAC_TEMPERATURE_SET, area, next)) {
            Float applied = mVhalHelper.getFloatProperty(
                    VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
            updateHvacDisplay(area, applied != null ? applied : next);
        }
    }

    private float clampHvac(int area, float value) {
        float[] range = mVhalHelper.getFloatRange(VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
        if (range == null) {
            return value;
        }
        return Math.max(range[0], Math.min(range[1], value));
    }

    private void adjustSeat(int area, int delta) {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        int current = area == AREA_DRIVER ? mDriverSeatTemp : mPassengerSeatTemp;
        int next = Math.max(SEAT_TEMP_MIN, Math.min(SEAT_TEMP_MAX, current + delta));
        if (mVhalHelper.setIntProperty(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, area, next)) {
            updateSeatDisplay(area, next);
        }
    }

    private void updateHvacDisplay(int area, float temp) {
        String text = HvacTemperatureUnits.format(temp, mFahrenheit, mTempScale);
        if (area == AREA_DRIVER) {
            mDriverHvacTemp = temp;
            if (mDriverHvacTempText != null) {
                mDriverHvacTempText.setText(text);
            }
        } else if (area == AREA_PASSENGER) {
            mPassengerHvacTemp = temp;
            if (mPassengerHvacTempText != null) {
                mPassengerHvacTempText.setText(text);
            }
        }
        refreshHvacButtons();
    }

    private void refreshHvacButtons() {
        boolean base = !mFullyRestricted && mVhalConnected;
        setHvacStepEnabled(mDriverHvacDown, mDriverHvacUp, mDriverHvacTemp, AREA_DRIVER, base);
        setHvacStepEnabled(mPassengerHvacDown, mPassengerHvacUp, mPassengerHvacTemp,
                AREA_PASSENGER, base);
    }

    private void setHvacStepEnabled(View down, View up, float temp, int area, boolean base) {
        boolean canDown = base;
        boolean canUp = base;
        if (base) {
            float[] range = mVhalHelper.getFloatRange(
                    VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
            if (range != null) {
                canDown = temp > range[0] + 0.01f;
                canUp = temp < range[1] - 0.01f;
            }
        }
        setViewEnabled(down, canDown);
        setViewEnabled(up, canUp);
    }

    private void updateSeatDisplay(int area, int seatTemp) {
        String text = String.valueOf(seatTemp);
        if (area == AREA_DRIVER) {
            mDriverSeatTemp = seatTemp;
            if (mDriverSeatTempText != null) {
                mDriverSeatTempText.setText(text);
            }
        } else if (area == AREA_PASSENGER) {
            mPassengerSeatTemp = seatTemp;
            if (mPassengerSeatTempText != null) {
                mPassengerSeatTempText.setText(text);
            }
        }
    }

    private void refreshAllDisplays() {
        updateHvacDisplay(AREA_DRIVER, mDriverHvacTemp);
        updateHvacDisplay(AREA_PASSENGER, mPassengerHvacTemp);
        updateSeatDisplay(AREA_DRIVER, mDriverSeatTemp);
        updateSeatDisplay(AREA_PASSENGER, mPassengerSeatTemp);
        updateFanDirectionUi(mFanDirection);
        refreshFanSpeedUi();
    }

    private void setFanDirection(int direction) {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        if (mVhalHelper.setIntProperty(
                VehiclePropertyIds.HVAC_FAN_DIRECTION, AREA_DRIVER, direction)) {
            updateFanDirectionUi(direction);
        }
    }

    private void cycleFanSpeed() {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        int next = mFanSpeed >= FAN_SPEED_MAX ? FAN_SPEED_MIN : mFanSpeed + 1;
        if (mVhalHelper.setIntProperty(
                VehiclePropertyIds.HVAC_FAN_SPEED, AREA_DRIVER, next)) {
            mFanSpeed = next;
            refreshFanSpeedUi();
        }
    }

    private void updateFanDirectionUi(int direction) {
        mFanDirection = direction;
        setClimateBtnActive(mVentFace, (direction & CarHvacFanDirection.FACE) != 0);
        setClimateBtnActive(mVentFeet, (direction & CarHvacFanDirection.FLOOR) != 0);
        setClimateBtnActive(mVentDefrost, (direction & CarHvacFanDirection.DEFROST) != 0);
    }

    private void refreshFanSpeedUi() {
        if (mFanSpeedBtn != null) {
            mFanSpeedBtn.setAlpha(0.45f + (0.55f * (mFanSpeed / (float) FAN_SPEED_MAX)));
            mFanSpeedBtn.setContentDescription("Fan speed " + mFanSpeed);
        }
    }

    private void setClimateBtnActive(View btn, boolean active) {
        if (btn == null || mRroContext == null) {
            return;
        }
        int res = resolveRroDrawable(active ? "oem_climate_btn_active" : "oem_climate_btn");
        if (res != 0) {
            btn.setBackground(mRroContext.getDrawable(res));
        }
    }

    @Override
    protected void applyUxRestrictions() {
        setScrimVisible(mHeaderUxScrim, mFullyRestricted);
        boolean enabled = !mFullyRestricted && mVhalConnected;
        refreshHvacButtons();
        setViewEnabled(mDriverSeatUp, enabled);
        setViewEnabled(mDriverSeatDown, enabled);
        setViewEnabled(mPassengerSeatUp, enabled);
        setViewEnabled(mPassengerSeatDown, enabled);
        setViewEnabled(mVentDefrost, enabled);
        setViewEnabled(mVentFace, enabled);
        setViewEnabled(mVentFeet, enabled);
        setViewEnabled(mFanSpeedBtn, enabled);
    }

    @Override
    protected void applyVhalDisconnectedState() {
        setScrimVisible(mHeaderVhalScrim, true);
        applyUxRestrictions();
    }

    @Override
    protected void applyVhalConnectedState() {
        setScrimVisible(mHeaderVhalScrim, false);
        // onControllerAttached can run before CarPropertyManager exists.
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_TEMPERATURE_DISPLAY_UNITS, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_DIRECTION, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_SPEED, 0, mHvacCallback);
        readInitialValues();
        refreshAllDisplays();
        applyUxRestrictions();
    }

    @Override
    protected void dumpControllerState(PrintWriter pw) {
        pw.println("  tempDisplayUnit=" + (mFahrenheit ? "F" : "C"));
        pw.println("  driverHvacTemp=" + mDriverHvacTemp + "C");
        pw.println("  passengerHvacTemp=" + mPassengerHvacTemp + "C");
        pw.println("  driverSeatTemp=" + mDriverSeatTemp);
        pw.println("  passengerSeatTemp=" + mPassengerSeatTemp);
        pw.println("  fanDirection=" + mFanDirection + " fanSpeed=" + mFanSpeed);
        pw.println("  panelLayout=" + getLayoutResourceName());
    }
}
