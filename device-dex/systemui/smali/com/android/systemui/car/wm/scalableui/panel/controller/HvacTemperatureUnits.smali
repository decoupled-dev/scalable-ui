.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits;
.super Ljava/lang/Object;
.source "HvacTemperatureUnits.java"


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static format(FZ[F)Ljava/lang/String;
    .registers 9

    if-eqz p1, :cond_celsius

    if-eqz p2, :cond_formula

    array-length v0, p2

    const/4 v1, 0x4

    if-lt v0, v1, :cond_formula

    const/4 v0, 0x1

    aget v0, p2, v0

    const/4 v1, 0x0

    int-to-float v1, v1

    cmpl-float v1, v0, v1

    if-lez v1, :cond_formula

    const/4 v1, 0x0

    aget v1, p2, v1

    sub-float v1, p0, v1

    div-float/2addr v1, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    const/4 v1, 0x3

    aget v1, p2, v1

    mul-float/2addr v0, v1

    const/4 v1, 0x2

    aget v1, p2, v1

    add-float/2addr v0, v1

    goto :goto_fmt_f

    :cond_formula
    const/high16 v0, 0x41100000    # 9.0f

    mul-float/2addr v0, p0

    const/high16 v1, 0x40a00000    # 5.0f

    div-float/2addr v0, v1

    const/high16 v1, 0x42000000    # 32.0f

    add-float/2addr v0, v1

    :goto_fmt_f
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    const-string v2, "%.0f\u00b0"

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v2, v0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_celsius
    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->rint(D)D

    move-result-wide v2

    sub-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(D)D

    move-result-wide v0

    const-wide v2, 0x3fa99999a0000000L    # 0.05

    cmpg-double v0, v0, v2

    if-gez v0, :cond_decimal

    const-string v0, "%.0f\u00b0"

    goto :goto_fmt

    :cond_decimal
    const-string v0, "%.1f\u00b0"

    :goto_fmt
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v0, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static isFahrenheit(Ljava/lang/Integer;)Z
    .registers 3

    if-nez p0, :cond_value

    const/4 v0, 0x0

    return v0

    :cond_value
    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0x31

    if-ne v0, v1, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

.method public static nextSetpointCelsius(FIZ[F)F
    .registers 7

    const/high16 v0, 0x3f000000    # 0.5f

    if-eqz p3, :cond_step

    array-length v1, p3

    const/4 v2, 0x2

    if-lt v1, v2, :cond_step

    const/4 v1, 0x1

    aget v1, p3, v1

    const/4 v2, 0x0

    int-to-float v2, v2

    cmpl-float v2, v1, v2

    if-lez v2, :cond_step

    move v0, v1

    :cond_step
    div-float v1, p0, v0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v1, v0

    int-to-float v2, p1

    mul-float/2addr v0, v2

    add-float/2addr v1, v0

    return v1
.end method
