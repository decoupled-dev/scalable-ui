package com.scalableui.widgets.user;

import android.app.Activity;
import android.car.VehiclePropertyIds;
import android.os.Bundle;
import android.os.UserManager;
import android.view.View;
import android.widget.TextView;

import com.scalableui.widgets.carprop.CarProps;

import java.util.Locale;

public class WidgetActivity extends Activity {
    private static final int[] IDS = {
            VehiclePropertyIds.INFO_MAKE,
            VehiclePropertyIds.INFO_MODEL,
    };

    private CarProps props;
    private TextView name;
    private TextView vehicle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        name = findViewById(R.id.name);
        vehicle = findViewById(R.id.vehicle);
        name.setText(userName());
        try {
            props = new CarProps(this);
            props.listen(IDS, this::bindVehicle);
            bindVehicle();
        } catch (RuntimeException ignored) {
            vehicle.setVisibility(View.GONE);
        }
    }

    private void bindVehicle() {
        runOnUiThread(() -> {
            if (props == null) {
                return;
            }
            String line = vehicleLine(
                    props.getString(VehiclePropertyIds.INFO_MAKE),
                    props.getString(VehiclePropertyIds.INFO_MODEL));
            if (line == null) {
                vehicle.setVisibility(View.GONE);
            } else {
                vehicle.setText(line);
                vehicle.setVisibility(View.VISIBLE);
            }
        });
    }

    private String userName() {
        try {
            UserManager users = getSystemService(UserManager.class);
            if (users != null) {
                String value = users.getUserName();
                if (!placeholder(value)) {
                    return value.trim();
                }
            }
        } catch (RuntimeException ignored) {
        }
        return "Driver";
    }

    /** Reference VHAL fills INFO_MAKE with "Toy Vehicle". That is not a driver name. */
    private static String vehicleLine(String make, String model) {
        boolean makeOk = !placeholder(make);
        boolean modelOk = !placeholder(model);
        if (makeOk && modelOk) {
            String makeText = make.trim();
            String modelText = model.trim();
            if (modelText.toLowerCase(Locale.US).startsWith(makeText.toLowerCase(Locale.US))) {
                return modelText;
            }
            return makeText + " " + modelText;
        }
        if (makeOk) {
            return make.trim();
        }
        if (modelOk) {
            return model.trim();
        }
        return null;
    }

    private static boolean placeholder(String value) {
        if (value == null) {
            return true;
        }
        String text = value.trim().toLowerCase(Locale.US);
        switch (text) {
            case "":
            case "—":
            case "-":
            case "toy":
            case "vehicle":
            case "toy vehicle":
            case "android":
            case "goldfish":
            case "cuttlefish":
            case "cuttlefish automotive":
            case "speedy model":
            case "unknown":
            case "null":
                return true;
            default:
                return false;
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
