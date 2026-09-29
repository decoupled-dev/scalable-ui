package com.android.car.mockwidgets;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.CallLog;
import android.text.TextUtils;
import android.text.format.DateUtils;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Set;

/**
 * Compact Dialer-style recents for the OEM phone card TaskPanel.
 * Reads the live call log and opens full Car Dialer on tap / Open.
 */
public class PhoneRecentsActivity extends Activity {
    private static final String TAG = "PhoneRecentsActivity";
    private static final String DIALER =
            "com.android.car.dialer/com.android.car.dialer.ui.TelecomActivity";
    private static final int MAX_RECENTS = 6;

    private TextView mSubtitle;
    private LinearLayout mList;
    private TextView mEmpty;
    private final Runnable mRefresh = this::refresh;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.phone_recents_widget);

        mSubtitle = findViewById(R.id.phone_subtitle);
        mList = findViewById(R.id.recents_list);
        mEmpty = findViewById(R.id.recents_empty);

        View open = findViewById(R.id.phone_open_dialer);
        if (open != null) {
            open.setOnClickListener(v -> openDialer());
        }
        View root = findViewById(R.id.root_view);
        if (root != null) {
            root.setOnLongClickListener(v -> {
                openDialer();
                return true;
            });
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        refresh();
        View root = findViewById(R.id.root_view);
        if (root != null) {
            root.removeCallbacks(mRefresh);
            root.postDelayed(mRefresh, 5000L);
        }
    }

    @Override
    protected void onPause() {
        View root = findViewById(R.id.root_view);
        if (root != null) {
            root.removeCallbacks(mRefresh);
        }
        super.onPause();
    }

    private void refresh() {
        updateBluetoothSubtitle();
        bindRecents();
        View root = findViewById(R.id.root_view);
        if (root != null && !isFinishing()) {
            root.removeCallbacks(mRefresh);
            root.postDelayed(mRefresh, 5000L);
        }
    }

    private void updateBluetoothSubtitle() {
        if (mSubtitle == null) {
            return;
        }
        String name = resolveConnectedBtName();
        if (name != null) {
            mSubtitle.setText("Connected: " + name);
        } else {
            mSubtitle.setText("Pair a phone to make and receive calls.");
        }
    }

    private String resolveConnectedBtName() {
        try {
            BluetoothAdapter adapter = BluetoothAdapter.getDefaultAdapter();
            if (adapter == null || !adapter.isEnabled()) {
                return null;
            }
            Set<BluetoothDevice> bonded = adapter.getBondedDevices();
            if (bonded == null || bonded.isEmpty()) {
                return null;
            }
            BluetoothDevice first = null;
            for (BluetoothDevice device : bonded) {
                if (device == null) {
                    continue;
                }
                if (first == null) {
                    first = device;
                }
                try {
                    Object connected = BluetoothDevice.class.getMethod("isConnected")
                            .invoke(device);
                    if (Boolean.TRUE.equals(connected)) {
                        String n = device.getName();
                        return !TextUtils.isEmpty(n) ? n : device.getAddress();
                    }
                } catch (Throwable ignored) {
                }
            }
            if (first != null) {
                String n = first.getName();
                return !TextUtils.isEmpty(n) ? n : first.getAddress();
            }
        } catch (SecurityException e) {
            Log.w(TAG, "BT query denied", e);
        } catch (Throwable t) {
            Log.w(TAG, "BT query failed", t);
        }
        return null;
    }

    private void bindRecents() {
        if (mList == null) {
            return;
        }
        mList.removeAllViews();
        int added = 0;
        try (Cursor c = getContentResolver().query(
                CallLog.Calls.CONTENT_URI,
                new String[]{
                        CallLog.Calls.NUMBER,
                        CallLog.Calls.CACHED_NAME,
                        CallLog.Calls.TYPE,
                        CallLog.Calls.DATE
                },
                null,
                null,
                CallLog.Calls.DEFAULT_SORT_ORDER)) {
            if (c != null) {
                while (c.moveToNext() && added < MAX_RECENTS) {
                    String number = c.getString(0);
                    String name = c.getString(1);
                    int type = c.getInt(2);
                    long date = c.getLong(3);
                    String label = !TextUtils.isEmpty(name) ? name
                            : (!TextUtils.isEmpty(number) ? number : "Unknown");
                    mList.addView(makeRow(label, number, type, date));
                    added++;
                }
            }
        } catch (SecurityException e) {
            Log.w(TAG, "CallLog read denied", e);
        } catch (Throwable t) {
            Log.w(TAG, "CallLog query failed", t);
        }

        boolean empty = added == 0;
        View scroll = findViewById(R.id.recents_scroll);
        if (scroll != null) {
            scroll.setVisibility(empty ? View.GONE : View.VISIBLE);
        }
        mList.setVisibility(empty ? View.GONE : View.VISIBLE);
        if (mEmpty != null) {
            mEmpty.setVisibility(empty ? View.VISIBLE : View.GONE);
            if (empty) {
                mEmpty.setText("No recent calls yet");
            }
        }
    }

    private View makeRow(String label, String number, int type, long dateMs) {
        LinearLayout row = new LinearLayout(this);
        row.setOrientation(LinearLayout.HORIZONTAL);
        row.setPadding(0, 6, 0, 6);
        row.setGravity(android.view.Gravity.CENTER_VERTICAL);
        row.setClickable(true);
        row.setFocusable(true);
        row.setBackgroundColor(0x00000000);

        TextView glyph = new TextView(this);
        glyph.setText(typeGlyph(type));
        glyph.setTextColor(typeColor(type));
        glyph.setTextSize(14f);
        glyph.setPadding(0, 0, 10, 0);

        LinearLayout textCol = new LinearLayout(this);
        textCol.setOrientation(LinearLayout.VERTICAL);
        LinearLayout.LayoutParams textLp = new LinearLayout.LayoutParams(
                0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        textCol.setLayoutParams(textLp);

        TextView title = new TextView(this);
        title.setText(label);
        title.setTextColor(0xFFFFFFFF);
        title.setTextSize(15f);
        title.setMaxLines(1);
        title.setEllipsize(android.text.TextUtils.TruncateAt.END);

        TextView meta = new TextView(this);
        meta.setText(typeLabel(type));
        meta.setTextColor(0x99FFFFFF);
        meta.setTextSize(11f);
        meta.setMaxLines(1);

        textCol.addView(title, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        textCol.addView(meta, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        TextView when = new TextView(this);
        when.setText(relativeTime(dateMs));
        when.setTextColor(0x80FFFFFF);
        when.setTextSize(11f);
        when.setMaxLines(1);
        when.setPadding(8, 0, 0, 0);

        row.addView(glyph, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        row.addView(textCol);
        row.addView(when, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        row.setOnClickListener(v -> {
            if (!TextUtils.isEmpty(number)) {
                try {
                    Intent call = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + number));
                    call.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(call);
                    return;
                } catch (Throwable t) {
                    Log.w(TAG, "ACTION_CALL failed, opening Dialer", t);
                }
            }
            openDialer();
        });
        return row;
    }

    private static String typeGlyph(int type) {
        switch (type) {
            case CallLog.Calls.INCOMING_TYPE:
                return "↙";
            case CallLog.Calls.OUTGOING_TYPE:
                return "↗";
            case CallLog.Calls.MISSED_TYPE:
            case CallLog.Calls.REJECTED_TYPE:
                return "✕";
            default:
                return "•";
        }
    }

    private static int typeColor(int type) {
        switch (type) {
            case CallLog.Calls.MISSED_TYPE:
            case CallLog.Calls.REJECTED_TYPE:
                return 0xFFFF8A80;
            case CallLog.Calls.OUTGOING_TYPE:
                return 0xFF7DCEA0;
            default:
                return 0xFF90CAF9;
        }
    }

    private static String typeLabel(int type) {
        switch (type) {
            case CallLog.Calls.INCOMING_TYPE:
                return "Incoming";
            case CallLog.Calls.OUTGOING_TYPE:
                return "Outgoing";
            case CallLog.Calls.MISSED_TYPE:
                return "Missed";
            case CallLog.Calls.REJECTED_TYPE:
                return "Rejected";
            default:
                return "Call";
        }
    }

    private String relativeTime(long dateMs) {
        try {
            return DateUtils.getRelativeTimeSpanString(
                    dateMs,
                    System.currentTimeMillis(),
                    DateUtils.MINUTE_IN_MILLIS,
                    DateUtils.FORMAT_ABBREV_RELATIVE).toString();
        } catch (Throwable t) {
            return "";
        }
    }

    private void openDialer() {
        try {
            Intent intent = Intent.makeMainActivity(
                    android.content.ComponentName.unflattenFromString(DIALER));
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);
            // Full Dialer chrome — not widget mode.
            intent.putExtra("com.android.car.dialer.EXTRA_WIDGET_MODE", false);
            startActivity(intent);
        } catch (ActivityNotFoundException e) {
            Log.w(TAG, "Dialer not found", e);
        }
    }
}
