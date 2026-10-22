package com.scalableui.widgets.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.drawBehind
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.semantics.role
import androidx.compose.ui.semantics.selected
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.em
import androidx.compose.ui.unit.sp
import androidx.compose.ui.geometry.Offset

/**
 * Dark diagonal washes matching the climate, media, and vehicle cards.
 * The panel clips the window, so the fill is full-bleed.
 */
data class WidgetPalette(
    val accent: Color,
    val gradientTop: Color,
    val gradientBottom: Color,
)

object WidgetPalettes {
    val Ev = WidgetPalette(Color(0xFF8EE6C5), Color(0xFF22303C), Color(0xFF141C24))
    val Lights = WidgetPalette(Color(0xFFE8B86D), Color(0xFF483428), Color(0xFF2A1E18))
    val Phone = WidgetPalette(Color(0xFF7DCEA0), Color(0xFF1E3A2C), Color(0xFF12241C))
    val Seats = WidgetPalette(Color(0xFF7EC8FF), Color(0xFF1E3348), Color(0xFF142230))
}

private val On = Color.White
private val MutedColor = Color(0xB3FFFFFF)
private val Hairline = Color(0x33FFFFFF)
private val TileFill = Color(0x14FFFFFF)
private val LocalPalette = staticCompositionLocalOf { WidgetPalettes.Ev }

private val TileShape = RoundedCornerShape(22.dp)

@Composable
fun widgetAccent(): Color = LocalPalette.current.accent

@Composable
fun WidgetScreen(
    title: String,
    palette: WidgetPalette,
    icon: ImageVector,
    modifier: Modifier = Modifier,
    content: @Composable ColumnScope.() -> Unit,
) {
    CompositionLocalProvider(LocalPalette provides palette) {
        Column(
            modifier
                .fillMaxSize()
                .cardGradient(palette)
                .padding(start = 18.dp, end = 18.dp, top = 16.dp, bottom = 16.dp),
        ) {
            WidgetHeader(title, icon)
            Spacer(Modifier.height(8.dp))
            content()
        }
    }
}

@Composable
private fun WidgetHeader(title: String, icon: ImageVector) {
    val accent = LocalPalette.current.accent
    Row(verticalAlignment = Alignment.CenterVertically) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = accent,
            modifier = Modifier.size(26.dp),
        )
        Text(
            text = title.uppercase(),
            color = accent,
            fontSize = 16.sp,
            fontWeight = FontWeight.Bold,
            letterSpacing = 0.08.em,
            modifier = Modifier.padding(start = 10.dp),
        )
    }
}

@Composable
fun StatPair(
    leftValue: String,
    leftCaption: String,
    rightValue: String,
    rightCaption: String,
    modifier: Modifier = Modifier,
) {
    Row(
        modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        GlanceStat(leftValue, leftCaption, Modifier.weight(1f))
        Box(
            Modifier
                .width(1.dp)
                .height(52.dp)
                .background(Hairline),
        )
        GlanceStat(rightValue, rightCaption, Modifier.weight(1f))
    }
}

@Composable
fun GlanceStat(value: String, caption: String, modifier: Modifier = Modifier) {
    Column(
        modifier,
        horizontalAlignment = Alignment.CenterHorizontally,
    ) {
        Text(
            text = value,
            color = On,
            fontSize = 48.sp,
            fontWeight = FontWeight.Bold,
            lineHeight = 52.sp,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
        )
        Text(
            text = caption,
            color = MutedColor,
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.padding(top = 4.dp),
        )
    }
}

@Composable
fun StatusPill(text: String, modifier: Modifier = Modifier) {
    Text(
        text = text,
        color = LocalPalette.current.accent,
        fontSize = 16.sp,
        fontWeight = FontWeight.Bold,
        textAlign = TextAlign.Center,
        maxLines = 1,
        overflow = TextOverflow.Ellipsis,
        modifier = modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(16.dp))
            .background(Color(0x28FFFFFF))
            .padding(horizontal = 14.dp, vertical = 10.dp),
    )
}

@Composable
fun IconTile(
    icon: ImageVector,
    label: String,
    selected: Boolean,
    modifier: Modifier = Modifier,
    selectedTint: Color? = null,
    onClick: () -> Unit,
) {
    val tint = if (selected) selectedTint ?: LocalPalette.current.accent else On
    val fill = if (selected) tint.copy(alpha = 0.22f) else TileFill
    val stroke = if (selected) tint.copy(alpha = 0.55f) else Color(0x28FFFFFF)
    Column(
        modifier
            .clip(TileShape)
            .background(fill)
            .border(1.dp, stroke, TileShape)
            .clickable(role = Role.Switch, onClick = onClick)
            .semantics {
                role = Role.Switch
                this.selected = selected
            }
            .padding(horizontal = 10.dp, vertical = 12.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = tint,
            modifier = Modifier.size(42.dp),
        )
        Text(
            text = label,
            color = tint,
            fontSize = 18.sp,
            fontWeight = FontWeight.SemiBold,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.padding(top = 8.dp),
        )
    }
}

@Composable
fun CallLine(name: String, whenText: String) {
    Row(
        Modifier
            .fillMaxWidth()
            .height(56.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(
            Modifier
                .size(44.dp)
                .clip(CircleShape)
                .background(Color(0x24FFFFFF)),
            contentAlignment = Alignment.Center,
        ) {
            Icon(
                imageVector = WidgetIcons.Phone,
                contentDescription = null,
                tint = LocalPalette.current.accent,
                modifier = Modifier.size(24.dp),
            )
        }
        Text(
            text = name,
            color = On,
            fontSize = 20.sp,
            fontWeight = FontWeight.SemiBold,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier
                .weight(1f)
                .padding(horizontal = 14.dp),
        )
        Text(
            text = whenText,
            color = MutedColor,
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
        )
    }
}

@Composable
fun Muted(text: String, modifier: Modifier = Modifier) {
    Text(
        text = text,
        modifier = modifier,
        color = MutedColor,
        fontSize = 18.sp,
        fontWeight = FontWeight.Medium,
        textAlign = TextAlign.Center,
    )
}

private fun Modifier.cardGradient(palette: WidgetPalette): Modifier = drawBehind {
    drawRect(
        brush = Brush.linearGradient(
            colors = listOf(palette.gradientTop, palette.gradientBottom),
            start = Offset(size.width, size.height),
            end = Offset.Zero,
        ),
    )
}
