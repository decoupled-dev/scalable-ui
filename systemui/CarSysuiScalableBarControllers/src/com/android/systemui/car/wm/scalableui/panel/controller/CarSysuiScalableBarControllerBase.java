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
import android.car.drivingstate.CarUxRestrictions;
import android.car.drivingstate.CarUxRestrictionsManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.UserHandle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;

import com.android.car.scalableui.model.PanelControllerMetadata;
import com.android.systemui.car.wm.scalableui.panel.controller.vhal.CarVhalSubscriptionHelper;

import java.io.PrintWriter;

/**
 * Shared base for the scalable system bar controllers.
 * Provides RRO dynamic binding, VHAL lifecycle, DDG UX restrictions, and Dumpable telemetry.
 */
public abstract class CarSysuiScalableBarControllerBase implements ScalableDecorPanelController,
        SysuiDumpable, CarVhalSubscriptionHelper.VhalConnectionListener,
        CarUxRestrictionsManager.OnUxRestrictionsChangedListener {

    private static final String TAG = "CarSysuiScalableBar";

    protected final Context mContext;
    protected final String mPanelId;
    protected final String mRroPackage;

    protected Context mRroContext;
    protected View mView;
    protected boolean mAttached;

    protected final CarVhalSubscriptionHelper mVhalHelper = new CarVhalSubscriptionHelper();
    protected CarUxRestrictionsManager mUxRestrictionsManager;
    private android.car.Car mUxCar;
    protected boolean mFullyRestricted;
    protected boolean mVhalConnected;

    protected CarSysuiScalableBarControllerBase(Context context, String panelId,
            String rroPackage) {
        mContext = context;
        mPanelId = panelId;
        mRroPackage = rroPackage;
    }

    /**
     * Reads a string configuration parsed from the panel controller XML
     * (see PanelControllerParser tags), falling back to {@code defValue}
     * when the tag is absent or empty.
     */
    protected static String configOrDefault(PanelControllerMetadata metadata, String key,
            String defValue) {
        String value = metadata == null ? null : metadata.getStringConfiguration(key);
        return (value == null || value.isEmpty()) ? defValue : value;
    }

    @Override
    public String getPanelId() {
        return mPanelId;
    }

    @Override
    public void onPanelAttached() {
        if (mAttached) {
            return;
        }
        mAttached = true;
        Log.i(TAG, "onPanelAttached panel=" + mPanelId);
        mVhalHelper.addConnectionListener(this);
        mVhalHelper.start(mContext);
        registerUxRestrictions();
        onControllerAttached();
    }

    @Override
    public void onPanelDetached() {
        if (!mAttached) {
            return;
        }
        mAttached = false;
        mVhalHelper.removeConnectionListener(this);
        mVhalHelper.stop();
        unregisterUxRestrictions();
        onControllerDetached();
    }

    /** Subclass hook after lifecycle attach. */
    protected abstract void onControllerAttached();

    /** Subclass hook before lifecycle detach. */
    protected abstract void onControllerDetached();

    /** Subclass layout resource name in the RRO package (without extension). */
    protected abstract String getLayoutResourceName();

    @Override
    public View getView() {
        if (mView == null) {
            mRroContext = resolveRroContext();
            int layoutId = mRroContext.getResources().getIdentifier(
                    getLayoutResourceName(), "layout", mRroContext.getPackageName());
            if (layoutId == 0) {
                Log.e(TAG, "Layout not found in RRO: " + getLayoutResourceName());
                mView = new View(mContext);
            } else {
                mView = LayoutInflater.from(mRroContext).inflate(layoutId, null);
                bindViews(mView);
            }
            // DecorPanel only calls getView()/refreshTheme()/destroy(); drive the
            // attach lifecycle from the actual window attachment of the view.
            mView.addOnAttachStateChangeListener(new View.OnAttachStateChangeListener() {
                @Override
                public void onViewAttachedToWindow(View v) {
                    onPanelAttached();
                }

                @Override
                public void onViewDetachedFromWindow(View v) {
                    onPanelDetached();
                }
            });
            // SurfaceControl / WM Shell may attach before the listener is registered, or
            // never deliver the callback for some DecorPanel hosts — bind immediately too.
            if (mView.isAttachedToWindow()) {
                onPanelAttached();
            } else {
                mView.post(this::onPanelAttached);
            }
        }
        return mView;
    }

    @Override
    public void refreshTheme() {
        // Drop the cached view; DecorPanel re-requests it via getView() on reset().
        onPanelDetached();
        mView = null;
        mRroContext = null;
    }

    @Override
    public void destroy() {
        onPanelDetached();
        mView = null;
    }

    /** Bind RRO view IDs to VHAL / media / nav logic. */
    protected abstract void bindViews(View root);

    /** Resolve a view ID from the RRO package by resource name. Returns 0 if absent. */
    protected int resolveRroId(String name) {
        if (mRroContext == null) {
            mRroContext = resolveRroContext();
        }
        String pkg = mRroContext.getPackageName();
        return mRroContext.getResources().getIdentifier(name, "id", pkg);
    }

    /** Resolve a string resource from the RRO package. */
    protected String resolveRroString(String name) {
        if (mRroContext == null) {
            mRroContext = resolveRroContext();
        }
        String pkg = mRroContext.getPackageName();
        int resId = mRroContext.getResources().getIdentifier(name, "string", pkg);
        if (resId == 0) {
            return null;
        }
        return mRroContext.getString(resId);
    }

    /** Resolve a drawable resource from the RRO package. */
    protected int resolveRroDrawable(String name) {
        if (mRroContext == null) {
            mRroContext = resolveRroContext();
        }
        String pkg = mRroContext.getPackageName();
        return mRroContext.getResources().getIdentifier(name, "drawable", pkg);
    }

    private Context resolveRroContext() {
        // The configured package (RroPackage tag in the controller XML) wins;
        // the static list only covers overlays that predate the config tag.
        Context configured = tryResolveRroContext(mRroPackage);
        if (configured != null) {
            return configured;
        }
        for (String pkg : RRO_PACKAGE_FALLBACKS) {
            if (pkg.equals(mRroPackage)) {
                continue;
            }
            Context ctx = tryResolveRroContext(pkg);
            if (ctx != null) {
                return ctx;
            }
        }
        Log.e(TAG, "No RRO package found for layout: " + getLayoutResourceName());
        return mContext;
    }

    private Context tryResolveRroContext(String pkg) {
        if (pkg == null || pkg.isEmpty()) {
            return null;
        }
        try {
            Context ctx = mContext.createPackageContext(pkg, 0);
            if (ctx.getResources().getIdentifier(
                    getLayoutResourceName(), "layout", pkg) != 0) {
                return ctx;
            }
        } catch (PackageManager.NameNotFoundException ignored) {
            // try next overlay package
        }
        return null;
    }

    private static final String[] RRO_PACKAGE_FALLBACKS = {
            "com.android.systemui.rro.scalableUI.oemDemo",
            "com.android.systemui.rro.scalableUI.sysuiBars",
            "com.android.systemui.rro.scalableUI.multiPanelLandscape",
    };

    private void registerUxRestrictions() {
        try {
            mUxCar = android.car.Car.createCar(mContext);
            if (mUxCar == null) {
                return;
            }
            mUxRestrictionsManager = (CarUxRestrictionsManager) mUxCar.getCarManager(
                    android.car.Car.CAR_UX_RESTRICTION_SERVICE);
            if (mUxRestrictionsManager != null) {
                mUxRestrictionsManager.registerListener(this);
                onUxRestrictionsChanged(mUxRestrictionsManager.getCurrentCarUxRestrictions());
            }
        } catch (Exception e) {
            Log.w(TAG, "UX restrictions unavailable", e);
        }
    }

    private void unregisterUxRestrictions() {
        if (mUxRestrictionsManager != null) {
            try {
                mUxRestrictionsManager.unregisterListener();
            } catch (Exception e) {
                Log.w(TAG, "Failed to unregister UX listener", e);
            }
            mUxRestrictionsManager = null;
        }
        if (mUxCar != null) {
            try {
                mUxCar.disconnect();
            } catch (Exception e) {
                Log.w(TAG, "Failed to disconnect UX Car", e);
            }
            mUxCar = null;
        }
    }

    @Override
    public void onUxRestrictionsChanged(CarUxRestrictions restrictions) {
        boolean fullyRestricted = restrictions != null
                && restrictions.isRequiresDistractionOptimization()
                && (restrictions.getActiveRestrictions()
                        & CarUxRestrictions.UX_RESTRICTIONS_FULLY_RESTRICTED) != 0;
        if (fullyRestricted != mFullyRestricted) {
            mFullyRestricted = fullyRestricted;
            runOnViewThread(this::applyUxRestrictions);
        }
    }

    /** Apply DDG scrim and disable complex touch targets when fully restricted. */
    protected abstract void applyUxRestrictions();

    /** Apply grayed-out state when VHAL disconnects. */
    protected abstract void applyVhalDisconnectedState();

    /** Apply enabled state when VHAL reconnects. */
    protected abstract void applyVhalConnectedState();

    /** Package hosting Design IVI glanceable / map screens. */
    protected static final String DESIGN_PACKAGE = "com.test.design";
    protected static final String DESIGN_ACTION_OPEN_CLIMATE =
            "com.test.design.action.OPEN_CLIMATE";
    protected static final String DESIGN_ACTION_OPEN_MEDIA =
            "com.test.design.action.OPEN_MEDIA";
    protected static final String DESIGN_ACTION_OPEN_VEHICLE =
            "com.test.design.action.OPEN_VEHICLE";
    protected static final String DESIGN_ACTION_OPEN_MAP =
            "com.test.design.action.OPEN_MAP";
    protected static final String DESIGN_CLIMATE_COMPONENT =
            "com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity";
    protected static final String DESIGN_MEDIA_COMPONENT =
            "com.test.design/.presentation.ivi.glanceables.MediaPanelActivity";
    protected static final String DESIGN_VEHICLE_COMPONENT =
            "com.test.design/.presentation.ivi.glanceables.VehiclePanelActivity";
    protected static final String DESIGN_MAP_COMPONENT =
            "com.test.design/.presentation.ivi.map.MapActivity";
    protected static final String DESIGN_HOME_COMPONENT =
            "com.test.design/.MainActivity";

    /**
     * Opens a Design screen with an explicit component (avoids Design/MaterialTheme
     * chooser on shared actions) plus the documented action + DEFAULT category.
     * Uses {@link Intent#FLAG_ACTIVITY_NEW_TASK} because SystemUI is not an Activity.
     *
     * @return true if the start was dispatched
     */
    protected boolean startDesignPanel(String action, String flattenedComponent) {
        if (mFullyRestricted) {
            return false;
        }
        if (!isDesignPackageInstalled()) {
            Log.w(TAG, "Design package missing — cannot open " + action);
            return false;
        }
        try {
            ComponentName cn = ComponentName.unflattenFromString(flattenedComponent);
            if (cn == null) {
                Log.w(TAG, "Bad Design component: " + flattenedComponent);
                return false;
            }
            Intent intent = new Intent(action);
            intent.setComponent(cn);
            intent.addCategory(Intent.CATEGORY_DEFAULT);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startDesignIntentAsUser(intent);
            Log.i(TAG, "startDesignPanel action=" + action + " cn=" + cn);
            return true;
        } catch (Throwable t) {
            Log.w(TAG, "startDesignPanel failed action=" + action, t);
            return false;
        }
    }

    protected boolean isDesignPackageInstalled() {
        try {
            mContext.getPackageManager().getPackageInfo(DESIGN_PACKAGE, 0);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    protected void startDesignIntentAsUser(Intent intent) {
        int userId = ActivityManager.getCurrentUser();
        UserHandle user = UserHandle.of(userId);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        try {
            java.lang.reflect.Method getPi = android.app.PendingIntent.class.getMethod(
                    "getActivityAsUser", Context.class, int.class, Intent.class, int.class,
                    android.os.Bundle.class, UserHandle.class);
            Object pi = getPi.invoke(null, mContext, 0, intent,
                    android.app.PendingIntent.FLAG_IMMUTABLE
                            | android.app.PendingIntent.FLAG_UPDATE_CURRENT,
                    null, user);
            if (pi instanceof android.app.PendingIntent) {
                ((android.app.PendingIntent) pi).send();
                return;
            }
        } catch (Throwable t) {
            Log.w(TAG, "PendingIntent Design launch failed", t);
        }
        try {
            android.app.ActivityOptions options = android.app.ActivityOptions.makeBasic();
            mContext.startActivityAsUser(intent, options.toBundle(), user);
        } catch (Throwable t) {
            Log.e(TAG, "startActivityAsUser Design failed user=" + userId, t);
        }
    }

    /**
     * DecorPanel views are attached on the WM Shell thread, so UI updates must
     * post to the view's handler rather than the SystemUI main executor.
     */
    protected void runOnViewThread(Runnable r) {
        View view = mView;
        if (view != null) {
            view.post(r);
        } else {
            mContext.getMainExecutor().execute(r);
        }
    }

    @Override
    public void onVhalConnected() {
        mVhalConnected = true;
        runOnViewThread(this::applyVhalConnectedState);
    }

    @Override
    public void onVhalDisconnected() {
        mVhalConnected = false;
        runOnViewThread(this::applyVhalDisconnectedState);
    }

    protected void setViewEnabled(View view, boolean enabled) {
        if (view == null) {
            return;
        }
        view.setEnabled(enabled);
        view.setAlpha(enabled ? 1.0f : 0.4f);
    }

    protected void setScrimVisible(View scrim, boolean visible) {
        if (scrim == null) {
            return;
        }
        scrim.setVisibility(visible ? View.VISIBLE : View.GONE);
    }

    @Override
    public void dump(PrintWriter pw, String[] args) {
        pw.println("CarSysuiScalableBarController{panelId=" + mPanelId
                + ", rroPackage=" + mRroPackage
                + ", attached=" + mAttached
                + ", vhalConnected=" + mVhalConnected
                + ", fullyRestricted=" + mFullyRestricted + "}");
        dumpControllerState(pw);
    }

    /** Subclass telemetry for dumpsys activity service SystemUI. */
    protected abstract void dumpControllerState(PrintWriter pw);
}
