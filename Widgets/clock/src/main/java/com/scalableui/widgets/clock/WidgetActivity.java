package com.scalableui.widgets.clock;

import android.app.Activity;
import android.car.VehiclePropertyIds;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.format.DateFormat;
import android.widget.TextView;

import com.scalableui.widgets.carprop.CarProps;

import java.util.Date;

public class WidgetActivity extends Activity {
    private final Handler handler = new Handler(Looper.getMainLooper());
    private final Runnable tick = new Runnable() {
        @Override
        public void run() {
            bindClock();
            handler.postDelayed(this, 1000);
        }
    };

    private CarProps props;
    private TextView time;
    private TextView date;
    private TextView night;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        time = findViewById(R.id.time);
        date = findViewById(R.id.date);
        night = findViewById(R.id.night);
        try {
            props = new CarProps(this);
            props.listen(new int[] {VehiclePropertyIds.NIGHT_MODE}, this::bindNight);
        } catch (RuntimeException error) {
            night.setText(error.getMessage());
        }
        bindNight();
        handler.post(tick);
    }

    private void bindClock() {
        Date now = new Date(System.currentTimeMillis());
        time.setText(DateFormat.getTimeFormat(this).format(now));
        date.setText(DateFormat.getLongDateFormat(this).format(now));
    }

    private void bindNight() {
        runOnUiThread(() -> {
            if (props == null) {
                return;
            }
            Boolean mode = props.getBoolean(VehiclePropertyIds.NIGHT_MODE);
            night.setSelected(Boolean.TRUE.equals(mode));
            night.setText(mode == null ? "Night —" : (mode ? "Night on" : "Night off"));
        });
    }

    @Override
    protected void onDestroy() {
        handler.removeCallbacks(tick);
        if (props != null) {
            props.close();
        }
        super.onDestroy();
    }
}
