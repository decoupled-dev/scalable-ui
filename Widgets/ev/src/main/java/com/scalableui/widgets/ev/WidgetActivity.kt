package com.scalableui.widgets.ev

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
import com.scalableui.widgets.ui.HeroStat
import com.scalableui.widgets.ui.Muted
import com.scalableui.widgets.ui.SoftChip
import com.scalableui.widgets.ui.WidgetScreen

open class WidgetActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { EvScreen() }
    }
}

class MainActivity : WidgetActivity()

private val Watched = intArrayOf(
    VehiclePropertyIds.EV_BATTERY_LEVEL,
    VehiclePropertyIds.INFO_EV_BATTERY_CAPACITY,
    VehiclePropertyIds.RANGE_REMAINING,
    VehiclePropertyIds.EV_CHARGE_PORT_CONNECTED,
    VehiclePropertyIds.EV_CHARGE_PORT_OPEN,
    VehiclePropertyIds.EV_CHARGE_SWITCH,
)

@Composable
private fun EvScreen() {
    val context = LocalContext.current
    val props = remember { CarProps(context) }
    var levelWh by remember { mutableStateOf<Float?>(null) }
    var capacityWh by remember { mutableStateOf<Float?>(null) }
    var rangeM by remember { mutableStateOf<Float?>(null) }
    var connected by remember { mutableStateOf<Boolean?>(null) }
    var portOpen by remember { mutableStateOf<Boolean?>(null) }
    var charging by remember { mutableStateOf<Boolean?>(null) }

    fun read() {
        levelWh = props.getFloat(VehiclePropertyIds.EV_BATTERY_LEVEL)
        capacityWh = props.getFloat(VehiclePropertyIds.INFO_EV_BATTERY_CAPACITY)
        rangeM = props.getFloat(VehiclePropertyIds.RANGE_REMAINING)
        connected = props.getBoolean(VehiclePropertyIds.EV_CHARGE_PORT_CONNECTED)
        portOpen = props.getBoolean(VehiclePropertyIds.EV_CHARGE_PORT_OPEN)
        charging = props.getBoolean(VehiclePropertyIds.EV_CHARGE_SWITCH)
    }

    DisposableEffect(props) {
        read()
        props.listen(Watched) { read() }
        onDispose { props.close() }
    }

    WidgetScreen("EV") {
        HeroStat(percent(levelWh, capacityWh), "Range ${rangeKm(rangeM)}")
        Muted("Port ${yesNo(connected)}")
        ChipRow {
            SoftChip("Port open", portOpen == true) {
                props.setBoolean(VehiclePropertyIds.EV_CHARGE_PORT_OPEN, 0, portOpen != true)
                read()
            }
            SoftChip("Charge", charging == true) {
                props.setBoolean(VehiclePropertyIds.EV_CHARGE_SWITCH, 0, charging != true)
                read()
            }
        }
    }
}

private fun percent(levelWh: Float?, capacityWh: Float?): String {
    if (levelWh == null) return "—"
    if (capacityWh == null || capacityWh == 0f) return "${levelWh.toInt()} Wh"
    return "${(levelWh / capacityWh * 100f).toInt()}%"
}

private fun rangeKm(meters: Float?): String =
    if (meters == null) "—" else "${(meters / 1000f).toInt()} km"

private fun yesNo(value: Boolean?): String = when (value) {
    true -> "yes"
    false -> "no"
    null -> "—"
}
