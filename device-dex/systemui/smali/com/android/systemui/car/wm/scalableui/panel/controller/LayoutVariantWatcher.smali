.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;
.super Landroid/database/ContentObserver;
.source "LayoutVariantWatcher.java"

# interfaces
.implements Ljava/lang/Runnable;
.implements Landroid/content/ComponentCallbacks;
.implements Landroid/view/View$OnAttachStateChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;
    }
.end annotation


# static fields
.field private static final PRIVACY_ANCHOR:Ljava/lang/String; = "launcher_privacy_chips"

.field private static final PROFILE_PANEL:Ljava/lang/String; = "launcher_pill_right"

.field public static final SETTING:Ljava/lang/String; = "scalable_ui_layout_variant"

.field private static final STATUS_PANEL:Ljava/lang/String; = "launcher_pill_left"

.field private static final STATUS_SLOTS:[Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "LayoutVariant"

.field private static final TYPE_SYSTEM_DIALOG:I = 0x7d8

.field public static final VARIANT_COUNT:I = 0x4

.field private static final VARIANT_DOCK_LEFT:I = 0x1

.field private static final VARIANT_WIDGET_COLUMN:I = 0x2

.field private static final WIDGET_PAGE_COUNT:I = 0x4

.field private static sDock:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/widget/LinearLayout;",
            ">;"
        }
    .end annotation
.end field

.field private static sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

.field private static sListeningDock:Landroid/widget/LinearLayout;


# instance fields
.field private mColumnWasCovered:Z

.field private final mContext:Landroid/content/Context;

.field private mDockTries:I

.field private mFollowPasses:I

.field private final mHandler:Landroid/os/Handler;

.field private mHasProfile:Z

.field private mPrivacyH:I

.field private mPrivacyPosted:Z

.field private mPrivacyX:I

.field private mPrivacyY:I

.field private mProfileH:I

.field private mProfileX:I

.field private mProfileY:I

.field private final mRailTick:Ljava/lang/Runnable;

.field private mReady:Z

.field private mReapplyVariant:Z

.field private mStatusCount:I

.field private final mStatusH:[I

.field private final mStatusW:[I

.field private final mStatusX:[I

.field private final mStatusY:[I

.field private mThemePasses:I

.field private mWidgetPage:I

.field private mWidgetRail:Landroid/view/View;

.field private mWidgetWm:Landroid/view/WindowManager;


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 88
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "launcher_status_wifi_slot"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "launcher_status_bluetooth_slot"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "launcher_status_brightness_slot"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "launcher_status_volume_slot"

    aput-object v2, v0, v1

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .registers 4

    .line 142
    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    .line 110
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    .line 111
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusY:[I

    .line 112
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusW:[I

    .line 113
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusH:[I

    .line 123
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mRailTick:Ljava/lang/Runnable;

    .line 143
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    .line 144
    iput-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    .line 145
    return-void
.end method

.method static synthetic access$000(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/view/View;
    .registers 1

    .line 64
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    return-object p0
.end method

.method static synthetic access$100(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/content/Context;
    .registers 1

    .line 64
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic access$200(Landroid/content/Context;)Z
    .registers 1

    .line 64
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$300(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Z
    .registers 1

    .line 64
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->widgetColumnCovered()Z

    move-result p0

    return p0
.end method

.method static synthetic access$400(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Z
    .registers 1

    .line 64
    iget-boolean p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mColumnWasCovered:Z

    return p0
.end method

.method static synthetic access$402(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Z)Z
    .registers 2

    .line 64
    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mColumnWasCovered:Z

    return p1
.end method

.method static synthetic access$500(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)I
    .registers 1

    .line 64
    iget p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    return p0
.end method

.method static synthetic access$600(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Ljava/lang/String;)V
    .registers 2

    .line 64
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$700(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/os/Handler;
    .registers 1

    .line 64
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$800(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;F)I
    .registers 2

    .line 64
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dp(F)I

    move-result p0

    return p0
.end method

.method static synthetic access$900(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;I)V
    .registers 2

    .line 64
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->stepWidgetPage(I)V

    return-void
.end method

.method private applyDockOrientation()V
    .registers 5

    .line 314
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->cachedDock()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 315
    if-nez v0, :cond_1a

    .line 316
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDock()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 317
    if-eqz v0, :cond_1a

    .line 318
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 319
    const-string v1, "LayoutVariant"

    const-string v2, "found dock"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    :cond_1a
    if-nez v0, :cond_30

    .line 323
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    const/16 v1, 0x8

    if-ge v0, v1, :cond_2f

    .line 324
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    .line 325
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    const-wide/16 v1, 0x3e8

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 327
    :cond_2f
    return-void

    .line 331
    :cond_30
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    .line 332
    if-eqz v1, :cond_44

    invoke-virtual {v1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v3

    if-eq v2, v3, :cond_44

    .line 333
    invoke-virtual {v1, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 334
    return-void

    .line 336
    :cond_44
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 337
    return-void
.end method

.method private static applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V
    .registers 4

    .line 425
    if-eqz p0, :cond_28

    if-nez p1, :cond_5

    goto :goto_28

    .line 428
    :cond_5
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    .line 429
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p0

    .line 431
    const/4 v1, 0x1

    if-eqz v0, :cond_15

    if-eq v0, v1, :cond_15

    if-nez p0, :cond_15

    .line 432
    return-void

    .line 434
    :cond_15
    if-ne v0, v1, :cond_1a

    if-nez p0, :cond_1a

    goto :goto_1b

    :cond_1a
    const/4 v1, 0x0

    .line 436
    :goto_1b
    :try_start_1b
    invoke-static {p1, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientationOnViewThread(Landroid/widget/LinearLayout;Z)V
    :try_end_1e
    .catchall {:try_start_1b .. :try_end_1e} :catchall_1f

    .line 439
    goto :goto_27

    .line 437
    :catchall_1f
    move-exception p0

    .line 438
    const-string p1, "LayoutVariant"

    const-string v0, "dock orientation failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 440
    :goto_27
    return-void

    .line 426
    :cond_28
    :goto_28
    return-void
.end method

.method private static applyDockOrientationOnViewThread(Landroid/widget/LinearLayout;Z)V
    .registers 11

    .line 443
    invoke-virtual {p0, p1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 444
    const/4 v0, 0x0

    move v1, v0

    :goto_5
    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_65

    .line 445
    invoke-virtual {p0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 446
    instance-of v3, v2, Landroid/widget/ImageButton;

    if-eqz v3, :cond_17

    .line 447
    invoke-static {v2, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyIconGap(Landroid/view/View;Z)V

    .line 448
    goto :goto_62

    .line 450
    :cond_17
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    instance-of v3, v3, Landroid/widget/LinearLayout$LayoutParams;

    if-nez v3, :cond_20

    .line 451
    goto :goto_62

    .line 453
    :cond_20
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/widget/LinearLayout$LayoutParams;

    .line 454
    invoke-static {v2, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dividerSpec(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I

    move-result-object v4

    .line 455
    if-nez v4, :cond_2d

    .line 456
    goto :goto_62

    .line 458
    :cond_2d
    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    if-eqz p1, :cond_49

    .line 459
    aget v7, v4, v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 460
    aget v7, v4, v0

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 461
    aget v6, v4, v6

    iput v6, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 462
    aget v4, v4, v5

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 463
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 464
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    goto :goto_5f

    .line 466
    :cond_49
    aget v8, v4, v0

    iput v8, v3, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 467
    aget v7, v4, v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 468
    iput v0, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 469
    iput v0, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 470
    aget v6, v4, v6

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 471
    aget v4, v4, v5

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    .line 473
    :goto_5f
    invoke-virtual {v2, v3}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 444
    :goto_62
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 475
    :cond_65
    return-void
.end method

.method private static applyIconGap(Landroid/view/View;Z)V
    .registers 6

    .line 479
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    instance-of v0, v0, Landroid/widget/LinearLayout$LayoutParams;

    if-nez v0, :cond_9

    .line 480
    return-void

    .line 482
    :cond_9
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout$LayoutParams;

    .line 483
    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->iconGap(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I

    move-result-object v1

    .line 484
    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz p1, :cond_26

    .line 485
    aget p1, v1, v3

    iput p1, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 486
    aget p1, v1, v2

    iput p1, v0, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 487
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 488
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    goto :goto_34

    .line 490
    :cond_26
    iput v3, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 491
    iput v3, v0, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 492
    aget p1, v1, v3

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 493
    aget p1, v1, v2

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    .line 495
    :goto_34
    invoke-virtual {p0, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 496
    return-void
.end method

.method public static attachDock(Landroid/view/View;)V
    .registers 3

    .line 226
    instance-of v0, p0, Landroid/widget/LinearLayout;

    if-nez v0, :cond_5

    .line 227
    return-void

    .line 229
    :cond_5
    move-object v0, p0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 230
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 231
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->watchDock(Landroid/widget/LinearLayout;)V

    .line 232
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 233
    return-void
.end method

.method private static cachedDock()Landroid/widget/LinearLayout;
    .registers 3

    .line 305
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    if-eqz v0, :cond_e

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    goto :goto_f

    :cond_e
    move-object v0, v1

    .line 306
    :goto_f
    if-eqz v0, :cond_1a

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->isAttachedToWindow()Z

    move-result v2

    if-nez v2, :cond_1a

    .line 307
    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 308
    return-object v1

    .line 310
    :cond_1a
    return-object v0
.end method

.method private static containsMicOrCameraChip(Landroid/view/View;)Z
    .registers 5

    .line 789
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    .line 790
    const-string v1, "MicPrivacyChip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_37

    const-string v1, "CameraPrivacyChip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1a

    goto :goto_37

    .line 793
    :cond_1a
    instance-of v0, p0, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    if-eqz v0, :cond_36

    .line 794
    check-cast p0, Landroid/view/ViewGroup;

    .line 795
    move v0, v1

    :goto_22
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v0, v3, :cond_36

    .line 796
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->containsMicOrCameraChip(Landroid/view/View;)Z

    move-result v3

    if-eqz v3, :cond_33

    .line 797
    return v2

    .line 795
    :cond_33
    add-int/lit8 v0, v0, 0x1

    goto :goto_22

    .line 801
    :cond_36
    return v1

    .line 791
    :cond_37
    :goto_37
    return v2
.end method

.method private dispatch(Ljava/lang/String;)V
    .registers 9

    .line 868
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 869
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

    .line 870
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getScalableUIEventDispatcher"

    new-array v4, v3, [Ljava/lang/Class;

    .line 871
    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 872
    new-instance v1, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v1, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v1

    .line 873
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v4, "executeEvent"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const-class v6, Lcom/android/car/scalableui/model/Event;

    aput-object v6, v5, v3

    .line 874
    invoke-virtual {v2, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 875
    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4c
    .catchall {:try_start_0 .. :try_end_4c} :catchall_4d

    .line 894
    goto :goto_b7

    .line 876
    :catchall_4d
    move-exception v0

    .line 877
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

    const-string v2, "LayoutVariant"

    invoke-static {v2, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 879
    :try_start_6c
    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v0, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    .line 882
    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    .line 880
    invoke-static {v0}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    move-result-object v0

    .line 883
    if-eqz v0, :cond_9f

    .line 885
    invoke-virtual {v0}, Lcom/android/car/scalableui/model/PanelTransaction;->getAnimators()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_83
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9f

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 886
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_9e

    .line 887
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/animation/Animator;

    invoke-virtual {v1}, Landroid/animation/Animator;->start()V
    :try_end_9e
    .catchall {:try_start_6c .. :try_end_9e} :catchall_a0

    .line 889
    :cond_9e
    goto :goto_83

    .line 893
    :cond_9f
    goto :goto_b7

    .line 891
    :catchall_a0
    move-exception v0

    .line 892
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

    .line 895
    :goto_b7
    return-void
.end method

.method private static dividerSpec(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I
    .registers 5

    .line 827
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    .line 828
    instance-of v1, v0, [I

    if-eqz v1, :cond_11

    .line 829
    check-cast v0, [I

    check-cast v0, [I

    .line 830
    array-length v1, v0

    const/4 v2, 0x4

    if-ne v1, v2, :cond_11

    .line 831
    return-object v0

    .line 834
    :cond_11
    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    if-lez v0, :cond_2e

    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->height:I

    if-gtz v0, :cond_1a

    goto :goto_2e

    .line 837
    :cond_1a
    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    iget v1, p1, Landroid/widget/LinearLayout$LayoutParams;->height:I

    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginStart()I

    move-result v2

    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginEnd()I

    move-result p1

    filled-new-array {v0, v1, v2, p1}, [I

    move-result-object p1

    .line 838
    invoke-virtual {p0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 839
    return-object p1

    .line 835
    :cond_2e
    :goto_2e
    const/4 p0, 0x0

    return-object p0
.end method

.method private dp(F)I
    .registers 3

    .line 975
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, v0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    return p1
.end method

.method private static entryNameOf(Landroid/view/View;)Ljava/lang/String;
    .registers 4

    .line 777
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    move-result v0

    .line 778
    const/4 v1, -0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_9

    .line 779
    return-object v2

    .line 782
    :cond_9
    :try_start_9
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getResourceEntryName(I)Ljava/lang/String;

    move-result-object p0
    :try_end_11
    .catchall {:try_start_9 .. :try_end_11} :catchall_12

    return-object p0

    .line 783
    :catchall_12
    move-exception p0

    .line 784
    return-object v2
.end method

.method private static findDock()Landroid/widget/LinearLayout;
    .registers 8

    .line 342
    const-string v0, "LayoutVariant"

    const/4 v1, 0x0

    :try_start_3
    const-string v2, "android.view.WindowManagerGlobal"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 343
    const-string v3, "getInstance"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    new-array v5, v4, [Ljava/lang/Object;

    invoke-virtual {v3, v1, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 344
    const-string v5, "mViews"

    invoke-static {v3, v2, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockInList(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v5

    .line 345
    if-eqz v5, :cond_21

    .line 346
    return-object v5

    .line 348
    :cond_21
    const-string v5, "mWindowlessRoots"

    invoke-virtual {v2, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 349
    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 350
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 351
    instance-of v3, v2, Ljava/util/List;

    if-nez v3, :cond_34

    .line 352
    return-object v1

    .line 354
    :cond_34
    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_3a
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_67

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 355
    if-nez v3, :cond_47

    .line 356
    goto :goto_3a

    .line 358
    :cond_47
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    const-string v6, "getView"

    new-array v7, v4, [Ljava/lang/Class;

    invoke-virtual {v5, v6, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    new-array v6, v4, [Ljava/lang/Object;

    invoke-virtual {v5, v3, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 359
    instance-of v5, v3, Landroid/view/View;

    if-eqz v5, :cond_66

    .line 360
    check-cast v3, Landroid/view/View;

    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 361
    if-eqz v3, :cond_66

    .line 362
    return-object v3

    .line 365
    :cond_66
    goto :goto_3a

    .line 366
    :cond_67
    const-string v2, "dock not found"

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6c
    .catchall {:try_start_3 .. :try_end_6c} :catchall_6d

    .line 369
    goto :goto_73

    .line 367
    :catchall_6d
    move-exception v2

    .line 368
    const-string v3, "dock search failed"

    invoke-static {v0, v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 370
    :goto_73
    return-object v1
.end method

.method private static findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;
    .registers 8

    .line 393
    instance-of v0, p0, Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    if-eqz v0, :cond_3c

    .line 394
    move-object v0, p0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 395
    nop

    .line 396
    nop

    .line 397
    move v2, v1

    move v3, v2

    move v4, v3

    :goto_d
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v5

    if-ge v2, v5, :cond_30

    .line 398
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    .line 399
    instance-of v6, v5, Landroid/widget/ImageButton;

    if-nez v6, :cond_1c

    .line 400
    goto :goto_2d

    .line 402
    :cond_1c
    add-int/lit8 v4, v4, 0x1

    .line 403
    invoke-virtual {v5}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v5

    .line 404
    if-eqz v5, :cond_2d

    const-string v6, "Home"

    invoke-virtual {v6, v5}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_2d

    .line 405
    const/4 v3, 0x1

    .line 397
    :cond_2d
    :goto_2d
    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    .line 408
    :cond_30
    if-eqz v3, :cond_3c

    const/4 v2, 0x5

    if-lt v4, v2, :cond_3c

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->isAttachedToWindow()Z

    move-result v2

    if-eqz v2, :cond_3c

    .line 409
    return-object v0

    .line 412
    :cond_3c
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_57

    .line 413
    check-cast p0, Landroid/view/ViewGroup;

    .line 414
    nop

    :goto_43
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v1, v0, :cond_57

    .line 415
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 416
    if-eqz v0, :cond_54

    .line 417
    return-object v0

    .line 414
    :cond_54
    add-int/lit8 v1, v1, 0x1

    goto :goto_43

    .line 421
    :cond_57
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findDockInList(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            ")",
            "Landroid/widget/LinearLayout;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 375
    invoke-virtual {p1, p2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    .line 376
    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 377
    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 378
    instance-of p1, p0, Ljava/util/List;

    const/4 p2, 0x0

    if-nez p1, :cond_12

    .line 379
    return-object p2

    .line 381
    :cond_12
    check-cast p0, Ljava/util/List;

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_18
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result p1

    if-eqz p1, :cond_30

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    .line 382
    instance-of v0, p1, Landroid/view/View;

    if-eqz v0, :cond_2f

    .line 383
    check-cast p1, Landroid/view/View;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object p1

    .line 384
    if-eqz p1, :cond_2f

    .line 385
    return-object p1

    .line 388
    :cond_2f
    goto :goto_18

    .line 389
    :cond_30
    return-object p2
.end method

.method private static findNamed(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;
    .registers 4

    .line 761
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->entryNameOf(Landroid/view/View;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    .line 762
    return-object p0

    .line 764
    :cond_b
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_26

    .line 765
    check-cast p0, Landroid/view/ViewGroup;

    .line 766
    const/4 v0, 0x0

    :goto_12
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_26

    .line 767
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-static {v1, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findNamed(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 768
    if-eqz v1, :cond_23

    .line 769
    return-object v1

    .line 766
    :cond_23
    add-int/lit8 v0, v0, 0x1

    goto :goto_12

    .line 773
    :cond_26
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findNamedView(Ljava/lang/String;)Landroid/view/View;
    .registers 8

    .line 734
    const/4 v0, 0x0

    :try_start_1
    const-string v1, "android.view.WindowManagerGlobal"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 735
    const-string v2, "getInstance"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    new-array v4, v3, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 736
    const-string v4, "mWindowlessRoots"

    invoke-virtual {v1, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 737
    const/4 v4, 0x1

    invoke-virtual {v1, v4}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 738
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 739
    instance-of v2, v1, Ljava/util/List;

    if-nez v2, :cond_29

    .line 740
    return-object v0

    .line 742
    :cond_29
    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_2f
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5c

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 743
    if-nez v2, :cond_3c

    .line 744
    goto :goto_2f

    .line 746
    :cond_3c
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    const-string v5, "getView"

    new-array v6, v3, [Ljava/lang/Class;

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    new-array v5, v3, [Ljava/lang/Object;

    invoke-virtual {v4, v2, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 747
    instance-of v4, v2, Landroid/view/View;

    if-eqz v4, :cond_5b

    .line 748
    check-cast v2, Landroid/view/View;

    invoke-static {v2, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findNamed(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v2
    :try_end_58
    .catchall {:try_start_1 .. :try_end_58} :catchall_5d

    .line 749
    if-eqz v2, :cond_5b

    .line 750
    return-object v2

    .line 753
    :cond_5b
    goto :goto_2f

    .line 756
    :cond_5c
    goto :goto_76

    .line 754
    :catchall_5d
    move-exception v1

    .line 755
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "anchor search failed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v2, "LayoutVariant"

    invoke-static {v2, p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 757
    :goto_76
    return-object v0
.end method

.method static getVariant(Landroid/content/Context;)I
    .registers 3

    .line 843
    const/4 v0, 0x0

    if-nez p0, :cond_4

    .line 844
    return v0

    .line 846
    :cond_4
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "scalable_ui_layout_variant"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0

    .line 847
    if-ltz p0, :cond_15

    const/4 v1, 0x4

    if-lt p0, v1, :cond_14

    goto :goto_15

    .line 850
    :cond_14
    return p0

    .line 848
    :cond_15
    :goto_15
    return v0
.end method

.method private hideWidgetRail()V
    .registers 4

    .line 1026
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mRailTick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 1027
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    .line 1028
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetWm:Landroid/view/WindowManager;

    .line 1029
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    .line 1030
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetWm:Landroid/view/WindowManager;

    .line 1031
    if-eqz v0, :cond_22

    if-nez v1, :cond_15

    goto :goto_22

    .line 1035
    :cond_15
    :try_start_15
    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_18
    .catchall {:try_start_15 .. :try_end_18} :catchall_19

    .line 1038
    goto :goto_21

    .line 1036
    :catchall_19
    move-exception v0

    .line 1037
    const-string v1, "LayoutVariant"

    const-string v2, "remove widget rail"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1039
    :goto_21
    return-void

    .line 1032
    :cond_22
    :goto_22
    return-void
.end method

.method private static iconGap(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I
    .registers 5

    .line 500
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    .line 501
    instance-of v1, v0, [I

    if-eqz v1, :cond_11

    .line 502
    check-cast v0, [I

    check-cast v0, [I

    .line 503
    array-length v1, v0

    const/4 v2, 0x2

    if-ne v1, v2, :cond_11

    .line 504
    return-object v0

    .line 507
    :cond_11
    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginStart()I

    move-result v0

    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginEnd()I

    move-result p1

    filled-new-array {v0, p1}, [I

    move-result-object p1

    .line 508
    invoke-virtual {p0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 509
    return-object p1
.end method

.method private static isPortrait(Landroid/content/Context;)Z
    .registers 4

    .line 854
    const-class v0, Landroid/hardware/display/DisplayManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/hardware/display/DisplayManager;

    .line 855
    const/4 v0, 0x1

    if-nez p0, :cond_c

    .line 856
    return v0

    .line 858
    :cond_c
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object p0

    .line 859
    if-nez p0, :cond_14

    .line 860
    return v0

    .line 862
    :cond_14
    invoke-virtual {p0}, Landroid/view/Display;->getRotation()I

    move-result p0

    .line 863
    if-eqz p0, :cond_1f

    const/4 v2, 0x2

    if-ne p0, v2, :cond_1e

    goto :goto_1f

    :cond_1e
    move v0, v1

    :cond_1f
    :goto_1f
    return v0
.end method

.method private static launcherPanelWindows()Ljava/util/List;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 707
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 708
    const-string v1, "android.view.WindowManagerGlobal"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 709
    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    const-string v4, "getInstance"

    invoke-virtual {v1, v4, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    const/4 v4, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 710
    const-string v3, "mViews"

    invoke-virtual {v1, v3}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 711
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 712
    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 713
    instance-of v2, v1, Ljava/util/List;

    if-nez v2, :cond_2e

    .line 714
    return-object v0

    .line 716
    :cond_2e
    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_34
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_68

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 717
    instance-of v3, v2, Landroid/view/View;

    if-nez v3, :cond_43

    .line 718
    goto :goto_34

    .line 720
    :cond_43
    check-cast v2, Landroid/view/View;

    .line 721
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    instance-of v3, v3, Landroid/view/WindowManager$LayoutParams;

    if-nez v3, :cond_4e

    .line 722
    goto :goto_34

    .line 724
    :cond_4e
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 725
    invoke-virtual {v3}, Landroid/view/WindowManager$LayoutParams;->getTitle()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "LauncherQcPanel"

    invoke-virtual {v4, v3}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_67

    .line 726
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 728
    :cond_67
    goto :goto_34

    .line 729
    :cond_68
    return-object v0
.end method

.method private moveStatusWindows(Landroid/view/WindowManager;)V
    .registers 14

    .line 626
    const-string v0, "LayoutVariant"

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    if-gtz v1, :cond_7

    .line 627
    return-void

    .line 629
    :cond_7
    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v1, v1

    new-array v2, v1, [Landroid/view/View;

    .line 630
    nop

    .line 633
    :try_start_d
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->launcherPanelWindows()Ljava/util/List;

    move-result-object v3
    :try_end_11
    .catchall {:try_start_d .. :try_end_11} :catchall_12f

    .line 637
    nop

    .line 638
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    const/4 v4, 0x0

    move v5, v4

    :cond_18
    :goto_18
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_40

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/View;

    .line 639
    invoke-static {v6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->containsMicOrCameraChip(Landroid/view/View;)Z

    move-result v7

    if-eqz v7, :cond_2b

    .line 640
    goto :goto_18

    .line 642
    :cond_2b
    nop

    .line 643
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v7

    check-cast v7, Landroid/view/WindowManager$LayoutParams;

    .line 644
    iget v7, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    const/16 v8, 0x5a

    if-ge v7, v8, :cond_18

    if-lt v5, v1, :cond_3b

    .line 645
    goto :goto_18

    .line 647
    :cond_3b
    aput-object v6, v2, v5

    .line 648
    add-int/lit8 v5, v5, 0x1

    .line 649
    goto :goto_18

    .line 650
    :cond_40
    const/4 v1, 0x1

    move v3, v1

    :goto_42
    if-ge v3, v5, :cond_6b

    .line 651
    aget-object v6, v2, v3

    .line 652
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v7

    check-cast v7, Landroid/view/WindowManager$LayoutParams;

    iget v7, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 653
    move v8, v3

    .line 654
    :goto_4f
    if-lez v8, :cond_66

    add-int/lit8 v9, v8, -0x1

    aget-object v10, v2, v9

    invoke-virtual {v10}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v10

    check-cast v10, Landroid/view/WindowManager$LayoutParams;

    iget v10, v10, Landroid/view/WindowManager$LayoutParams;->x:I

    if-le v10, v7, :cond_66

    .line 655
    aget-object v9, v2, v9

    aput-object v9, v2, v8

    .line 656
    add-int/lit8 v8, v8, -0x1

    goto :goto_4f

    .line 658
    :cond_66
    aput-object v6, v2, v8

    .line 650
    add-int/lit8 v3, v3, 0x1

    goto :goto_42

    .line 660
    :cond_6b
    iget v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    new-array v3, v3, [I

    .line 661
    move v6, v4

    :goto_70
    iget v7, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    if-ge v6, v7, :cond_79

    .line 662
    aput v6, v3, v6

    .line 661
    add-int/lit8 v6, v6, 0x1

    goto :goto_70

    .line 664
    :cond_79
    nop

    :goto_7a
    iget v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    if-ge v1, v6, :cond_9d

    .line 665
    aget v6, v3, v1

    .line 666
    iget-object v7, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    aget v7, v7, v6

    .line 667
    move v8, v1

    .line 668
    :goto_85
    if-lez v8, :cond_98

    iget-object v9, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    add-int/lit8 v10, v8, -0x1

    aget v11, v3, v10

    aget v9, v9, v11

    if-le v9, v7, :cond_98

    .line 669
    aget v9, v3, v10

    aput v9, v3, v8

    .line 670
    add-int/lit8 v8, v8, -0x1

    goto :goto_85

    .line 672
    :cond_98
    aput v6, v3, v8

    .line 664
    add-int/lit8 v1, v1, 0x1

    goto :goto_7a

    .line 674
    :cond_9d
    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    if-ge v5, v1, :cond_a2

    goto :goto_a4

    :cond_a2
    iget v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    .line 675
    :goto_a4
    nop

    :goto_a5
    if-ge v4, v5, :cond_12e

    .line 676
    aget v1, v3, v4

    .line 677
    aget-object v6, v2, v4

    .line 678
    nop

    .line 679
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v7

    check-cast v7, Landroid/view/WindowManager$LayoutParams;

    .line 680
    iget v8, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v9, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    aget v9, v9, v1

    if-ne v8, v9, :cond_d3

    iget v8, v7, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v9, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusY:[I

    aget v9, v9, v1

    if-ne v8, v9, :cond_d3

    iget v8, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v9, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusW:[I

    aget v9, v9, v1

    if-ne v8, v9, :cond_d3

    iget v8, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    iget-object v9, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusH:[I

    aget v9, v9, v1

    if-ne v8, v9, :cond_d3

    .line 682
    goto :goto_12a

    .line 684
    :cond_d3
    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    aget v8, v8, v1

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 685
    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusY:[I

    aget v8, v8, v1

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 686
    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusW:[I

    aget v8, v8, v1

    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 687
    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusH:[I

    aget v1, v8, v1

    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 688
    invoke-interface {p1, v6, v7}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 689
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "status slot -> "

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v6, v7, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, ","

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v6, v7, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, " "

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v6, v7, Landroid/view/WindowManager$LayoutParams;->width:I

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v6, "x"

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v6, v7, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 675
    :goto_12a
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_a5

    .line 692
    :cond_12e
    return-void

    .line 634
    :catchall_12f
    move-exception p1

    .line 635
    const-string v1, "status windows"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 636
    return-void
.end method

.method private static moveWindow(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;IIILjava/lang/String;)V
    .registers 8

    .line 696
    iget v0, p2, Landroid/view/WindowManager$LayoutParams;->x:I

    if-ne v0, p3, :cond_d

    iget v0, p2, Landroid/view/WindowManager$LayoutParams;->y:I

    if-ne v0, p4, :cond_d

    iget v0, p2, Landroid/view/WindowManager$LayoutParams;->height:I

    if-ne v0, p5, :cond_d

    .line 697
    return-void

    .line 699
    :cond_d
    iput p3, p2, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 700
    iput p4, p2, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 701
    iput p5, p2, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 702
    invoke-interface {p0, p1, p2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 703
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, p6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " chip -> "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ","

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " h="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "LayoutVariant"

    invoke-static {p1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 704
    return-void
.end method

.method public static onOrientationApplied(Z)V
    .registers 3

    .line 209
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    .line 210
    if-nez v0, :cond_5

    .line 211
    return-void

    .line 213
    :cond_5
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReady:Z

    .line 214
    if-nez p0, :cond_e

    .line 215
    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->postCurrent()V

    goto :goto_14

    .line 217
    :cond_e
    const/4 p0, 0x0

    iput p0, v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    .line 218
    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->hideWidgetRail()V

    .line 220
    :goto_14
    const/16 p0, 0x8

    iput p0, v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    .line 221
    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 222
    return-void
.end method

.method private static panelBounds(Ljava/lang/String;)Landroid/graphics/Rect;
    .registers 6

    .line 806
    :try_start_0
    const-string v0, "com.android.car.scalableui.manager.StateManager"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 808
    const-string v1, "getPanelState"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const-class v3, Ljava/lang/String;

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v1

    .line 809
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 810
    if-eqz v0, :cond_5a

    .line 811
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getCurrentVariant"

    new-array v3, v4, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 812
    if-eqz v0, :cond_5a

    .line 813
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getBounds"

    new-array v3, v4, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 814
    instance-of v1, v0, Landroid/graphics/Rect;

    if-eqz v1, :cond_5a

    move-object v1, v0

    check-cast v1, Landroid/graphics/Rect;

    invoke-virtual {v1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_5a

    .line 815
    new-instance v1, Landroid/graphics/Rect;

    check-cast v0, Landroid/graphics/Rect;

    invoke-direct {v1, v0}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V
    :try_end_59
    .catchall {:try_start_0 .. :try_end_59} :catchall_5b

    return-object v1

    .line 821
    :cond_5a
    goto :goto_74

    .line 819
    :catchall_5b
    move-exception v0

    .line 820
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "panel bounds "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v1, "LayoutVariant"

    invoke-static {v1, p0, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 822
    :goto_74
    new-instance p0, Landroid/graphics/Rect;

    invoke-direct {p0}, Landroid/graphics/Rect;-><init>()V

    return-object p0
.end method

.method private panelVariantName(Ljava/lang/String;)Ljava/lang/String;
    .registers 8

    .line 956
    const/4 v0, 0x0

    :try_start_1
    const-string v1, "com.android.car.scalableui.manager.StateManager"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 958
    const-string v2, "getPanelState"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const-class v4, Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 959
    invoke-virtual {v1, v0, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 960
    if-nez p1, :cond_20

    .line 961
    return-object v0

    .line 963
    :cond_20
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getCurrentVariant"

    new-array v3, v5, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v1, p1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 964
    if-nez p1, :cond_35

    .line 965
    return-object v0

    .line 967
    :cond_35
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getIdName"

    new-array v3, v5, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v5, [Ljava/lang/Object;

    invoke-virtual {v1, p1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 968
    instance-of v1, p1, Ljava/lang/String;

    if-eqz v1, :cond_4e

    check-cast p1, Ljava/lang/String;
    :try_end_4d
    .catchall {:try_start_1 .. :try_end_4d} :catchall_4f

    move-object v0, p1

    :cond_4e
    return-object v0

    .line 969
    :catchall_4f
    move-exception p1

    .line 970
    return-object v0
.end method

.method private placePrivacyChip()V
    .registers 7

    .line 519
    :try_start_0
    const-string v0, "launcher_pill_right"

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->panelBounds(Ljava/lang/String;)Landroid/graphics/Rect;

    move-result-object v0

    .line 520
    invoke-virtual {v0}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_d

    .line 521
    return-void

    .line 523
    :cond_d
    const-string v1, "launcher_privacy_chips"

    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findNamedView(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 524
    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_2f

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v4

    if-lez v4, :cond_2f

    .line 525
    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->screenPoint(Landroid/view/View;Landroid/graphics/Rect;)[I

    move-result-object v4

    .line 526
    aget v5, v4, v2

    iput v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyX:I

    .line 527
    aget v4, v4, v3

    iput v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyY:I

    .line 528
    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v1

    iput v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyH:I

    .line 530
    :cond_2f
    const-string v1, "launcher_user_anchor"

    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findNamedView(Ljava/lang/String;)Landroid/view/View;

    move-result-object v1

    .line 531
    if-eqz v1, :cond_3f

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v4

    if-lez v4, :cond_3f

    move v4, v3

    goto :goto_40

    :cond_3f
    move v4, v2

    :goto_40
    iput-boolean v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHasProfile:Z

    .line 532
    iget-boolean v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHasProfile:Z

    if-eqz v4, :cond_58

    .line 533
    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->screenPoint(Landroid/view/View;Landroid/graphics/Rect;)[I

    move-result-object v0

    .line 534
    aget v2, v0, v2

    iput v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileX:I

    .line 535
    aget v0, v0, v3

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileY:I

    .line 536
    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v0

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileH:I

    .line 538
    :cond_58
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->placeStatusSlots()V

    .line 539
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyPosted:Z

    if-eqz v0, :cond_60

    .line 540
    return-void

    .line 542
    :cond_60
    iput-boolean v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyPosted:Z

    .line 543
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_67
    .catchall {:try_start_0 .. :try_end_67} :catchall_68

    .line 546
    goto :goto_70

    .line 544
    :catchall_68
    move-exception v0

    .line 545
    const-string v1, "LayoutVariant"

    const-string v2, "privacy chip place failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 547
    :goto_70
    return-void
.end method

.method private placeStatusSlots()V
    .registers 9

    .line 555
    const-string v0, "launcher_pill_left"

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->panelBounds(Ljava/lang/String;)Landroid/graphics/Rect;

    move-result-object v0

    .line 556
    invoke-virtual {v0}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_10

    .line 557
    iput v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    .line 558
    return-void

    .line 560
    :cond_10
    nop

    .line 561
    move v1, v2

    move v3, v1

    :goto_13
    sget-object v4, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    array-length v4, v4

    if-ge v1, v4, :cond_55

    .line 562
    sget-object v4, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->STATUS_SLOTS:[Ljava/lang/String;

    aget-object v4, v4, v1

    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findNamedView(Ljava/lang/String;)Landroid/view/View;

    move-result-object v4

    .line 563
    if-eqz v4, :cond_52

    invoke-virtual {v4}, Landroid/view/View;->getWidth()I

    move-result v5

    if-lez v5, :cond_52

    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v5

    if-gtz v5, :cond_2f

    .line 564
    goto :goto_52

    .line 566
    :cond_2f
    invoke-static {v4, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->screenPoint(Landroid/view/View;Landroid/graphics/Rect;)[I

    move-result-object v5

    .line 567
    iget-object v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusX:[I

    aget v7, v5, v2

    aput v7, v6, v3

    .line 568
    iget-object v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusY:[I

    const/4 v7, 0x1

    aget v5, v5, v7

    aput v5, v6, v3

    .line 569
    iget-object v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusW:[I

    invoke-virtual {v4}, Landroid/view/View;->getWidth()I

    move-result v6

    aput v6, v5, v3

    .line 570
    iget-object v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusH:[I

    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v4

    aput v4, v5, v3

    .line 571
    add-int/lit8 v3, v3, 0x1

    .line 561
    :cond_52
    :goto_52
    add-int/lit8 v1, v1, 0x1

    goto :goto_13

    .line 573
    :cond_55
    iput v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mStatusCount:I

    .line 574
    return-void
.end method

.method private postCurrent()V
    .registers 5

    .line 297
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    .line 298
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "layout_variant_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 299
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "event="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "LayoutVariant"

    invoke-static {v3, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 300
    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V

    .line 301
    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->syncWidgetRail(I)V

    .line 302
    return-void
.end method

.method private static screenPoint(Landroid/view/View;Landroid/graphics/Rect;)[I
    .registers 6

    .line 578
    const/4 v0, 0x2

    new-array v1, v0, [I

    .line 579
    invoke-virtual {p0, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 580
    new-array v0, v0, [I

    .line 581
    invoke-virtual {p0}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object p0

    .line 582
    if-eqz p0, :cond_11

    .line 583
    invoke-virtual {p0, v0}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 585
    :cond_11
    iget p0, p1, Landroid/graphics/Rect;->left:I

    const/4 v2, 0x0

    aget v3, v1, v2

    add-int/2addr p0, v3

    aget v2, v0, v2

    sub-int/2addr p0, v2

    iget p1, p1, Landroid/graphics/Rect;->top:I

    const/4 v2, 0x1

    aget v1, v1, v2

    add-int/2addr p1, v1

    aget v0, v0, v2

    sub-int/2addr p1, v0

    filled-new-array {p0, p1}, [I

    move-result-object p0

    return-object p0
.end method

.method private showWidgetRail()V
    .registers 14

    .line 979
    const-string v1, "LayoutVariant"

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    if-eqz v0, :cond_c

    .line 980
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->invalidate()V

    .line 981
    return-void

    .line 984
    :cond_c
    const/4 v2, 0x0

    :try_start_d
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    const-class v3, Landroid/hardware/display/DisplayManager;

    invoke-virtual {v0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/display/DisplayManager;

    .line 985
    const/4 v3, 0x0

    if-nez v0, :cond_1c

    move-object v0, v2

    goto :goto_20

    .line 986
    :cond_1c
    invoke-virtual {v0, v3}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object v0

    .line 987
    :goto_20
    if-nez v0, :cond_23

    .line 988
    return-void

    .line 990
    :cond_23
    new-instance v4, Landroid/graphics/Point;

    invoke-direct {v4}, Landroid/graphics/Point;-><init>()V

    .line 991
    invoke-virtual {v0, v4}, Landroid/view/Display;->getRealSize(Landroid/graphics/Point;)V

    .line 992
    const/high16 v5, 0x42400000    # 48.0f

    invoke-direct {p0, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dp(F)I

    move-result v7

    .line 993
    iget v4, v4, Landroid/graphics/Point;->x:I

    const/high16 v5, 0x44040000    # 528.0f

    invoke-direct {p0, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dp(F)I

    move-result v5

    sub-int/2addr v4, v5

    .line 994
    const/high16 v5, 0x43d00000    # 416.0f

    invoke-direct {p0, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dp(F)I

    move-result v5

    .line 995
    const/high16 v6, 0x434c0000    # 204.0f

    invoke-direct {p0, v6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dp(F)I

    move-result v8

    .line 996
    iget-object v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    const/16 v9, 0x7d8

    invoke-virtual {v6, v0, v9, v2}, Landroid/content/Context;->createWindowContext(Landroid/view/Display;ILandroid/os/Bundle;)Landroid/content/Context;

    move-result-object v0

    .line 997
    const-class v6, Landroid/view/WindowManager;

    invoke-virtual {v0, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/WindowManager;

    iput-object v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetWm:Landroid/view/WindowManager;

    .line 998
    new-instance v12, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;

    invoke-direct {v12, p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Landroid/content/Context;)V

    .line 999
    new-instance v6, Landroid/view/WindowManager$LayoutParams;

    const/16 v10, 0x128

    const/4 v11, -0x3

    const/16 v9, 0x7d8

    invoke-direct/range {v6 .. v11}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    .line 1005
    const v0, 0x800033

    iput v0, v6, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 1006
    iput v4, v6, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1007
    iput v5, v6, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1008
    const-string v0, "launcher_widget_rail"

    invoke-virtual {v6, v0}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V
    :try_end_75
    .catchall {:try_start_d .. :try_end_75} :catchall_d2

    .line 1010
    :try_start_75
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v9, "setTrustedOverlay"

    new-array v10, v3, [Ljava/lang/Class;

    invoke-virtual {v0, v9, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v0, v6, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_86
    .catchall {:try_start_75 .. :try_end_86} :catchall_87

    .line 1012
    goto :goto_88

    .line 1011
    :catchall_87
    move-exception v0

    .line 1013
    :goto_88
    :try_start_88
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetWm:Landroid/view/WindowManager;

    invoke-interface {v0, v12, v6}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1014
    iput-object v12, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    .line 1015
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mRailTick:Ljava/lang/Runnable;

    invoke-virtual {v0, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 1016
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mRailTick:Ljava/lang/Runnable;

    invoke-virtual {v0, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1017
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "widget rail "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ","

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "x"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d1
    .catchall {:try_start_88 .. :try_end_d1} :catchall_d2

    .line 1022
    goto :goto_dc

    .line 1018
    :catchall_d2
    move-exception v0

    .line 1019
    const-string v3, "widget rail failed"

    invoke-static {v1, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1020
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    .line 1021
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetWm:Landroid/view/WindowManager;

    .line 1023
    :goto_dc
    return-void
.end method

.method public static start(Landroid/content/Context;)V
    .registers 6

    .line 149
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    if-nez v0, :cond_52

    if-nez p0, :cond_7

    goto :goto_52

    .line 152
    :cond_7
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 153
    if-nez v0, :cond_e

    .line 154
    goto :goto_f

    .line 153
    :cond_e
    move-object p0, v0

    .line 156
    :goto_f
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 157
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-direct {v1, p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    .line 158
    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    .line 159
    const-string v2, "scalable_ui_layout_variant"

    invoke-static {v2}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 160
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v2, v4, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 161
    invoke-virtual {p0, v1}, Landroid/content/Context;->registerComponentCallbacks(Landroid/content/ComponentCallbacks;)V

    .line 162
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "watching scalable_ui_layout_variant="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v2, "LayoutVariant"

    invoke-static {v2, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 163
    const-wide/16 v2, 0x7d0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 164
    return-void

    .line 150
    :cond_52
    :goto_52
    return-void
.end method

.method private stepWidgetPage(I)V
    .registers 4

    .line 916
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_60

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_60

    .line 917
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->widgetColumnCovered()Z

    move-result v0

    if-eqz v0, :cond_18

    goto :goto_60

    .line 920
    :cond_18
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    add-int/2addr v0, p1

    .line 921
    if-ltz v0, :cond_5f

    const/4 p1, 0x4

    if-lt v0, p1, :cond_21

    goto :goto_5f

    .line 924
    :cond_21
    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    .line 925
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "widget page "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "LayoutVariant"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 926
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "widget_page_"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V

    .line 927
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    if-eqz p1, :cond_5e

    .line 928
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    .line 930
    :cond_5e
    return-void

    .line 922
    :cond_5f
    :goto_5f
    return-void

    .line 918
    :cond_60
    :goto_60
    return-void
.end method

.method private syncWidgetRail(I)V
    .registers 3

    .line 903
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2c

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_c

    goto :goto_2c

    .line 909
    :cond_c
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->showWidgetRail()V

    .line 910
    iget p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    if-lez p1, :cond_2b

    .line 911
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "widget_page_"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V

    .line 913
    :cond_2b
    return-void

    .line 904
    :cond_2c
    :goto_2c
    const/4 p1, 0x0

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I

    .line 905
    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mColumnWasCovered:Z

    .line 906
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->hideWidgetRail()V

    .line 907
    return-void
.end method

.method private updatePrivacyWindow(III)V
    .registers 14

    .line 593
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    const-string v1, "window"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroid/view/WindowManager;

    .line 594
    if-nez v1, :cond_e

    .line 595
    return-void

    .line 597
    :cond_e
    nop

    .line 598
    nop

    .line 599
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->launcherPanelWindows()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v2, 0x0

    const/high16 v3, -0x80000000

    move-object v8, v2

    move v9, v3

    :goto_1d
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_58

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/View;

    .line 600
    nop

    .line 601
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 602
    invoke-static {v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->containsMicOrCameraChip(Landroid/view/View;)Z

    move-result v4

    if-eqz v4, :cond_42

    .line 603
    const-string v7, "privacy"

    move v4, p1

    move v5, p2

    move v6, p3

    invoke-static/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->moveWindow(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;IIILjava/lang/String;)V

    .line 604
    move p1, v4

    move p2, v5

    move p3, v6

    goto :goto_1d

    .line 608
    :cond_42
    move v4, p1

    move v5, p2

    move v6, p3

    iget p1, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    const/16 p2, 0x5a

    if-lt p1, p2, :cond_54

    iget p1, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    if-lt p1, v9, :cond_54

    .line 609
    nop

    .line 610
    iget p1, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    move v9, p1

    move-object v8, v2

    .line 612
    :cond_54
    move p1, v4

    move p2, v5

    move p3, v6

    goto :goto_1d

    .line 613
    :cond_58
    iget-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHasProfile:Z

    if-eqz p1, :cond_72

    if-eqz v8, :cond_72

    .line 614
    nop

    .line 615
    invoke-virtual {v8}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    move-object v3, p1

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    iget v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileX:I

    iget v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileY:I

    iget v6, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mProfileH:I

    const-string v7, "profile"

    .line 614
    move-object v2, v8

    invoke-static/range {v1 .. v7}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->moveWindow(Landroid/view/WindowManager;Landroid/view/View;Landroid/view/WindowManager$LayoutParams;IIILjava/lang/String;)V

    .line 618
    :cond_72
    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->moveStatusWindows(Landroid/view/WindowManager;)V
    :try_end_75
    .catchall {:try_start_0 .. :try_end_75} :catchall_76

    .line 621
    goto :goto_7f

    .line 619
    :catchall_76
    move-exception v0

    move-object p1, v0

    .line 620
    const-string p2, "LayoutVariant"

    const-string p3, "privacy chip update failed"

    invoke-static {p2, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 622
    :goto_7f
    return-void
.end method

.method private static watchDock(Landroid/widget/LinearLayout;)V
    .registers 3

    .line 258
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    if-eq v0, p0, :cond_1c

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    if-nez v0, :cond_9

    goto :goto_1c

    .line 261
    :cond_9
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_14

    .line 262
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->removeOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 264
    :cond_14
    sput-object p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    .line 265
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-virtual {p0, v0}, Landroid/widget/LinearLayout;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 266
    return-void

    .line 259
    :cond_1c
    :goto_1c
    return-void
.end method

.method private widgetColumnCovered()Z
    .registers 8

    .line 933
    const/4 v0, 0x5

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "launcher_app"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "launcher_climate_app"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const/4 v2, 0x2

    const-string v5, "launcher_vehicle_app"

    aput-object v5, v1, v2

    const/4 v2, 0x3

    const-string v5, "launcher_settings_app"

    aput-object v5, v1, v2

    const/4 v2, 0x4

    const-string v5, "panel_app_grid"

    aput-object v5, v1, v2

    .line 940
    move v2, v3

    :goto_1d
    if-ge v2, v0, :cond_5c

    aget-object v5, v1, v2

    .line 941
    invoke-direct {p0, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->panelVariantName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 942
    if-eqz v5, :cond_59

    const-string v6, "closed"

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_59

    const-string v6, "hidden"

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_59

    .line 943
    const-string v6, "behind"

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_40

    .line 944
    goto :goto_59

    .line 946
    :cond_40
    const-string v6, "opened"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_58

    const-string v6, "layout_v1"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_58

    .line 947
    const-string v6, "portrait_opened"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_59

    .line 948
    :cond_58
    return v4

    .line 940
    :cond_59
    :goto_59
    add-int/lit8 v2, v2, 0x1

    goto :goto_1d

    .line 951
    :cond_5c
    return v3
.end method


# virtual methods
.method public onChange(Z)V
    .registers 2

    .line 270
    iget-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReady:Z

    if-eqz p1, :cond_f

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_f

    .line 271
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->postCurrent()V

    .line 273
    :cond_f
    const/16 p1, 0x8

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    .line 274
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 275
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .registers 4

    .line 284
    const/4 p1, 0x0

    sput-object p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 285
    const/4 p1, 0x0

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    .line 286
    const/16 p1, 0x8

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    .line 287
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReapplyVariant:Z

    .line 288
    const/4 p1, 0x2

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mThemePasses:I

    .line 289
    const-string p1, "LayoutVariant"

    const-string v0, "theme changed, reapplying variant"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 290
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    const-wide/16 v0, 0x190

    invoke-virtual {p1, p0, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 291
    return-void
.end method

.method public onLowMemory()V
    .registers 1

    .line 294
    return-void
.end method

.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2

    .line 237
    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 4

    .line 241
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    if-ne v0, p1, :cond_7

    .line 242
    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sListeningDock:Landroid/widget/LinearLayout;

    .line 244
    :cond_7
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_14

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    goto :goto_15

    :cond_14
    move-object v0, v1

    .line 245
    :goto_15
    if-eq v0, p1, :cond_18

    .line 246
    return-void

    .line 248
    :cond_18
    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 249
    const/4 p1, 0x0

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    .line 250
    const/16 p1, 0x8

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    .line 251
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReapplyVariant:Z

    .line 252
    const/4 p1, 0x2

    iput p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mThemePasses:I

    .line 253
    const-string p1, "LayoutVariant"

    const-string v0, "dock rebuilt, reapplying variant"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 254
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    const-wide/16 v0, 0x190

    invoke-virtual {p1, p0, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 255
    return-void
.end method

.method public run()V
    .registers 4

    .line 172
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyPosted:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1d

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    invoke-virtual {v2}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    if-ne v0, v2, :cond_1d

    .line 173
    iput-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyPosted:Z

    .line 174
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyX:I

    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyY:I

    iget v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mPrivacyH:I

    invoke-direct {p0, v0, v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->updatePrivacyWindow(III)V

    .line 175
    return-void

    .line 177
    :cond_1d
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReapplyVariant:Z

    if-eqz v0, :cond_4c

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    invoke-virtual {v2}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    if-ne v0, v2, :cond_4c

    .line 178
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_38

    .line 179
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->postCurrent()V

    .line 181
    :cond_38
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mThemePasses:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mThemePasses:I

    .line 182
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mThemePasses:I

    if-lez v0, :cond_4a

    .line 183
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    const-wide/16 v1, 0x2bc

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_4c

    .line 185
    :cond_4a
    iput-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReapplyVariant:Z

    .line 188
    :cond_4c
    :goto_4c
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->cachedDock()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 189
    if-eqz v0, :cond_81

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    if-eqz v1, :cond_81

    .line 190
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v2

    if-ne v1, v2, :cond_81

    .line 191
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->watchDock(Landroid/widget/LinearLayout;)V

    .line 192
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 193
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->placePrivacyChip()V

    .line 194
    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    if-lez v1, :cond_80

    .line 195
    iget v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mFollowPasses:I

    .line 196
    const-wide/16 v1, 0x78

    invoke-virtual {v0, p0, v1, v2}, Landroid/widget/LinearLayout;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 198
    :cond_80
    return-void

    .line 200
    :cond_81
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 201
    return-void
.end method
