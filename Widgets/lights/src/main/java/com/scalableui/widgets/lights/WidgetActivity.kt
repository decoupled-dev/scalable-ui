package com.scalableui.widgets.lights

import android.car.VehiclePropertyIds
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.platform.LocalContext
import com.scalableui.widgets.carprop.CarProps
import com.scalableui.widgets.ui.ChipRow
import com.scalableui.widgets.ui.SoftChip
import com.scalableui.widgets.ui.WidgetScreen

private const val Off = 0
private const val On = 1

private val Switches = intArrayOf(
    VehiclePropertyIds.CABIN_LIGHTS_SWITCH,
    VehiclePropertyIds.HEADLIGHTS_SWITCH,
    VehiclePropertyIds.HIGH_BEAM_LIGHTS_SWITCH,
    VehiclePropertyIds.HAZARD_LIGHTS_SWITCH,
)

open class WidgetActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { LightsScreen() }
    }
}

class MainActivity : WidgetActivity()

@Composable
private fun LightsScreen() {
    val context = LocalContext.current
    val props = remember { CarProps(context) }
    var cabin by remember { mutableStateOf<Int?>(null) }
    var head by remember { mutableStateOf<Int?>(null) }
    var high by remember { mutableStateOf<Int?>(null) }
    var hazard by remember { mutableStateOf<Int?>(null) }

    fun read() {
        cabin = props.getInt(VehiclePropertyIds.CABIN_LIGHTS_SWITCH)
        head = props.getInt(VehiclePropertyIds.HEADLIGHTS_SWITCH)
        high = props.getInt(VehiclePropertyIds.HIGH_BEAM_LIGHTS_SWITCH)
        hazard = props.getInt(VehiclePropertyIds.HAZARD_LIGHTS_SWITCH)
    }

    DisposableEffect(props) {
        read()
        props.listen(Switches) { read() }
        onDispose { props.close() }
    }

    WidgetScreen("Lights") {
        ChipRow {
            Lamp("Cabin", cabin) {
                props.setInt(VehiclePropertyIds.CABIN_LIGHTS_SWITCH, 0, it)
                read()
            }
            Lamp("Headlights", head) {
                props.setInt(VehiclePropertyIds.HEADLIGHTS_SWITCH, 0, it)
                read()
            }
        }
        ChipRow {
            Lamp("High beam", high) {
                props.setInt(VehiclePropertyIds.HIGH_BEAM_LIGHTS_SWITCH, 0, it)
                read()
            }
            Lamp("Hazards", hazard) {
                props.setInt(VehiclePropertyIds.HAZARD_LIGHTS_SWITCH, 0, it)
                read()
            }
        }
    }
}

@Composable
private fun Lamp(label: String, value: Int?, write: (Int) -> Unit) {
    val on = value == On
    SoftChip(label, on) {
        write(if (on) Off else On)
    }
}
