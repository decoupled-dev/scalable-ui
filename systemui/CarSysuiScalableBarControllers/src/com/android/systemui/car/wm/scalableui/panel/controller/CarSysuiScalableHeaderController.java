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
import android.content.res.Configuration;
import android.os.UserHandle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.android.car.scalableui.loader.xml.parser.PanelControllerParser;
import com.android.car.scalableui.model.PanelControllerMetadata;
import com.android.car.scalableui.panel.DecorPanelController;

import java.io.PrintWriter;
import java.util.Locale;

/**
 * Controller for the Pleos dual-zone header (driver + passenger HVAC and seat temperature).
 * Inflates RRO layouts via dynamic binding; all bounds are declared in panel XML variants.
 */
public class CarSysuiScalableHeaderController extends CarSysuiScalableBarControllerBase {

    private static final String TAG = "CarSysuiHeaderCtrl";
    private static final String DEFAULT_RRO_PACKAGE =
            "com.android.systemui.rro.scalableUI.sysuiBars";
    private static final float HVAC_STEP_CELSIUS = 0.5f;
    private static final int SEAT_TEMP_STEP = 1;
    private static final int SEAT_TEMP_MIN = 0;
    private static final int SEAT_TEMP_MAX = 3;

    private static final int AREA_DRIVER = VehicleAreaSeat.SEAT_ROW_1_LEFT;
    private static final int AREA_PASSENGER = VehicleAreaSeat.SEAT_ROW_1_RIGHT;

    private float mDriverHvacTemp = 22.0f;
    private float mPassengerHvacTemp = 22.0f;
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
        button.setContentDescription(night ? "Light theme" : "Dark theme");
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
            mDriverHvacUp.setOnClickListener(v -> adjustHvac(AREA_DRIVER, HVAC_STEP_CELSIUS));
        }
        if (mDriverHvacDown != null) {
            mDriverHvacDown.setOnClickListener(v -> adjustHvac(AREA_DRIVER, -HVAC_STEP_CELSIUS));
        }
        if (mDriverSeatUp != null) {
            mDriverSeatUp.setOnClickListener(v -> adjustSeat(AREA_DRIVER, SEAT_TEMP_STEP));
        }
        if (mDriverSeatDown != null) {
            mDriverSeatDown.setOnClickListener(v -> adjustSeat(AREA_DRIVER, -SEAT_TEMP_STEP));
        }
        if (mPassengerHvacUp != null) {
            mPassengerHvacUp.setOnClickListener(v -> adjustHvac(AREA_PASSENGER, HVAC_STEP_CELSIUS));
        }
        if (mPassengerHvacDown != null) {
            mPassengerHvacDown.setOnClickListener(
                    v -> adjustHvac(AREA_PASSENGER, -HVAC_STEP_CELSIUS));
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
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_DIRECTION, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_FAN_SPEED, 0, mHvacCallback);
        readInitialValues();
        refreshAllDisplays();
    }

    @Override
    protected void onControllerDetached() {
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_FAN_DIRECTION);
        mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_FAN_SPEED);
    }

    private void readInitialValues() {
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

    private void adjustHvac(int area, float delta) {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        float current = area == AREA_DRIVER ? mDriverHvacTemp : mPassengerHvacTemp;
        Float live = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
        if (live != null) {
            current = live;
        }
        float next = clampHvac(area, current + delta);
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
        // %.0f rounds the real bounds 17.5 → "18°" and 32.5 → "33°". The next
        // press then looks valid and crashes when the write is rejected.
        boolean whole = Math.abs(temp - Math.rint(temp)) < 0.05f;
        String text = String.format(Locale.getDefault(), whole ? "%.0f°" : "%.1f°", temp);
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
        readInitialValues();
        refreshAllDisplays();
        applyUxRestrictions();
    }

    @Override
    protected void dumpControllerState(PrintWriter pw) {
        pw.println("  driverHvacTemp=" + mDriverHvacTemp + "C");
        pw.println("  passengerHvacTemp=" + mPassengerHvacTemp + "C");
        pw.println("  driverSeatTemp=" + mDriverSeatTemp);
        pw.println("  passengerSeatTemp=" + mPassengerSeatTemp);
        pw.println("  fanDirection=" + mFanDirection + " fanSpeed=" + mFanSpeed);
        pw.println("  panelLayout=" + getLayoutResourceName());
    }
}
