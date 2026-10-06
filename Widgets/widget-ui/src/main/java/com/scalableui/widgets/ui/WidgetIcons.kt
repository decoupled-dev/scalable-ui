package com.scalableui.widgets.ui

import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.PathFillType
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.PathParser
import androidx.compose.ui.unit.dp

/** Header and control glyphs. Same 24dp material shapes the climate and media cards use. */
object WidgetIcons {
    val Battery: ImageVector = icon(
        "Battery",
        "M15.67,4H14V2h-4v2H8.33C7.6,4 7,4.6 7,5.33v15.33C7,21.4 7.6,22 8.33,22h7.33c0.74,0 1.34,-0.6 1.34,-1.33V5.33C17,4.6 16.4,4 15.67,4z",
    )
    val Bolt: ImageVector = icon(
        "Bolt",
        "M7,2v11h3v9l7,-12h-4l4,-8z",
    )
    val Port: ImageVector = icon(
        "Port",
        "M16,9v4.66l-3.5,3.51V19h-1v-1.83L8,13.65V9h8m0,-6h-2v4h-4V3H8v4h-0.01C6.9,6.99 6,7.89 6,8.98v5.52L9.5,18v3h5v-3l3.5,-3.51V9c0,-1.1 -0.9,-2 -2,-2V3z",
    )
    val Cabin: ImageVector = icon(
        "Cabin",
        "M9,21c0,0.55 0.45,1 1,1h4c0.55,0 1,-0.45 1,-1v-1H9v1zM12,2C8.14,2 5,5.14 5,9c0,2.38 1.19,4.47 3,5.74V17c0,0.55 0.45,1 1,1h6c0.55,0 1,-0.45 1,-1v-2.26c1.81,-1.27 3,-3.36 3,-5.74 0,-3.86 -3.14,-7 -7,-7z",
    )
    val Headlight: ImageVector = icon(
        "Headlight",
        "M6,14l3,3v5h6v-5l3,-3V9H6v5zM11,2h2v3h-2zM3.5,5.88l1.41,-1.41 2.12,2.12L5.62,8 3.5,5.88zM16.96,6.59l2.12,-2.12 1.41,1.41L18.38,8l-1.42,-1.41z",
    )
    val HighBeam: ImageVector = icon(
        "HighBeam",
        "M6,2h12v3H6zM6,7v1l2,3v11h8V11l2,-3V7H6zM12,15.5c-0.83,0 -1.5,-0.67 -1.5,-1.5s0.67,-1.5 1.5,-1.5 1.5,0.67 1.5,1.5 -0.67,1.5 -1.5,1.5z",
    )
    val Hazard: ImageVector = icon(
        "Hazard",
        "M1,21h22L12,2 1,21zM11,10h2v4h-2zM11,16h2v2h-2z",
        PathFillType.EvenOdd,
    )
    val Phone: ImageVector = icon(
        "Phone",
        "M6.62,10.79c1.44,2.83 3.76,5.14 6.59,6.59l2.2,-2.2c0.27,-0.27 0.67,-0.36 1.02,-0.24 1.12,0.37 2.33,0.57 3.57,0.57 0.55,0 1,0.45 1,1V20c0,0.55 -0.45,1 -1,1 -9.39,0 -17,-7.61 -17,-17 0,-0.55 0.45,-1 1,-1h3.5c0.55,0 1,0.45 1,1 0,1.25 0.2,2.45 0.57,3.57 0.11,0.35 0.03,0.74 -0.25,1.02l-2.2,2.2z",
    )
    val Seat: ImageVector = icon(
        "Seat",
        "M4,18v3h3v-3h10v3h3v-6H4v3zM19,10h3v3h-3zM2,10h3v3H2zM17,13H7V5c0,-1.1 0.9,-2 2,-2h6c1.1,0 2,0.9 2,2v8z",
    )
}

private fun icon(
    name: String,
    path: String,
    fillType: PathFillType = PathFillType.NonZero,
): ImageVector = ImageVector.Builder(
    name = name,
    defaultWidth = 24.dp,
    defaultHeight = 24.dp,
    viewportWidth = 24f,
    viewportHeight = 24f,
).apply {
    addPath(
        pathData = PathParser().parsePathString(path).toNodes(),
        pathFillType = fillType,
        fill = SolidColor(Color.Black),
    )
}.build()
