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
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.scalableui.widgets.carprop.CarProps
import com.scalableui.widgets.ui.IconTile
import com.scalableui.widgets.ui.WidgetIcons
import com.scalableui.widgets.ui.WidgetPalettes
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

    WidgetScreen("Lights", WidgetPalettes.Lights, WidgetIcons.Cabin) {
        Column(
            Modifier
                .weight(1f)
                .fillMaxWidth(),
            verticalArrangement = Arrangement.spacedBy(14.dp),
        ) {
            Row(
                Modifier
                    .weight(1f)
                    .fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(14.dp),
            ) {
                Lamp(WidgetIcons.Cabin, "Cabin", cabin, Modifier.weight(1f).fillMaxHeight()) {
                    props.setInt(VehiclePropertyIds.CABIN_LIGHTS_SWITCH, 0, it)
                    read()
                }
                Lamp(WidgetIcons.Headlight, "Headlights", head, Modifier.weight(1f).fillMaxHeight()) {
                    props.setInt(VehiclePropertyIds.HEADLIGHTS_SWITCH, 0, it)
                    read()
                }
            }
            Row(
                Modifier
                    .weight(1f)
                    .fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(14.dp),
            ) {
                Lamp(WidgetIcons.HighBeam, "High beam", high, Modifier.weight(1f).fillMaxHeight()) {
                    props.setInt(VehiclePropertyIds.HIGH_BEAM_LIGHTS_SWITCH, 0, it)
                    read()
                }
                Lamp(
                    WidgetIcons.Hazard,
                    "Hazards",
                    hazard,
                    Modifier.weight(1f).fillMaxHeight(),
                    Color(0xFFFF8A80),
                ) {
                    props.setInt(VehiclePropertyIds.HAZARD_LIGHTS_SWITCH, 0, it)
                    read()
                }
            }
        }
    }
}

@Composable
private fun Lamp(
    icon: ImageVector,
    label: String,
    value: Int?,
    modifier: Modifier,
    selectedTint: Color? = null,
    write: (Int) -> Unit,
) {
    val on = value == On
    IconTile(icon, label, on, modifier, selectedTint) {
        write(if (on) Off else On)
    }
}
