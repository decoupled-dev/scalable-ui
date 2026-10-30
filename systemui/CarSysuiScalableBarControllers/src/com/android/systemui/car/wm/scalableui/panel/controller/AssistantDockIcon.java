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
import android.content.pm.LauncherActivityInfo;
import android.content.pm.LauncherApps;
import android.content.pm.PackageManager;
import android.database.ContentObserver;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.os.UserHandle;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.List;

/**
 * Swaps the dock assistant glyph for the selected assistant's launcher icon.
 * Kept separate so a prebuilt SystemUI can call {@link #bind(View)} without
 * rebuilding the whole footer controller.
 */
public final class AssistantDockIcon {
    private static final String TAG = "AssistantDockIcon";
    private static final String ROLE_ASSISTANT = "android.app.role.ASSISTANT";

    private static final Handler sMain = new Handler(Looper.getMainLooper());
    private static final long POLL_MS = 1500L;

    /**
     * Comma-separated packages whose panel task survives {@link #prepare(Context)}.
     * Defaults to the car Media Center: removing its task kills the process that holds
     * the last binding to the active media app's browser service, and a paused source
     * such as Spotify then stops and destroys its media session about a second later,
     * which the home media widget renders as "Nothing playing".
     * Override for testing:
     *   adb shell settings put global scalable_ui_assistant_keep_packages com.android.car.media
     */
    private static final String KEEP_PACKAGES_SETTING = "scalable_ui_assistant_keep_packages";
    private static final String DEFAULT_KEEP_PACKAGES = "com.android.car.media";

    private static ImageView sButton;
    private static View sRoot;
    private static Context sContext;
    private static boolean sWatching;
    private static ContentObserver sObserver;
    private static Object sRoleListener;
    private static BroadcastReceiver sUserReceiver;
    private static String sAppliedPackage;
    private static int sAppliedUser = -1;

    private static final Runnable sPoll = new Runnable() {
        @Override
        public void run() {
            View target = sButton != null ? sButton : sRoot;
            if (target != null && !onViewThread(target)) {
                target.post(this);
                return;
            }
            try {
                int userId = currentUserId();
                String pkg = selectedPackage(userId);
                if (userId != sAppliedUser || !same(pkg, sAppliedPackage)) {
                    refresh();
                }
            } catch (Throwable t) {
                Log.w(TAG, "assistant poll failed", t);
            }
            schedulePoll();
        }
    };

    private AssistantDockIcon() {}

    /**
     * Remove other apps from the default card before the assistant session
     * opens, so the last-used app is not left visible behind Gemini.
     */
    public static void prepare(Context context) {
        if (context == null) {
            return;
        }
        try {
            List<?> tasks = runningTasks();
            if (tasks == null || tasks.isEmpty()) {
                return;
            }
            String assistant = packageFor(context, currentUserId());
            int panel = -1;
            for (int i = 0; i < tasks.size(); i++) {
                Object info = tasks.get(i);
                ComponentName top = taskTop(info);
                if (top == null || isChrome(top.getPackageName())
                        || (assistant != null && assistant.equals(top.getPackageName()))) {
                    continue;
                }
                int parent = panelId(info);
                if (parent > 0) {
                    panel = parent;
                    break;
                }
            }
            if (panel < 0) {
                Log.i(TAG, "assistant prepare: no app card");
                return;
            }
            int cleared = 0;
            for (int i = 0; i < tasks.size(); i++) {
                Object info = tasks.get(i);
                if (panelId(info) != panel) {
                    continue;
                }
                int taskId = intField(info, "taskId");
                if (taskId <= 0 || taskId == panel) {
                    continue;
                }
                ComponentName kept = taskTop(info);
                if (kept != null && keepsAlive(context, kept.getPackageName())) {
                    Log.i(TAG, "assistant prepare keeps " + kept.getPackageName());
                    continue;
                }
                if (removeTask(taskId)) {
                    cleared++;
                }
            }
            Log.i(TAG, "assistant prepare cleared " + cleared + " from panel " + panel);
        } catch (Throwable t) {
            Log.w(TAG, "assistant prepare failed", t);
        }
    }

    /** Find the assistant button under {@code root} and keep its icon current. */
    public static void bind(View root) {
        if (root == null) {
            return;
        }
        ImageView button = findAssistant(root);
        if (button == null) {
            return;
        }
        sRoot = root;
        sButton = button;
        Context context = root.getContext();
        Context app = context.getApplicationContext();
        sContext = app != null ? app : context;
        refresh();
        watch();
        root.addOnAttachStateChangeListener(new View.OnAttachStateChangeListener() {
            @Override
            public void onViewAttachedToWindow(View v) {
                ImageView found = findAssistant(v);
                if (found != null) {
                    sButton = found;
                    refresh();
                }
            }

            @Override
            public void onViewDetachedFromWindow(View v) {
                // A user switch detaches the dock briefly. Dropping the watcher
                // here left the new user's assistant changes with nobody listening.
                if (sButton != null && isDescendant(v, sButton)) {
                    sButton = null;
                }
            }
        });
    }

    private static ImageView findAssistant(View root) {
        if (root instanceof ImageView) {
            CharSequence desc = root.getContentDescription();
            if (desc != null && "Assistant".contentEquals(desc)) {
                return (ImageView) root;
            }
        }
        if (root instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) root;
            for (int i = 0; i < group.getChildCount(); i++) {
                ImageView found = findAssistant(group.getChildAt(i));
                if (found != null) {
                    return found;
                }
            }
        }
        return null;
    }

    private static void watch() {
        if (sWatching || sContext == null) {
            return;
        }
        sWatching = true;
        final Handler handler = new Handler(Looper.getMainLooper());
        sObserver = new ContentObserver(handler) {
            @Override
            public void onChange(boolean selfChange) {
                postRefresh();
            }
        };
        try {
            Method register = sContext.getContentResolver().getClass().getMethod(
                    "registerContentObserver",
                    Uri.class, boolean.class, ContentObserver.class, int.class);
            register.invoke(sContext.getContentResolver(),
                    Settings.Secure.getUriFor("voice_interaction_service"),
                    Boolean.FALSE, sObserver, Integer.valueOf(-1));
            register.invoke(sContext.getContentResolver(),
                    Settings.Secure.getUriFor("assistant"),
                    Boolean.FALSE, sObserver, Integer.valueOf(-1));
        } catch (Throwable t) {
            Log.w(TAG, "assistant settings watch failed", t);
        }
        try {
            Object roles = sContext.getSystemService("role");
            if (roles != null) {
                Class<?> listenerClass = roleListenerClass();
                sRoleListener = Proxy.newProxyInstance(
                        listenerClass.getClassLoader(),
                        new Class<?>[] {listenerClass},
                        (proxy, method, args) -> {
                            String name = method.getName();
                            if ("hashCode".equals(name)) {
                                return Integer.valueOf(System.identityHashCode(proxy));
                            }
                            if ("equals".equals(name)) {
                                return Boolean.valueOf(proxy == (args == null ? null : args[0]));
                            }
                            if ("toString".equals(name)) {
                                return "AssistantRoleListener";
                            }
                            if ("onRoleHoldersChanged".equals(name)
                                    && args != null && args.length > 0
                                    && ROLE_ASSISTANT.equals(args[0])) {
                                postRefresh();
                            }
                            return null;
                        });
                Method add = roles.getClass().getMethod(
                        "addOnRoleHoldersChangedListenerAsUser",
                        java.util.concurrent.Executor.class,
                        listenerClass,
                        UserHandle.class);
                add.invoke(roles, sContext.getMainExecutor(), sRoleListener, userHandleAll());
            }
        } catch (Throwable t) {
            Log.w(TAG, "assistant role watch failed", t);
        }
        sUserReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                Log.i(TAG, "assistant user event " + (intent == null ? "" : intent.getAction()));
                postRefresh();
                postRefreshDelayed(400);
            }
        };
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.intent.action.USER_SWITCHED");
        filter.addAction(Intent.ACTION_USER_UNLOCKED);
        try {
            Method register = Context.class.getMethod(
                    "registerReceiverAsUser",
                    BroadcastReceiver.class,
                    UserHandle.class,
                    IntentFilter.class,
                    String.class,
                    Handler.class,
                    int.class);
            register.invoke(sContext, sUserReceiver, userHandleAll(), filter, null, sMain,
                    Integer.valueOf(Context.RECEIVER_EXPORTED));
        } catch (Throwable t) {
            Log.w(TAG, "assistant user watch as user failed", t);
            try {
                sContext.registerReceiver(sUserReceiver, filter, Context.RECEIVER_EXPORTED);
            } catch (Throwable t2) {
                try {
                    sContext.registerReceiver(sUserReceiver, filter);
                } catch (Throwable t3) {
                    Log.w(TAG, "assistant user watch failed", t3);
                }
            }
        }
        schedulePoll();
    }

    /** The dock is created on the shell thread, not the main looper. */
    private static void postRefresh() {
        View target = sButton != null ? sButton : sRoot;
        if (target != null) {
            target.post(new Runnable() {
                @Override
                public void run() {
                    refresh();
                }
            });
            return;
        }
        sMain.post(new Runnable() {
            @Override
            public void run() {
                refresh();
            }
        });
    }

    private static void postRefreshDelayed(long delayMs) {
        View target = sButton != null ? sButton : sRoot;
        if (target != null) {
            target.postDelayed(new Runnable() {
                @Override
                public void run() {
                    refresh();
                }
            }, delayMs);
        }
    }

    private static void schedulePoll() {
        View target = sButton != null ? sButton : sRoot;
        if (target != null) {
            target.removeCallbacks(sPoll);
            target.postDelayed(sPoll, POLL_MS);
            return;
        }
        sMain.removeCallbacks(sPoll);
        sMain.postDelayed(sPoll, POLL_MS);
    }

    private static boolean onViewThread(View view) {
        android.os.Handler handler = view.getHandler();
        return handler != null && handler.getLooper().isCurrentThread();
    }

    private static void unbind() {
        if (!sWatching || sContext == null) {
            sWatching = false;
            sButton = null;
            return;
        }
        sWatching = false;
        if (sObserver != null) {
            try {
                sContext.getContentResolver().unregisterContentObserver(sObserver);
            } catch (Throwable ignored) {
            }
            sObserver = null;
        }
        if (sRoleListener != null) {
            try {
                Object roles = sContext.getSystemService("role");
                if (roles != null) {
                    Method remove = roles.getClass().getMethod(
                            "removeOnRoleHoldersChangedListenerAsUser",
                            roleListenerClass(),
                            UserHandle.class);
                    remove.invoke(roles, sRoleListener, userHandleAll());
                }
            } catch (Throwable ignored) {
            }
            sRoleListener = null;
        }
        if (sUserReceiver != null) {
            try {
                sContext.unregisterReceiver(sUserReceiver);
            } catch (Throwable ignored) {
            }
            sUserReceiver = null;
        }
        sButton = null;
    }

    /** This image exposes the listener as a top-level type, not a RoleManager nested type. */
    private static Class<?> roleListenerClass() throws ClassNotFoundException {
        try {
            return Class.forName("android.app.role.OnRoleHoldersChangedListener");
        } catch (ClassNotFoundException ignored) {
            return Class.forName("android.app.role.RoleManager$OnRoleHoldersChangedListener");
        }
    }

    private static void refresh() {
        if (sButton == null && sRoot != null) {
            sButton = findAssistant(sRoot);
        }
        ImageView button = sButton;
        int userId = currentUserId();
        String pkg = selectedPackage(userId);
        if (button == null) {
            Log.i(TAG, "assistant dock icon pending user=" + userId + " pkg=" + pkg);
            return;
        }
        if (!onViewThread(button)) {
            button.post(new Runnable() {
                @Override
                public void run() {
                    refresh();
                }
            });
            return;
        }
        Drawable icon = loadIcon(userId);
        if (icon != null) {
            button.setImageTintList(null);
            button.clearColorFilter();
            button.setScaleType(ImageView.ScaleType.FIT_CENTER);
            // Dock glyphs are circles inset in the 60dp slot. A launcher icon
            // fills the slot, so Gemini reads larger than Home and Maps.
            int pad = Math.round(4f * button.getResources().getDisplayMetrics().density);
            button.setPadding(pad, pad, pad, pad);
            button.setImageDrawable(icon.mutate());
            sAppliedUser = userId;
            sAppliedPackage = pkg;
            Log.i(TAG, "assistant dock icon updated user=" + userId + " pkg=" + pkg);
            return;
        }
        button.clearColorFilter();
        sAppliedUser = userId;
        sAppliedPackage = pkg;
        Log.i(TAG, "assistant dock icon unchanged user=" + userId + " pkg=" + pkg);
    }

    private static boolean same(String a, String b) {
        return a == null ? b == null : a.equals(b);
    }

    private static boolean isDescendant(View root, View child) {
        View current = child;
        while (current != null) {
            if (current == root) {
                return true;
            }
            android.view.ViewParent parent = current.getParent();
            current = parent instanceof View ? (View) parent : null;
        }
        return false;
    }

    private static Drawable loadIcon(int userId) {
        String pkg = selectedPackage(userId);
        if (pkg == null) {
            return null;
        }
        Context context = sContext;
        UserHandle user = userHandle(userId);
        try {
            LauncherApps apps = context.getSystemService(LauncherApps.class);
            if (apps != null) {
                List<LauncherActivityInfo> list = apps.getActivityList(pkg, user);
                if (list != null && !list.isEmpty()) {
                    int density = context.getResources().getDisplayMetrics().densityDpi;
                    Log.i(TAG, "assistant icon from " + pkg);
                    return list.get(0).getIcon(density);
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "assistant launcher icon failed for " + pkg, t);
        }
        try {
            return context.getPackageManager().getApplicationIcon(pkg);
        } catch (Throwable t) {
            Log.w(TAG, "assistant icon missing for " + pkg, t);
            return null;
        }
    }

    private static String packageFor(Context context, int userId) {
        Context previous = sContext;
        sContext = context;
        try {
            return selectedPackage(userId);
        } finally {
            sContext = previous;
        }
    }

    /** True when {@code pkg} is listed in {@link #KEEP_PACKAGES_SETTING} or its default. */
    private static boolean keepsAlive(Context context, String pkg) {
        if (pkg == null) {
            return false;
        }
        String list = null;
        try {
            list = Settings.Global.getString(context.getContentResolver(), KEEP_PACKAGES_SETTING);
        } catch (Throwable ignored) {
        }
        if (list == null || list.trim().isEmpty()) {
            list = DEFAULT_KEEP_PACKAGES;
        }
        for (String entry : list.split(",")) {
            if (pkg.equals(entry.trim())) {
                return true;
            }
        }
        return false;
    }

    private static boolean isChrome(String pkg) {
        if (pkg == null) {
            return true;
        }
        return "com.android.systemui".equals(pkg)
                || "com.android.car.carlauncher".equals(pkg)
                || "com.google.android.apps.maps".equals(pkg)
                || pkg.startsWith("com.scalableui.widgets")
                || "com.test.design".equals(pkg)
                || "android".equals(pkg)
                || "com.android.car.settings".equals(pkg)
                || "com.android.car.hvac".equals(pkg)
                || "com.android.permissioncontroller".equals(pkg)
                || "com.google.android.permissioncontroller".equals(pkg)
                || "com.android.packageinstaller".equals(pkg)
                || "com.google.android.packageinstaller".equals(pkg)
                || "com.android.intentresolver".equals(pkg);
    }

    private static List<?> runningTasks() throws Exception {
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
        if (chosen == null) {
            return null;
        }
        Class<?>[] params = chosen.getParameterTypes();
        Object[] args = new Object[params.length];
        for (int i = 0; i < params.length; i++) {
            if (params[i] == int.class) {
                args[i] = Integer.valueOf(i == 0 ? 32 : -1);
            } else if (params[i] == boolean.class) {
                args[i] = Boolean.TRUE;
            } else {
                args[i] = null;
            }
        }
        Object result = chosen.invoke(service, args);
        if (result instanceof List) {
            return (List<?>) result;
        }
        return null;
    }

    private static boolean removeTask(int taskId) {
        try {
            Class<?> atm = Class.forName("android.app.ActivityTaskManager");
            Object service = atm.getMethod("getService").invoke(null);
            for (Method method : service.getClass().getMethods()) {
                if (!"removeTask".equals(method.getName())) {
                    continue;
                }
                Class<?>[] params = method.getParameterTypes();
                if (params.length == 1 && params[0] == int.class) {
                    method.invoke(service, Integer.valueOf(taskId));
                    return true;
                }
            }
        } catch (Throwable t) {
            Log.w(TAG, "removeTask " + taskId + " failed", t);
        }
        return false;
    }

    private static ComponentName taskTop(Object info) {
        Object value = field(info, "topActivity");
        return value instanceof ComponentName ? (ComponentName) value : null;
    }

    private static int panelId(Object info) {
        int parent = intField(info, "parentTaskId");
        if (parent > 0) {
            return parent;
        }
        int root = intField(info, "rootTaskId");
        int self = intField(info, "taskId");
        if (root > 0 && root != self) {
            return root;
        }
        return -1;
    }

    private static int intField(Object info, String name) {
        Object value = field(info, name);
        return value instanceof Integer ? ((Integer) value).intValue() : -1;
    }

    private static Object field(Object info, String name) {
        Class<?> type = info.getClass();
        while (type != null) {
            try {
                Field field = type.getDeclaredField(name);
                field.setAccessible(true);
                return field.get(info);
            } catch (Throwable ignored) {
            }
            type = type.getSuperclass();
        }
        return null;
    }

    private static String selectedPackage(int userId) {
        ComponentName component = unflatten(secureString("voice_interaction_service", userId));
        if (component == null) {
            component = unflatten(secureString("assistant", userId));
        }
        if (component != null) {
            return component.getPackageName();
        }
        try {
            Object roles = sContext.getSystemService("role");
            if (roles == null) {
                return null;
            }
            Method get = roles.getClass().getMethod(
                    "getRoleHoldersAsUser", String.class, UserHandle.class);
            Object holders = get.invoke(roles, ROLE_ASSISTANT, userHandle(userId));
            if (holders instanceof List && !((List<?>) holders).isEmpty()) {
                Object first = ((List<?>) holders).get(0);
                return first instanceof String ? (String) first : null;
            }
        } catch (Throwable t) {
            Log.w(TAG, "assistant role lookup failed", t);
        }
        return null;
    }

    private static String secureString(String key, int userId) {
        try {
            Method get = Settings.Secure.class.getMethod(
                    "getStringForUser",
                    android.content.ContentResolver.class, String.class, int.class);
            Object value = get.invoke(null, sContext.getContentResolver(), key,
                    Integer.valueOf(userId));
            return value instanceof String ? (String) value : null;
        } catch (Throwable t) {
            return Settings.Secure.getString(sContext.getContentResolver(), key);
        }
    }

    private static ComponentName unflatten(String flat) {
        if (flat == null || flat.isEmpty()) {
            return null;
        }
        return ComponentName.unflattenFromString(flat);
    }

    private static int currentUserId() {
        try {
            Method method = ActivityManager.class.getMethod("getCurrentUser");
            Object value = method.invoke(null);
            if (value instanceof Integer) {
                return (Integer) value;
            }
        } catch (Throwable ignored) {
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
        } catch (Throwable ignored) {
        }
        return android.os.Process.myUserHandle();
    }

    private static UserHandle userHandleAll() {
        try {
            Object value = UserHandle.class.getField("ALL").get(null);
            if (value instanceof UserHandle) {
                return (UserHandle) value;
            }
        } catch (Throwable ignored) {
        }
        return userHandle(-1);
    }
}
