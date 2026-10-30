package com.scalableui.widgets.carprop;

import android.car.Car;
import android.car.hardware.CarPropertyConfig;
import android.car.hardware.CarPropertyValue;
import android.car.hardware.property.CarPropertyManager;
import android.content.Context;

import java.io.Closeable;
import java.util.ArrayList;
import java.util.List;

/** Thin CarPropertyManager wrapper. Values come from the vehicle, never stand-ins. */
public final class CarProps implements Closeable {
    public interface Listener {
        void onChanged();
    }

    private final Car car;
    private final CarPropertyManager manager;
    private final List<CarPropertyManager.CarPropertyEventCallback> callbacks = new ArrayList<>();

    public CarProps(Context context) {
        car = Car.createCar(context.getApplicationContext());
        Object service = car.getCarManager(Car.PROPERTY_SERVICE);
        if (!(service instanceof CarPropertyManager)) {
            car.disconnect();
            throw new IllegalStateException("CarPropertyManager unavailable");
        }
        manager = (CarPropertyManager) service;
    }

    public Float getFloat(int id) {
        return getFloat(id, 0);
    }

    public Float getFloat(int id, int area) {
        Number number = number(id, area);
        return number == null ? null : number.floatValue();
    }

    public Integer getInt(int id) {
        return getInt(id, 0);
    }

    public Integer getInt(int id, int area) {
        Number number = number(id, area);
        return number == null ? null : number.intValue();
    }

    public Boolean getBoolean(int id) {
        return getBoolean(id, 0);
    }

    public Boolean getBoolean(int id, int area) {
        Object value = raw(id, area);
        return value instanceof Boolean ? (Boolean) value : null;
    }

    public String getString(int id) {
        return getString(id, 0);
    }

    public String getString(int id, int area) {
        Object value = raw(id, area);
        return value instanceof String ? (String) value : null;
    }

    /** Inclusive min and max from the property config, or -10..10 when unset. */
    public int[] intRange(int id, int area) {
        int min = -10;
        int max = 10;
        try {
            CarPropertyConfig<?> config = manager.getCarPropertyConfig(id);
            if (config != null) {
                Object minValue = config.getMinValue(area);
                Object maxValue = config.getMaxValue(area);
                if (minValue instanceof Number) {
                    min = ((Number) minValue).intValue();
                }
                if (maxValue instanceof Number) {
                    max = ((Number) maxValue).intValue();
                }
            }
        } catch (RuntimeException ignored) {
        }
        if (min >= max) {
            return new int[] {-10, 10};
        }
        return new int[] {min, max};
    }

    public boolean setInt(int id, int area, int value) {
        try {
            manager.setIntProperty(id, area, value);
            return true;
        } catch (RuntimeException ignored) {
            return false;
        }
    }

    public boolean setBoolean(int id, int area, boolean value) {
        try {
            manager.setBooleanProperty(id, area, value);
            return true;
        } catch (RuntimeException ignored) {
            return false;
        }
    }

    public void listen(int[] ids, Listener listener) {
        CarPropertyManager.CarPropertyEventCallback callback =
                new CarPropertyManager.CarPropertyEventCallback() {
                    @Override
                    public void onChangeEvent(CarPropertyValue value) {
                        listener.onChanged();
                    }

                    @Override
                    public void onErrorEvent(int propId, int areaId) {
                    }
                };
        for (int id : ids) {
            try {
                CarPropertyConfig<?> config = manager.getCarPropertyConfig(id);
                float rate = config != null
                        && config.getChangeMode()
                                == CarPropertyConfig.VEHICLE_PROPERTY_CHANGE_MODE_CONTINUOUS
                        ? CarPropertyManager.SENSOR_RATE_UI
                        : CarPropertyManager.SENSOR_RATE_ONCHANGE;
                manager.registerCallback(callback, id, rate);
            } catch (RuntimeException ignored) {
            }
        }
        callbacks.add(callback);
    }

    @Override
    public void close() {
        for (CarPropertyManager.CarPropertyEventCallback callback : callbacks) {
            try {
                manager.unregisterCallback(callback);
            } catch (RuntimeException ignored) {
            }
        }
        callbacks.clear();
        car.disconnect();
    }

    private Number number(int id, int area) {
        Object value = raw(id, area);
        return value instanceof Number ? (Number) value : null;
    }

    private Object raw(int id, int area) {
        try {
            CarPropertyValue<?> value = manager.getProperty(id, area);
            return value == null ? null : value.getValue();
        } catch (RuntimeException ignored) {
            return null;
        }
    }
}
