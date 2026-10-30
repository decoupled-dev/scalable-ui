package com.scalableui.widgets.connections;

import android.Manifest;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class WidgetActivity extends Activity {
    private final BroadcastReceiver receiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            bind();
        }
    };

    private WifiManager wifiManager;
    private BluetoothAdapter bluetooth;
    private View wifiTile;
    private View bluetoothTile;
    private TextView wifiState;
    private TextView bluetoothState;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        wifiManager = getSystemService(WifiManager.class);
        BluetoothManager manager = getSystemService(BluetoothManager.class);
        bluetooth = manager == null ? null : manager.getAdapter();
        wifiTile = findViewById(R.id.wifi);
        bluetoothTile = findViewById(R.id.bluetooth);
        wifiState = findViewById(R.id.wifi_state);
        bluetoothState = findViewById(R.id.bluetooth_state);
        wifiTile.setOnClickListener(v -> setWifi(!wifiTile.isSelected()));
        bluetoothTile.setOnClickListener(v -> setBluetooth(!bluetoothTile.isSelected()));
    }

    @Override
    protected void onStart() {
        super.onStart();
        IntentFilter filter = new IntentFilter();
        filter.addAction(WifiManager.WIFI_STATE_CHANGED_ACTION);
        filter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
        registerReceiver(receiver, filter, RECEIVER_NOT_EXPORTED);
        if (checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(new String[] {Manifest.permission.BLUETOOTH_CONNECT}, 1);
        }
        bind();
    }

    @Override
    protected void onStop() {
        unregisterReceiver(receiver);
        super.onStop();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        bind();
    }

    private void bind() {
        boolean wifiOn = wifiManager != null && wifiManager.isWifiEnabled();
        wifiTile.setSelected(wifiOn);
        wifiState.setText(wifiOn ? "On" : "Off");
        boolean btOn = false;
        if (bluetooth != null
                && checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED) {
            try {
                btOn = bluetooth.isEnabled();
            } catch (SecurityException ignored) {
            }
        }
        bluetoothTile.setSelected(btOn);
        bluetoothState.setText(btOn ? "On" : "Off");
    }

    @SuppressWarnings("deprecation")
    private void setWifi(boolean enabled) {
        if (wifiManager != null) {
            wifiManager.setWifiEnabled(enabled);
        }
    }

    @SuppressWarnings("deprecation")
    private void setBluetooth(boolean enabled) {
        if (bluetooth == null
                || checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        try {
            if (enabled) {
                bluetooth.enable();
            } else {
                bluetooth.disable();
            }
        } catch (SecurityException ignored) {
        }
    }
}
