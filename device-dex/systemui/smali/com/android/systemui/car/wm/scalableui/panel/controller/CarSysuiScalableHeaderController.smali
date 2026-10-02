.class public Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;
.super Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;
.source "CarSysuiScalableHeaderController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$Factory;
    }
.end annotation


# static fields
.field private static final AREA_DRIVER:I = 0x1

.field private static final AREA_PASSENGER:I = 0x4

.field private static final DEFAULT_RRO_PACKAGE:Ljava/lang/String; = "com.android.systemui.rro.scalableUI.sysuiBars"

.field private static final DESIGN_ACTION_OPEN_CLIMATE:Ljava/lang/String; = "com.test.design.action.OPEN_CLIMATE"

.field private static final DESIGN_ACTION_OPEN_VEHICLE:Ljava/lang/String; = "com.test.design.action.OPEN_VEHICLE"

.field private static final DESIGN_CLIMATE_COMPONENT:Ljava/lang/String; = "com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity"

.field private static final DESIGN_PACKAGE:Ljava/lang/String; = "com.test.design"

.field private static final DESIGN_VEHICLE_COMPONENT:Ljava/lang/String; = "com.test.design/.presentation.ivi.glanceables.VehiclePanelActivity"

.field private static final FAN_SPEED_MAX:I = 0x7

.field private static final FAN_SPEED_MIN:I = 0x1

.field private static final HVAC_STEP_CELSIUS:F = 0.5f

.field private static final SEAT_TEMP_MAX:I = 0x3

.field private static final SEAT_TEMP_MIN:I = 0x0

.field private static final SEAT_TEMP_STEP:I = 0x1

.field private static final TAG:Ljava/lang/String; = "CarSysuiHeaderCtrl"


# instance fields
.field private mDriverHvacDown:Landroid/widget/ImageButton;

.field private mDriverHvacTemp:F

.field private mFahrenheit:Z

.field private mTempScale:[F

.field private mDriverHvacTempText:Landroid/widget/TextView;

.field private mDriverHvacUp:Landroid/widget/ImageButton;

.field private mDriverSeatDown:Landroid/widget/ImageButton;

.field private mDriverSeatTemp:I

.field private mDriverSeatTempText:Landroid/widget/TextView;

.field private mDriverSeatUp:Landroid/widget/ImageButton;

.field private mDriverZoneRoot:Landroid/view/View;

.field private mFanDirection:I

.field private mFanSpeed:I

.field private mFanSpeedBtn:Landroid/view/View;

.field private mHeaderUxScrim:Landroid/view/View;

.field private mHeaderVhalScrim:Landroid/view/View;

.field private final mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

.field private final mMainThreadHosts:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private mPassengerHvacDown:Landroid/widget/ImageButton;

.field private mPassengerHvacTemp:F

.field private mPassengerHvacTempText:Landroid/widget/TextView;

.field private mPassengerHvacUp:Landroid/widget/ImageButton;

.field private mPassengerSeatDown:Landroid/widget/ImageButton;

.field private mPassengerSeatTemp:I

.field private mPassengerSeatTempText:Landroid/widget/TextView;

.field private mPassengerSeatUp:Landroid/widget/ImageButton;

.field private mPassengerZoneRoot:Landroid/view/View;

.field private mVentDefrost:Landroid/view/View;

.field private mVentFace:Landroid/view/View;

.field private mVentFeet:Landroid/view/View;


# direct methods
.method public static synthetic $r8$lambda$elPHehyolNHJwuFCoQ1ZwJJwYCI(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V
    .registers 1

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->removeMainThreadHosts()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .registers 4

    .line 147
    const-string v0, "sysui_scalable_header_panel"

    const-string v1, "com.android.systemui.rro.scalableUI.sysuiBars"

    invoke-direct {p0, p1, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 148
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    .line 151
    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    const/high16 p1, 0x41b00000    # 22.0f

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 71
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 72
    const/4 p1, 0x2

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 73
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 98
    const/4 p1, 0x1

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanDirection:I

    .line 99
    const/4 p1, 0x3

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    .line 106
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mMainThreadHosts:Ljava/util/ArrayList;

    .line 109
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;

    invoke-direct {p1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    .line 152
    return-void
.end method

.method static synthetic access$002(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;I)I
    .registers 2

    .line 57
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    return p1
.end method

.method static synthetic access$100(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V
    .registers 1

    .line 57
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshFanSpeedUi()V

    return-void
.end method

.method static synthetic access$200(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;I)V
    .registers 2

    .line 57
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateFanDirectionUi(I)V

    return-void
.end method

.method static synthetic access$300(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;II)V
    .registers 3

    .line 57
    invoke-direct {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    return-void
.end method

.method static synthetic access$400(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;IF)V
    .registers 3

    .line 57
    invoke-direct {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    return-void
.end method

.method private addHostView(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)Z
    .registers 5

    .line 486
    :try_start_0
    invoke-interface {p1, p2, p3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_5

    .line 487
    const/4 p1, 0x1

    return p1

    .line 488
    :catchall_5
    move-exception p1

    .line 489
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "window type "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget p3, p3, Landroid/view/WindowManager$LayoutParams;->type:I

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " failed"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string p3, "CarSysuiHeaderCtrl"

    invoke-static {p3, p2, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 490
    const/4 p1, 0x0

    return p1
.end method

.method private adjustHvac(IF)V
    .registers 8

    .line 1171
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_4e

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_4e

    .line 1174
    :cond_9
    const/4 v0, 0x1

    if-ne p1, v0, :cond_f

    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    goto :goto_11

    :cond_f
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 1175
    :goto_11
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v2, 0x15600503

    invoke-virtual {v1, v2, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v1

    .line 1177
    if-eqz v1, :cond_20

    .line 1178
    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v0

    .line 1180
    :cond_20
    const/4 v1, 0x0

    int-to-float v1, v1

    cmpl-float v1, p2, v1

    iget-boolean v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFahrenheit:Z

    iget-object v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mTempScale:[F

    invoke-static {v0, v1, v3, v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits;->nextSetpointCelsius(FIZ[F)F

    move-result p2

    invoke-direct {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->clampHvac(IF)F

    move-result p2

    .line 1183
    sub-float v1, p2, v0

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    const v3, 0x3c23d70a    # 0.01f

    cmpg-float v1, v1, v3

    if-gez v1, :cond_36

    .line 1184
    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 1185
    return-void

    .line 1187
    :cond_36
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    invoke-virtual {v0, v2, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setFloatProperty(IIF)Z

    move-result v0

    if-eqz v0, :cond_4d

    .line 1188
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    invoke-virtual {v0, v2, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v0

    .line 1190
    if-eqz v0, :cond_4a

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result p2

    :cond_4a
    invoke-direct {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 1192
    :cond_4d
    return-void

    .line 1172
    :cond_4e
    :goto_4e
    return-void
.end method

.method private adjustSeat(II)V
    .registers 5

    .line 1203
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_2b

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_2b

    .line 1206
    :cond_9
    const/4 v0, 0x1

    if-ne p1, v0, :cond_f

    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    goto :goto_11

    :cond_f
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 1207
    :goto_11
    const/4 v1, 0x3

    add-int/2addr v0, p2

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    const/4 v0, 0x0

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 1208
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    invoke-virtual {v0, v1, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setIntProperty(III)Z

    move-result v0

    if-eqz v0, :cond_2a

    .line 1209
    invoke-direct {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    .line 1211
    :cond_2a
    return-void

    .line 1204
    :cond_2b
    :goto_2b
    return-void
.end method

.method private static assignUniqueIds(Landroid/view/View;)V
    .registers 3

    .line 507
    invoke-static {}, Landroid/view/View;->generateViewId()I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setId(I)V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PrivacyChip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_18

    return-void

    .line 508
    :cond_18
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_2f

    .line 509
    check-cast p0, Landroid/view/ViewGroup;

    .line 510
    const/4 v0, 0x0

    :goto_1f
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_2f

    .line 511
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->assignUniqueIds(Landroid/view/View;)V

    .line 510
    add-int/lit8 v0, v0, 0x1

    goto :goto_1f

    .line 514
    :cond_2f
    return-void
.end method

.method private bindChromeScrim(Landroid/view/View;)V
    .registers 4

    .line 945
    const-string v0, "sysui_header_ux_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 946
    const/4 v1, 0x0

    if-eqz v0, :cond_e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderUxScrim:Landroid/view/View;

    .line 947
    const-string v0, "sysui_header_vhal_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 948
    if-eqz v0, :cond_1d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    :cond_1d
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    .line 949
    return-void
.end method

.method private bindClimateExtras(Landroid/view/View;)V
    .registers 4

    .line 904
    const-string v0, "oem_vent_defrost"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentDefrost:Landroid/view/View;

    .line 905
    const-string v0, "oem_vent_face"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFace:Landroid/view/View;

    .line 906
    const-string v0, "oem_vent_feet"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFeet:Landroid/view/View;

    .line 907
    const-string v0, "oem_fan_speed"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v1

    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    .line 908
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    if-nez v1, :cond_32

    .line 909
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 910
    if-eqz v0, :cond_2f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    goto :goto_30

    :cond_2f
    const/4 p1, 0x0

    :goto_30
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    .line 912
    :cond_32
    return-void
.end method

.method private bindDriverZone(Landroid/view/View;)V
    .registers 4

    .line 915
    const-string v0, "sysui_driver_zone_root"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 916
    const/4 v1, 0x0

    if-eqz v0, :cond_e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    .line 918
    const-string v0, "sysui_driver_hvac_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 919
    if-eqz v0, :cond_20

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_21

    :cond_20
    move-object v0, v1

    :goto_21
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    .line 920
    const-string v0, "sysui_driver_hvac_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    .line 921
    const-string v0, "sysui_driver_hvac_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    .line 923
    const-string v0, "sysui_driver_seat_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 924
    if-eqz v0, :cond_42

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroid/widget/TextView;

    :cond_42
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTempText:Landroid/widget/TextView;

    .line 925
    const-string v0, "sysui_driver_seat_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    .line 926
    const-string v0, "sysui_driver_seat_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    .line 927
    return-void
.end method

.method private bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V
    .registers 15

    .line 321
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v3

    .line 322
    const/4 v4, 0x0

    if-nez v3, :cond_9

    move-object v3, v4

    goto :goto_d

    :cond_9
    invoke-virtual {p1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    .line 323
    :goto_d
    if-nez p4, :cond_11

    move-object v2, v4

    goto :goto_15

    :cond_11
    invoke-direct {p0, p4, p5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->detachPanelButton(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2

    .line 324
    :goto_15
    instance-of v5, v3, Landroid/view/ViewGroup;

    if-eqz v5, :cond_b0

    if-nez v2, :cond_1d

    goto/16 :goto_b0

    .line 328
    :cond_1d
    invoke-virtual {v3}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v5, "main-hosted"

    invoke-virtual {v5, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2e

    .line 329
    return-void

    .line 331
    :cond_2e
    invoke-virtual {v3, v5}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 332
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    instance-of v1, v1, Landroid/view/ViewGroup;

    if-eqz v1, :cond_42

    .line 333
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 335
    :cond_42
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v1, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 337
    const/4 v1, 0x0

    invoke-virtual {v2, v1}, Landroid/view/View;->setMinimumWidth(I)V

    .line 338
    invoke-virtual {v2, v1}, Landroid/view/View;->setMinimumHeight(I)V

    .line 339
    invoke-virtual {v2, v4}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 340
    const/4 v1, 0x1

    invoke-virtual {v2, v1}, Landroid/view/View;->setClickable(Z)V

    .line 341
    move-object v1, v3

    new-instance v3, Landroid/widget/FrameLayout;

    iget-object v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-direct {v3, v4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 342
    invoke-virtual {v3, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 343
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda24;

    move-object v4, p3

    move-object v5, p6

    move-object v2, v1

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda24;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;Landroid/widget/FrameLayout;Ljava/lang/String;Ljava/lang/String;)V

    .line 346
    move-object v1, v2

    move-object v2, v3

    invoke-virtual {v1, v0}, Landroid/view/View;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 347
    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v0

    if-lez v0, :cond_8d

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v0

    if-lez v0, :cond_8d

    .line 348
    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v3

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v4

    const/4 v7, 0x1

    move-object v0, p0

    move-object v5, p3

    move-object v6, p6

    invoke-direct/range {v0 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->placeMainThreadHost(Landroid/view/View;Landroid/view/View;IILjava/lang/String;Ljava/lang/String;Z)V

    .line 351
    :cond_8d
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "main-thread panel "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " -> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CarSysuiHeaderCtrl"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 352
    return-void

    .line 325
    :cond_b0
    :goto_b0
    move-object v5, p6

    invoke-direct {p0, p1, p3, p6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireSettingsButton(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    .line 326
    return-void
.end method

.method private bindPassengerZone(Landroid/view/View;)V
    .registers 4

    .line 930
    const-string v0, "sysui_passenger_zone_root"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 931
    const/4 v1, 0x0

    if-eqz v0, :cond_e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerZoneRoot:Landroid/view/View;

    .line 933
    const-string v0, "sysui_passenger_hvac_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 934
    if-eqz v0, :cond_20

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_21

    :cond_20
    move-object v0, v1

    :goto_21
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTempText:Landroid/widget/TextView;

    .line 935
    const-string v0, "sysui_passenger_hvac_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    .line 936
    const-string v0, "sysui_passenger_hvac_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    .line 938
    const-string v0, "sysui_passenger_seat_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 939
    if-eqz v0, :cond_42

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroid/widget/TextView;

    :cond_42
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTempText:Landroid/widget/TextView;

    .line 940
    const-string v0, "sysui_passenger_seat_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    .line 941
    const-string v0, "sysui_passenger_seat_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    .line 942
    return-void
.end method

.method private bindStockPanelOrSettings(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Z)V
    .registers 10

    .line 300
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 301
    const/4 v1, 0x0

    if-nez v0, :cond_9

    move-object v0, v1

    goto :goto_d

    :cond_9
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 302
    :goto_d
    if-nez p4, :cond_10

    goto :goto_14

    :cond_10
    invoke-direct {p0, p4, p5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->detachPanelButton(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 303
    :goto_14
    instance-of p4, v0, Landroid/view/ViewGroup;

    if-eqz p4, :cond_45

    if-eqz v1, :cond_45

    check-cast v0, Landroid/view/ViewGroup;

    .line 304
    invoke-direct {p0, v0, v1, p3, p7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->installStockPanel(Landroid/view/ViewGroup;Landroid/view/View;Ljava/lang/String;Z)Z

    move-result p4

    if-eqz p4, :cond_45

    .line 305
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "stock panel "

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p3, " -> "

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "CarSysuiHeaderCtrl"

    invoke-static {p2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 306
    return-void

    .line 308
    :cond_45
    if-eqz v1, :cond_58

    invoke-virtual {v1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p2

    instance-of p2, p2, Landroid/view/ViewGroup;

    if-eqz p2, :cond_58

    .line 309
    invoke-virtual {v1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p2

    check-cast p2, Landroid/view/ViewGroup;

    invoke-virtual {p2, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 311
    :cond_58
    invoke-direct {p0, p1, p3, p6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireSettingsButton(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    .line 312
    return-void
.end method

.method private static chipLayoutParams(I)Landroid/widget/LinearLayout$LayoutParams;
    .registers 3

    .line 790
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, p0, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    return-object v0
.end method

.method private clampHvac(IF)F
    .registers 5

    .line 1195
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    invoke-virtual {v0, v1, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatRange(II)[F

    move-result-object p1

    .line 1196
    if-nez p1, :cond_c

    .line 1197
    return p2

    .line 1199
    :cond_c
    const/4 v0, 0x0

    aget v0, p1, v0

    const/4 v1, 0x1

    aget p1, p1, v1

    invoke-static {p1, p2}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-static {v0, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    return p1
.end method

.method private currentUserName()Ljava/lang/String;
    .registers 6

    .line 838
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    const-class v1, Landroid/os/UserManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/UserManager;

    .line 839
    if-eqz v0, :cond_4c

    .line 842
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenCurrentUser()I

    move-result v1

    .line 843
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getUserInfo"

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    .line 844
    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 845
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 846
    if-eqz v0, :cond_4c

    .line 847
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "name"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 848
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_4c

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4c

    .line 849
    check-cast v0, Ljava/lang/String;
    :try_end_4b
    .catchall {:try_start_0 .. :try_end_4b} :catchall_4d

    return-object v0

    .line 855
    :cond_4c
    goto :goto_55

    .line 853
    :catchall_4d
    move-exception v0

    .line 854
    const-string v1, "CarSysuiHeaderCtrl"

    const-string v2, "currentUserName"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 856
    :goto_55
    const-string v0, "Driver"

    return-object v0
.end method

.method private cycleFanSpeed()V
    .registers 5

    .line 1289
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_25

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_25

    .line 1292
    :cond_9
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    const/4 v1, 0x7

    const/4 v2, 0x1

    if-lt v0, v1, :cond_11

    move v0, v2

    goto :goto_14

    :cond_11
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    add-int/2addr v0, v2

    .line 1293
    :goto_14
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v3, 0x15400500

    invoke-virtual {v1, v3, v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setIntProperty(III)Z

    move-result v1

    if-eqz v1, :cond_24

    .line 1295
    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    .line 1296
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshFanSpeedUi()V

    .line 1298
    :cond_24
    return-void

    .line 1290
    :cond_25
    :goto_25
    return-void
.end method

.method private decorPanelBounds()Landroid/graphics/Rect;
    .registers 6

    .line 402
    :try_start_0
    const-string v0, "com.android.car.scalableui.manager.StateManager"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 404
    const-string v1, "getPanelState"

    const-class v2, Ljava/lang/String;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 405
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 406
    if-eqz v0, :cond_5b

    .line 407
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getCurrentVariant"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 408
    if-eqz v0, :cond_5b

    .line 409
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getBounds"

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 410
    instance-of v1, v0, Landroid/graphics/Rect;

    if-eqz v1, :cond_5b

    move-object v1, v0

    check-cast v1, Landroid/graphics/Rect;

    invoke-virtual {v1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_5b

    .line 411
    new-instance v1, Landroid/graphics/Rect;

    check-cast v0, Landroid/graphics/Rect;

    invoke-direct {v1, v0}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V
    :try_end_5a
    .catchall {:try_start_0 .. :try_end_5a} :catchall_5c

    return-object v1

    .line 417
    :cond_5b
    goto :goto_64

    .line 415
    :catchall_5c
    move-exception v0

    .line 416
    const-string v1, "CarSysuiHeaderCtrl"

    const-string v2, "decorPanelBounds"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 418
    :goto_64
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    return-object v0
.end method

.method private detachPanelButton(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;
    .registers 6

    .line 571
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    const-string v2, "com.android.systemui"

    invoke-virtual {v0, p2, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 573
    const/4 v1, 0x0

    const-string v2, "CarSysuiHeaderCtrl"

    if-nez v0, :cond_2a

    .line 574
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "SystemUI panel layout missing: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 575
    return-object v1

    .line 577
    :cond_2a
    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findPanelButton(Landroid/view/View;I)Landroid/view/View;

    move-result-object p1

    .line 578
    if-nez p1, :cond_47

    .line 579
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "panel button missing: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 580
    return-object v1

    .line 582
    :cond_47
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p2

    instance-of p2, p2, Landroid/view/ViewGroup;

    if-eqz p2, :cond_58

    .line 583
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p2

    check-cast p2, Landroid/view/ViewGroup;

    invoke-virtual {p2, p1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 585
    :cond_58
    return-object p1
.end method

.method private dispatchScalableEvent(Ljava/lang/String;)V
    .registers 7

    .line 1089
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 1090
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getWMComponent"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 1091
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getScalableUIEventDispatcher"

    new-array v4, v3, [Ljava/lang/Class;

    .line 1092
    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 1093
    new-instance v1, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v1, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v1

    .line 1094
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "executeEvent"

    const-class v4, Lcom/android/car/scalableui/model/Event;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    .line 1095
    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 1096
    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4b
    .catchall {:try_start_0 .. :try_end_4b} :catchall_4c

    .line 1115
    goto :goto_b6

    .line 1097
    :catchall_4c
    move-exception v0

    .line 1098
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EventDispatcher.executeEvent("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") failed"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CarSysuiHeaderCtrl"

    invoke-static {v2, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1100
    :try_start_6b
    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v0, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    .line 1103
    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    .line 1101
    invoke-static {v0}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    move-result-object v0

    .line 1104
    if-eqz v0, :cond_9e

    .line 1106
    invoke-virtual {v0}, Lcom/android/car/scalableui/model/PanelTransaction;->getAnimators()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_82
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9e

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 1107
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_9d

    .line 1108
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/animation/Animator;

    invoke-virtual {v1}, Landroid/animation/Animator;->start()V
    :try_end_9d
    .catchall {:try_start_6b .. :try_end_9d} :catchall_9f

    .line 1110
    :cond_9d
    goto :goto_82

    .line 1114
    :cond_9e
    goto :goto_b6

    .line 1112
    :catchall_9f
    move-exception v0

    .line 1113
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " fallback failed"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v2, p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1116
    :goto_b6
    return-void
.end method

.method private dp(I)I
    .registers 4

    .line 784
    int-to-float p1, p1

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    .line 786
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 784
    const/4 v1, 0x1

    invoke-static {v1, p1, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p1

    float-to-int p1, p1

    return p1
.end method

.method private ensureMainThreadHost(Landroid/view/View;IIII)Z
    .registers 22

    .line 434
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v0, p2

    move/from16 v3, p3

    const-string v4, "setTrustedOverlay"

    iget-object v5, v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    const-string v6, "window"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/view/WindowManager;

    .line 435
    const/4 v6, 0x0

    if-nez v5, :cond_18

    .line 436
    return v6

    .line 438
    :cond_18
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v7

    const-string v8, "CarSysuiHeaderCtrl"

    const/4 v9, 0x1

    if-eqz v7, :cond_3e

    .line 439
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 440
    iput v0, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 441
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 442
    move/from16 v11, p4

    iput v11, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 443
    move/from16 v12, p5

    iput v12, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 445
    :try_start_33
    invoke-interface {v5, v2, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_36
    .catchall {:try_start_33 .. :try_end_36} :catchall_37

    .line 446
    return v9

    .line 447
    :catchall_37
    move-exception v0

    .line 448
    const-string v1, "update panel host"

    invoke-static {v8, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 449
    return v6

    .line 452
    :cond_3e
    move/from16 v11, p4

    move/from16 v12, p5

    new-instance v10, Landroid/view/WindowManager$LayoutParams;

    const/16 v14, 0x128

    const/4 v15, -0x3

    const/16 v13, 0x7e1

    invoke-direct/range {v10 .. v15}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    .line 459
    const v7, 0x800033

    iput v7, v10, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 460
    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 461
    iput v3, v10, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 462
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 463
    const-string v0, "LauncherQcPanel"

    invoke-virtual {v10, v0}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    .line 467
    :try_start_5e
    invoke-virtual {v10}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    new-array v3, v6, [Ljava/lang/Class;

    invoke-virtual {v0, v4, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v0, v10, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_6d
    .catchall {:try_start_5e .. :try_end_6d} :catchall_6e

    .line 470
    goto :goto_72

    .line 468
    :catchall_6e
    move-exception v0

    .line 469
    invoke-static {v8, v4, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 473
    :goto_72
    invoke-static {v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->assignUniqueIds(Landroid/view/View;)V

    .line 474
    invoke-direct {v1, v5, v2, v10}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->addHostView(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)Z

    move-result v0

    if-nez v0, :cond_86

    .line 475
    const/16 v0, 0x7f6

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 476
    invoke-direct {v1, v5, v2, v10}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->addHostView(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)Z

    move-result v0

    if-nez v0, :cond_86

    .line 477
    return v6

    .line 480
    :cond_86
    iget-object v0, v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mMainThreadHosts:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 481
    return v9
.end method

.method private static fadeStockChrome(Landroid/view/View;)V
    .registers 4

    .line 422
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-nez v0, :cond_5

    .line 423
    return-void

    .line 425
    :cond_5
    check-cast p0, Landroid/view/ViewGroup;

    .line 426
    const/4 v0, 0x0

    :goto_8
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_1d

    .line 427
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 428
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setAlpha(F)V

    .line 429
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 426
    add-int/lit8 v0, v0, 0x1

    goto :goto_8

    .line 431
    :cond_1d
    return-void
.end method

.method private findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;
    .registers 3

    .line 952
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result p2

    .line 953
    if-eqz p2, :cond_d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageButton;

    goto :goto_e

    :cond_d
    const/4 p1, 0x0

    :goto_e
    return-object p1
.end method

.method private findClickable(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;
    .registers 4

    .line 1034
    const/4 v0, 0x0

    if-nez p1, :cond_4

    .line 1035
    return-object v0

    .line 1037
    :cond_4
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result p2

    .line 1038
    if-eqz p2, :cond_e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 1039
    :cond_e
    if-eqz v0, :cond_17

    .line 1040
    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Landroid/view/View;->setClickable(Z)V

    .line 1041
    invoke-virtual {v0, p1}, Landroid/view/View;->setFocusable(Z)V

    .line 1043
    :cond_17
    return-object v0
.end method

.method private findPanelButton(Landroid/view/View;I)Landroid/view/View;
    .registers 6

    .line 589
    const-string v0, "mPanelLayoutRes"

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CarSystemBarPanelButtonView"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2c

    .line 591
    :try_start_12
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 592
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 593
    invoke-virtual {v1, p1}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v0
    :try_end_22
    .catchall {:try_start_12 .. :try_end_22} :catchall_26

    if-ne v0, p2, :cond_25

    .line 594
    return-object p1

    .line 598
    :cond_25
    goto :goto_2c

    .line 596
    :catchall_26
    move-exception v1

    .line 597
    const-string v2, "CarSysuiHeaderCtrl"

    invoke-static {v2, v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 600
    :cond_2c
    :goto_2c
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_47

    .line 601
    check-cast p1, Landroid/view/ViewGroup;

    .line 602
    const/4 v0, 0x0

    :goto_33
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_47

    .line 603
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-direct {p0, v1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findPanelButton(Landroid/view/View;I)Landroid/view/View;

    move-result-object v1

    .line 604
    if-eqz v1, :cond_44

    .line 605
    return-object v1

    .line 602
    :cond_44
    add-int/lit8 v0, v0, 0x1

    goto :goto_33

    .line 609
    :cond_47
    const/4 p1, 0x0

    return-object p1
.end method

.method private static fitPrivacyChip(Landroid/view/View;)V
    .registers 3

    .line 775
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0, v0, v0}, Landroid/view/View;->setPadding(IIII)V

    .line 776
    instance-of v1, p0, Landroid/view/ViewGroup;

    if-eqz v1, :cond_10

    .line 777
    check-cast p0, Landroid/view/ViewGroup;

    .line 778
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->setClipToPadding(Z)V

    .line 779
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    .line 781
    :cond_10
    return-void
.end method

.method private static hiddenCurrentUser()I
    .registers 5

    .line 1366
    const-string v0, "getCurrentUser"

    const/4 v1, 0x0

    :try_start_3
    const-class v2, Landroid/app/ActivityManager;

    new-array v3, v1, [Ljava/lang/Class;

    invoke-virtual {v2, v0, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v3, v1, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_18
    .catchall {:try_start_3 .. :try_end_18} :catchall_19

    return v0

    .line 1367
    :catchall_19
    move-exception v2

    .line 1368
    const-string v3, "CarSysuiHeaderCtrl"

    invoke-static {v3, v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1369
    return v1
.end method

.method private static hiddenSetNightMode(Landroid/app/UiModeManager;Z)V
    .registers 5

    .line 1389
    const-string v0, "setNightModeActivated"

    :try_start_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v1, p0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1b
    .catchall {:try_start_2 .. :try_end_1b} :catchall_1c

    .line 1392
    goto :goto_22

    .line 1390
    :catchall_1c
    move-exception p0

    .line 1391
    const-string p1, "CarSysuiHeaderCtrl"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1393
    :goto_22
    return-void
.end method

.method private static hiddenStartActivity(Landroid/content/Context;Landroid/content/Intent;I)V
    .registers 7

    .line 1382
    const-string v0, "startActivityAsUser"

    :try_start_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-class v2, Landroid/content/Intent;

    const-class v3, Landroid/os/UserHandle;

    filled-new-array {v2, v3}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    invoke-static {p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenUser(I)Landroid/os/UserHandle;

    move-result-object p2

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v1, p0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1d
    .catchall {:try_start_2 .. :try_end_1d} :catchall_1e

    .line 1385
    goto :goto_24

    .line 1383
    :catchall_1e
    move-exception p0

    .line 1384
    const-string p1, "CarSysuiHeaderCtrl"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1386
    :goto_24
    return-void
.end method

.method private static hiddenUser(I)Landroid/os/UserHandle;
    .registers 4

    .line 1374
    :try_start_0
    const-class v0, Landroid/os/UserHandle;

    const-string v1, "of"

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/os/UserHandle;
    :try_end_1d
    .catchall {:try_start_0 .. :try_end_1d} :catchall_1e

    return-object p0

    .line 1375
    :catchall_1e
    move-exception p0

    .line 1376
    const-string v0, "CarSysuiHeaderCtrl"

    const-string v1, "UserHandle.of"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1377
    invoke-static {}, Landroid/os/Process;->myUserHandle()Landroid/os/UserHandle;

    move-result-object p0

    return-object p0
.end method

.method private inflateSystemUiLayout(Ljava/lang/String;)Landroid/view/View;
    .registers 7

    .line 744
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    const-string v2, "com.android.systemui"

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 746
    const-string v1, "CarSysuiHeaderCtrl"

    const/4 v2, 0x0

    if-nez v0, :cond_2a

    .line 747
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SystemUI layout missing: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 748
    return-object v2

    .line 753
    :cond_2a
    :try_start_2a
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v3

    invoke-virtual {v3, v0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1
    :try_end_34
    .catchall {:try_start_2a .. :try_end_34} :catchall_35

    return-object p1

    .line 754
    :catchall_35
    move-exception v0

    .line 755
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "inflate "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 756
    return-object v2
.end method

.method private initializeElements(Landroid/view/ViewGroup;)Z
    .registers 8

    .line 629
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->systemBarElementInitializer()Ljava/lang/Object;

    move-result-object v0

    .line 630
    const/4 v1, 0x0

    const-string v2, "CarSysuiHeaderCtrl"

    if-nez v0, :cond_f

    .line 631
    const-string p1, "system bar element initializer unavailable"

    invoke-static {v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 632
    return v1

    .line 635
    :cond_f
    :try_start_f
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "initializeCarSystemBarElements"

    const-class v5, Landroid/view/ViewGroup;

    filled-new-array {v5}, [Ljava/lang/Class;

    move-result-object v5

    .line 636
    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 637
    invoke-virtual {v3, v0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_26
    .catchall {:try_start_f .. :try_end_26} :catchall_28

    .line 638
    const/4 p1, 0x1

    return p1

    .line 639
    :catchall_28
    move-exception p1

    .line 640
    const-string v0, "initializeCarSystemBarElements failed"

    invoke-static {v2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 641
    return v1
.end method

.method private installStockPanel(Landroid/view/ViewGroup;Landroid/view/View;Ljava/lang/String;Z)Z
    .registers 10

    .line 525
    invoke-virtual {p0, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result p3

    .line 526
    const/4 v0, 0x0

    if-nez p3, :cond_9

    move-object p3, v0

    goto :goto_d

    :cond_9
    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object p3

    .line 527
    :goto_d
    const/4 v1, 0x0

    if-eqz p3, :cond_19

    .line 528
    if-eqz p4, :cond_14

    move v2, v1

    goto :goto_16

    :cond_14
    const/16 v2, 0x8

    :goto_16
    invoke-virtual {p3, v2}, Landroid/view/View;->setVisibility(I)V

    .line 530
    :cond_19
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p2, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 532
    invoke-virtual {p2, v1}, Landroid/view/View;->setMinimumWidth(I)V

    .line 533
    invoke-virtual {p2, v1}, Landroid/view/View;->setMinimumHeight(I)V

    .line 534
    invoke-virtual {p2, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 535
    const/4 v2, 0x1

    invoke-virtual {p2, v2}, Landroid/view/View;->setClickable(Z)V

    .line 538
    invoke-direct {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->stripStatusIconViews(Landroid/view/View;)V

    .line 541
    const/4 v3, 0x0

    if-eqz p4, :cond_37

    move v4, v3

    goto :goto_39

    :cond_37
    const/high16 v4, 0x3f800000    # 1.0f

    :goto_39
    invoke-virtual {p2, v4}, Landroid/view/View;->setAlpha(F)V

    .line 544
    invoke-virtual {p1, p2, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;I)V

    .line 545
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->initializeElements(Landroid/view/ViewGroup;)Z

    move-result v4

    if-eqz v4, :cond_58

    .line 546
    invoke-virtual {p2, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 547
    if-eqz p4, :cond_4d

    .line 548
    invoke-virtual {p2, v3}, Landroid/view/View;->setAlpha(F)V

    .line 550
    :cond_4d
    if-eqz p3, :cond_57

    .line 551
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda21;

    invoke-direct {p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda21;-><init>(Landroid/view/View;)V

    invoke-virtual {p3, p1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 560
    :cond_57
    return v2

    .line 562
    :cond_58
    invoke-virtual {p1, p2}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 563
    if-eqz p3, :cond_60

    .line 564
    invoke-virtual {p3, v1}, Landroid/view/View;->setVisibility(I)V

    .line 566
    :cond_60
    return v1
.end method

.method private isNightMode()Z
    .registers 3

    .line 243
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    .line 244
    and-int/lit8 v0, v0, 0x30

    const/16 v1, 0x20

    if-ne v0, v1, :cond_14

    const/4 v0, 0x1

    goto :goto_15

    :cond_14
    const/4 v0, 0x0

    :goto_15
    return v0
.end method

.method static synthetic lambda$installStockPanel$4(Landroid/view/View;Landroid/view/View;)V
    .registers 4

    .line 553
    const-string p1, "CarSysuiHeaderCtrl"

    :try_start_2
    const-string v0, "forward click to stock panel"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 554
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stock panel click handled="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/View;->performClick()Z

    move-result p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_21
    .catchall {:try_start_2 .. :try_end_21} :catchall_22

    .line 557
    goto :goto_28

    .line 555
    :catchall_22
    move-exception p0

    .line 556
    const-string v0, "stock panel click failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 558
    :goto_28
    return-void
.end method

.method private launchClimatePanel()V
    .registers 5

    .line 1050
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    .line 1051
    return-void

    .line 1053
    :cond_5
    const-string v0, "com.test.design.action.OPEN_CLIMATE"

    const-string v1, "com.test.design/.presentation.ivi.glanceables.ClimatePanelActivity"

    invoke-direct {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->startDesignPanel(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const-string v1, "CarSysuiHeaderCtrl"

    if-eqz v0, :cond_17

    .line 1054
    const-string v0, "launchClimatePanel \u2192 Design ClimatePanelActivity"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1055
    return-void

    .line 1057
    :cond_17
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenCurrentUser()I

    move-result v0

    .line 1058
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "launchClimatePanel \u2192 TOGGLE_HVAC_PANEL user="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1059
    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.android.systemui.car.action.TOGGLE_HVAC_PANEL"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1060
    const-string v3, "com.android.systemui"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 1061
    const/high16 v3, 0x10000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1063
    :try_start_42
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenUser(I)Landroid/os/UserHandle;

    move-result-object v0

    invoke-virtual {v3, v2, v0}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V
    :try_end_4b
    .catch Ljava/lang/Exception; {:try_start_42 .. :try_end_4b} :catch_4c

    .line 1071
    goto :goto_5e

    .line 1064
    :catch_4c
    move-exception v0

    .line 1065
    const-string v3, "sendBroadcastAsUser failed, trying sendBroadcast"

    invoke-static {v1, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1067
    :try_start_52
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
    :try_end_57
    .catch Ljava/lang/Exception; {:try_start_52 .. :try_end_57} :catch_58

    .line 1070
    goto :goto_5e

    .line 1068
    :catch_58
    move-exception v0

    .line 1069
    const-string v2, "TOGGLE_HVAC_PANEL failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1072
    :goto_5e
    return-void
.end method

.method private launchDesignScreen(Ljava/lang/String;)V
    .registers 6

    .line 891
    const-string v0, "CarSysuiHeaderCtrl"

    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .line 892
    new-instance v2, Landroid/content/ComponentName;

    const-string v3, "com.test.design"

    invoke-direct {v2, v3, p1}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 893
    const/high16 v2, 0x14000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 894
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenCurrentUser()I

    move-result v2

    .line 896
    :try_start_1a
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {v3, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenStartActivity(Landroid/content/Context;Landroid/content/Intent;I)V

    .line 897
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "launchDesignScreen "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " user="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3f
    .catchall {:try_start_1a .. :try_end_3f} :catchall_40

    .line 900
    goto :goto_57

    .line 898
    :catchall_40
    move-exception v1

    .line 899
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "launchDesignScreen failed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 901
    :goto_57
    return-void
.end method

.method private launchVehiclePanel()V
    .registers 3

    .line 1076
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    .line 1077
    return-void

    .line 1079
    :cond_5
    const-string v0, "com.test.design.action.OPEN_VEHICLE"

    const-string v1, "com.test.design/.presentation.ivi.glanceables.VehiclePanelActivity"

    invoke-direct {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->startDesignPanel(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const-string v1, "CarSysuiHeaderCtrl"

    if-eqz v0, :cond_17

    .line 1080
    const-string v0, "launchVehiclePanel \u2192 Design VehiclePanelActivity"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1081
    return-void

    .line 1083
    :cond_17
    const-string v0, "launchVehiclePanel: Design package missing"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1084
    const-string v0, "toggle_card_expand_climate"

    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->dispatchScalableEvent(Ljava/lang/String;)V

    .line 1085
    return-void
.end method

.method private openSettings(Ljava/lang/String;)V
    .registers 6

    .line 658
    const-string v0, "CarSysuiHeaderCtrl"

    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 659
    const/high16 v2, 0x14000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 660
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenCurrentUser()I

    move-result v2

    .line 662
    :try_start_10
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {v3, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenStartActivity(Landroid/content/Context;Landroid/content/Intent;I)V

    .line 663
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "openSettings "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " user="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_35
    .catchall {:try_start_10 .. :try_end_35} :catchall_36

    .line 666
    goto :goto_4d

    .line 664
    :catchall_36
    move-exception v1

    .line 665
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "openSettings failed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 667
    :goto_4d
    return-void
.end method

.method private placeMainThreadHost(Landroid/view/View;Landroid/view/View;IILjava/lang/String;Ljava/lang/String;Z)V
    .registers 20

    .line 356
    move/from16 v6, p4

    if-lez p3, :cond_ad

    if-lez v6, :cond_ad

    if-nez p1, :cond_a

    goto/16 :goto_ad

    .line 361
    :cond_a
    const/4 v0, 0x2

    new-array v1, v0, [I

    .line 362
    invoke-virtual {p1, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 363
    new-array v0, v0, [I

    .line 364
    invoke-virtual {p1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object v2

    .line 365
    if-eqz v2, :cond_1b

    .line 366
    invoke-virtual {v2, v0}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 368
    :cond_1b
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->decorPanelBounds()Landroid/graphics/Rect;

    move-result-object v2

    .line 369
    iget v3, v2, Landroid/graphics/Rect;->left:I

    const/4 v4, 0x0

    aget v5, v1, v4

    add-int/2addr v3, v5

    aget v5, v0, v4

    sub-int/2addr v3, v5

    .line 370
    iget v5, v2, Landroid/graphics/Rect;->top:I

    const/4 v7, 0x1

    aget v8, v1, v7

    add-int/2addr v5, v8

    aget v0, v0, v7

    sub-int/2addr v5, v0

    .line 371
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "place "

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, " local="

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    aget v4, v1, v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, ","

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    aget v1, v1, v7

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bounds="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " -> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "CarSysuiHeaderCtrl"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 374
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getMainExecutor()Ljava/util/concurrent/Executor;

    move-result-object v11

    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda18;

    move-object v1, p0

    move-object v9, p1

    move-object v2, p2

    move-object/from16 v7, p5

    move-object/from16 v8, p6

    move/from16 v10, p7

    move v4, v5

    move v5, p3

    invoke-direct/range {v0 .. v10}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda18;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;IIIILjava/lang/String;Ljava/lang/String;Landroid/view/View;Z)V

    invoke-interface {v11, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 397
    return-void

    .line 357
    :cond_ad
    :goto_ad
    return-void
.end method

.method private privacyChipWidth()I
    .registers 5

    .line 765
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "dimen"

    const-string v2, "com.android.systemui"

    const-string v3, "privacy_chip_icon_size"

    invoke-virtual {v0, v3, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 767
    if-eqz v0, :cond_1d

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    .line 768
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    goto :goto_24

    :cond_1d
    nop

    .line 769
    const/16 v0, 0x1e

    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->dp(I)I

    move-result v0

    .line 770
    :goto_24
    const/4 v1, 0x4

    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->dp(I)I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method private static readField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    .line 824
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    :goto_4
    if-eqz v0, :cond_19

    .line 826
    :try_start_6
    invoke-virtual {v0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 827
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 828
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_12
    .catch Ljava/lang/NoSuchFieldException; {:try_start_6 .. :try_end_12} :catch_13

    return-object p0

    .line 829
    :catch_13
    move-exception v1

    .line 824
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_4

    .line 833
    :cond_19
    new-instance p0, Ljava/lang/NoSuchFieldException;

    invoke-direct {p0, p1}, Ljava/lang/NoSuchFieldException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private readTemperatureDisplayUnit()V
    .registers 4

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1140050e

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits;->isFahrenheit(Ljava/lang/Integer;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFahrenheit:Z

    const-string v1, "CarSysuiHeaderCtrl"

    if-eqz v0, :cond_c

    const-string v0, "HVAC display unit=F"

    goto :goto_log

    :cond_c
    const-string v0, "HVAC display unit=C"

    :goto_log
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    invoke-virtual {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getHvacTemperatureScale()[F

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mTempScale:[F

    return-void
.end method

.method public applyTemperatureDisplayUnit(Z)V
    .registers 2

    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFahrenheit:Z

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshAllDisplays()V

    return-void
.end method

.method private readInitialValues()V
    .registers 5

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readTemperatureDisplayUnit()V

    .line 1138
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v0

    .line 1140
    if-eqz v0, :cond_12

    .line 1141
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 1143
    :cond_12
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const/4 v3, 0x4

    invoke-virtual {v0, v1, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v0

    .line 1145
    if-eqz v0, :cond_21

    .line 1146
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 1148
    :cond_21
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    .line 1150
    if-eqz v0, :cond_32

    .line 1151
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 1153
    :cond_32
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    invoke-virtual {v0, v1, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    .line 1155
    if-eqz v0, :cond_40

    .line 1156
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 1158
    :cond_40
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400501

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    .line 1160
    if-eqz v0, :cond_51

    .line 1161
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanDirection:I

    .line 1163
    :cond_51
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400500

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    .line 1165
    if-eqz v0, :cond_62

    .line 1166
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    .line 1168
    :cond_62
    return-void
.end method

.method private refreshAllDisplays()V
    .registers 4

    .line 1270
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    const/4 v1, 0x1

    invoke-direct {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 1271
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    const/4 v2, 0x4

    invoke-direct {p0, v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 1272
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    invoke-direct {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    .line 1273
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    invoke-direct {p0, v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    .line 1274
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanDirection:I

    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateFanDirectionUi(I)V

    .line 1275
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshFanSpeedUi()V

    .line 1276
    return-void
.end method

.method private refreshFanSpeedUi()V
    .registers 4

    .line 1308
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    if-eqz v0, :cond_31

    .line 1309
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    int-to-float v1, v1

    const/high16 v2, 0x40e00000    # 7.0f

    div-float/2addr v1, v2

    const v2, 0x3f0ccccd    # 0.55f

    mul-float/2addr v1, v2

    const v2, 0x3ee66666    # 0.45f

    add-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/view/View;->setAlpha(F)V

    .line 1310
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Fan speed "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1312
    :cond_31
    return-void
.end method

.method private refreshHvacButtons()V
    .registers 8

    .line 1233
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_a

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-eqz v0, :cond_a

    const/4 v0, 0x1

    goto :goto_b

    :cond_a
    const/4 v0, 0x0

    :goto_b
    move v6, v0

    .line 1234
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    iget v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    const/4 v5, 0x1

    move-object v1, p0

    invoke-direct/range {v1 .. v6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setHvacStepEnabled(Landroid/view/View;Landroid/view/View;FIZ)V

    .line 1235
    iget-object v2, v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    iget-object v3, v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    iget v4, v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    const/4 v5, 0x4

    invoke-direct/range {v1 .. v6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setHvacStepEnabled(Landroid/view/View;Landroid/view/View;FIZ)V

    .line 1237
    return-void
.end method

.method private removeMainThreadHost(Landroid/view/View;)V
    .registers 5

    .line 495
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 497
    if-eqz v0, :cond_1f

    :try_start_c
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    if-eqz v1, :cond_1f

    .line 498
    invoke-interface {v0, p1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_15
    .catchall {:try_start_c .. :try_end_15} :catchall_16

    goto :goto_1f

    .line 500
    :catchall_16
    move-exception v0

    .line 501
    const-string v1, "CarSysuiHeaderCtrl"

    const-string v2, "remove panel host"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_20

    .line 502
    :cond_1f
    :goto_1f
    nop

    .line 503
    :goto_20
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mMainThreadHosts:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 504
    return-void
.end method

.method private removeMainThreadHosts()V
    .registers 3

    .line 517
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mMainThreadHosts:Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 518
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_b
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1b

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    .line 519
    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->removeMainThreadHost(Landroid/view/View;)V

    .line 520
    goto :goto_b

    .line 521
    :cond_1b
    return-void
.end method

.method private setClimateBtnActive(Landroid/view/View;Z)V
    .registers 4

    .line 1315
    if-eqz p1, :cond_1e

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mRroContext:Landroid/content/Context;

    if-nez v0, :cond_7

    goto :goto_1e

    .line 1318
    :cond_7
    if-eqz p2, :cond_c

    const-string p2, "oem_climate_btn_active"

    goto :goto_e

    :cond_c
    const-string p2, "oem_climate_btn"

    :goto_e
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroDrawable(Ljava/lang/String;)I

    move-result p2

    .line 1319
    if-eqz p2, :cond_1d

    .line 1320
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mRroContext:Landroid/content/Context;

    invoke-virtual {v0, p2}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 1322
    :cond_1d
    return-void

    .line 1316
    :cond_1e
    :goto_1e
    return-void
.end method

.method private setFanDirection(I)V
    .registers 5

    .line 1279
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_19

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_19

    .line 1282
    :cond_9
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400501

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setIntProperty(III)Z

    move-result v0

    if-eqz v0, :cond_18

    .line 1284
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateFanDirectionUi(I)V

    .line 1286
    :cond_18
    return-void

    .line 1280
    :cond_19
    :goto_19
    return-void
.end method

.method private setHvacStepEnabled(Landroid/view/View;Landroid/view/View;FIZ)V
    .registers 9

    .line 1240
    nop

    .line 1241
    nop

    .line 1242
    if-eqz p5, :cond_29

    .line 1243
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    invoke-virtual {v0, v1, p4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatRange(II)[F

    move-result-object p4

    .line 1245
    if-eqz p4, :cond_29

    .line 1246
    const/4 p5, 0x0

    aget v0, p4, p5

    const v1, 0x3c23d70a    # 0.01f

    add-float/2addr v0, v1

    cmpl-float v0, p3, v0

    const/4 v2, 0x1

    if-lez v0, :cond_1d

    move v0, v2

    goto :goto_1e

    :cond_1d
    move v0, p5

    .line 1247
    :goto_1e
    aget p4, p4, v2

    sub-float/2addr p4, v1

    cmpg-float p3, p3, p4

    if-gez p3, :cond_26

    move p5, v2

    :cond_26
    move p3, p5

    move p5, v0

    goto :goto_2a

    .line 1250
    :cond_29
    move p3, p5

    :goto_2a
    invoke-virtual {p0, p1, p5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1251
    invoke-virtual {p0, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1252
    return-void
.end method

.method private startDesignPanel(Ljava/lang/String;Ljava/lang/String;)Z
    .registers 6

    .line 1400
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_6

    return v1

    .line 1402
    :cond_6
    :try_start_6
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v2, "com.test.design"

    invoke-virtual {v0, v2, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_11
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_6 .. :try_end_11} :catch_3f

    .line 1405
    nop

    .line 1407
    :try_start_12
    invoke-static {p2}, Landroid/content/ComponentName;->unflattenFromString(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object p2

    .line 1408
    if-nez p2, :cond_19

    return v1

    .line 1409
    :cond_19
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1410
    invoke-virtual {v0, p2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1411
    const-string p1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, p1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 1412
    const/high16 p1, 0x14000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1413
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenCurrentUser()I

    move-result p2

    invoke-static {p1, v0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenStartActivity(Landroid/content/Context;Landroid/content/Intent;I)V
    :try_end_34
    .catchall {:try_start_12 .. :try_end_34} :catchall_36

    .line 1414
    const/4 p1, 0x1

    return p1

    .line 1415
    :catchall_36
    move-exception p1

    .line 1416
    const-string p2, "CarSysuiHeaderCtrl"

    const-string v0, "startDesignPanel failed"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1417
    return v1

    .line 1403
    :catch_3f
    move-exception p1

    .line 1404
    return v1
.end method

.method private stripStatusIconViews(Landroid/view/View;)V
    .registers 6

    .line 614
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-nez v0, :cond_5

    .line 615
    return-void

    .line 617
    :cond_5
    check-cast p1, Landroid/view/ViewGroup;

    .line 618
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_d
    if-ltz v0, :cond_2d

    .line 619
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 620
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "StatusIconView"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_27

    .line 621
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->removeViewAt(I)V

    goto :goto_2a

    .line 623
    :cond_27
    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->stripStatusIconViews(Landroid/view/View;)V

    .line 618
    :goto_2a
    add-int/lit8 v0, v0, -0x1

    goto :goto_d

    .line 626
    :cond_2d
    return-void
.end method

.method private systemBarElementInitializer()Ljava/lang/Object;
    .registers 7

    .line 801
    const-string v0, "mSysUIComponent"

    const/4 v1, 0x0

    :try_start_3
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2
    :try_end_9
    .catchall {:try_start_3 .. :try_end_9} :catchall_3a

    .line 802
    nop

    .line 804
    :try_start_a
    invoke-static {v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0
    :try_end_e
    .catch Ljava/lang/NoSuchFieldException; {:try_start_a .. :try_end_e} :catch_f
    .catchall {:try_start_a .. :try_end_e} :catchall_3a

    .line 808
    goto :goto_1a

    .line 805
    :catch_f
    move-exception v3

    .line 806
    :try_start_10
    const-string v3, "mInitializer"

    invoke-static {v2, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 807
    invoke-static {v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 809
    :goto_1a
    if-nez v0, :cond_1d

    .line 810
    return-object v1

    .line 812
    :cond_1d
    const-string v2, "carSystemBarElementInitializerProvider"

    invoke-static {v0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 813
    if-nez v0, :cond_26

    .line 814
    return-object v1

    .line 816
    :cond_26
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "get"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_39
    .catchall {:try_start_10 .. :try_end_39} :catchall_3a

    return-object v0

    .line 817
    :catchall_3a
    move-exception v0

    .line 818
    const-string v2, "CarSysuiHeaderCtrl"

    const-string v3, "systemBarElementInitializer"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 819
    return-object v1
.end method

.method private toggleNightMode(Landroid/view/View;)V
    .registers 4

    .line 233
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    const-class v1, Landroid/app/UiModeManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/UiModeManager;

    .line 234
    if-nez v0, :cond_d

    .line 235
    return-void

    .line 237
    :cond_d
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->isNightMode()Z

    move-result v1

    .line 238
    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->hiddenSetNightMode(Landroid/app/UiModeManager;Z)V

    .line 239
    invoke-direct {p0, p1, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateNightModeIcon(Landroid/view/View;Z)V

    .line 240
    return-void
.end method

.method private updateFanDirectionUi(I)V
    .registers 6

    .line 1301
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanDirection:I

    .line 1302
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFace:Landroid/view/View;

    and-int/lit8 v1, p1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_c

    move v1, v3

    goto :goto_d

    :cond_c
    move v1, v2

    :goto_d
    invoke-direct {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setClimateBtnActive(Landroid/view/View;Z)V

    .line 1303
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFeet:Landroid/view/View;

    and-int/lit8 v1, p1, 0x2

    if-eqz v1, :cond_18

    move v1, v3

    goto :goto_19

    :cond_18
    move v1, v2

    :goto_19
    invoke-direct {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setClimateBtnActive(Landroid/view/View;Z)V

    .line 1304
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentDefrost:Landroid/view/View;

    and-int/lit8 p1, p1, 0x4

    if-eqz p1, :cond_23

    move v2, v3

    :cond_23
    invoke-direct {p0, v0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setClimateBtnActive(Landroid/view/View;Z)V

    .line 1305
    return-void
.end method

.method private updateHvacDisplay(IF)V
    .registers 7

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFahrenheit:Z

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mTempScale:[F

    invoke-static {p2, v0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits;->format(FZ[F)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    .line 1218
    if-ne p1, v1, :cond_3c

    .line 1219
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 1220
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    if-eqz p1, :cond_4a

    .line 1221
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4a

    .line 1223
    :cond_3c
    const/4 v1, 0x4

    if-ne p1, v1, :cond_4a

    .line 1224
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 1225
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTempText:Landroid/widget/TextView;

    if-eqz p1, :cond_4a

    .line 1226
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTempText:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1229
    :cond_4a
    :goto_4a
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshHvacButtons()V

    .line 1230
    return-void
.end method

.method private updateNightModeIcon(Landroid/view/View;Z)V
    .registers 6

    .line 248
    instance-of v0, p1, Landroid/widget/ImageView;

    if-eqz v0, :cond_20

    .line 249
    if-eqz p2, :cond_9

    const-string v0, "ic_status_day"

    goto :goto_b

    :cond_9
    const-string v0, "ic_status_night"

    :goto_b
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroDrawable(Ljava/lang/String;)I

    move-result v0

    .line 250
    if-eqz v0, :cond_20

    .line 252
    :try_start_11
    move-object v1, p1

    check-cast v1, Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_17
    .catch Ljava/lang/RuntimeException; {:try_start_11 .. :try_end_17} :catch_18

    .line 255
    goto :goto_20

    .line 253
    :catch_18
    move-exception v0

    .line 254
    const-string v1, "CarSysuiHeaderCtrl"

    const-string v2, "night mode icon"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 258
    :cond_20
    :goto_20
    if-eqz p2, :cond_25

    const-string p2, "Light theme"

    goto :goto_27

    :cond_25
    const-string p2, "Dark theme"

    :goto_27
    invoke-virtual {p1, p2}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 259
    return-void
.end method

.method private updateSeatDisplay(II)V
    .registers 5

    .line 1255
    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 1256
    const/4 v1, 0x1

    if-ne p1, v1, :cond_13

    .line 1257
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 1258
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTempText:Landroid/widget/TextView;

    if-eqz p1, :cond_21

    .line 1259
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTempText:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_21

    .line 1261
    :cond_13
    const/4 v1, 0x4

    if-ne p1, v1, :cond_21

    .line 1262
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 1263
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTempText:Landroid/widget/TextView;

    if-eqz p1, :cond_21

    .line 1264
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTempText:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1267
    :cond_21
    :goto_21
    return-void
.end method

.method private wireClickListeners()V
    .registers 5

    .line 957
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_e

    .line 958
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda2;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 960
    :cond_e
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_1c

    .line 961
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda9;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda9;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 963
    :cond_1c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_2a

    .line 964
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda10;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda10;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 966
    :cond_2a
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_38

    .line 967
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda11;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda11;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 969
    :cond_38
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_46

    .line 970
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda12;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda12;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 972
    :cond_46
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_54

    .line 973
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda13;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda13;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 976
    :cond_54
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_62

    .line 977
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda14;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda14;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 979
    :cond_62
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_70

    .line 980
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda15;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda15;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 983
    :cond_70
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentDefrost:Landroid/view/View;

    if-eqz v0, :cond_7e

    .line 984
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentDefrost:Landroid/view/View;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda16;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda16;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 987
    :cond_7e
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFace:Landroid/view/View;

    if-eqz v0, :cond_8c

    .line 988
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFace:Landroid/view/View;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda17;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda17;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 991
    :cond_8c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFeet:Landroid/view/View;

    if-eqz v0, :cond_9a

    .line 992
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFeet:Landroid/view/View;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda3;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 995
    :cond_9a
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    if-eqz v0, :cond_a8

    .line 996
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda4;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 999
    :cond_a8
    const-string v0, "oem_climate_card"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_bc

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    .line 1000
    const-string v1, "sysui_driver_zone_panel"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_135

    .line 1001
    :cond_bc
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    const/4 v1, 0x1

    if-eqz v0, :cond_d5

    .line 1002
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setClickable(Z)V

    .line 1003
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setFocusable(Z)V

    .line 1004
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    new-instance v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda5;

    invoke-direct {v2, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda5;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1006
    :cond_d5
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mView:Landroid/view/View;

    if-eqz v0, :cond_dc

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mView:Landroid/view/View;

    goto :goto_de

    :cond_dc
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    :goto_de
    const-string v2, "oem_card_header"

    invoke-direct {p0, v0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findClickable(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 1007
    if-nez v0, :cond_ff

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    if-eqz v2, :cond_ff

    .line 1009
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    instance-of v2, v2, Landroid/view/ViewGroup;

    if-eqz v2, :cond_ff

    .line 1010
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    check-cast v2, Landroid/view/ViewGroup;

    .line 1011
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-lez v3, :cond_ff

    .line 1012
    const/4 v0, 0x0

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 1016
    :cond_ff
    if-eqz v0, :cond_117

    .line 1017
    invoke-virtual {v0, v1}, Landroid/view/View;->setClickable(Z)V

    .line 1018
    invoke-virtual {v0, v1}, Landroid/view/View;->setFocusable(Z)V

    .line 1019
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda6;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1020
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda7;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 1025
    :cond_117
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mView:Landroid/view/View;

    if-eqz v0, :cond_11e

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mView:Landroid/view/View;

    goto :goto_120

    :cond_11e
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    :goto_120
    const-string v1, "oem_card_expand"

    invoke-direct {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findClickable(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 1026
    if-eqz v0, :cond_135

    .line 1027
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda8;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda8;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 1028
    const-string v1, "Vehicle"

    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1031
    :cond_135
    return-void
.end method

.method private wireDesignClick(Landroid/view/View;Landroid/view/View$OnClickListener;)V
    .registers 5

    .line 878
    instance-of v0, p1, Landroid/widget/ImageButton;

    const/4 v1, 0x0

    if-eqz v0, :cond_d

    invoke-virtual {p1}, Landroid/view/View;->hasOnClickListeners()Z

    move-result v0

    if-eqz v0, :cond_d

    const/4 v0, 0x1

    goto :goto_e

    :cond_d
    move v0, v1

    .line 879
    :goto_e
    if-nez v0, :cond_13

    .line 880
    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 882
    :cond_13
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_2a

    .line 883
    check-cast p1, Landroid/view/ViewGroup;

    .line 884
    nop

    :goto_1a
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v1, v0, :cond_2a

    .line 885
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireDesignClick(Landroid/view/View;Landroid/view/View$OnClickListener;)V

    .line 884
    add-int/lit8 v1, v1, 0x1

    goto :goto_1a

    .line 888
    :cond_2a
    return-void
.end method

.method private wireDesignScreen(Landroid/view/View;)V
    .registers 4

    .line 861
    nop

    .line 862
    const-string v0, "sysui_driver_zone_panel"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_30

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    .line 863
    const-string v1, "oem_climate_card"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    goto :goto_30

    .line 865
    :cond_16
    const-string v0, "sysui_passenger_zone_panel"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2d

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    .line 866
    const-string v1, "oem_car_status_card"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2b

    goto :goto_2d

    :cond_2b
    const/4 v0, 0x0

    goto :goto_32

    .line 867
    :cond_2d
    :goto_2d
    const-string v0, "com.test.design.presentation.ivi.glanceables.VehiclePanelActivity"

    goto :goto_32

    .line 864
    :cond_30
    :goto_30
    const-string v0, "com.test.design.presentation.ivi.glanceables.ClimatePanelActivity"

    .line 869
    :goto_32
    if-eqz v0, :cond_41

    if-nez p1, :cond_37

    goto :goto_41

    .line 872
    :cond_37
    nop

    .line 873
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Ljava/lang/String;)V

    invoke-direct {p0, p1, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireDesignClick(Landroid/view/View;Landroid/view/View$OnClickListener;)V

    .line 874
    return-void

    .line 870
    :cond_41
    :goto_41
    return-void
.end method

.method private wireMapScrim(Landroid/view/View;)V
    .registers 3

    if-nez p1, :cond_3

    return-void

    :cond_3
    const-string v0, "launcher_map_scrim_touch"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_c

    return-void

    :cond_c
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    if-nez p1, :cond_13

    return-void

    :cond_13
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda25;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda25;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private wireNightMode(Landroid/view/View;)V
    .registers 3

    .line 217
    if-nez p1, :cond_3

    .line 218
    return-void

    .line 220
    :cond_3
    const-string v0, "sysui_night_mode"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 221
    if-nez v0, :cond_c

    .line 222
    return-void

    .line 224
    :cond_c
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    .line 225
    if-nez p1, :cond_13

    .line 226
    return-void

    .line 228
    :cond_13
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->isNightMode()Z

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateNightModeIcon(Landroid/view/View;Z)V

    .line 229
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda23;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda23;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 230
    return-void
.end method

.method private wirePrivacyChips(Landroid/view/View;)V
    .registers 11

    .line 692
    const-string v0, "launcher_pill_right"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    .line 693
    return-void

    .line 695
    :cond_b
    const-string v0, "launcher_privacy_chips"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 696
    if-nez v0, :cond_14

    .line 697
    return-void

    .line 699
    :cond_14
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    .line 700
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-nez v0, :cond_1d

    .line 701
    return-void

    .line 703
    :cond_1d
    move-object v2, p1

    check-cast v2, Landroid/view/ViewGroup;

    .line 704
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getTag()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "main-hosted"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_31

    .line 705
    return-void

    .line 707
    :cond_31
    const-string p1, "camera_privacy_chip"

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->inflateSystemUiLayout(Ljava/lang/String;)Landroid/view/View;

    move-result-object p1

    .line 708
    const-string v1, "mic_privacy_chip"

    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->inflateSystemUiLayout(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 709
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->privacyChipWidth()I

    move-result v3

    .line 710
    move v4, v3

    new-instance v3, Landroid/widget/LinearLayout;

    iget-object v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-direct {v3, v5}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 711
    const/4 v5, 0x0

    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 712
    const/16 v6, 0x10

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 713
    invoke-virtual {v3, v5}, Landroid/widget/LinearLayout;->setClipChildren(Z)V

    .line 714
    nop

    .line 715
    if-eqz p1, :cond_64

    .line 716
    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->fitPrivacyChip(Landroid/view/View;)V

    .line 717
    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->chipLayoutParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, p1, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 718
    add-int/lit8 v5, v4, 0x0

    .line 720
    :cond_64
    if-eqz v1, :cond_73

    .line 721
    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->fitPrivacyChip(Landroid/view/View;)V

    .line 722
    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->chipLayoutParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object p1

    invoke-virtual {v3, v1, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 723
    add-int/2addr v5, v4

    move v4, v5

    goto :goto_74

    .line 720
    :cond_73
    move v4, v5

    .line 725
    :goto_74
    if-nez v4, :cond_77

    .line 726
    return-void

    .line 728
    :cond_77
    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->setTag(Ljava/lang/Object;)V

    .line 730
    new-instance p1, Landroid/view/View;

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-direct {p1, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->chipLayoutParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v2, p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 731
    nop

    .line 732
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda19;

    invoke-direct {p1, p0, v2, v3, v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda19;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/ViewGroup;Landroid/widget/LinearLayout;I)V

    .line 735
    invoke-virtual {v2, p1}, Landroid/view/ViewGroup;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 736
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getHeight()I

    move-result p1

    if-lez p1, :cond_a2

    .line 737
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getHeight()I

    move-result v5

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-direct/range {v1 .. v8}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->placeMainThreadHost(Landroid/view/View;Landroid/view/View;IILjava/lang/String;Ljava/lang/String;Z)V

    .line 740
    :cond_a2
    const-string p1, "CarSysuiHeaderCtrl"

    const-string v0, "privacy chips hosted on main thread"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 741
    return-void
.end method

.method private wireSettingsButton(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    .line 646
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result p2

    .line 647
    if-nez p2, :cond_7

    .line 648
    return-void

    .line 650
    :cond_7
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    .line 651
    if-nez p1, :cond_e

    .line 652
    return-void

    .line 654
    :cond_e
    new-instance p2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda22;

    invoke-direct {p2, p0, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda22;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Ljava/lang/String;)V

    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 655
    return-void
.end method

.method private wireStatusPills(Landroid/view/View;)V
    .registers 10

    .line 269
    if-nez p1, :cond_3

    .line 270
    return-void

    .line 272
    :cond_3
    const-string v0, "launcher_pill_left"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_42

    .line 273
    const-string v0, "qc_status_icons_horizontal"

    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->inflateSystemUiLayout(Ljava/lang/String;)Landroid/view/View;

    move-result-object v5

    .line 276
    const-string v6, "qc_connectivity_panel"

    const-string v7, "android.settings.WIFI_SETTINGS"

    const-string v3, "launcher_status_wifi_slot"

    const-string v4, "launcher_status_wifi"

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    .line 279
    const-string v6, "qc_bluetooth_panel"

    const-string v7, "android.settings.BLUETOOTH_SETTINGS"

    const-string v3, "launcher_status_bluetooth_slot"

    const-string v4, "launcher_status_bluetooth"

    invoke-direct/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    .line 282
    const-string v6, "qc_display_panel"

    const-string v7, "android.settings.DISPLAY_SETTINGS"

    const-string v3, "launcher_status_brightness_slot"

    const-string v4, "launcher_status_brightness"

    invoke-direct/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    const-string v6, "qc_volume_panel"

    const-string v7, "android.settings.SOUND_SETTINGS"

    const-string v3, "launcher_status_volume_slot"

    const-string v4, "launcher_status_volume"

    invoke-direct/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_43

    .line 272
    :cond_42
    move-object v2, p1

    .line 286
    :goto_43
    invoke-direct {p0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireUserProfile(Landroid/view/View;)V

    .line 287
    invoke-direct {p0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wirePrivacyChips(Landroid/view/View;)V

    .line 288
    return-void
.end method

.method private wireUserProfile(Landroid/view/View;)V
    .registers 10

    .line 670
    const-string v0, "launcher_user_name"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    .line 671
    if-eqz v0, :cond_19

    .line 672
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .line 673
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_19

    .line 674
    check-cast v0, Landroid/widget/TextView;

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->currentUserName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 677
    :cond_19
    const-string v0, "launcher_pill_right"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_24

    .line 678
    return-void

    .line 680
    :cond_24
    const-string v0, "user_name_container"

    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->inflateSystemUiLayout(Ljava/lang/String;)Landroid/view/View;

    move-result-object v5

    .line 681
    const-string v6, "qc_profile_switcher"

    const-string v7, "android.settings.USER_SETTINGS"

    const-string v3, "launcher_user_anchor"

    const-string v4, "launcher_user_profile"

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindMainThreadPanel(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    .line 683
    return-void
.end method


# virtual methods
.method protected applyUxRestrictions()V
    .registers 3

    .line 1326
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderUxScrim:Landroid/view/View;

    iget-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setScrimVisible(Landroid/view/View;Z)V

    .line 1327
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFullyRestricted:Z

    if-nez v0, :cond_11

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalConnected:Z

    if-eqz v0, :cond_11

    const/4 v0, 0x1

    goto :goto_12

    :cond_11
    const/4 v0, 0x0

    .line 1328
    :goto_12
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshHvacButtons()V

    .line 1329
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1330
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1331
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1332
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1333
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentDefrost:Landroid/view/View;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1334
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFace:Landroid/view/View;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1335
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVentFeet:Landroid/view/View;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1336
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeedBtn:Landroid/view/View;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setViewEnabled(Landroid/view/View;Z)V

    .line 1337
    return-void
.end method

.method protected applyVhalConnectedState()V
    .registers 5

    .line 1347
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setScrimVisible(Landroid/view/View;Z)V

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    const v2, 0x15600503

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v2, 0x1140050e

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 1348
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readInitialValues()V

    .line 1349
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshAllDisplays()V

    .line 1350
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->applyUxRestrictions()V

    .line 1351
    return-void
.end method

.method protected applyVhalDisconnectedState()V
    .registers 3

    .line 1341
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setScrimVisible(Landroid/view/View;Z)V

    .line 1342
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->applyUxRestrictions()V

    .line 1343
    return-void
.end method

.method protected bindViews(Landroid/view/View;)V
    .registers 2

    .line 201
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindDriverZone(Landroid/view/View;)V

    .line 202
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindPassengerZone(Landroid/view/View;)V

    .line 203
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindClimateExtras(Landroid/view/View;)V

    .line 204
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindChromeScrim(Landroid/view/View;)V

    .line 205
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireClickListeners()V

    .line 206
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireDesignScreen(Landroid/view/View;)V

    .line 207
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireNightMode(Landroid/view/View;)V

    .line 208
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireStatusPills(Landroid/view/View;)V

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireMapScrim(Landroid/view/View;)V

    .line 209
    return-void
.end method

.method protected dumpControllerState(Ljava/io/PrintWriter;)V
    .registers 5

    .line 1355
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  driverHvacTemp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "C"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1356
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "  passengerHvacTemp="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1357
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  driverSeatTemp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1358
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  passengerSeatTemp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1359
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  fanDirection="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanDirection:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " fanSpeed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1360
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "  panelLayout="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->getLayoutResourceName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 1361
    return-void
.end method

.method protected getLayoutResourceName()Ljava/lang/String;
    .registers 4

    .line 179
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    const-string v1, "oem_climate_card"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_51

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    .line 180
    const-string v2, "sysui_driver_zone_panel"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_15

    goto :goto_51

    .line 184
    :cond_15
    const-string v0, "sysui_passenger_zone_panel"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_22

    .line 185
    const-string v0, "car_sysui_scalable_header_passenger_zone"

    return-object v0

    .line 187
    :cond_22
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    const-string v1, "launcher_pill_left"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2d

    .line 188
    return-object v1

    .line 190
    :cond_2d
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    const-string v1, "launcher_pill_center"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_38

    .line 191
    return-object v1

    .line 193
    :cond_38
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    const-string v1, "launcher_pill_right"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_43

    .line 194
    return-object v1

    .line 196
    :cond_43
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPanelId:Ljava/lang/String;

    const-string v1, "launcher_map_scrim"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4e

    return-object v1

    :cond_4e
    const-string v0, "car_sysui_scalable_header"

    return-object v0

    .line 182
    :cond_51
    :goto_51
    return-object v1
.end method

.method synthetic lambda$bindMainThreadPanel$1$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;Landroid/widget/FrameLayout;Ljava/lang/String;Ljava/lang/String;Landroid/view/View;IIIIIIII)V
    .registers 14

    .line 344
    sub-int/2addr p8, p6

    sub-int p5, p9, p7

    move-object p7, p4

    move p4, p8

    const/4 p8, 0x1

    move-object p6, p3

    move-object p3, p2

    move-object p2, p1

    move-object p1, p0

    invoke-direct/range {p1 .. p8}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->placeMainThreadHost(Landroid/view/View;Landroid/view/View;IILjava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method synthetic lambda$null$2$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    .line 378
    invoke-virtual {p1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object p1

    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireSettingsButton(Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$placeMainThreadHost$3$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;IIIILjava/lang/String;Ljava/lang/String;Landroid/view/View;Z)V
    .registers 10

    .line 375
    invoke-direct/range {p0 .. p5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->ensureMainThreadHost(Landroid/view/View;IIII)Z

    move-result p2

    move-object p3, p1

    move-object p1, p0

    const-string p4, "CarSysuiHeaderCtrl"

    if-nez p2, :cond_1c

    .line 376
    const-string p2, "main-thread host failed"

    invoke-static {p4, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 377
    if-eqz p6, :cond_1b

    if-eqz p7, :cond_1b

    .line 378
    new-instance p2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda20;

    invoke-direct {p2, p0, p8, p6, p7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda20;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p8, p2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 381
    :cond_1b
    return-void

    .line 383
    :cond_1c
    invoke-virtual {p3}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    if-nez p2, :cond_39

    .line 384
    move-object p2, p3

    check-cast p2, Landroid/view/ViewGroup;

    invoke-direct {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->initializeElements(Landroid/view/ViewGroup;)Z

    move-result p2

    if-nez p2, :cond_2f

    .line 385
    invoke-direct {p0, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->removeMainThreadHost(Landroid/view/View;)V

    .line 386
    return-void

    .line 388
    :cond_2f
    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p3, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 389
    const-string p1, "main-thread panel ready"

    invoke-static {p4, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 391
    :cond_39
    if-eqz p9, :cond_3e

    .line 394
    invoke-static {p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->fadeStockChrome(Landroid/view/View;)V

    .line 396
    :cond_3e
    return-void
.end method

.method synthetic lambda$wireClickListeners$10$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 964
    const/4 p1, 0x1

    invoke-direct {p0, p1, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$11$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 967
    const/4 p1, 0x1

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$12$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 970
    const/4 p1, 0x4

    const/high16 v0, 0x3f000000    # 0.5f

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$13$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 974
    const/4 p1, 0x4

    const/high16 v0, -0x41000000    # -0.5f

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$14$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 977
    const/4 p1, 0x4

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$15$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 981
    const/4 p1, 0x4

    const/4 v0, -0x1

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$16$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 985
    const/4 p1, 0x4

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setFanDirection(I)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$17$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 989
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setFanDirection(I)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$18$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 993
    const/4 p1, 0x2

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->setFanDirection(I)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$19$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 996
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->cycleFanSpeed()V

    return-void
.end method

.method synthetic lambda$wireClickListeners$20$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 1004
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->launchClimatePanel()V

    return-void
.end method

.method synthetic lambda$wireClickListeners$21$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 1019
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->launchClimatePanel()V

    return-void
.end method

.method synthetic lambda$wireClickListeners$22$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)Z
    .registers 2

    .line 1021
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->launchVehiclePanel()V

    .line 1022
    const/4 p1, 0x1

    return p1
.end method

.method synthetic lambda$wireClickListeners$23$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 1027
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->launchVehiclePanel()V

    return-void
.end method

.method synthetic lambda$wireClickListeners$8$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 958
    const/4 p1, 0x1

    const/high16 v0, 0x3f000000    # 0.5f

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method synthetic lambda$wireClickListeners$9$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 3

    .line 961
    const/4 p1, 0x1

    const/high16 v0, -0x41000000    # -0.5f

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method synthetic lambda$wireDesignScreen$7$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Ljava/lang/String;Landroid/view/View;)V
    .registers 3

    .line 873
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->launchDesignScreen(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$wireNightMode$0$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/View;)V
    .registers 2

    .line 229
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->toggleNightMode(Landroid/view/View;)V

    return-void
.end method

.method synthetic lambda$wirePrivacyChips$6$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Landroid/view/ViewGroup;Landroid/widget/LinearLayout;ILandroid/view/View;IIIIIIII)V
    .registers 13

    .line 733
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getHeight()I

    move-result p5

    const/4 p7, 0x0

    const/4 p8, 0x0

    const/4 p6, 0x0

    move p4, p3

    move-object p3, p2

    move-object p2, p1

    move-object p1, p0

    invoke-direct/range {p1 .. p8}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->placeMainThreadHost(Landroid/view/View;Landroid/view/View;IILjava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method synthetic lambda$wireSettingsButton$5$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController(Ljava/lang/String;Landroid/view/View;)V
    .registers 3

    .line 654
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->openSettings(Ljava/lang/String;)V

    return-void
.end method

.method protected onControllerAttached()V
    .registers 5

    .line 1120
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    const v2, 0x15600503

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v2, 0x1140050e

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 1121
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v1, v3, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 1122
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400501

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v1, v3, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 1123
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400500

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v1, v3, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 1124
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readInitialValues()V

    .line 1125
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshAllDisplays()V

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->start(Landroid/content/Context;)V

    .line 1126
    return-void
.end method

.method protected onControllerDetached()V
    .registers 3

    .line 1130
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getMainExecutor()Ljava/util/concurrent/Executor;

    move-result-object v0

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 1131
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1140050e

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 1132
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 1133
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400501

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 1134
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15400500

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 1135
    return-void
.end method

.method public onMapScrimClick(Landroid/view/View;)V
    .registers 3

    const-string p1, "CarSysuiHeaderCtrl"

    const-string v0, "map scrim tap -> home"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string p1, "_System_OnHomeEvent"

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->dispatchScalableEvent(Ljava/lang/String;)V

    return-void
.end method
