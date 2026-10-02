package com.scalableui.widgets.seats

import android.car.VehicleAreaSeat
import android.car.VehiclePropertyIds
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.platform.LocalContext
import com.scalableui.widgets.carprop.CarProps
import com.scalableui.widgets.ui.Muted
import com.scalableui.widgets.ui.WidgetScreen
import com.scalableui.widgets.ui.sliderColors

private const val Driver = VehicleAreaSeat.SEAT_ROW_1_LEFT

private val Positions = intArrayOf(
    VehiclePropertyIds.SEAT_FORE_AFT_POS,
    VehiclePropertyIds.SEAT_HEIGHT_POS,
    VehiclePropertyIds.SEAT_BACKREST_ANGLE_1_POS,
)

open class WidgetActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { SeatsScreen() }
    }
}

class MainActivity : WidgetActivity()

@Composable
private fun SeatsScreen() {
    val context = LocalContext.current
    val props = remember { CarProps(context) }
    var foreRange by remember { mutableStateOf(-10f..10f) }
    var heightRange by remember { mutableStateOf(-10f..10f) }
    var backRange by remember { mutableStateOf(-10f..10f) }
    var fore by remember { mutableFloatStateOf(0f) }
    var height by remember { mutableFloatStateOf(0f) }
    var back by remember { mutableFloatStateOf(0f) }

    fun read() {
        foreRange = range(props, VehiclePropertyIds.SEAT_FORE_AFT_POS)
        heightRange = range(props, VehiclePropertyIds.SEAT_HEIGHT_POS)
        backRange = range(props, VehiclePropertyIds.SEAT_BACKREST_ANGLE_1_POS)
        fore = (props.getInt(VehiclePropertyIds.SEAT_FORE_AFT_POS, Driver) ?: 0).toFloat()
        height = (props.getInt(VehiclePropertyIds.SEAT_HEIGHT_POS, Driver) ?: 0).toFloat()
        back = (props.getInt(VehiclePropertyIds.SEAT_BACKREST_ANGLE_1_POS, Driver) ?: 0).toFloat()
    }

    DisposableEffect(props) {
        read()
        props.listen(Positions) { read() }
        onDispose { props.close() }
    }

    WidgetScreen("Seats") {
        Axis("Fore-aft", fore, foreRange, { fore = it }) {
            props.setInt(VehiclePropertyIds.SEAT_FORE_AFT_POS, Driver, fore.toInt())
        }
        Axis("Height", height, heightRange, { height = it }) {
            props.setInt(VehiclePropertyIds.SEAT_HEIGHT_POS, Driver, height.toInt())
        }
        Axis("Backrest", back, backRange, { back = it }) {
            props.setInt(VehiclePropertyIds.SEAT_BACKREST_ANGLE_1_POS, Driver, back.toInt())
        }
    }
}

@Composable
private fun Axis(
    label: String,
    value: Float,
    range: ClosedFloatingPointRange<Float>,
    onChange: (Float) -> Unit,
    onFinish: () -> Unit,
) {
    val colors = sliderColors()
    Muted("$label  ${value.toInt()}")
    Slider(
        value = value.coerceIn(range),
        onValueChange = onChange,
        onValueChangeFinished = onFinish,
        valueRange = range,
        colors = SliderDefaults.colors(
            thumbColor = colors.accent,
            activeTrackColor = colors.accent,
            inactiveTrackColor = colors.track,
        ),
    )
}

private fun range(props: CarProps, id: Int): ClosedFloatingPointRange<Float> {
    val bounds = props.intRange(id, Driver)
    return bounds[0].toFloat()..bounds[1].toFloat()
}
