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

import android.view.View;

import com.android.car.scalableui.panel.DecorPanelController;

/**
 * Contract for scalable UI DecorPanel controllers.
 *
 * <p>Extends the AOSP scalable UI {@link DecorPanelController} (consumed by
 * {@code DecorPanel} via {@code PanelControllerInitializer}) with explicit
 * attach/detach lifecycle hooks. Implementations bridge the hooks from
 * {@link View.OnAttachStateChangeListener} on the panel view, since the AOSP
 * interface only exposes {@code getView()}, {@code refreshTheme()} and
 * {@code destroy()}.
 */
public interface ScalableDecorPanelController extends DecorPanelController {
    /** Called when the panel view is attached to the window hierarchy. */
    void onPanelAttached();

    /** Called when the panel view is detached; release all subscriptions. */
    void onPanelDetached();

    /** Panel identifier from the XML {@code id} attribute. */
    String getPanelId();
}
