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

import android.car.VehicleUnit;

import java.util.Locale;

/**
 * Cabin setpoints from {@code HVAC_TEMPERATURE_SET} are always Celsius.
 * Temperature pills follow {@code HVAC_TEMPERATURE_DISPLAY_UNITS}.
 */
public final class HvacTemperatureUnits {

    private static final float CELSIUS_STEP = 0.5f;

    private HvacTemperatureUnits() {}

    public static boolean isFahrenheit(Integer vehicleUnit) {
        return vehicleUnit != null && vehicleUnit == VehicleUnit.FAHRENHEIT;
    }

    /** Pill text for a Celsius setpoint in the active display unit. */
    public static String format(float celsius, boolean fahrenheit) {
        return format(celsius, fahrenheit, null);
    }

    /**
     * @param scale min Celsius, Celsius step, min Fahrenheit, Fahrenheit step
     *              from {@code HVAC_TEMPERATURE_SET}'s config array. The climate
     *              panel maps steps on this scale; {@code C * 9/5 + 32} is one
     *              degree higher on the usual 17.5°C = 60°F range.
     */
    public static String format(float celsius, boolean fahrenheit, float[] scale) {
        if (fahrenheit) {
            return String.format(Locale.getDefault(), "%.0f°", fahrenheitFromScale(celsius, scale));
        }
        // Half-degree steps: avoid rounding 32.5 → "33°".
        boolean whole = Math.abs(celsius - Math.rint(celsius)) < 0.05f;
        return String.format(Locale.getDefault(), whole ? "%.0f°" : "%.1f°", celsius);
    }

    /** Next Celsius setpoint after one press. One config step is one displayed degree. */
    public static float nextSetpointCelsius(float celsius, int direction, boolean fahrenheit) {
        return nextSetpointCelsius(celsius, direction, fahrenheit, null);
    }

    public static float nextSetpointCelsius(float celsius, int direction, boolean fahrenheit,
            float[] scale) {
        float step = CELSIUS_STEP;
        if (scale != null && scale.length >= 2 && scale[1] > 0f) {
            step = scale[1];
        }
        float snapped = Math.round(celsius / step) * step;
        return snapped + direction * step;
    }

    private static float fahrenheitFromScale(float celsius, float[] scale) {
        if (scale != null && scale.length >= 4 && scale[1] > 0f) {
            int steps = Math.round((celsius - scale[0]) / scale[1]);
            return scale[2] + steps * scale[3];
        }
        return celsius * 9f / 5f + 32f;
    }
}
