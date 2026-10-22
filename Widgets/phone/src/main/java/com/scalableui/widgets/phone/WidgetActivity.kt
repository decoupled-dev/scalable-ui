package com.scalableui.widgets.phone

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.CallLog
import androidx.activity.ComponentActivity
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import com.scalableui.widgets.ui.CallLine
import com.scalableui.widgets.ui.Muted
import com.scalableui.widgets.ui.WidgetIcons
import com.scalableui.widgets.ui.WidgetPalettes
import com.scalableui.widgets.ui.WidgetScreen
import java.text.DateFormat
import java.util.Date

open class WidgetActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { PhoneScreen() }
    }
}

class MainActivity : WidgetActivity()

private data class CallRow(val title: String, val whenText: String)

@Composable
private fun PhoneScreen() {
    val context = LocalContext.current
    var rows by remember { mutableStateOf<List<CallRow>>(emptyList()) }
    val request = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) {
        rows = loadCalls(context)
    }
    LaunchedEffect(Unit) {
        val granted = context.checkSelfPermission(Manifest.permission.READ_CALL_LOG) ==
            PackageManager.PERMISSION_GRANTED
        if (granted) rows = loadCalls(context) else request.launch(Manifest.permission.READ_CALL_LOG)
    }
    WidgetScreen("Phone", WidgetPalettes.Phone, WidgetIcons.Phone) {
        if (rows.isEmpty()) {
            Box(
                Modifier
                    .weight(1f)
                    .fillMaxWidth(),
                contentAlignment = Alignment.Center,
            ) {
                Muted("No recent calls")
            }
        } else {
            Column(
                Modifier.weight(1f),
                verticalArrangement = Arrangement.SpaceEvenly,
            ) {
                rows.take(3).forEach { row ->
                    CallLine(row.title, row.whenText)
                }
            }
        }
    }
}

private fun loadCalls(context: android.content.Context): List<CallRow> {
    if (context.checkSelfPermission(Manifest.permission.READ_CALL_LOG) != PackageManager.PERMISSION_GRANTED) {
        return emptyList()
    }
    val rows = mutableListOf<CallRow>()
    try {
        context.contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            arrayOf(CallLog.Calls.CACHED_NAME, CallLog.Calls.NUMBER, CallLog.Calls.DATE),
            null,
            null,
            "${CallLog.Calls.DATE} DESC",
        )?.use { cursor ->
            val name = cursor.getColumnIndex(CallLog.Calls.CACHED_NAME)
            val number = cursor.getColumnIndex(CallLog.Calls.NUMBER)
            val date = cursor.getColumnIndex(CallLog.Calls.DATE)
            while (cursor.moveToNext() && rows.size < 8) {
                val label = cursor.getString(name)?.takeIf { it.isNotBlank() }
                    ?: cursor.getString(number)
                    ?: "Unknown"
                val whenText = DateFormat.getTimeInstance(DateFormat.SHORT).format(Date(cursor.getLong(date)))
                rows += CallRow(label, whenText)
            }
        }
    } catch (_: SecurityException) {
        return emptyList()
    }
    return rows
}
