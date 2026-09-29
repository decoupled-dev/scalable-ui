.class public Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;
.super Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;
.source "CarSysuiScalableHeaderController.java"


# instance fields
.field public mDriverHvacDown:Landroid/widget/ImageButton;

.field public mDriverHvacTemp:F

.field public mDriverHvacTempText:Landroid/widget/TextView;

.field public mDriverHvacUp:Landroid/widget/ImageButton;

.field public mDriverSeatDown:Landroid/widget/ImageButton;

.field public mDriverSeatTemp:I

.field public mDriverSeatTempText:Landroid/widget/TextView;

.field public mDriverSeatUp:Landroid/widget/ImageButton;

.field public mDriverZoneRoot:Landroid/view/View;

.field public mHeaderUxScrim:Landroid/view/View;

.field public mHeaderVhalScrim:Landroid/view/View;

.field public final mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

.field public mPassengerHvacDown:Landroid/widget/ImageButton;

.field public mPassengerHvacTemp:F

.field public mPassengerHvacTempText:Landroid/widget/TextView;

.field public mPassengerHvacUp:Landroid/widget/ImageButton;

.field public mPassengerSeatDown:Landroid/widget/ImageButton;

.field public mPassengerSeatTemp:I

.field public mPassengerSeatTempText:Landroid/widget/TextView;

.field public mPassengerSeatUp:Landroid/widget/ImageButton;

.field public mPassengerZoneRoot:Landroid/view/View;


# direct methods
.method public static synthetic $r8$lambda$-up3xb0HD5lhEq7bzfhbYgoe9SA(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$7(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$-wdTcYgd5uYsxoaoZ1WNU015Bak(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$0(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$1NnnlGot02aV7HyEZJyr7b_eg1Y(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$6(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$4YBFjzBFsq7aybR7Fv7jhrAnTzw(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$ByoF1RpfOgcd6ldeuP_HgcUgx1E(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$5(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$RJ-8cZxCsfKLoLq1ziSxXAwyP24(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$1(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$bB8wKOtT8nBNtalIeSZKQ5QBSDY(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$4(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$q4AG-UgUWOLVyUwjAzhfP5QhfG0(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->lambda$wireClickListeners$3(Landroid/view/View;)V

    return-void
.end method

.method public static bridge synthetic -$$Nest$mupdateHvacDisplay(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;IF)V
    .registers 3

    .line 0
    invoke-virtual {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    return-void
.end method

.method public static bridge synthetic -$$Nest$mupdateSeatDisplay(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;II)V
    .registers 3

    .line 0
    invoke-virtual {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .registers 4

    .line 111
    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    const/high16 p1, 0x41b00000    # 22.0f

    .line 55
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 56
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    const/4 p1, 0x2

    .line 57
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 58
    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 83
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;

    invoke-direct {p1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    return-void
.end method

.method private findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;
    .registers 3

    .line 194
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_d

    .line 195
    invoke-virtual {p1, p0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p0

    check-cast p0, Landroid/widget/ImageButton;

    return-object p0

    :cond_d
    const/4 p0, 0x0

    return-object p0
.end method

.method private isNightMode()Z
    .registers 3

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v0, v0, 0x30

    const/16 v1, 0x20

    if-ne v0, v1, :cond_14

    const/4 v0, 0x1

    return v0

    :cond_14
    const/4 v0, 0x0

    return v0
.end method

.method private synthetic lambda$wireClickListeners$2(Landroid/view/View;)V
    .registers 2

    const/4 p1, 0x1

    .line 206
    invoke-virtual {p0, p1, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method private synthetic lambda$wireClickListeners$3(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x1

    const/4 v0, -0x1

    .line 209
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method private synthetic lambda$wireClickListeners$4(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x4

    const/high16 v0, 0x3f000000    # 0.5f

    .line 212
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method private synthetic lambda$wireClickListeners$5(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x4

    const/high16 v0, -0x41000000    # -0.5f

    .line 216
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method private synthetic lambda$wireClickListeners$6(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x4

    const/4 v0, 0x1

    .line 219
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method private synthetic lambda$wireClickListeners$7(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x4

    const/4 v0, -0x1

    .line 223
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustSeat(II)V

    return-void
.end method

.method private updateNightModeIcon(Landroid/view/View;Z)V
    .registers 6

    if-eqz p2, :cond_7

    const-string v0, "ic_status_day"

    const-string v1, "Light theme"

    goto :goto_b

    :cond_7
    const-string v0, "ic_status_night"

    const-string v1, "Dark theme"

    :goto_b
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroDrawable(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1b

    instance-of v2, p1, Landroid/widget/ImageView;

    if-eqz v2, :cond_1b

    move-object v2, p1

    check-cast v2, Landroid/widget/ImageView;

    :try_start_18
    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_1b
    .catch Ljava/lang/RuntimeException; {:try_start_18 .. :try_end_1b} :catch_1b

    :catch_1b
    :cond_1b
    invoke-virtual {p1, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private wireClickListeners()V
    .registers 3

    .line 199
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_c

    .line 200
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 202
    :cond_c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_18

    .line 203
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 205
    :cond_18
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_24

    .line 206
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda2;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 208
    :cond_24
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_30

    .line 209
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda3;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 211
    :cond_30
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_3c

    .line 212
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda4;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 214
    :cond_3c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_48

    .line 215
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda5;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 218
    :cond_48
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    if-eqz v0, :cond_54

    .line 219
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda6;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 221
    :cond_54
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    if-eqz v0, :cond_60

    .line 222
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$$ExternalSyntheticLambda7;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_60
    return-void
.end method

.method private wireNightMode(Landroid/view/View;)V
    .registers 4

    if-eqz p1, :cond_1f

    const-string v0, "sysui_night_mode"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_1f

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->isNightMode()Z

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateNightModeIcon(Landroid/view/View;Z)V

    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/NightModeToggle;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/NightModeToggle;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1f
    return-void
.end method


# virtual methods
.method public final adjustHvac(IF)V
    .registers 5

    .line 265
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-nez v0, :cond_20

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_20

    :cond_9
    const/4 v0, 0x1

    if-ne p1, v0, :cond_f

    .line 268
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    goto :goto_11

    :cond_f
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    :goto_11
    add-float/2addr v0, p2

    # Stay inside HVAC_TEMPERATURE_SET (17.5–32.5). Past that, setProperty throws.
    const p2, 0x418c0000

    invoke-static {v0, p2}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const p2, 0x42020000

    invoke-static {v0, p2}, Ljava/lang/Math;->min(FF)F

    move-result v0

    .line 270
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    invoke-virtual {p2, v1, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setFloatProperty(IIF)Z

    move-result p2

    if-eqz p2, :cond_20

    .line 271
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    :cond_20
    :goto_20
    return-void
.end method

.method public final adjustSeat(II)V
    .registers 5

    .line 276
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-nez v0, :cond_2a

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalConnected:Z

    if-nez v0, :cond_9

    goto :goto_2a

    :cond_9
    const/4 v0, 0x1

    if-ne p1, v0, :cond_f

    .line 279
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    goto :goto_11

    :cond_f
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    :goto_11
    const/4 v1, 0x3

    add-int/2addr v0, p2

    .line 280
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    const/4 v0, 0x0

    invoke-static {v0, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 281
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    invoke-virtual {v0, v1, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->setIntProperty(III)Z

    move-result v0

    if-eqz v0, :cond_2a

    .line 282
    invoke-virtual {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    :cond_2a
    :goto_2a
    return-void
.end method

.method public applyUxRestrictions()V
    .registers 3

    .line 329
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderUxScrim:Landroid/view/View;

    iget-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setScrimVisible(Landroid/view/View;Z)V

    .line 330
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-nez v0, :cond_11

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalConnected:Z

    if-eqz v0, :cond_11

    const/4 v0, 0x1

    goto :goto_12

    :cond_11
    const/4 v0, 0x0

    .line 331
    :goto_12
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 332
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 333
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 334
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 335
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 336
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 337
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 338
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    return-void
.end method

.method public applyVhalConnectedState()V
    .registers 3

    .line 349
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setScrimVisible(Landroid/view/View;Z)V

    .line 350
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readInitialValues()V

    .line 351
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshAllDisplays()V

    .line 352
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->applyUxRestrictions()V

    return-void
.end method

.method public applyVhalDisconnectedState()V
    .registers 3

    .line 343
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setScrimVisible(Landroid/view/View;Z)V

    .line 344
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->applyUxRestrictions()V

    return-void
.end method

.method public final bindChromeScrim(Landroid/view/View;)V
    .registers 4

    .line 187
    const-string v0, "sysui_header_ux_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_e

    .line 188
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderUxScrim:Landroid/view/View;

    .line 189
    const-string v0, "sysui_header_vhal_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1d

    .line 190
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    :cond_1d
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHeaderVhalScrim:Landroid/view/View;

    return-void
.end method

.method public final bindDriverZone(Landroid/view/View;)V
    .registers 4

    .line 157
    const-string v0, "sysui_driver_zone_root"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_e

    .line 158
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverZoneRoot:Landroid/view/View;

    .line 160
    const-string v0, "sysui_driver_hvac_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_20

    .line 161
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_21

    :cond_20
    move-object v0, v1

    :goto_21
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    .line 162
    const-string v0, "sysui_driver_hvac_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacUp:Landroid/widget/ImageButton;

    .line 163
    const-string v0, "sysui_driver_hvac_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacDown:Landroid/widget/ImageButton;

    .line 165
    const-string v0, "sysui_driver_seat_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_42

    .line 166
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroid/widget/TextView;

    :cond_42
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTempText:Landroid/widget/TextView;

    .line 167
    const-string v0, "sysui_driver_seat_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatUp:Landroid/widget/ImageButton;

    .line 168
    const-string v0, "sysui_driver_seat_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatDown:Landroid/widget/ImageButton;

    return-void
.end method

.method public final bindPassengerZone(Landroid/view/View;)V
    .registers 4

    .line 172
    const-string v0, "sysui_passenger_zone_root"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_e

    .line 173
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_f

    :cond_e
    move-object v0, v1

    :goto_f
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerZoneRoot:Landroid/view/View;

    .line 175
    const-string v0, "sysui_passenger_hvac_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_20

    .line 176
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_21

    :cond_20
    move-object v0, v1

    :goto_21
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTempText:Landroid/widget/TextView;

    .line 177
    const-string v0, "sysui_passenger_hvac_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacUp:Landroid/widget/ImageButton;

    .line 178
    const-string v0, "sysui_passenger_hvac_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacDown:Landroid/widget/ImageButton;

    .line 180
    const-string v0, "sysui_passenger_seat_temp"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_42

    .line 181
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroid/widget/TextView;

    :cond_42
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTempText:Landroid/widget/TextView;

    .line 182
    const-string v0, "sysui_passenger_seat_up"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatUp:Landroid/widget/ImageButton;

    .line 183
    const-string v0, "sysui_passenger_seat_down"

    invoke-direct {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatDown:Landroid/widget/ImageButton;

    return-void
.end method

.method public bindViews(Landroid/view/View;)V
    .registers 2

    .line 150
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindDriverZone(Landroid/view/View;)V

    .line 151
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindPassengerZone(Landroid/view/View;)V

    .line 152
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->bindChromeScrim(Landroid/view/View;)V

    .line 153
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireClickListeners()V

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->wireNightMode(Landroid/view/View;)V

    return-void
.end method

.method public getLayoutResourceName()Ljava/lang/String;
    .registers 3

    .line 139
    const-string v0, "sysui_driver_zone_panel"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    .line 140
    const-string p0, "car_sysui_scalable_header_driver_zone"

    return-object p0

    .line 142
    :cond_d
    const-string v0, "sysui_passenger_zone_panel"

    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1a

    .line 143
    const-string p0, "car_sysui_scalable_header_passenger_zone"

    return-object p0

    .line 145
    :cond_1a
    const-string p0, "car_sysui_scalable_header"

    return-object p0
.end method

.method public final synthetic lambda$wireClickListeners$0(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x1

    const/high16 v0, 0x3f000000    # 0.5f

    .line 200
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$1(Landroid/view/View;)V
    .registers 3

    const/4 p1, 0x1

    const/high16 v0, -0x41000000    # -0.5f

    .line 203
    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->adjustHvac(IF)V

    return-void
.end method

.method public onControllerAttached()V
    .registers 5

    .line 229
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    const v2, 0x15600503

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 230
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mHvacCallback:Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    invoke-virtual {v0, v1, v3, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z

    .line 231
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->readInitialValues()V

    .line 232
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshAllDisplays()V

    return-void
.end method

.method public onControllerDetached()V
    .registers 3

    .line 237
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 238
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v0, 0x1540050b

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    return-void
.end method

.method public final readInitialValues()V
    .registers 5

    .line 242
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x15600503

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v0

    if-eqz v0, :cond_12

    .line 245
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 247
    :cond_12
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const/4 v3, 0x4

    invoke-virtual {v0, v1, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatProperty(II)Ljava/lang/Float;

    move-result-object v0

    if-eqz v0, :cond_21

    .line 250
    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 252
    :cond_21
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    const v1, 0x1540050b

    invoke-virtual {v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_32

    .line 255
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 257
    :cond_32
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mVhalHelper:Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;

    invoke-virtual {v0, v1, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getIntProperty(II)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_40

    .line 260
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    :cond_40
    return-void
.end method

.method public final refreshAllDisplays()V
    .registers 4

    .line 321
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 322
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    const/4 v2, 0x4

    invoke-virtual {p0, v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V

    .line 323
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    .line 324
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    invoke-virtual {p0, v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V

    return-void
.end method

.method public toggleNightMode(Landroid/view/View;)V
    .registers 4

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    const-class v1, Landroid/app/UiModeManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/UiModeManager;

    if-eqz v0, :cond_18

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->isNightMode()Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/UiModeManager;->setNightModeActivated(Z)Z

    invoke-direct {p0, p1, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateNightModeIcon(Landroid/view/View;Z)V

    :cond_18
    return-void
.end method

.method public final updateHvacDisplay(IF)V
    .registers 8

    # %.0f rounds 17.5 to 18 and 32.5 to 33. Keep a decimal on half degrees.
    float-to-double v0, p2

    invoke-static {v0, v1}, Ljava/lang/Math;->rint(D)D

    move-result-wide v0

    double-to-float v0, v0

    sub-float/2addr v0, p2

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v1, 0x3d4ccccd

    cmpl-float v0, v0, v1

    if-gez v0, :cond_half

    const-string v0, "%.0f\u00b0"

    goto :cond_a

    :cond_half
    const-string v0, "%.1f\u00b0"

    :cond_a
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v0, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_27

    .line 293
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTemp:F

    .line 294
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverHvacTempText:Landroid/widget/TextView;

    if-eqz p0, :cond_33

    .line 295
    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_27
    const/4 v1, 0x4

    if-ne p1, v1, :cond_33

    .line 298
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTemp:F

    .line 299
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerHvacTempText:Landroid/widget/TextView;

    if-eqz p0, :cond_33

    .line 300
    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_33
    return-void
.end method

.method public final updateSeatDisplay(II)V
    .registers 5

    .line 306
    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    if-ne p1, v1, :cond_11

    .line 308
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTemp:I

    .line 309
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mDriverSeatTempText:Landroid/widget/TextView;

    if-eqz p0, :cond_1d

    .line 310
    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_11
    const/4 v1, 0x4

    if-ne p1, v1, :cond_1d

    .line 313
    iput p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTemp:I

    .line 314
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mPassengerSeatTempText:Landroid/widget/TextView;

    if-eqz p0, :cond_1d

    .line 315
    invoke-virtual {p0, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_1d
    return-void
.end method
