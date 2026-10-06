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
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.scalableui.widgets.carprop.CarProps
import com.scalableui.widgets.ui.IconTile
import com.scalableui.widgets.ui.StatPair
import com.scalableui.widgets.ui.StatusPill
import com.scalableui.widgets.ui.WidgetIcons
import com.scalableui.widgets.ui.WidgetPalettes
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

    val battery = batteryStat(levelWh, capacityWh)
    val range = rangeStat(rangeM)
    WidgetScreen("EV", WidgetPalettes.Ev, WidgetIcons.Battery) {
        StatPair(
            battery.value,
            battery.caption,
            range.value,
            range.caption,
            Modifier.weight(1f),
        )
        StatusPill(
            chargeStatus(connected, charging),
            Modifier.padding(bottom = 10.dp),
        )
        Row(
            Modifier
                .fillMaxWidth()
                .height(76.dp),
            horizontalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            IconTile(
                WidgetIcons.Port,
                "Port",
                portOpen == true,
                Modifier
                    .weight(1f)
                    .fillMaxHeight(),
            ) {
                props.setBoolean(VehiclePropertyIds.EV_CHARGE_PORT_OPEN, 0, portOpen != true)
                read()
            }
            IconTile(
                WidgetIcons.Bolt,
                "Charge",
                charging == true,
                Modifier
                    .weight(1f)
                    .fillMaxHeight(),
            ) {
                props.setBoolean(VehiclePropertyIds.EV_CHARGE_SWITCH, 0, charging != true)
                read()
            }
        }
    }
}

private data class Stat(val value: String, val caption: String)

private fun batteryStat(levelWh: Float?, capacityWh: Float?): Stat {
    if (levelWh == null) return Stat("—", "percent")
    if (capacityWh == null || capacityWh == 0f) return Stat("${levelWh.toInt()}", "Wh")
    return Stat("${(levelWh / capacityWh * 100f).toInt()}", "percent")
}

private fun rangeStat(meters: Float?): Stat =
    if (meters == null) Stat("—", "km range") else Stat("${(meters / 1000f).toInt()}", "km range")

private fun chargeStatus(connected: Boolean?, charging: Boolean?): String {
    val charge = when (charging) {
        true -> "Charging"
        false -> "Not charging"
        null -> "Charge —"
    }
    val port = when (connected) {
        true -> "Plugged in"
        false -> "Unplugged"
        null -> "Port —"
    }
    return "$charge  ·  $port"
}
