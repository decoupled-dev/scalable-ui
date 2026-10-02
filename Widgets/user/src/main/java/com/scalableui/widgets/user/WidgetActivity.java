package com.scalableui.widgets.user;

import android.app.Activity;
import android.car.VehiclePropertyIds;
import android.os.Bundle;
import android.widget.TextView;

import com.scalableui.widgets.carprop.CarProps;

public class WidgetActivity extends Activity {
    private static final int[] IDS = {
            VehiclePropertyIds.INFO_MAKE,
            VehiclePropertyIds.INFO_MODEL,
            VehiclePropertyIds.INFO_MODEL_YEAR,
            VehiclePropertyIds.INFO_DRIVER_SEAT,
    };

    private CarProps props;
    private TextView make;
    private TextView model;
    private TextView year;
    private TextView driver;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        make = findViewById(R.id.make);
        model = findViewById(R.id.model);
        year = findViewById(R.id.year);
        driver = findViewById(R.id.driver);
        try {
            props = new CarProps(this);
            props.listen(IDS, this::bind);
            bind();
        } catch (RuntimeException error) {
            make.setText(error.getMessage());
        }
    }

    private void bind() {
        runOnUiThread(() -> {
            if (props == null) {
                return;
            }
            make.setText(text(props.getString(VehiclePropertyIds.INFO_MAKE)));
            model.setText(text(props.getString(VehiclePropertyIds.INFO_MODEL)));
            Integer modelYear = props.getInt(VehiclePropertyIds.INFO_MODEL_YEAR);
            year.setText(modelYear == null ? "—" : Integer.toString(modelYear));
            driver.setText(seat(props.getInt(VehiclePropertyIds.INFO_DRIVER_SEAT)));
        });
    }

    private static String text(String value) {
        return value == null || value.isEmpty() ? "—" : value;
    }

    private static String seat(Integer area) {
        if (area == null) {
            return "—";
        }
        switch (area) {
            case 0x1:
                return "Row 1 left";
            case 0x4:
                return "Row 1 right";
            case 0x10:
                return "Row 2 left";
            case 0x40:
                return "Row 2 right";
            default:
                return "Seat " + area;
        }
    }

    @Override
    protected void onDestroy() {
        if (props != null) {
            props.close();
        }
        super.onDestroy();
    }
}
