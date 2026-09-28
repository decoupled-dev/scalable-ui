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
import android.car.VehicleAreaSeat;
import android.car.VehiclePropertyIds;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.graphics.Rect;
import android.media.AudioManager;
import android.media.MediaMetadata;
import android.media.session.MediaController;
import android.media.session.MediaSessionManager;
import android.media.session.PlaybackState;
import android.os.SystemClock;
import android.os.UserHandle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.android.car.scalableui.loader.xml.parser.PanelControllerParser;
import com.android.car.scalableui.model.PanelControllerMetadata;
import com.android.car.scalableui.panel.DecorPanelController;

import java.io.PrintWriter;
import java.util.List;

/**
 * Controller for the dynamic footer navigation bar and state-driven media playback panel.
 * Media panel visibility is orchestrated by WM variants in sysui_footer_media_panel.xml —
 * this controller only binds media session controls and nav intents.
 */
public class CarSysuiScalableFooterController extends CarSysuiScalableBarControllerBase {

    private static final String TAG = "CarSysuiFooterCtrl";
    private static final String DEFAULT_RRO_PACKAGE =
            "com.android.systemui.rro.scalableUI.sysuiBars";
    private static final String DEFAULT_MEDIA_PANEL_ID = "sysui_footer_media_panel";
    private static final String DEFAULT_PRIMARY_MEDIA =
            "com.android.car.media/com.android.car.media.MediaDispatcherActivity";
    private static final String SPOTIFY_PACKAGE = "com.spotify.music";
    private static final float HVAC_STEP_CELSIUS = 0.5f;
    private static final int AREA_DRIVER = VehicleAreaSeat.SEAT_ROW_1_LEFT;
    private static final int AREA_PASSENGER = VehicleAreaSeat.SEAT_ROW_1_RIGHT;

    private static final long PROGRESS_TICK_MS = 500L;

    private final String mPrimaryMediaComponent;
    private final String mMediaPanelId;
    /** Toggles AOSP HvacPanelOverlay (injected from CarSystemUI); null = ClimateActivity fallback. */
    private final Runnable mToggleAospHvac;

    private MediaSessionManager mMediaSessionManager;
    private AudioManager mAudioManager;
    private MediaController mActiveController;
    private boolean mMediaPanelVisible = true;

    // Footer nav
    private View mNavAllApps;
    private View mNavHome;
    private View mNavRecent;
    private View mNavPinned;
    private View mFullscreenToggle;
    private boolean mMapFullscreen;
    private View mFooterUxScrim;

    // Media controls
    private View mMediaRoot;
    private View mMediaPrev;
    private View mMediaPlayPause;
    private View mMediaNext;
    private TextView mMediaTrackName;
    private TextView mMediaArtistName;
    private ImageView mMediaArt;
    private View mMediaUxScrim;
    private View mMediaProgressFill;
    private View mMediaProgressTrack;
    private ProgressBar mMediaProgressBar;
    private TextView mMediaPositionText;
    private TextView mMediaDurationText;
    private long mTrackDurationMs;
    private static final int PROGRESS_MAX = 1000;

    // Optional dock HVAC — driver (left) + passenger (right)
    private View mHvacUp;
    private View mHvacDown;
    private TextView mHvacTempText;
    private float mDriverHvacTemp = 22.0f;
    private View mPassengerHvacUp;
    private View mPassengerHvacDown;
    private TextView mPassengerHvacTempText;
    private float mPassengerHvacTemp = 22.0f;

    // Dock seat heat / vent (driver)
    private View mSeatHeat;
    private View mSeatVent;
    private int mSeatHeatLevel = 0;
    private int mSeatVentLevel = 0;
    private static final int SEAT_LEVEL_MIN = 0;
    private static final int SEAT_LEVEL_MAX = 3;

    private boolean mIsPlaying;
    private android.graphics.drawable.Drawable mPlayDrawable;
    private android.graphics.drawable.Drawable mPauseDrawable;

    private final Runnable mProgressTickRunnable = new Runnable() {
        @Override
        public void run() {
            if (mActiveController == null) {
                return;
            }
            // Progress only — avoid reloading play/pause icons every tick (causes flicker).
            // Must run on the view's thread (wmshell.main); DecorPanel views are not on
            // ActivityThread main — posting there crashes SystemUI and black-flickers the UI.
            updateProgressUi(mActiveController.getPlaybackState());
            if (mIsPlaying) {
                scheduleProgressTick();
            }
        }
    };

    private final Runnable mRefreshSessionsRunnable = this::refreshMediaSessions;

    private final MediaSessionManager.OnActiveSessionsChangedListener mSessionsListener =
            controllers -> {
                if (!shouldBindMediaSessions()) {
                    return;
                }
                runOnViewThread(() -> bindActiveMediaController(controllers));
            };

    private final android.car.hardware.property.CarPropertyManager.CarPropertyEventCallback
            mHvacCallback =
            new android.car.hardware.property.CarPropertyManager.CarPropertyEventCallback() {
                @Override
                public void onChangeEvent(android.car.hardware.CarPropertyValue value) {
                    if (value == null) {
                        return;
                    }
                    int prop = value.getPropertyId();
                    Object raw = value.getValue();
                    int area = value.getAreaId();
                    if (prop == VehiclePropertyIds.HVAC_TEMPERATURE_SET && raw instanceof Float) {
                        float temp = (Float) raw;
                        if (area == AREA_DRIVER) {
                            mDriverHvacTemp = temp;
                            runOnViewThread(() -> setHvacTempText(mHvacTempText, temp));
                        } else if (area == AREA_PASSENGER) {
                            mPassengerHvacTemp = temp;
                            runOnViewThread(() -> setHvacTempText(mPassengerHvacTempText, temp));
                        }
                    } else if (prop == VehiclePropertyIds.HVAC_SEAT_TEMPERATURE
                            && raw instanceof Integer && area == AREA_DRIVER) {
                        int level = (Integer) raw;
                        runOnViewThread(() -> {
                            mSeatHeatLevel = level;
                            refreshSeatHeatUi();
                        });
                    } else if (prop == VehiclePropertyIds.HVAC_SEAT_VENTILATION
                            && raw instanceof Integer && area == AREA_DRIVER) {
                        int level = (Integer) raw;
                        runOnViewThread(() -> {
                            mSeatVentLevel = level;
                            refreshSeatVentUi();
                        });
                    }
                }

                @Override
                public void onErrorEvent(int propId, int zone) {
                    Log.w(TAG, "HVAC error prop=" + propId + " zone=" + zone);
                }
            };

    private final MediaController.Callback mMediaCallback = new MediaController.Callback() {
        @Override
        public void onPlaybackStateChanged(PlaybackState state) {
            runOnViewThread(() -> updatePlaybackUi(state));
        }

        @Override
        public void onMetadataChanged(MediaMetadata metadata) {
            runOnViewThread(() -> updateTrackMetadata(metadata));
        }
    };

    public CarSysuiScalableFooterController(Context context) {
        this(context, "sysui_scalable_footer_panel", DEFAULT_RRO_PACKAGE,
                DEFAULT_PRIMARY_MEDIA, DEFAULT_MEDIA_PANEL_ID, /* toggleAospHvac= */ null);
    }

    public CarSysuiScalableFooterController(Context context, String panelId, String rroPackage,
            String primaryMediaComponent, String mediaPanelId) {
        this(context, panelId, rroPackage, primaryMediaComponent, mediaPanelId,
                /* toggleAospHvac= */ null);
    }

    public CarSysuiScalableFooterController(Context context, String panelId, String rroPackage,
            String primaryMediaComponent, String mediaPanelId, Runnable toggleAospHvac) {
        super(context, panelId, rroPackage);
        mPrimaryMediaComponent = primaryMediaComponent;
        mMediaPanelId = mediaPanelId;
        mToggleAospHvac = toggleAospHvac;
    }

    /**
     * Creates footer controllers from the parsed panel controller XML. The
     * RroPackage, PrimaryMediaComponent and MediaPanelId tags override the
     * built-in defaults, so the OEM overlay alone controls the wiring.
     */
    public static class Factory
            implements DecorPanelController.Factory<CarSysuiScalableFooterController> {
        private final Context mContext;
        private final Runnable mToggleAospHvac;

        public Factory(Context context) {
            this(context, /* toggleAospHvac= */ null);
        }

        public Factory(Context context, Runnable toggleAospHvac) {
            mContext = context;
            mToggleAospHvac = toggleAospHvac;
        }

        @Override
        public CarSysuiScalableFooterController create(String panelId,
                PanelControllerMetadata metadata) {
            return new CarSysuiScalableFooterController(
                    mContext,
                    panelId,
                    configOrDefault(metadata, PanelControllerParser.RRO_PACKAGE_TAG,
                            DEFAULT_RRO_PACKAGE),
                    configOrDefault(metadata, PanelControllerParser.PRIMARY_MEDIA_COMPONENT_TAG,
                            DEFAULT_PRIMARY_MEDIA),
                    configOrDefault(metadata, PanelControllerParser.MEDIA_PANEL_ID_TAG,
                            DEFAULT_MEDIA_PANEL_ID),
                    mToggleAospHvac);
        }
    }

    @Override
    public View getView() {
        View v = super.getView();
        if ("oem_canvas".equals(mPanelId) && v != null) {
            v.setBackgroundColor(0xFF0B0F14);
        }
        return v;
    }

    @Override
    protected String getLayoutResourceName() {
        // OEM card / dock panels reuse this controller with dedicated layouts.
        if ("oem_canvas".equals(mPanelId)) {
            return "oem_canvas";
        }
        if ("oem_dock".equals(mPanelId)) {
            return "oem_dock";
        }
        if ("oem_media_card".equals(mPanelId) || "sysui_footer_media_panel".equals(mPanelId)) {
            // oem_media_card.xml panel id is sysui_footer_media_panel — prefer OEM layout.
            return "oem_media_card";
        }
        if ("oem_phone_card".equals(mPanelId)) {
            return "oem_phone_card";
        }
        if ("oem_car_status_card".equals(mPanelId)) {
            return "oem_car_status_card";
        }
        return "car_sysui_scalable_footer";
    }

    @Override
    protected void bindViews(View root) {
        if ("oem_canvas".equals(mPanelId)) {
            // AutoDecor surfaces default to white when the RRO decor view has no
            // painted background. Force the OEM dark fill in code.
            root.setBackgroundColor(0xFF0B0F14);
            if (root instanceof android.view.ViewGroup) {
                android.view.ViewGroup vg = (android.view.ViewGroup) root;
                for (int i = 0; i < vg.getChildCount(); i++) {
                    View child = vg.getChildAt(i);
                    if (child.getBackground() == null) {
                        child.setBackgroundColor(0xFF12161C);
                    }
                }
            }
            Log.i(TAG, "oem_canvas dark backdrop applied");
            return;
        }
        bindFooterNav(root);
        bindMediaControls(root);
        wireClickListeners();
        wireOptionalLaunches(root);
    }

    private void bindFooterNav(View root) {
        // Prefer parent columns (larger hit targets). Icons also get listeners in
        // wireNavClick — findClickable alone on icons without listeners steals taps.
        View homeCol = findClickable(root, "sysui_nav_home_column");
        View appsCol = findClickable(root, "sysui_nav_all_apps_column");
        View recentCol = findClickable(root, "sysui_nav_recent_column");
        mNavHome = homeCol != null ? homeCol : findClickable(root, "sysui_nav_home");
        mNavAllApps = appsCol != null ? appsCol : findClickable(root, "sysui_nav_all_apps");
        mNavRecent = recentCol != null ? recentCol : findClickable(root, "sysui_nav_recent");
        mNavPinned = findClickable(root, "sysui_nav_pinned");
        // Fan HVAC launch (oem_dock) — preferred over legacy pinned Favorites id.
        if (mNavPinned == null) {
            mNavPinned = findClickable(root, "oem_launch_hvac");
        }
        mFullscreenToggle = findClickable(root, "sysui_footer_fullscreen_toggle");
        int uxId = resolveRroId("sysui_footer_ux_scrim");
        mFooterUxScrim = uxId != 0 ? root.findViewById(uxId) : null;
        Log.i(TAG, "bindFooterNav panel=" + mPanelId
                + " home=" + (mNavHome != null)
                + " allApps=" + (mNavAllApps != null)
                + " recent=" + (mNavRecent != null)
                + " homeCol=" + (homeCol != null)
                + " layout=" + getLayoutResourceName());
    }

    /**
     * Attach {@code listener} to the primary nav target and to the icon child (if any).
     * oem_dock icons were left clickable by findClickable without a listener, which
     * consumed touches and blocked the column OnClickListener.
     */
    private void wireNavClick(View primary, String iconName, View.OnClickListener listener) {
        if (primary != null) {
            primary.setClickable(true);
            primary.setFocusable(true);
            primary.setOnClickListener(listener);
        }
        if (mView == null || iconName == null) {
            return;
        }
        int id = resolveRroId(iconName);
        View icon = id != 0 ? mView.findViewById(id) : null;
        if (icon != null && icon != primary) {
            icon.setClickable(true);
            icon.setFocusable(true);
            icon.setOnClickListener(listener);
        }
    }

    private void bindMediaControls(View root) {
        int rootId = resolveRroId("sysui_footer_media_root");
        mMediaRoot = rootId != 0 ? root.findViewById(rootId) : root;
        mMediaPrev = findClickable(root, "sysui_media_prev");
        mMediaPlayPause = findClickable(root, "sysui_media_play_pause");
        mMediaNext = findClickable(root, "sysui_media_next");
        int trackId = resolveRroId("sysui_media_track_name");
        mMediaTrackName = trackId != 0 ? root.findViewById(trackId) : null;
        int artistId = resolveRroId("sysui_media_artist");
        mMediaArtistName = artistId != 0 ? root.findViewById(artistId) : null;
        int artId = resolveRroId("sysui_media_art");
        mMediaArt = artId != 0 ? root.findViewById(artId) : null;
        int uxId = resolveRroId("sysui_media_ux_scrim");
        mMediaUxScrim = uxId != 0 ? root.findViewById(uxId) : null;
        int progressFillId = resolveRroId("sysui_media_progress_fill");
        mMediaProgressFill = progressFillId != 0 ? root.findViewById(progressFillId) : null;
        int progressTrackId = resolveRroId("sysui_media_progress_track");
        mMediaProgressTrack = progressTrackId != 0 ? root.findViewById(progressTrackId) : null;
        int progressBarId = resolveRroId("sysui_media_progress_bar");
        mMediaProgressBar = progressBarId != 0 ? root.findViewById(progressBarId) : null;
        if (mMediaProgressBar != null) {
            mMediaProgressBar.setMax(PROGRESS_MAX);
            mMediaProgressBar.setIndeterminate(false);
        }
        int positionId = resolveRroId("sysui_media_position");
        mMediaPositionText = positionId != 0 ? root.findViewById(positionId) : null;
        int durationId = resolveRroId("sysui_media_duration");
        mMediaDurationText = durationId != 0 ? root.findViewById(durationId) : null;

        mHvacUp = findClickable(root, "sysui_driver_hvac_up");
        mHvacDown = findClickable(root, "sysui_driver_hvac_down");
        int hvacTempId = resolveRroId("sysui_driver_hvac_temp");
        mHvacTempText = hvacTempId != 0 ? root.findViewById(hvacTempId) : null;

        mPassengerHvacUp = findClickable(root, "sysui_passenger_hvac_up");
        mPassengerHvacDown = findClickable(root, "sysui_passenger_hvac_down");
        int passengerTempId = resolveRroId("sysui_passenger_hvac_temp");
        mPassengerHvacTempText = passengerTempId != 0 ? root.findViewById(passengerTempId) : null;

        mSeatHeat = findClickable(root, "oem_seat_heat");
        mSeatVent = findClickable(root, "oem_seat_vent");
    }

    private View findClickable(View root, String name) {
        int id = resolveRroId(name);
        View view = id != 0 ? root.findViewById(id) : null;
        if (view != null) {
            view.setClickable(true);
            view.setFocusable(true);
        }
        return view;
    }

    private void wireClickListeners() {
        // Wire column (or icon) AND mirror onto icons so either path fires.
        wireNavClick(mNavAllApps, "sysui_nav_all_apps", v -> launchAllApps());
        wireNavClick(mNavHome, "sysui_nav_home", v -> launchHome());
        wireNavClick(mNavRecent, "sysui_nav_recent", v -> launchRecent());
        // Center-dock CLIMATE column (oem_hvac_nav_column / oem_launch_hvac_panel).
        if (mView != null) {
            View hvacCol = findClickable(mView, "oem_hvac_nav_column");
            if (hvacCol != null) {
                hvacCol.setOnClickListener(v -> launchClimate());
                hvacCol.setContentDescription("Climate");
            }
            View hvacPanelBtn = findClickable(mView, "oem_launch_hvac_panel");
            if (hvacPanelBtn != null) {
                // Parent column handles click; keep icon non-interactive.
                hvacPanelBtn.setClickable(false);
                hvacPanelBtn.setOnClickListener(null);
            }
        }
        if (mNavPinned != null) {
            // Fan / HVAC icon opens AOSP HVAC panel.
            mNavPinned.setOnClickListener(v -> launchClimate());
            mNavPinned.setContentDescription("HVAC");
        }
        if (mView != null) {
            View hvacFan = findClickable(mView, "oem_launch_hvac");
            if (hvacFan != null && hvacFan != mNavPinned) {
                hvacFan.setOnClickListener(v -> launchClimate());
                hvacFan.setContentDescription("HVAC");
            }
        }
        if (mFullscreenToggle != null) {
            mFullscreenToggle.setContentDescription("Map fullscreen");
            mFullscreenToggle.setOnClickListener(v -> toggleMapFullscreen());
        }
        if (mMediaPrev != null) {
            mMediaPrev.setOnClickListener(v -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PREVIOUS));
        }
        if (mMediaPlayPause != null) {
            mMediaPlayPause.setOnClickListener(v -> togglePlayPause());
        }
        if (mMediaNext != null) {
            mMediaNext.setOnClickListener(v -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_NEXT));
        }
        if (mHvacUp != null) {
            mHvacUp.setOnClickListener(v -> adjustHvac(AREA_DRIVER, HVAC_STEP_CELSIUS));
        }
        if (mHvacDown != null) {
            mHvacDown.setOnClickListener(v -> adjustHvac(AREA_DRIVER, -HVAC_STEP_CELSIUS));
        }
        if (mPassengerHvacUp != null) {
            mPassengerHvacUp.setOnClickListener(v -> adjustHvac(AREA_PASSENGER, HVAC_STEP_CELSIUS));
        }
        if (mPassengerHvacDown != null) {
            mPassengerHvacDown.setOnClickListener(
                    v -> adjustHvac(AREA_PASSENGER, -HVAC_STEP_CELSIUS));
        }
        if (mSeatHeat != null) {
            mSeatHeat.setOnClickListener(v -> cycleSeatHeat());
        }
        if (mSeatVent != null) {
            mSeatVent.setOnClickListener(v -> cycleSeatVent());
        }
        if (mHvacTempText != null) {
            mHvacTempText.setClickable(true);
            mHvacTempText.setOnClickListener(v -> launchClimate());
        }
        if (mPassengerHvacTempText != null) {
            mPassengerHvacTempText.setClickable(true);
            mPassengerHvacTempText.setOnClickListener(v -> launchClimate());
        }
    }

    /** Optional OEM launch targets present only on some card/dock layouts. */
    private void wireOptionalLaunches(View root) {
        wireLaunch(root, "oem_launch_phone", this::launchPhone);
        wireLaunch(root, "oem_launch_dialpad", this::launchPhone);
        wireLaunch(root, "oem_launch_climate", this::launchClimate);
        wireLaunch(root, "oem_launch_hvac", this::launchClimate);
        wireLaunch(root, "oem_launch_hvac_panel", this::launchClimate);
        wireLaunch(root, "oem_hvac_nav_column", this::launchClimate);
        wireLaunch(root, "oem_launch_media", this::launchMedia);
        wireLaunch(root, "oem_launch_car_status", this::launchCarStatus);
        // Whole-card tap targets (only when the card has no dedicated action chips).
        if ("oem_car_status_card".equals(mPanelId)) {
            root.setOnClickListener(v -> launchCarStatus());
            root.setClickable(true);
        } else if ("oem_media_card".equals(mPanelId)
                || "sysui_footer_media_panel".equals(mPanelId)) {
            // Prefer transport controls; header chrome is not an app launcher.
            View open = findClickable(root, "oem_media_open_app");
            if (open != null) {
                open.setClickable(false);
                open.setOnClickListener(null);
            }
            if (mMediaArt != null) {
                mMediaArt.setClickable(false);
                mMediaArt.setOnClickListener(null);
            }
        }
        // oem_phone_card: Call / Dialpad chips own launches — do not make the root
        // clickable (would fight child hit-testing and re-launch Dialer on every tap).
    }

    private void wireLaunch(View root, String idName, Runnable action) {
        View view = findClickable(root, idName);
        if (view != null) {
            view.setOnClickListener(v -> action.run());
        }
    }

    @Override
    protected void onControllerAttached() {
        mAudioManager = mContext.getSystemService(AudioManager.class);
        if (shouldBindMediaSessions()) {
            mMediaSessionManager = mediaSessionManagerForForegroundUser();
            List<MediaController> sessions = queryMediaSessions();
            bindActiveMediaController(sessions);
            Log.i(TAG, "onControllerAttached panel=" + mPanelId
                    + " currentUser=" + ActivityManager.getCurrentUser()
                    + " sessions=" + (sessions == null ? -1 : sessions.size())
                    + " picked=" + (mActiveController != null ? mActiveController.getPackageName()
                    : "none"));
            if (mMediaSessionManager != null) {
                try {
                    UserHandle user = UserHandle.of(ActivityManager.getCurrentUser());
                    java.lang.reflect.Method add = MediaSessionManager.class.getMethod(
                            "addOnActiveSessionsChangedListener",
                            ComponentName.class, UserHandle.class,
                            java.util.concurrent.Executor.class,
                            MediaSessionManager.OnActiveSessionsChangedListener.class);
                    add.invoke(mMediaSessionManager, null, user, mContext.getMainExecutor(),
                            mSessionsListener);
                } catch (Throwable t) {
                    Log.w(TAG, "user-scoped session listener failed", t);
                    try {
                        ComponentName listenerComponent = new ComponentName(
                                mContext.getPackageName(),
                                CarSysuiScalableFooterController.class.getName());
                        mMediaSessionManager.addOnActiveSessionsChangedListener(
                                mSessionsListener, listenerComponent);
                    } catch (SecurityException e) {
                        Log.w(TAG, "Media session listener denied", e);
                    }
                }
            }
            if (mView != null) {
                mView.removeCallbacks(mRefreshSessionsRunnable);
                mView.postDelayed(mRefreshSessionsRunnable, 1500);
            }
        } else {
            Log.i(TAG, "onControllerAttached panel=" + mPanelId + " (no media binding)");
        }
        // HVAC subscribe is owned by applyVhalConnectedState() — avoid double-register.
        if (mVhalConnected) {
            readHvacTemp();
        }
    }

    /** Only media panels should own MediaSession listeners — avoids multi-panel rebind flicker. */
    private boolean shouldBindMediaSessions() {
        return "sysui_footer_media_panel".equals(mPanelId)
                || "oem_media_card".equals(mPanelId)
                || mMediaPlayPause != null
                || mMediaProgressBar != null
                || mMediaProgressFill != null
                || mMediaTrackName != null;
    }

    /** MediaSessionManager bound to the foreground (driver) user so Spotify sessions are visible. */
    private MediaSessionManager mediaSessionManagerForForegroundUser() {
        // Use the SystemUI context's manager — cross-user fetch is done via
        // getActiveSessionsForUser reflection. createContextAsUser can under-report sessions.
        return mContext.getSystemService(MediaSessionManager.class);
    }

    @SuppressWarnings("unchecked")
    private List<MediaController> queryMediaSessions() {
        if (mMediaSessionManager == null) {
            mMediaSessionManager = mediaSessionManagerForForegroundUser();
        }
        if (mMediaSessionManager == null) {
            return null;
        }
        int userId = ActivityManager.getCurrentUser();
        UserHandle user = UserHandle.of(userId);
        List<MediaController> best = null;
        try {
            java.lang.reflect.Method get = MediaSessionManager.class.getMethod(
                    "getActiveSessionsForUser", ComponentName.class, UserHandle.class);
            Object result = get.invoke(mMediaSessionManager, null, user);
            if (result instanceof List) {
                best = (List<MediaController>) result;
                Log.i(TAG, "getActiveSessionsForUser(" + userId + ")=" + best.size()
                        + " pkgs=" + sessionPackages(best));
            }
        } catch (Throwable t) {
            Log.w(TAG, "getActiveSessionsForUser unavailable", t);
        }
        // Also try default API and keep the larger list (Spotify may only appear on one path).
        try {
            List<MediaController> local = mMediaSessionManager.getActiveSessions(null);
            Log.i(TAG, "getActiveSessions(null)=" + (local == null ? -1 : local.size())
                    + " pkgs=" + sessionPackages(local));
            if (local != null && (best == null || local.size() > best.size())) {
                best = local;
            }
        } catch (SecurityException e) {
            Log.w(TAG, "getActiveSessions denied", e);
        }
        // Last resort: MSM from a user-context.
        if (best == null || best.isEmpty() || !containsPackage(best, SPOTIFY_PACKAGE)) {
            try {
                Context userContext = mContext.createContextAsUser(user, 0);
                MediaSessionManager userMsm = userContext.getSystemService(MediaSessionManager.class);
                if (userMsm != null) {
                    List<MediaController> fromUser = userMsm.getActiveSessions(null);
                    Log.i(TAG, "userContext sessions=" + (fromUser == null ? -1 : fromUser.size())
                            + " pkgs=" + sessionPackages(fromUser));
                    if (fromUser != null && (best == null || fromUser.size() > best.size())) {
                        best = fromUser;
                    }
                }
            } catch (Throwable t) {
                Log.w(TAG, "userContext media query failed", t);
            }
        }
        return best;
    }

    private static boolean containsPackage(List<MediaController> controllers, String pkg) {
        if (controllers == null) {
            return false;
        }
        for (MediaController c : controllers) {
            if (c != null && pkg.equals(c.getPackageName())) {
                return true;
            }
        }
        return false;
    }

    private static String sessionPackages(List<MediaController> controllers) {
        if (controllers == null || controllers.isEmpty()) {
            return "[]";
        }
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < controllers.size(); i++) {
            MediaController c = controllers.get(i);
            if (i > 0) {
                sb.append(',');
            }
            sb.append(c == null ? "null" : c.getPackageName());
        }
        return sb.append(']').toString();
    }

    private void refreshMediaSessions() {
        if (!shouldBindMediaSessions()) {
            return;
        }
        bindActiveMediaController(queryMediaSessions());
        if (mView != null) {
            mView.postDelayed(mRefreshSessionsRunnable, 3000);
        }
    }

    @Override
    protected void onControllerDetached() {
        if (mView != null) {
            mView.removeCallbacks(mRefreshSessionsRunnable);
        }
        unbindMediaController();
        if (mMediaSessionManager != null) {
            try {
                mMediaSessionManager.removeOnActiveSessionsChangedListener(mSessionsListener);
            } catch (Exception e) {
                Log.w(TAG, "Failed to remove sessions listener", e);
            }
        }
        try {
            mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET);
            mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE);
            mVhalHelper.unsubscribe(VehiclePropertyIds.HVAC_SEAT_VENTILATION);
        } catch (Exception e) {
            Log.w(TAG, "HVAC unsubscribe failed", e);
        }
    }

    /**
     * Called by the WM orchestrator when the media panel variant changes.
     * Visibility is driven declaratively — this only updates controller telemetry state.
     */
    public void onMediaPanelVisibilityChanged(boolean visible) {
        mMediaPanelVisible = visible;
        Log.d(TAG, "Media panel visibility (WM-driven): " + visible);
    }

    private void bindActiveMediaController(List<MediaController> controllers) {
        if (controllers == null || controllers.isEmpty()) {
            unbindMediaController();
            setDefaultTrackTitle();
            return;
        }
        MediaController next = pickMediaController(controllers);
        if (next == null) {
            unbindMediaController();
            setDefaultTrackTitle();
            return;
        }
        // Same session — keep existing callback registration (rebind causes UI flicker).
        // Do not push metadata/playback into the view on the 3s poll — only on callbacks.
        if (mActiveController != null
                && mActiveController.getSessionToken().equals(next.getSessionToken())) {
            return;
        }
        unbindMediaController();
        mActiveController = next;
        mActiveController.registerCallback(mMediaCallback);
        updatePlaybackUi(mActiveController.getPlaybackState());
        updateTrackMetadata(mActiveController.getMetadata());
    }

    /**
     * Prefer Spotify (or any real media app with metadata) over Bluetooth ERROR / empty sessions.
     */
    private MediaController pickMediaController(List<MediaController> controllers) {
        MediaController spotify = null;
        MediaController withTitle = null;
        MediaController playing = null;
        MediaController fallback = null;
        for (MediaController controller : controllers) {
            if (controller == null) {
                continue;
            }
            String pkg = controller.getPackageName();
            PlaybackState state = controller.getPlaybackState();
            boolean error = state != null && state.getState() == PlaybackState.STATE_ERROR;
            if (error) {
                continue;
            }
            if (fallback == null) {
                fallback = controller;
            }
            if (state != null && state.getState() == PlaybackState.STATE_PLAYING && playing == null) {
                playing = controller;
            }
            MediaMetadata metadata = controller.getMetadata();
            boolean hasTitle = metadata != null
                    && (metadata.getString(MediaMetadata.METADATA_KEY_TITLE) != null
                    || metadata.getString(MediaMetadata.METADATA_KEY_DISPLAY_TITLE) != null);
            if (hasTitle && withTitle == null) {
                withTitle = controller;
            }
            if (SPOTIFY_PACKAGE.equals(pkg)) {
                spotify = controller;
                if (hasTitle || (state != null && state.getState() == PlaybackState.STATE_PLAYING)) {
                    return controller;
                }
            }
        }
        if (spotify != null) {
            return spotify;
        }
        if (playing != null) {
            return playing;
        }
        if (withTitle != null) {
            return withTitle;
        }
        return fallback != null ? fallback : controllers.get(0);
    }

    private void unbindMediaController() {
        cancelProgressTick();
        if (mActiveController != null) {
            try {
                mActiveController.unregisterCallback(mMediaCallback);
            } catch (Exception ignored) {
            }
            mActiveController = null;
        }
    }

    private void togglePlayPause() {
        if (mFullyRestricted) {
            return;
        }
        // Do not rebind sessions on every tap — that unregisters callbacks and flickers the card.
        if (mActiveController == null) {
            refreshMediaSessionsOnce();
        }
        if (mActiveController == null) {
            dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE);
            return;
        }
        PlaybackState state = mActiveController.getPlaybackState();
        if (state != null && state.getState() == PlaybackState.STATE_PLAYING) {
            mActiveController.getTransportControls().pause();
        } else {
            mActiveController.getTransportControls().play();
        }
    }

    private void refreshMediaSessionsOnce() {
        if (!shouldBindMediaSessions()) {
            return;
        }
        bindActiveMediaController(queryMediaSessions());
    }

    private void dispatchMediaKey(int keyCode) {
        if (mFullyRestricted) {
            return;
        }
        if (mActiveController == null) {
            refreshMediaSessionsOnce();
        }
        if (mActiveController != null) {
            MediaController.TransportControls controls = mActiveController.getTransportControls();
            switch (keyCode) {
                case KeyEvent.KEYCODE_MEDIA_PREVIOUS:
                    controls.skipToPrevious();
                    return;
                case KeyEvent.KEYCODE_MEDIA_NEXT:
                    controls.skipToNext();
                    return;
                case KeyEvent.KEYCODE_MEDIA_PLAY:
                    controls.play();
                    return;
                case KeyEvent.KEYCODE_MEDIA_PAUSE:
                    controls.pause();
                    return;
                case KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE:
                    togglePlayPause();
                    return;
                default:
                    break;
            }
        }
        // System-service media key reaches Spotify even when we lack a controller handle.
        KeyEvent down = new KeyEvent(KeyEvent.ACTION_DOWN, keyCode);
        KeyEvent up = new KeyEvent(KeyEvent.ACTION_UP, keyCode);
        if (mAudioManager != null) {
            try {
                mAudioManager.dispatchMediaKeyEvent(down);
                mAudioManager.dispatchMediaKeyEvent(up);
                return;
            } catch (Exception e) {
                Log.w(TAG, "AudioManager media key failed", e);
            }
        }
        mContext.sendOrderedBroadcast(new Intent(Intent.ACTION_MEDIA_BUTTON)
                .putExtra(Intent.EXTRA_KEY_EVENT, down), null);
        mContext.sendOrderedBroadcast(new Intent(Intent.ACTION_MEDIA_BUTTON)
                .putExtra(Intent.EXTRA_KEY_EVENT, up), null);
    }

    private void updatePlaybackUi(PlaybackState state) {
        if (mMediaPlayPause == null && mMediaProgressFill == null && mMediaProgressBar == null) {
            return;
        }
        boolean playing = state != null && state.getState() == PlaybackState.STATE_PLAYING;
        if (mMediaPlayPause instanceof ImageView && playing != mIsPlaying) {
            // Cache drawables — setImageResource every toggle forces a decode/layout flash.
            ensurePlayPauseDrawables();
            android.graphics.drawable.Drawable d = playing ? mPauseDrawable : mPlayDrawable;
            if (d != null) {
                ((ImageView) mMediaPlayPause).setImageDrawable(d);
            }
        }
        mIsPlaying = playing;
        updateProgressUi(state);
        cancelProgressTick();
        if (mIsPlaying) {
            scheduleProgressTick();
        }
    }

    private void ensurePlayPauseDrawables() {
        if (mPlayDrawable != null && mPauseDrawable != null) {
            return;
        }
        int playRes = resolveRroDrawable("ic_sysui_media_play");
        int pauseRes = resolveRroDrawable("ic_sysui_media_pause");
        if (mRroContext != null) {
            if (playRes != 0 && mPlayDrawable == null) {
                mPlayDrawable = mRroContext.getDrawable(playRes);
            }
            if (pauseRes != 0 && mPauseDrawable == null) {
                mPauseDrawable = mRroContext.getDrawable(pauseRes);
            }
        }
    }


    /** Progress ticker must use the DecorPanel view handler (wmshell.main), not main looper. */
    private void cancelProgressTick() {
        if (mView != null) {
            mView.removeCallbacks(mProgressTickRunnable);
        }
    }

    private void scheduleProgressTick() {
        if (mView == null) {
            return;
        }
        mView.removeCallbacks(mProgressTickRunnable);
        mView.postDelayed(mProgressTickRunnable, PROGRESS_TICK_MS);
    }

    private void updateProgressUi(PlaybackState state) {
        long positionMs = 0L;
        if (state != null) {
            positionMs = state.getPosition();
            if (state.getState() == PlaybackState.STATE_PLAYING
                    && state.getLastPositionUpdateTime() > 0) {
                long elapsed = SystemClock.elapsedRealtime() - state.getLastPositionUpdateTime();
                float speed = state.getPlaybackSpeed() > 0f ? state.getPlaybackSpeed() : 1f;
                positionMs += (long) (elapsed * speed);
            }
            if (positionMs < 0) {
                positionMs = 0;
            }
        }
        long durationMs = mTrackDurationMs;
        if (durationMs > 0 && positionMs > durationMs) {
            positionMs = durationMs;
        }
        if (mMediaPositionText != null) {
            mMediaPositionText.setText(formatTime(positionMs));
        }
        if (mMediaDurationText != null) {
            if (durationMs > 0) {
                mMediaDurationText.setText(formatTime(durationMs));
            } else {
                mMediaDurationText.setText("0:00");
            }
        }
        int progress = 0;
        if (durationMs > 0) {
            progress = (int) Math.min(PROGRESS_MAX,
                    Math.round((positionMs / (double) durationMs) * PROGRESS_MAX));
        }
        if (mMediaProgressBar != null) {
            if (mMediaProgressBar.getProgress() != progress) {
                mMediaProgressBar.setProgress(progress, false);
            }
        } else if (mMediaProgressFill != null && mMediaProgressTrack != null) {
            int trackWidth = mMediaProgressTrack.getWidth();
            if (trackWidth <= 0) {
                mMediaProgressTrack.post(() -> updateProgressUi(state));
                return;
            }
            int fillWidth = (int) Math.min(trackWidth,
                    Math.round((progress / (double) PROGRESS_MAX) * trackWidth));
            ViewGroup.LayoutParams lp = mMediaProgressFill.getLayoutParams();
            if (lp != null) {
                lp.width = fillWidth;
                if (lp.height <= 0) {
                    int h = mMediaProgressTrack.getHeight();
                    if (h > 0) {
                        lp.height = h;
                    }
                }
                mMediaProgressFill.setLayoutParams(lp);
            }
        }
    }

    private static String formatTime(long ms) {
        long totalSec = Math.max(0, ms / 1000L);
        long min = totalSec / 60L;
        long sec = totalSec % 60L;
        return String.format(java.util.Locale.getDefault(), "%d:%02d", min, sec);
    }

    private void updateTrackMetadata(MediaMetadata metadata) {
        if (metadata == null) {
            setDefaultTrackTitle();
            return;
        }
        String title = metadata.getString(MediaMetadata.METADATA_KEY_TITLE);
        if (title == null || title.isEmpty()) {
            title = metadata.getString(MediaMetadata.METADATA_KEY_DISPLAY_TITLE);
        }
        String artist = metadata.getString(MediaMetadata.METADATA_KEY_ARTIST);
        if (artist == null || artist.isEmpty()) {
            artist = metadata.getString(MediaMetadata.METADATA_KEY_ALBUM_ARTIST);
        }
        if (mMediaTrackName != null) {
            CharSequence cur = mMediaTrackName.getText();
            String next;
            if (title != null && !title.isEmpty()) {
                next = title;
            } else if (mIsPlaying) {
                // Avoid "Not Playing" flash while Spotify metadata catches up.
                next = cur != null && cur.length() > 0 ? cur.toString() : "Playing";
            } else {
                next = getDefaultTrackTitleString();
            }
            if (cur == null || !next.contentEquals(cur)) {
                mMediaTrackName.setText(next);
            }
        }
        if (mMediaArtistName != null) {
            String nextArtist = artist != null ? artist : "";
            CharSequence cur = mMediaArtistName.getText();
            if (cur == null || !nextArtist.contentEquals(cur)) {
                mMediaArtistName.setText(nextArtist);
            }
        }
        if (mMediaArt != null) {
            android.graphics.Bitmap bitmap = metadata.getBitmap(MediaMetadata.METADATA_KEY_ALBUM_ART);
            if (bitmap == null) {
                bitmap = metadata.getBitmap(MediaMetadata.METADATA_KEY_ART);
            }
            if (bitmap != null) {
                Object tag = mMediaArt.getTag();
                int gen = bitmap.getGenerationId();
                if (!(tag instanceof Integer) || ((Integer) tag) != gen) {
                    mMediaArt.setImageBitmap(bitmap);
                    mMediaArt.setTag(gen);
                }
            }
        }
        long duration = metadata.getLong(MediaMetadata.METADATA_KEY_DURATION);
        if (duration != mTrackDurationMs) {
            mTrackDurationMs = duration;
            if (mActiveController != null) {
                updateProgressUi(mActiveController.getPlaybackState());
            }
        }
    }

    private void setDefaultTrackTitle() {
        if (mMediaTrackName != null) {
            mMediaTrackName.setText(getDefaultTrackTitleString());
        }
        if (mMediaArtistName != null) {
            mMediaArtistName.setText("");
        }
    }

    private String getDefaultTrackTitleString() {
        String fallback = resolveRroString("sysui_media_not_playing");
        return fallback != null ? fallback : "Not Playing";
    }

    private static void setHvacTempText(TextView view, float temp) {
        if (view != null) {
            // Half-degree HVAC steps: avoid rounding 32.5 → "33°".
            boolean whole = Math.abs(temp - Math.rint(temp)) < 0.05f;
            view.setText(String.format(java.util.Locale.getDefault(),
                    whole ? "%.0f°" : "%.1f°", temp));
        }
    }

    private void adjustHvac(int area, float delta) {
        if (mFullyRestricted) {
            return;
        }
        if (!mVhalConnected) {
            Log.w(TAG, "HVAC adjust ignored — VHAL not connected");
            return;
        }
        boolean driver = area == AREA_DRIVER;
        Float current = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
        float base = current != null ? current
                : (driver ? mDriverHvacTemp : mPassengerHvacTemp);
        float next = base + delta;
        // setFloatProperty clamps to VHAL min/max and must never throw.
        if (mVhalHelper.setFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, area, next)) {
            Float applied = mVhalHelper.getFloatProperty(
                    VehiclePropertyIds.HVAC_TEMPERATURE_SET, area);
            float shown = applied != null ? applied : next;
            if (driver) {
                mDriverHvacTemp = shown;
                setHvacTempText(mHvacTempText, shown);
            } else {
                mPassengerHvacTemp = shown;
                setHvacTempText(mPassengerHvacTempText, shown);
            }
        }
    }

    private void readHvacTemp() {
        Float driver = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, AREA_DRIVER);
        if (driver != null) {
            mDriverHvacTemp = driver;
            setHvacTempText(mHvacTempText, driver);
        }
        Float passenger = mVhalHelper.getFloatProperty(
                VehiclePropertyIds.HVAC_TEMPERATURE_SET, AREA_PASSENGER);
        if (passenger != null) {
            mPassengerHvacTemp = passenger;
            setHvacTempText(mPassengerHvacTempText, passenger);
        }
        Integer seatHeat = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, AREA_DRIVER);
        if (seatHeat != null) {
            mSeatHeatLevel = seatHeat;
        }
        Integer seatVent = mVhalHelper.getIntProperty(
                VehiclePropertyIds.HVAC_SEAT_VENTILATION, AREA_DRIVER);
        if (seatVent != null) {
            mSeatVentLevel = seatVent;
        }
        refreshSeatHeatUi();
        refreshSeatVentUi();
    }

    private void cycleSeatHeat() {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        int next = mSeatHeatLevel >= SEAT_LEVEL_MAX ? SEAT_LEVEL_MIN : mSeatHeatLevel + 1;
        if (mVhalHelper.setIntProperty(
                VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, AREA_DRIVER, next)) {
            mSeatHeatLevel = next;
            refreshSeatHeatUi();
        }
    }

    private void cycleSeatVent() {
        if (mFullyRestricted || !mVhalConnected) {
            return;
        }
        int next = mSeatVentLevel >= SEAT_LEVEL_MAX ? SEAT_LEVEL_MIN : mSeatVentLevel + 1;
        if (mVhalHelper.setIntProperty(
                VehiclePropertyIds.HVAC_SEAT_VENTILATION, AREA_DRIVER, next)) {
            mSeatVentLevel = next;
            refreshSeatVentUi();
        }
    }

    private void refreshSeatHeatUi() {
        setClimateBtnActive(mSeatHeat, mSeatHeatLevel > 0);
        if (mSeatHeat != null) {
            mSeatHeat.setAlpha(mSeatHeatLevel > 0
                    ? 0.55f + (0.45f * (mSeatHeatLevel / (float) SEAT_LEVEL_MAX))
                    : 0.55f);
            mSeatHeat.setContentDescription("Seat heat " + mSeatHeatLevel);
        }
    }

    private void refreshSeatVentUi() {
        setClimateBtnActive(mSeatVent, mSeatVentLevel > 0);
        if (mSeatVent != null) {
            mSeatVent.setAlpha(mSeatVentLevel > 0
                    ? 0.55f + (0.45f * (mSeatVentLevel / (float) SEAT_LEVEL_MAX))
                    : 0.55f);
            mSeatVent.setContentDescription("Seat vent " + mSeatVentLevel);
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

    private void launchAllApps() {
        if (mFullyRestricted) {
            return;
        }
        int userId = ActivityManager.getCurrentUser();
        UserHandle user = UserHandle.of(userId);
        Log.i(TAG, "launchAllApps user=" + userId);
        // Declarative open first so AppGrid binds into panel_app_grid (layer 18, above
        // cards, below dock). Then start the activity with NEW_TASK|CLEAR_TOP.
        try {
            com.android.car.scalableui.manager.StateManager.handleEvent(
                    new com.android.car.scalableui.model.Event.Builder("_System_TaskOpenEvent")
                            .setPanelId("panel_app_grid")
                            .build());
        } catch (Throwable t) {
            Log.w(TAG, "TaskOpen panel_app_grid failed", t);
        }
        Intent intent = new Intent("com.android.car.carlauncher.ACTION_APP_GRID");
        intent.setPackage("com.android.car.carlauncher");
        intent.setComponent(ComponentName.unflattenFromString(
                "com.android.car.carlauncher/.AppGridActivity"));
        // FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP — matches config intent flags.
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        try {
            java.lang.reflect.Method getPi = android.app.PendingIntent.class.getMethod(
                    "getActivityAsUser", Context.class, int.class, Intent.class, int.class,
                    android.os.Bundle.class, UserHandle.class);
            Object pi = getPi.invoke(null, mContext, 0, intent,
                    android.app.PendingIntent.FLAG_IMMUTABLE
                            | android.app.PendingIntent.FLAG_UPDATE_CURRENT
                            | android.app.PendingIntent.FLAG_ONE_SHOT,
                    null, user);
            if (pi instanceof android.app.PendingIntent) {
                ((android.app.PendingIntent) pi).send();
                return;
            }
        } catch (Throwable t) {
            Log.w(TAG, "PendingIntent AppGrid failed", t);
        }
        startAsForegroundUser(intent);
    }

    /**
     * Restore the map + OEM cards dashboard.
     * Prefer declarative StateManager transitions; only remove stuck overlay tasks.
     * Do not force-stop media/carlauncher — that tears Spotify sessions and races Maps.
     */
    private void launchHome() {
        if (mFullyRestricted) {
            Log.w(TAG, "launchHome blocked — fully UX restricted");
            return;
        }
        Log.i(TAG, "launchHome user=" + ActivityManager.getCurrentUser()
                + " panel=" + mPanelId
                + " mapFs=" + isMapPanelFullscreen());
        // Must go through EventDispatcher → PanelTransitionCoordinator. A bare
        // StateManager.handleEvent() updates variants / builds animators but never
        // starts them — leaving cards/canvas stuck in hidden after map fullscreen
        // while mMapFullscreen alone flips the pin icon off.
        mMapFullscreen = false;
        dispatchScalableEvent("_System_OnHomeEvent");
        // Drop sticky AppGrid / Settings / Dialer / mock overlay tasks without killing Maps
        // or Spotify. TaskOpen below rebinds map_panel if needed.
        removeOverlayTasks();
        // Maps leaf task can drift to tip-style right bounds (e.g. left=832) while
        // map_panel stays at OEM left (32,144)-(1408,1400). OnHome is then a no-op
        // (already opened) and the left half of the map panel stays black.
        realignMapPanelIfNeeded();
        try {
            dispatchScalableEvent(
                    new com.android.car.scalableui.model.Event.Builder("_System_TaskOpenEvent")
                            .setPanelId("map_panel")
                            .build());
        } catch (Throwable t) {
            Log.w(TAG, "TaskOpen map_panel failed", t);
        }
        // After panel transitions settle, force Maps leaf into opened (split) bounds.
        final Rect opened = expectedMapPanelBounds();
        Runnable realign = () -> resizeMapsTask(opened);
        if (mView != null) {
            mView.postDelayed(realign, 350L);
            mView.postDelayed(realign, 800L);
        } else {
            realign.run();
        }
    }

    /**
     * Read live map_panel variant. {@link #mMapFullscreen} alone drifts when system
     * OnHome / TaskOpen resets the panel without going through {@link #launchHome()}.
     */
    private boolean isMapPanelFullscreen() {
        try {
            com.android.car.scalableui.model.PanelState state =
                    com.android.car.scalableui.manager.StateManager.getPanelState("map_panel");
            if (state != null && state.getCurrentVariant() != null) {
                return "fullscreen".equals(state.getCurrentVariant().getIdName());
            }
        } catch (Throwable t) {
            Log.w(TAG, "isMapPanelFullscreen failed", t);
        }
        return mMapFullscreen;
    }

    /**
     * Route through EventDispatcher → PanelTransitionCoordinator so DecorPanel /
     * TaskPanel surfaces (and Maps task bounds) actually animate. Controllers
     * cannot compile against EventDispatcher; resolve it via CarWMComponent.
     */
    private void dispatchScalableEvent(String eventId) {
        dispatchScalableEvent(
                new com.android.car.scalableui.model.Event.Builder(eventId).build());
    }

    private void dispatchScalableEvent(com.android.car.scalableui.model.Event event) {
        final String eventId = event != null ? event.getId() : "null";
        try {
            Object app = mContext.getApplicationContext();
            Object wm = app.getClass().getMethod("getWMComponent").invoke(app);
            Object dispatcher = wm.getClass()
                    .getMethod("getScalableUIEventDispatcher").invoke(wm);
            dispatcher.getClass()
                    .getMethod("executeEvent",
                            com.android.car.scalableui.model.Event.class)
                    .invoke(dispatcher, event);
            return;
        } catch (Throwable t) {
            Log.w(TAG, "EventDispatcher.executeEvent(" + eventId + ") failed; fallback", t);
        }
        // Fallback: build transaction and start animators (may not push AutoDecor).
        try {
            com.android.car.scalableui.model.PanelTransaction tx =
                    com.android.car.scalableui.manager.StateManager.handleEvent(event);
            if (tx == null) {
                return;
            }
            for (java.util.Map.Entry<String, android.animation.Animator> e : tx.getAnimators()) {
                if (e.getValue() != null) {
                    e.getValue().start();
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, eventId + " failed", t);
        }
    }

    /** Toggle map between left-column home and full-bleed behind the dock. */
    private void toggleMapFullscreen() {
        if (mFullyRestricted) {
            return;
        }
        // Destination must match StateManager (variant-based) transitions, not a stale flag.
        final boolean currentlyFs = isMapPanelFullscreen();
        final boolean goingFs = !currentlyFs;
        Log.i(TAG, "toggle_map_fullscreen → " + (goingFs ? "fullscreen" : "opened")
                + " (panel=" + (currentlyFs ? "fullscreen" : "opened")
                + " flag=" + mMapFullscreen + ")");
        try {
            dispatchScalableEvent("toggle_map_fullscreen");
        } catch (Throwable t) {
            Log.w(TAG, "toggle_map_fullscreen failed", t);
            return;
        }
        mMapFullscreen = goingFs;
        final Rect target = goingFs
                ? expectedMapFullscreenBounds()
                : expectedMapPanelBounds();
        Runnable realign = () -> resizeMapsTask(target);
        if (mView != null) {
            // After panel transition (~400ms) force Maps leaf task into new bounds.
            mView.postDelayed(realign, 450L);
            mView.postDelayed(realign, 900L);
        } else {
            realign.run();
        }
    }

    /** Expected OEM map_panel opened bounds (matches OemDemoRRO map_panel.xml). */
    private Rect expectedMapPanelBounds() {
        float d = mContext.getResources().getDisplayMetrics().density;
        return new Rect(
                Math.round(16 * d),
                Math.round(72 * d),
                Math.round(704 * d),
                Math.round(700 * d));
    }

    /** Full-bleed map behind header/dock (matches map_panel fullscreen variant). */
    private Rect expectedMapFullscreenBounds() {
        float d = mContext.getResources().getDisplayMetrics().density;
        return new Rect(
                0,
                Math.round(64 * d),
                Math.round(1280 * d),
                Math.round(708 * d));
    }

    /** Resize the Google Maps task to {@code expected} bounds. */
    private void resizeMapsTask(Rect expected) {
        try {
            Object atm = Class.forName("android.app.ActivityTaskManager")
                    .getMethod("getInstance").invoke(null);
            java.lang.reflect.Method getTasks;
            java.util.List<?> tasks;
            try {
                getTasks = atm.getClass().getMethod(
                        "getTasks", int.class, boolean.class, boolean.class, int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100, false, false, -1);
            } catch (NoSuchMethodException e) {
                getTasks = atm.getClass().getMethod("getTasks", int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100);
            }
            if (tasks == null) {
                return;
            }
            for (Object raw : tasks) {
                if (!(raw instanceof ActivityManager.RunningTaskInfo)) {
                    continue;
                }
                ActivityManager.RunningTaskInfo task = (ActivityManager.RunningTaskInfo) raw;
                ComponentName cn = task.topActivity != null ? task.topActivity : task.baseActivity;
                if (cn == null || !"com.google.android.apps.maps".equals(cn.getPackageName())) {
                    continue;
                }
                Log.i(TAG, "resizeMapsTask id=" + task.taskId + " → " + expected);
                atm.getClass().getMethod("resizeTask", int.class, Rect.class)
                        .invoke(atm, task.taskId, expected);
                return;
            }
        } catch (Throwable t) {
            Log.w(TAG, "resizeMapsTask failed", t);
        }
    }

    /**
     * If Maps is hosted under map_panel but its window bounds do not fill the panel,
     * resize (or remove so TaskOpen relaunches) to clear the black left gap.
     */

    /** Read task window bounds via reflection — stub SDK hides TaskInfo.configuration. */
    private static Rect getTaskBounds(ActivityManager.RunningTaskInfo task) {
        try {
            Object config = task.getClass().getField("configuration").get(task);
            if (config == null) {
                Object getConfig = task.getClass().getMethod("getConfiguration").invoke(task);
                config = getConfig;
            }
            if (config == null) {
                return null;
            }
            Object winConfig = config.getClass().getField("windowConfiguration").get(config);
            if (winConfig == null) {
                winConfig = config.getClass().getMethod("getWindowConfiguration").invoke(config);
            }
            if (winConfig == null) {
                return null;
            }
            Object bounds = winConfig.getClass().getMethod("getBounds").invoke(winConfig);
            return bounds instanceof Rect ? new Rect((Rect) bounds) : null;
        } catch (Throwable t) {
            return null;
        }
    }

    private void realignMapPanelIfNeeded() {
        Rect expected = expectedMapPanelBounds();
        try {
            Object atm = Class.forName("android.app.ActivityTaskManager")
                    .getMethod("getInstance").invoke(null);
            java.lang.reflect.Method getTasks;
            java.util.List<?> tasks;
            try {
                getTasks = atm.getClass().getMethod(
                        "getTasks", int.class, boolean.class, boolean.class, int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100, false, false, -1);
            } catch (NoSuchMethodException e) {
                getTasks = atm.getClass().getMethod("getTasks", int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100);
            }
            if (tasks == null) {
                return;
            }
            for (Object raw : tasks) {
                if (!(raw instanceof ActivityManager.RunningTaskInfo)) {
                    continue;
                }
                ActivityManager.RunningTaskInfo task = (ActivityManager.RunningTaskInfo) raw;
                ComponentName cn = task.topActivity != null ? task.topActivity : task.baseActivity;
                if (cn == null || !"com.google.android.apps.maps".equals(cn.getPackageName())) {
                    continue;
                }
                Rect bounds = getTaskBounds(task);
                if (bounds == null || bounds.isEmpty()) {
                    continue;
                }
                // Already aligned (within ~40px).
                if (Math.abs(bounds.left - expected.left) <= 40
                        && Math.abs(bounds.top - expected.top) <= 40
                        && Math.abs(bounds.right - expected.right) <= 40
                        && Math.abs(bounds.bottom - expected.bottom) <= 40) {
                    return;
                }
                Log.w(TAG, "Maps misaligned bounds=" + bounds + " expected=" + expected
                        + " — realigning");
                try {
                    atm.getClass().getMethod("resizeTask", int.class, Rect.class)
                            .invoke(atm, task.taskId, expected);
                    return;
                } catch (Throwable resizeFail) {
                    Log.w(TAG, "resizeTask failed, removing Maps for relaunch", resizeFail);
                    try {
                        atm.getClass().getMethod("removeTask", int.class)
                                .invoke(atm, task.taskId);
                    } catch (Throwable removeFail) {
                        Log.w(TAG, "removeTask Maps failed", removeFail);
                    }
                    return;
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "realignMapPanelIfNeeded failed", t);
        }
    }

    /**
     * Removes AppGrid and Car Settings tasks via ActivityTaskManager.
     * OnHomeEvent alone can leave TaskView surfaces visible over the map/cards.
     */
    private void removeOverlayTasks() {
        try {
            Object atm = Class.forName("android.app.ActivityTaskManager")
                    .getMethod("getInstance").invoke(null);
            java.lang.reflect.Method getTasks;
            java.util.List<?> tasks;
            try {
                getTasks = atm.getClass().getMethod(
                        "getTasks", int.class, boolean.class, boolean.class, int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100, false, false, -1);
            } catch (NoSuchMethodException e) {
                getTasks = atm.getClass().getMethod("getTasks", int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100);
            }
            java.lang.reflect.Method removeTask =
                    atm.getClass().getMethod("removeTask", int.class);
            if (tasks == null) {
                return;
            }
            for (Object raw : tasks) {
                if (!(raw instanceof ActivityManager.RunningTaskInfo)) {
                    continue;
                }
                ActivityManager.RunningTaskInfo task = (ActivityManager.RunningTaskInfo) raw;
                ComponentName cn = task.topActivity != null ? task.topActivity : task.baseActivity;
                if (cn == null) {
                    continue;
                }
                String pkg = cn.getPackageName();
                String cls = cn.getClassName();
                // Only remove known overlay hosts — never Maps (TaskPanel owns it) or Spotify.
                boolean appGrid = "com.android.car.carlauncher".equals(pkg)
                        && cls != null && cls.contains("AppGrid");
                boolean settings = "com.android.car.settings".equals(pkg);
                boolean dialer = "com.android.car.dialer".equals(pkg);
                boolean mock = "com.android.car.mockwidgets".equals(pkg);
                if (!appGrid && !settings && !dialer && !mock) {
                    continue;
                }
                Log.i(TAG, "removeTask overlay id=" + task.taskId + " cn=" + cn);
                removeTask.invoke(atm, task.taskId);
            }
        } catch (Throwable t) {
            Log.w(TAG, "removeOverlayTasks failed", t);
        }
    }

    private void launchRecent() {
        if (mFullyRestricted) {
            return;
        }
        // SHOW_RECENTS broadcast is not handled on this build — open CarRecentsActivity.
        Log.i(TAG, "launchRecent → CarRecentsActivity");
        try {
            com.android.car.scalableui.manager.StateManager.handleEvent(
                    new com.android.car.scalableui.model.Event.Builder("_System_TaskOpenEvent")
                            .setPanelId("app_panel")
                            .build());
        } catch (Throwable t) {
            Log.w(TAG, "TaskOpen app_panel for Recents failed", t);
        }
        Intent intent = new Intent(
                "com.android.car.carlauncher.recents.OPEN_RECENT_TASK_ACTION");
        intent.setPackage("com.android.car.carlauncher");
        intent.setComponent(ComponentName.unflattenFromString(
                "com.android.car.carlauncher/.recents.CarRecentsActivity"));
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP
                | Intent.FLAG_ACTIVITY_NO_ANIMATION);
        startAsForegroundUser(intent);
    }

    private void launchPinned() {
        if (mFullyRestricted) {
            return;
        }
        Intent intent = new Intent("com.android.car.carlauncher.ACTION_SHOW_FAVORITES");
        intent.setPackage("com.android.car.carlauncher");
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startAsForegroundUser(intent);
    }

    private void launchPhone() {
        // Host Dialer in app_panel so it cannot go fullscreen over oem_dock.
        startComponentInAppPanel("com.android.car.dialer/.ui.TelecomActivity");
    }

    private void launchClimate() {
        if (mFullyRestricted) {
            return;
        }
        // Prefer direct in-process toggle (Dagger-injected) when available.
        if (mToggleAospHvac != null) {
            Log.i(TAG, "launchClimate → AOSP HvacPanelOverlay.toggle()");
            try {
                runOnViewThread(mToggleAospHvac);
            } catch (Throwable t) {
                Log.w(TAG, "AOSP HVAC toggle failed", t);
            }
            return;
        }
        // Same-process SystemUI: receiver is registered for the current user
        // (BroadcastDispatcher + UserTracker). Plain sendBroadcast() from a
        // system Context can miss user 10 — must use sendBroadcastAsUser.
        int userId = ActivityManager.getCurrentUser();
        Log.i(TAG, "launchClimate → TOGGLE_HVAC_PANEL user=" + userId);
        Intent toggle = new Intent(
                "com.android.systemui.car.action.TOGGLE_HVAC_PANEL");
        toggle.setPackage("com.android.systemui");
        toggle.addFlags(Intent.FLAG_RECEIVER_FOREGROUND);
        try {
            mContext.sendBroadcastAsUser(toggle, UserHandle.of(userId));
        } catch (Exception e) {
            Log.w(TAG, "sendBroadcastAsUser failed, trying sendBroadcast", e);
            try {
                mContext.sendBroadcast(toggle);
            } catch (Exception e2) {
                Log.w(TAG, "TOGGLE_HVAC_PANEL failed; ClimateActivity fallback", e2);
                removeMisplacedClimateTasks();
                startComponent("com.android.car.mockwidgets/.ClimateActivity");
            }
        }
    }

    /**
     * Removes ClimateActivity tasks that are NOT in the HVAC slide-up bounds
     * (typically leftover app_panel hosts). Leaves a correctly placed HVAC task alone.
     */
    private void removeMisplacedClimateTasks() {
        Rect hvacBounds = expectedHvacPanelBounds();
        try {
            Object atm = Class.forName("android.app.ActivityTaskManager")
                    .getMethod("getInstance").invoke(null);
            java.lang.reflect.Method getTasks;
            java.util.List<?> tasks;
            try {
                getTasks = atm.getClass().getMethod(
                        "getTasks", int.class, boolean.class, boolean.class, int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100, false, false, -1);
            } catch (NoSuchMethodException e) {
                getTasks = atm.getClass().getMethod("getTasks", int.class);
                tasks = (java.util.List<?>) getTasks.invoke(atm, 100);
            }
            if (tasks == null) {
                return;
            }
            java.lang.reflect.Method removeTask =
                    atm.getClass().getMethod("removeTask", int.class);
            for (Object raw : tasks) {
                if (!(raw instanceof ActivityManager.RunningTaskInfo)) {
                    continue;
                }
                ActivityManager.RunningTaskInfo task = (ActivityManager.RunningTaskInfo) raw;
                ComponentName cn = task.topActivity != null ? task.topActivity : task.baseActivity;
                if (cn == null) {
                    continue;
                }
                if (!"com.android.car.mockwidgets".equals(cn.getPackageName())) {
                    continue;
                }
                String cls = cn.getClassName();
                if (cls == null || !cls.endsWith(".ClimateActivity")) {
                    continue;
                }
                Rect bounds = getTaskBounds(task);
                if (bounds != null
                        && Math.abs(bounds.left - hvacBounds.left) <= 48
                        && Math.abs(bounds.right - hvacBounds.right) <= 48) {
                    Log.i(TAG, "Climate already in hvac bounds=" + bounds + " — keep");
                    continue;
                }
                Log.i(TAG, "removeMisplacedClimate taskId=" + task.taskId
                        + " bounds=" + bounds);
                removeTask.invoke(atm, task.taskId);
            }
        } catch (Throwable t) {
            Log.w(TAG, "removeMisplacedClimateTasks failed", t);
        }
    }

    /** Expected expanded HVAC panel bounds in px (matches hvac_left_panel.xml). */
    private Rect expectedHvacPanelBounds() {
        float d = mContext.getResources().getDisplayMetrics().density;
        return new Rect(
                Math.round(16 * d),
                Math.round(120 * d),
                Math.round(700 * d),
                Math.round(700 * d));
    }

    private void launchMedia() {
        // Keep playback on the OEM media card. Opening MediaActivity steals the map panel.
        Log.i(TAG, "launchMedia ignored — use media card controls");
    }

    private void launchCarStatus() {
        startComponentInAppPanel("com.android.car.mockwidgets/.DrivingStatsActivity");
    }

    /**
     * Opens {@code app_panel} (content plane above map/cards, below dock) then starts
     * {@code flattened}. Prevents freestanding fullscreen tasks from obscuring Home/All Apps.
     */
    private void startComponentInAppPanel(String flattened) {
        if (mFullyRestricted) {
            return;
        }
        try {
            com.android.car.scalableui.manager.StateManager.handleEvent(
                    new com.android.car.scalableui.model.Event.Builder("_System_TaskOpenEvent")
                            .setPanelId("app_panel")
                            .build());
        } catch (Throwable t) {
            Log.w(TAG, "TaskOpen app_panel failed", t);
        }
        startComponent(flattened);
    }

    private void startComponent(String flattened) {
        if (mFullyRestricted) {
            return;
        }
        try {
            ComponentName cn = ComponentName.unflattenFromString(flattened);
            if (cn == null) {
                Log.w(TAG, "Bad component: " + flattened);
                return;
            }
            Intent intent = new Intent(Intent.ACTION_MAIN);
            intent.setComponent(cn);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startAsForegroundUser(intent);
        } catch (Exception e) {
            Log.w(TAG, "Failed to launch " + flattened, e);
        }
    }

    private void startAsForegroundUser(Intent intent) {
        int userId = ActivityManager.getCurrentUser();
        UserHandle user = UserHandle.of(userId);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        Log.i(TAG, "startAsForegroundUser user=" + userId + " intent=" + intent);
        // PendingIntent.getActivityAsUser is @SystemApi — invoke via reflection.
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
            Log.w(TAG, "PendingIntent.getActivityAsUser failed", t);
        }
        try {
            android.app.ActivityOptions options = android.app.ActivityOptions.makeBasic();
            mContext.startActivityAsUser(intent, options.toBundle(), user);
        } catch (Throwable t) {
            Log.e(TAG, "startActivityAsUser failed for user " + userId, t);
        }
    }

    @Override
    protected void applyUxRestrictions() {
        setScrimVisible(mFooterUxScrim, mFullyRestricted);
        setScrimVisible(mMediaUxScrim, mFullyRestricted);
        boolean enabled = !mFullyRestricted;
        setViewEnabled(mNavAllApps, enabled);
        setViewEnabled(mNavHome, enabled);
        setViewEnabled(mNavRecent, enabled);
        setViewEnabled(mNavPinned, enabled);
        setViewEnabled(mMediaPrev, enabled);
        setViewEnabled(mMediaPlayPause, enabled);
        setViewEnabled(mMediaNext, enabled);
        setViewEnabled(mHvacUp, enabled);
        setViewEnabled(mHvacDown, enabled);
        setViewEnabled(mPassengerHvacUp, enabled);
        setViewEnabled(mPassengerHvacDown, enabled);
        setViewEnabled(mSeatHeat, enabled);
        setViewEnabled(mSeatVent, enabled);
    }

    @Override
    protected void applyVhalConnectedState() {
        readHvacTemp();
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_TEMPERATURE_SET, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_SEAT_TEMPERATURE, 0, mHvacCallback);
        mVhalHelper.subscribe(VehiclePropertyIds.HVAC_SEAT_VENTILATION, 0, mHvacCallback);
    }

    @Override
    protected void applyVhalDisconnectedState() {
        // Keep last known HVAC display; transport still works via media keys.
    }

    @Override
    protected void dumpControllerState(PrintWriter pw) {
        pw.println("  mediaPanelId=" + mMediaPanelId);
        pw.println("  mediaPanelVisible=" + mMediaPanelVisible);
        pw.println("  primaryMediaComponent=" + mPrimaryMediaComponent);
        pw.println("  isPlaying=" + mIsPlaying);
        pw.println("  activeController="
                + (mActiveController != null ? mActiveController.getPackageName() : "none"));
        pw.println("  panelLayout=" + getLayoutResourceName());
        pw.println("  navHome=" + (mNavHome != null)
                + " clickable=" + (mNavHome != null && mNavHome.isClickable())
                + " listener=" + (mNavHome != null && mNavHome.hasOnClickListeners()));
        pw.println("  navAllApps=" + (mNavAllApps != null)
                + " clickable=" + (mNavAllApps != null && mNavAllApps.isClickable())
                + " listener=" + (mNavAllApps != null && mNavAllApps.hasOnClickListeners()));
        if (mMediaTrackName != null) {
            pw.println("  trackTitle=" + mMediaTrackName.getText());
        }
        pw.println("  driverHvac=" + mDriverHvacTemp
                + "C view=" + (mHvacTempText != null));
        pw.println("  passengerHvac=" + mPassengerHvacTemp
                + "C view=" + (mPassengerHvacTempText != null));
        pw.println("  seatHeat=" + mSeatHeatLevel + " seatVent=" + mSeatVentLevel);
    }
}
