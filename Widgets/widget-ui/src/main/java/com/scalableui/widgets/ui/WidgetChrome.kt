package com.scalableui.widgets.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.lerp
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.foundation.shape.RoundedCornerShape

/** Same surfaces as the design demo home cards. */
data class WidgetColors(
    val light: Boolean,
    val title: Color,
    val label: Color,
    val card: Color,
    val control: Color,
    val track: Color,
    val accent: Color,
)

private val Dark = WidgetColors(
    light = false,
    title = Color.White,
    label = Color(0xFFB7BCC4),
    card = Color(0xFF10141C),
    control = Color.White.copy(alpha = 0.08f),
    track = Color.White.copy(alpha = 0.14f),
    accent = Color(0xFF7EB6FF),
)

private val Light = WidgetColors(
    light = true,
    title = Color(0xFF1A1C1E),
    label = Color(0xFF3E4752),
    card = Color.White,
    control = Color(0xFFF1F3F6),
    track = Color(0xFFE3E6EB),
    accent = Color(0xFF1565C0),
)

private val LocalWidgetColors = staticCompositionLocalOf { Dark }

@Composable
fun widgetColors(): WidgetColors = if (isSystemInDarkTheme()) Dark else Light

@Composable
fun WidgetScreen(
    title: String,
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit,
) {
    val colors = widgetColors()
    CompositionLocalProvider(LocalWidgetColors provides colors) {
        Column(
            modifier
                .fillMaxSize()
                .background(colors.card)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = 20.dp, vertical = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            Text(
                text = title,
                color = colors.title,
                fontSize = 22.sp,
                fontWeight = FontWeight.SemiBold,
            )
            content()
        }
    }
}

@Composable
fun HeroStat(value: String, caption: String) {
    val colors = LocalWidgetColors.current
    Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
        Text(value, color = colors.title, fontSize = 40.sp, fontWeight = FontWeight.SemiBold)
        Text(caption, color = colors.label, fontSize = 14.sp, fontWeight = FontWeight.Medium)
    }
}

@Composable
fun Muted(text: String) {
    Text(text, color = LocalWidgetColors.current.label, fontSize = 14.sp, fontWeight = FontWeight.Medium)
}

@Composable
fun Body(text: String) {
    Text(text, color = LocalWidgetColors.current.title, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
}

@Composable
fun ChipRow(content: @Composable () -> Unit) {
    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        content()
    }
}

@Composable
fun SoftChip(
    text: String,
    selected: Boolean,
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
) {
    val colors = LocalWidgetColors.current
    val tint = colors.accent
    val label = if (selected && colors.light) lerp(tint, colors.title, 0.45f) else tint
    Text(
        text = text,
        color = if (selected) label else colors.title,
        fontSize = 16.sp,
        fontWeight = FontWeight.SemiBold,
        modifier = modifier
            .clip(RoundedCornerShape(10.dp))
            .background(if (selected) tint.copy(alpha = if (colors.light) 0.22f else 0.18f) else colors.control)
            .clickable(onClick = onClick)
            .padding(horizontal = 12.dp, vertical = 6.dp),
    )
}

@Composable
fun sliderColors(): WidgetColors = LocalWidgetColors.current
