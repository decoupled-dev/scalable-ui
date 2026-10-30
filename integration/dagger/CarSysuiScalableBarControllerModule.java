/*
 * Copyright (C) 2026 The Android Open Source Project
 *
 * Drop-in Dagger module for packages/apps/Car/SystemUI.
 *
 * Integration steps:
 * 1. Copy this file next to PanelControllerModule.java (same package).
 * 2. Add CarSysuiScalableBarControllers to CarSystemUI static_libs.
 * 3. Add CarSysuiScalableBarControllerModule.class to the includes list of
 *    PanelControllerModule's @Module annotation.
 * 4. Rebuild CarSystemUI and enable LauncherRRO
 *
 * Bindings are keyed by controller class to match PanelControllerInitializer:
 * panel controller XML declares the class in its ControllerName tag and the
 * initializer resolves it via Class.forName before looking up the factory map
 * (Map<Class<?>, Provider<DecorPanelController.Factory<?>>>). Controller
 * configuration (RroPackage, PrimaryMediaComponent, MediaPanelId) is read by
 * each factory from the parsed PanelControllerMetadata, so the OEM overlay
 * alone controls the wiring.
 */

package com.android.systemui.car.wm.scalableui.panel.controller;

import android.content.Context;

import com.android.car.scalableui.panel.DecorPanelController;
import com.android.systemui.car.hvac.HvacPanelOverlayViewController;

import dagger.Module;
import dagger.Provides;
import dagger.multibindings.ClassKey;
import dagger.multibindings.IntoMap;

/**
 * Registers the OEM scalable system bar controllers with the decor panel
 * controller map consumed by PanelControllerInitializer.
 */
@Module
public abstract class CarSysuiScalableBarControllerModule {

    /** Provides the dual-zone header (HVAC / seat temperature) controller factory. */
    @Provides
    @IntoMap
    @ClassKey(CarSysuiScalableHeaderController.class)
    static DecorPanelController.Factory<?> provideScalableHeaderControllerFactory(
            Context context) {
        return new CarSysuiScalableHeaderController.Factory(context);
    }

    /**
     * Provides the footer nav / media playback controller factory.
     * Injects AOSP HVAC panel toggle so the OEM dock FAN opens HvacPanelOverlay.
     */
    @Provides
    @IntoMap
    @ClassKey(CarSysuiScalableFooterController.class)
    static DecorPanelController.Factory<?> provideScalableFooterControllerFactory(
            Context context,
            HvacPanelOverlayViewController hvacPanelOverlayViewController) {
        return new CarSysuiScalableFooterController.Factory(
                context, hvacPanelOverlayViewController::toggle);
    }
}
