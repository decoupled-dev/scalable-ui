.class public final Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;
.super Ljava/lang/Object;
.source "PanelOutsideHost.java"


# static fields
.field private static final TYPE_SYSTEM_DIALOG:I = 0x7d8

.field private static sHost:Landroid/view/View;


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static ensureHost(Landroid/content/Context;)Landroid/view/View;
    .registers 9

    .line 70
    sget-object v0, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->sHost:Landroid/view/View;

    if-eqz v0, :cond_f

    sget-object v0, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->sHost:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isAttachedToWindow()Z

    move-result v0

    if-eqz v0, :cond_f

    .line 71
    sget-object p0, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->sHost:Landroid/view/View;

    return-object p0

    .line 73
    :cond_f
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 74
    if-nez v0, :cond_16

    .line 75
    goto :goto_17

    .line 74
    :cond_16
    move-object p0, v0

    .line 77
    :goto_17
    const-class v0, Landroid/hardware/display/DisplayManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/display/DisplayManager;

    .line 78
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object v0

    .line 79
    const/16 v1, 0x7d8

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Landroid/content/Context;->createWindowContext(Landroid/view/Display;ILandroid/os/Bundle;)Landroid/content/Context;

    move-result-object p0

    .line 80
    const-class v0, Landroid/view/WindowManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 81
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 82
    new-instance v2, Landroid/view/WindowManager$LayoutParams;

    const/16 v6, 0x138

    const/4 v7, -0x3

    const/4 v3, -0x1

    const/4 v4, -0x1

    const/16 v5, 0x7d8

    invoke-direct/range {v2 .. v7}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    .line 91
    const/16 p0, 0x33

    iput p0, v2, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 92
    const-string p0, "scalable-panel-host"

    invoke-virtual {v2, p0}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    .line 96
    invoke-static {v2}, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->markTrustedOverlay(Landroid/view/WindowManager$LayoutParams;)V

    .line 97
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 98
    sput-object v1, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->sHost:Landroid/view/View;

    .line 99
    return-object v1
.end method

.method private static markTrustedOverlay(Landroid/view/WindowManager$LayoutParams;)V
    .registers 5

    .line 105
    const-string v0, "setTrustedOverlay"

    :try_start_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v1, v0, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_12
    .catchall {:try_start_2 .. :try_end_12} :catchall_13

    .line 108
    goto :goto_19

    .line 106
    :catchall_13
    move-exception p0

    .line 107
    const-string v1, "CarSysuiHeaderCtrl"

    invoke-static {v1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 109
    :goto_19
    return-void
.end method

.method public static show(Landroid/widget/PopupWindow;Landroid/view/View;III)V
    .registers 13

    .line 26
    if-eqz p0, :cond_f4

    if-nez p1, :cond_6

    goto/16 :goto_f4

    .line 29
    :cond_6
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/systembar/panel/PanelOutsideHost;->ensureHost(Landroid/content/Context;)Landroid/view/View;

    move-result-object v0

    .line 30
    const/4 v1, 0x2

    new-array v2, v1, [I

    .line 31
    invoke-virtual {p1, v2}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 32
    invoke-virtual {p0}, Landroid/widget/PopupWindow;->getWidth()I

    move-result v3

    .line 33
    if-gtz v3, :cond_1e

    .line 34
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v3

    .line 36
    :cond_1e
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v4

    const-class v5, Landroid/hardware/display/DisplayManager;

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/display/DisplayManager;

    .line 37
    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object v4

    .line 38
    new-instance v6, Landroid/graphics/Point;

    invoke-direct {v6}, Landroid/graphics/Point;-><init>()V

    .line 39
    invoke-virtual {v4, v6}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 41
    invoke-virtual {p1}, Landroid/view/View;->getLayoutDirection()I

    move-result v4

    invoke-static {p4, v4}, Landroid/view/Gravity;->getAbsoluteGravity(II)I

    move-result p4

    .line 42
    aget v4, v2, v5

    add-int/2addr v4, p2

    .line 43
    and-int/lit8 p4, p4, 0x7

    const/4 v7, 0x5

    if-ne p4, v7, :cond_51

    .line 44
    aget p4, v2, v5

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v4

    add-int/2addr p4, v4

    sub-int/2addr p4, v3

    add-int v4, p4, p2

    .line 46
    :cond_51
    const/4 p2, 0x1

    aget p4, v2, p2

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v7

    add-int/2addr p4, v7

    add-int/2addr p4, p3

    .line 47
    invoke-virtual {p1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object p3

    invoke-virtual {p3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p3

    iget p3, p3, Landroid/util/DisplayMetrics;->density:F

    const/high16 v7, 0x41800000    # 16.0f

    mul-float/2addr p3, v7

    invoke-static {p3}, Ljava/lang/Math;->round(F)I

    move-result p3

    .line 48
    # Left-pill anchors open on the left edge, right-pill anchors on the right edge.
    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v7

    div-int/2addr v7, v1

    aget p1, v2, v5

    add-int/2addr p1, v7

    iget v7, v6, Landroid/graphics/Point;->x:I

    div-int/2addr v7, v1

    if-ge p1, v7, :cond_right

    move v4, p3

    goto :goto_side

    :cond_right
    iget p1, v6, Landroid/graphics/Point;->x:I

    sub-int/2addr p1, v3

    sub-int/2addr p1, p3

    invoke-static {v5, p1}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 57
    :goto_side
    if-gez p4, :cond_9d

    .line 58
    move p4, v5

    .line 60
    :cond_9d
    invoke-virtual {p0, v5}, Landroid/widget/PopupWindow;->setClippingEnabled(Z)V

    .line 63
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "privacy panel at "

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p3, ","

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " size "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " screen "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v1, v6, Landroid/graphics/Point;->x:I

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " anchor "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    aget v1, v2, v5

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    aget p2, v2, p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "CarSysuiHeaderCtrl"

    invoke-static {p2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 66
    const/16 p1, 0x33

    invoke-virtual {p0, v0, p1, v4, p4}, Landroid/widget/PopupWindow;->showAtLocation(Landroid/view/View;III)V

    .line 67
    return-void

    .line 27
    :cond_f4
    :goto_f4
    return-void
.end method
