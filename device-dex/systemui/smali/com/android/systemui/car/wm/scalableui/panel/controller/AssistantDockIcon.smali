.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;
.super Ljava/lang/Object;
.source "AssistantDockIcon.java"


# static fields
.field private static final POLL_MS:J = 0x5dcL

.field private static final ROLE_ASSISTANT:Ljava/lang/String; = "android.app.role.ASSISTANT"

.field private static final TAG:Ljava/lang/String; = "AssistantDockIcon"

.field private static sAppliedPackage:Ljava/lang/String;

.field private static sAppliedUser:I

.field private static sButton:Landroid/widget/ImageView;

.field private static sContext:Landroid/content/Context;

.field private static final sMain:Landroid/os/Handler;

.field private static sObserver:Landroid/database/ContentObserver;

.field private static final sPoll:Ljava/lang/Runnable;

.field private static sRoleListener:Ljava/lang/Object;

.field private static sRoot:Landroid/view/View;

.field private static sUserReceiver:Landroid/content/BroadcastReceiver;

.field private static sWatching:Z


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 54
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sMain:Landroid/os/Handler;

    .line 65
    const/4 v0, -0x1

    sput v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedUser:I

    .line 67
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$1;

    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$1;-><init>()V

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sPoll:Ljava/lang/Runnable;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Landroid/widget/ImageView;
    .registers 1

    .line 50
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$002(Landroid/widget/ImageView;)Landroid/widget/ImageView;
    .registers 1

    .line 50
    sput-object p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    return-object p0
.end method

.method static synthetic access$100()Landroid/view/View;
    .registers 1

    .line 50
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$1000(Landroid/view/View;)Landroid/widget/ImageView;
    .registers 1

    .line 50
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->findAssistant(Landroid/view/View;)Landroid/widget/ImageView;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$1100(Landroid/view/View;Landroid/view/View;)Z
    .registers 2

    .line 50
    invoke-static {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->isDescendant(Landroid/view/View;Landroid/view/View;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1200()V
    .registers 0

    .line 50
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->postRefresh()V

    return-void
.end method

.method static synthetic access$1300(J)V
    .registers 2

    .line 50
    invoke-static {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->postRefreshDelayed(J)V

    return-void
.end method

.method static synthetic access$200(Landroid/view/View;)Z
    .registers 1

    .line 50
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->onViewThread(Landroid/view/View;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$300()I
    .registers 1

    .line 50
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->currentUserId()I

    move-result v0

    return v0
.end method

.method static synthetic access$400(I)Ljava/lang/String;
    .registers 1

    .line 50
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->selectedPackage(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$500()I
    .registers 1

    .line 50
    sget v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedUser:I

    return v0
.end method

.method static synthetic access$600()Ljava/lang/String;
    .registers 1

    .line 50
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedPackage:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$700(Ljava/lang/String;Ljava/lang/String;)Z
    .registers 2

    .line 50
    invoke-static {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->same(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$800()V
    .registers 0

    .line 50
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->refresh()V

    return-void
.end method

.method static synthetic access$900()V
    .registers 0

    .line 50
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->schedulePoll()V

    return-void
.end method

.method public static bind(Landroid/view/View;)V
    .registers 3

    .line 144
    if-nez p0, :cond_3

    .line 145
    return-void

    .line 147
    :cond_3
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->findAssistant(Landroid/view/View;)Landroid/widget/ImageView;

    move-result-object v0

    .line 148
    if-nez v0, :cond_a

    .line 149
    return-void

    .line 151
    :cond_a
    sput-object p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    .line 152
    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    .line 153
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 154
    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 155
    if-eqz v1, :cond_19

    move-object v0, v1

    :cond_19
    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 156
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->refresh()V

    .line 157
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->watch()V

    .line 158
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$2;

    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$2;-><init>()V

    invoke-virtual {p0, v0}, Landroid/view/View;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    .line 177
    return-void
.end method

.method private static currentUserId()I
    .registers 4

    .line 646
    const/4 v0, 0x0

    :try_start_1
    const-class v1, Landroid/app/ActivityManager;

    const-string v2, "getCurrentUser"

    new-array v3, v0, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 647
    new-array v2, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 648
    instance-of v2, v1, Ljava/lang/Integer;

    if-eqz v2, :cond_1d

    .line 649
    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_1c
    .catchall {:try_start_1 .. :try_end_1c} :catchall_1e

    return v0

    .line 652
    :cond_1d
    goto :goto_1f

    .line 651
    :catchall_1e
    move-exception v1

    .line 653
    :goto_1f
    return v0
.end method

.method private static field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .registers 5

    .line 585
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 586
    :goto_4
    if-eqz v0, :cond_19

    .line 588
    :try_start_6
    invoke-virtual {v0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 589
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 590
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_12
    .catchall {:try_start_6 .. :try_end_12} :catchall_13

    return-object p0

    .line 591
    :catchall_13
    move-exception v1

    .line 593
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_4

    .line 595
    :cond_19
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findAssistant(Landroid/view/View;)Landroid/widget/ImageView;
    .registers 3

    .line 180
    instance-of v0, p0, Landroid/widget/ImageView;

    if-eqz v0, :cond_15

    .line 181
    invoke-virtual {p0}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v0

    .line 182
    if-eqz v0, :cond_15

    const-string v1, "Assistant"

    invoke-virtual {v1, v0}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_15

    .line 183
    check-cast p0, Landroid/widget/ImageView;

    return-object p0

    .line 186
    :cond_15
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_30

    .line 187
    check-cast p0, Landroid/view/ViewGroup;

    .line 188
    const/4 v0, 0x0

    :goto_1c
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_30

    .line 189
    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->findAssistant(Landroid/view/View;)Landroid/widget/ImageView;

    move-result-object v1

    .line 190
    if-eqz v1, :cond_2d

    .line 191
    return-object v1

    .line 188
    :cond_2d
    add-int/lit8 v0, v0, 0x1

    goto :goto_1c

    .line 195
    :cond_30
    const/4 p0, 0x0

    return-object p0
.end method

.method private static intField(Ljava/lang/Object;Ljava/lang/String;)I
    .registers 2

    .line 580
    invoke-static {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 581
    instance-of p1, p0, Ljava/lang/Integer;

    if-eqz p1, :cond_f

    check-cast p0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0

    goto :goto_10

    :cond_f
    const/4 p0, -0x1

    :goto_10
    return p0
.end method

.method private static isChrome(Ljava/lang/String;)Z
    .registers 3

    .line 486
    const/4 v0, 0x1

    if-nez p0, :cond_4

    .line 487
    return v0

    .line 489
    :cond_4
    const-string v1, "com.android.systemui"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 490
    const-string v1, "com.android.car.carlauncher"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 491
    const-string v1, "com.google.android.apps.maps"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 492
    const-string v1, "com.scalableui.widgets"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 493
    const-string v1, "com.test.design"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 494
    const-string v1, "android"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 495
    const-string v1, "com.android.car.settings"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 496
    const-string v1, "com.android.car.hvac"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 497
    const-string v1, "com.android.permissioncontroller"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 498
    const-string v1, "com.google.android.permissioncontroller"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 499
    const-string v1, "com.android.packageinstaller"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 500
    const-string v1, "com.google.android.packageinstaller"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6f

    .line 501
    const-string v1, "com.android.intentresolver"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_6d

    goto :goto_6f

    :cond_6d
    const/4 v0, 0x0

    goto :goto_70

    :cond_6f
    :goto_6f
    nop

    .line 489
    :goto_70
    return v0
.end method

.method private static isDescendant(Landroid/view/View;Landroid/view/View;)Z
    .registers 3

    .line 436
    nop

    .line 437
    :goto_1
    if-eqz p1, :cond_14

    .line 438
    if-ne p1, p0, :cond_7

    .line 439
    const/4 p0, 0x1

    return p0

    .line 441
    :cond_7
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    .line 442
    instance-of v0, p1, Landroid/view/View;

    if-eqz v0, :cond_12

    check-cast p1, Landroid/view/View;

    goto :goto_13

    :cond_12
    const/4 p1, 0x0

    .line 443
    :goto_13
    goto :goto_1

    .line 444
    :cond_14
    const/4 p0, 0x0

    return p0
.end method

.method static synthetic lambda$watch$0(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .registers 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 231
    invoke-virtual {p1}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p1

    .line 232
    const-string v0, "hashCode"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_15

    .line 233
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    .line 235
    :cond_15
    const-string v0, "equals"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_2c

    .line 236
    if-nez p2, :cond_22

    goto :goto_24

    :cond_22
    aget-object v1, p2, v2

    :goto_24
    if-ne p0, v1, :cond_27

    const/4 v2, 0x1

    :cond_27
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    .line 238
    :cond_2c
    const-string p0, "toString"

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_37

    .line 239
    const-string p0, "AssistantRoleListener"

    return-object p0

    .line 241
    :cond_37
    const-string p0, "onRoleHoldersChanged"

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_51

    if-eqz p2, :cond_51

    array-length p0, p2

    if-lez p0, :cond_51

    aget-object p0, p2, v2

    .line 243
    const-string p1, "android.app.role.ASSISTANT"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_51

    .line 244
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->postRefresh()V

    .line 246
    :cond_51
    return-object v1
.end method

.method private static loadIcon(I)Landroid/graphics/drawable/Drawable;
    .registers 8

    .line 448
    const-string v0, "AssistantDockIcon"

    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->selectedPackage(I)Ljava/lang/String;

    move-result-object v1

    .line 449
    const/4 v2, 0x0

    if-nez v1, :cond_a

    .line 450
    return-object v2

    .line 452
    :cond_a
    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 453
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandle(I)Landroid/os/UserHandle;

    move-result-object p0

    .line 455
    :try_start_10
    const-class v4, Landroid/content/pm/LauncherApps;

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/pm/LauncherApps;

    .line 456
    if-eqz v4, :cond_52

    .line 457
    invoke-virtual {v4, v1, p0}, Landroid/content/pm/LauncherApps;->getActivityList(Ljava/lang/String;Landroid/os/UserHandle;)Ljava/util/List;

    move-result-object p0

    .line 458
    if-eqz p0, :cond_52

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_52

    .line 459
    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    iget v4, v4, Landroid/util/DisplayMetrics;->densityDpi:I

    .line 460
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "assistant icon from "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 461
    const/4 v5, 0x0

    invoke-interface {p0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/content/pm/LauncherActivityInfo;

    invoke-virtual {p0, v4}, Landroid/content/pm/LauncherActivityInfo;->getIcon(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0
    :try_end_51
    .catchall {:try_start_10 .. :try_end_51} :catchall_53

    return-object p0

    .line 466
    :cond_52
    goto :goto_6a

    .line 464
    :catchall_53
    move-exception p0

    .line 465
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "assistant launcher icon failed for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 468
    :goto_6a
    :try_start_6a
    invoke-virtual {v3}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    invoke-virtual {p0, v1}, Landroid/content/pm/PackageManager;->getApplicationIcon(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object p0
    :try_end_72
    .catchall {:try_start_6a .. :try_end_72} :catchall_73

    return-object p0

    .line 469
    :catchall_73
    move-exception p0

    .line 470
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "assistant icon missing for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 471
    return-object v2
.end method

.method private static onViewThread(Landroid/view/View;)Z
    .registers 1

    .line 339
    invoke-virtual {p0}, Landroid/view/View;->getHandler()Landroid/os/Handler;

    move-result-object p0

    .line 340
    if-eqz p0, :cond_12

    invoke-virtual {p0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object p0

    invoke-virtual {p0}, Landroid/os/Looper;->isCurrentThread()Z

    move-result p0

    if-eqz p0, :cond_12

    const/4 p0, 0x1

    goto :goto_13

    :cond_12
    const/4 p0, 0x0

    :goto_13
    return p0
.end method

.method private static packageFor(Landroid/content/Context;I)Ljava/lang/String;
    .registers 3

    .line 476
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 477
    sput-object p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 479
    :try_start_4
    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->selectedPackage(I)Ljava/lang/String;

    move-result-object p0
    :try_end_8
    .catchall {:try_start_4 .. :try_end_8} :catchall_b

    .line 481
    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 479
    return-object p0

    .line 481
    :catchall_b
    move-exception p0

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    .line 482
    throw p0
.end method

.method private static panelId(Ljava/lang/Object;)I
    .registers 3

    .line 567
    const-string v0, "parentTaskId"

    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->intField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 568
    if-lez v0, :cond_9

    .line 569
    return v0

    .line 571
    :cond_9
    const-string v0, "rootTaskId"

    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->intField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0

    .line 572
    const-string v1, "taskId"

    invoke-static {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->intField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p0

    .line 573
    if-lez v0, :cond_1a

    if-eq v0, p0, :cond_1a

    .line 574
    return v0

    .line 576
    :cond_1a
    const/4 p0, -0x1

    return p0
.end method

.method private static postRefresh()V
    .registers 2

    .line 297
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    if-eqz v0, :cond_7

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    goto :goto_9

    :cond_7
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    .line 298
    :goto_9
    if-eqz v0, :cond_14

    .line 299
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$5;

    invoke-direct {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$5;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 305
    return-void

    .line 307
    :cond_14
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sMain:Landroid/os/Handler;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$6;

    invoke-direct {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$6;-><init>()V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 313
    return-void
.end method

.method private static postRefreshDelayed(J)V
    .registers 4

    .line 316
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    if-eqz v0, :cond_7

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    goto :goto_9

    :cond_7
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    .line 317
    :goto_9
    if-eqz v0, :cond_13

    .line 318
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$7;

    invoke-direct {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$7;-><init>()V

    invoke-virtual {v0, v1, p0, p1}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 325
    :cond_13
    return-void
.end method

.method public static prepare(Landroid/content/Context;)V
    .registers 8

    .line 95
    const-string v0, "AssistantDockIcon"

    if-nez p0, :cond_5

    .line 96
    return-void

    .line 99
    :cond_5
    :try_start_5
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->runningTasks()Ljava/util/List;

    move-result-object v1

    .line 100
    if-eqz v1, :cond_a3

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_13

    goto/16 :goto_a3

    .line 103
    :cond_13
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->currentUserId()I

    move-result v2

    invoke-static {p0, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->packageFor(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p0

    .line 104
    nop

    .line 105
    const/4 v2, 0x0

    move v3, v2

    :goto_1e
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_50

    .line 106
    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    .line 107
    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->taskTop(Ljava/lang/Object;)Landroid/content/ComponentName;

    move-result-object v5

    .line 108
    if-eqz v5, :cond_4d

    invoke-virtual {v5}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->isChrome(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_4d

    if-eqz p0, :cond_45

    .line 109
    invoke-virtual {v5}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_45

    .line 110
    goto :goto_4d

    .line 112
    :cond_45
    invoke-static {v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->panelId(Ljava/lang/Object;)I

    move-result v4

    .line 113
    if-lez v4, :cond_4d

    .line 114
    nop

    .line 115
    goto :goto_51

    .line 105
    :cond_4d
    :goto_4d
    add-int/lit8 v3, v3, 0x1

    goto :goto_1e

    :cond_50
    const/4 v4, -0x1

    .line 118
    :goto_51
    if-gez v4, :cond_59

    .line 119
    const-string p0, "assistant prepare: no app card"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    return-void

    .line 122
    :cond_59
    nop

    .line 123
    move p0, v2

    :goto_5b
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_82

    .line 124
    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    .line 125
    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->panelId(Ljava/lang/Object;)I

    move-result v5

    if-eq v5, v4, :cond_6c

    .line 126
    goto :goto_7f

    .line 128
    :cond_6c
    const-string v5, "taskId"

    invoke-static {v3, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->intField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v3

    .line 129
    if-lez v3, :cond_7f

    if-ne v3, v4, :cond_77

    .line 130
    goto :goto_7f

    .line 132
    :cond_77
    # keep-alive patch: never remove the Media Center task; removing it kills the
    # process that holds the media app's browser-service binding and a paused
    # source then destroys its session ("Nothing playing" in the home widget).
    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-static {v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->taskTop(Ljava/lang/Object;)Landroid/content/ComponentName;

    move-result-object v5

    if-eqz v5, :keep_check_done

    invoke-virtual {v5}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.android.car.media"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :keep_check_done

    const-string v6, "assistant prepare keeps com.android.car.media"

    invoke-static {v0, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_7f

    :keep_check_done
    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->removeTask(I)Z

    move-result v3

    if-eqz v3, :cond_7f

    .line 133
    add-int/lit8 p0, p0, 0x1

    .line 123
    :cond_7f
    :goto_7f
    add-int/lit8 v2, v2, 0x1

    goto :goto_5b

    .line 136
    :cond_82
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "assistant prepare cleared "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " from panel "

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_a2
    .catchall {:try_start_5 .. :try_end_a2} :catchall_a4

    .line 139
    goto :goto_aa

    .line 101
    :cond_a3
    :goto_a3
    return-void

    .line 137
    :catchall_a4
    move-exception p0

    .line 138
    const-string v1, "assistant prepare failed"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 140
    :goto_aa
    return-void
.end method

.method private static refresh()V
    .registers 8

    .line 391
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    if-nez v0, :cond_10

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_10

    .line 392
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->findAssistant(Landroid/view/View;)Landroid/widget/ImageView;

    move-result-object v0

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    .line 394
    :cond_10
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    .line 395
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->currentUserId()I

    move-result v1

    .line 396
    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->selectedPackage(I)Ljava/lang/String;

    move-result-object v2

    .line 397
    const-string v3, " pkg="

    const-string v4, "AssistantDockIcon"

    if-nez v0, :cond_3f

    .line 398
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "assistant dock icon pending user="

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 399
    return-void

    .line 401
    :cond_3f
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->onViewThread(Landroid/view/View;)Z

    move-result v5

    if-nez v5, :cond_4e

    .line 402
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$8;

    invoke-direct {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$8;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->post(Ljava/lang/Runnable;)Z

    .line 408
    return-void

    .line 410
    :cond_4e
    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->loadIcon(I)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    .line 411
    if-eqz v5, :cond_9e

    .line 412
    const/4 v6, 0x0

    invoke-virtual {v0, v6}, Landroid/widget/ImageView;->setImageTintList(Landroid/content/res/ColorStateList;)V

    .line 413
    invoke-virtual {v0}, Landroid/widget/ImageView;->clearColorFilter()V

    .line 414
    sget-object v6, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v6}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 417
    invoke-virtual {v0}, Landroid/widget/ImageView;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v6

    iget v6, v6, Landroid/util/DisplayMetrics;->density:F

    const/high16 v7, 0x40800000    # 4.0f

    mul-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    .line 418
    invoke-virtual {v0, v6, v6, v6, v6}, Landroid/widget/ImageView;->setPadding(IIII)V

    .line 419
    invoke-virtual {v5}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 420
    sput v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedUser:I

    .line 421
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedPackage:Ljava/lang/String;

    .line 422
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "assistant dock icon updated user="

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 423
    return-void

    .line 425
    :cond_9e
    invoke-virtual {v0}, Landroid/widget/ImageView;->clearColorFilter()V

    .line 426
    sput v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedUser:I

    .line 427
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sAppliedPackage:Ljava/lang/String;

    .line 428
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "assistant dock icon unchanged user="

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 429
    return-void
.end method

.method private static removeTask(I)Z
    .registers 10

    .line 543
    const/4 v0, 0x0

    :try_start_1
    const-string v1, "android.app.ActivityTaskManager"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 544
    const-string v2, "getService"

    new-array v3, v0, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 545
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getMethods()[Ljava/lang/reflect/Method;

    move-result-object v2

    array-length v3, v2

    move v4, v0

    :goto_20
    if-ge v4, v3, :cond_4e

    aget-object v5, v2, v4

    .line 546
    const-string v6, "removeTask"

    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_31

    .line 547
    goto :goto_4b

    .line 549
    :cond_31
    invoke-virtual {v5}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v6

    .line 550
    array-length v7, v6

    const/4 v8, 0x1

    if-ne v7, v8, :cond_4b

    aget-object v6, v6, v0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v6, v7, :cond_4b

    .line 551
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v5, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4a
    .catchall {:try_start_1 .. :try_end_4a} :catchall_4f

    .line 552
    return v8

    .line 545
    :cond_4b
    :goto_4b
    add-int/lit8 v4, v4, 0x1

    goto :goto_20

    .line 557
    :cond_4e
    goto :goto_6e

    .line 555
    :catchall_4f
    move-exception v1

    .line 556
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "removeTask "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, " failed"

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v2, "AssistantDockIcon"

    invoke-static {v2, p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 558
    :goto_6e
    return v0
.end method

.method private static roleListenerClass()Ljava/lang/Class;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    .line 384
    :try_start_0
    const-string v0, "android.app.role.OnRoleHoldersChangedListener"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_6
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_6} :catch_7

    return-object v0

    .line 385
    :catch_7
    move-exception v0

    .line 386
    const-string v0, "android.app.role.RoleManager$OnRoleHoldersChangedListener"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method

.method private static runningTasks()Ljava/util/List;
    .registers 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 505
    const-string v0, "android.app.ActivityTaskManager"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 506
    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Class;

    const-string v3, "getService"

    invoke-virtual {v0, v3, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v2, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 507
    nop

    .line 508
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getMethods()[Ljava/lang/reflect/Method;

    move-result-object v2

    array-length v4, v2

    move v5, v1

    move-object v6, v3

    :goto_22
    if-ge v5, v4, :cond_4c

    aget-object v7, v2, v5

    .line 509
    const-string v8, "getTasks"

    invoke-virtual {v7}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_33

    .line 510
    goto :goto_49

    .line 512
    :cond_33
    invoke-virtual {v7}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v8

    .line 513
    array-length v9, v8

    const/4 v10, 0x1

    if-lt v9, v10, :cond_49

    aget-object v9, v8, v1

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v9, v10, :cond_49

    .line 514
    nop

    .line 515
    array-length v6, v8

    const/4 v8, 0x4

    if-ne v6, v8, :cond_48

    .line 516
    move-object v6, v7

    goto :goto_4c

    .line 515
    :cond_48
    move-object v6, v7

    .line 508
    :cond_49
    :goto_49
    add-int/lit8 v5, v5, 0x1

    goto :goto_22

    .line 520
    :cond_4c
    :goto_4c
    if-nez v6, :cond_4f

    .line 521
    return-object v3

    .line 523
    :cond_4f
    invoke-virtual {v6}, Ljava/lang/reflect/Method;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v2

    .line 524
    array-length v4, v2

    new-array v4, v4, [Ljava/lang/Object;

    .line 525
    nop

    :goto_57
    array-length v5, v2

    if-ge v1, v5, :cond_7d

    .line 526
    aget-object v5, v2, v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne v5, v7, :cond_6d

    .line 527
    if-nez v1, :cond_65

    const/16 v5, 0x20

    goto :goto_66

    :cond_65
    const/4 v5, -0x1

    :goto_66
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v1

    goto :goto_7a

    .line 528
    :cond_6d
    aget-object v5, v2, v1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    if-ne v5, v7, :cond_78

    .line 529
    sget-object v5, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    aput-object v5, v4, v1

    goto :goto_7a

    .line 531
    :cond_78
    aput-object v3, v4, v1

    .line 525
    :goto_7a
    add-int/lit8 v1, v1, 0x1

    goto :goto_57

    .line 534
    :cond_7d
    invoke-virtual {v6, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 535
    instance-of v1, v0, Ljava/util/List;

    if-eqz v1, :cond_88

    .line 536
    check-cast v0, Ljava/util/List;

    return-object v0

    .line 538
    :cond_88
    return-object v3
.end method

.method private static same(Ljava/lang/String;Ljava/lang/String;)Z
    .registers 2

    .line 432
    if-nez p0, :cond_8

    if-nez p1, :cond_6

    const/4 p0, 0x1

    goto :goto_c

    :cond_6
    const/4 p0, 0x0

    goto :goto_c

    :cond_8
    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    :goto_c
    return p0
.end method

.method private static schedulePoll()V
    .registers 4

    .line 328
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    if-eqz v0, :cond_7

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    goto :goto_9

    :cond_7
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoot:Landroid/view/View;

    .line 329
    :goto_9
    const-wide/16 v1, 0x5dc

    if-eqz v0, :cond_18

    .line 330
    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v3}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 331
    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v3, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 332
    return-void

    .line 334
    :cond_18
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sMain:Landroid/os/Handler;

    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 335
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sMain:Landroid/os/Handler;

    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sPoll:Ljava/lang/Runnable;

    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 336
    return-void
.end method

.method private static secureString(Ljava/lang/String;I)Ljava/lang/String;
    .registers 7

    .line 626
    :try_start_0
    const-class v0, Landroid/provider/Settings$Secure;

    const-string v1, "getStringForUser"

    const-class v2, Landroid/content/ContentResolver;

    const-class v3, Ljava/lang/String;

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3, v4}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 629
    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 630
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    filled-new-array {v1, p0, p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 629
    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 631
    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_2c

    move-object v1, p1

    check-cast v1, Ljava/lang/String;
    :try_end_2c
    .catchall {:try_start_0 .. :try_end_2c} :catchall_2d

    :cond_2c
    return-object v1

    .line 632
    :catchall_2d
    move-exception p1

    .line 633
    sget-object p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    invoke-static {p1, p0}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static selectedPackage(I)Ljava/lang/String;
    .registers 7

    .line 599
    const-string/jumbo v0, "voice_interaction_service"

    invoke-static {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->secureString(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->unflatten(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object v0

    .line 600
    if-nez v0, :cond_17

    .line 601
    const-string v0, "assistant"

    invoke-static {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->secureString(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->unflatten(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object v0

    .line 603
    :cond_17
    if-eqz v0, :cond_1e

    .line 604
    invoke-virtual {v0}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 607
    :cond_1e
    const/4 v0, 0x0

    :try_start_1f
    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    const-string v2, "role"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 608
    if-nez v1, :cond_2a

    .line 609
    return-object v0

    .line 611
    :cond_2a
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getRoleHoldersAsUser"

    const-class v4, Ljava/lang/String;

    const-class v5, Landroid/os/UserHandle;

    filled-new-array {v4, v5}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 613
    const-string v3, "android.app.role.ASSISTANT"

    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandle(I)Landroid/os/UserHandle;

    move-result-object p0

    filled-new-array {v3, p0}, [Ljava/lang/Object;

    move-result-object p0

    invoke-virtual {v2, v1, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 614
    instance-of v1, p0, Ljava/util/List;

    if-eqz v1, :cond_66

    move-object v1, p0

    check-cast v1, Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_66

    .line 615
    check-cast p0, Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    .line 616
    instance-of v1, p0, Ljava/lang/String;

    if-eqz v1, :cond_65

    check-cast p0, Ljava/lang/String;
    :try_end_64
    .catchall {:try_start_1f .. :try_end_64} :catchall_67

    move-object v0, p0

    :cond_65
    return-object v0

    .line 620
    :cond_66
    goto :goto_6f

    .line 618
    :catchall_67
    move-exception p0

    .line 619
    const-string v1, "AssistantDockIcon"

    const-string v2, "assistant role lookup failed"

    invoke-static {v1, v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 621
    :goto_6f
    return-object v0
.end method

.method private static taskTop(Ljava/lang/Object;)Landroid/content/ComponentName;
    .registers 2

    .line 562
    const-string v0, "topActivity"

    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 563
    instance-of v0, p0, Landroid/content/ComponentName;

    if-eqz v0, :cond_d

    check-cast p0, Landroid/content/ComponentName;

    goto :goto_e

    :cond_d
    const/4 p0, 0x0

    :goto_e
    return-object p0
.end method

.method private static unbind()V
    .registers 6

    .line 344
    sget-boolean v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sWatching:Z

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_65

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    if-nez v0, :cond_b

    goto :goto_65

    .line 349
    :cond_b
    sput-boolean v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sWatching:Z

    .line 350
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    if-eqz v0, :cond_20

    .line 352
    :try_start_11
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V
    :try_end_1c
    .catchall {:try_start_11 .. :try_end_1c} :catchall_1d

    .line 354
    goto :goto_1e

    .line 353
    :catchall_1d
    move-exception v0

    .line 355
    :goto_1e
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    .line 357
    :cond_20
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoleListener:Ljava/lang/Object;

    if-eqz v0, :cond_53

    .line 359
    :try_start_24
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    const-string v1, "role"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 360
    if-eqz v0, :cond_4f

    .line 361
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v3, "removeOnRoleHoldersChangedListenerAsUser"

    .line 363
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->roleListenerClass()Ljava/lang/Class;

    move-result-object v4

    const-class v5, Landroid/os/UserHandle;

    filled-new-array {v4, v5}, [Ljava/lang/Class;

    move-result-object v4

    .line 361
    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 365
    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoleListener:Ljava/lang/Object;

    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandleAll()Landroid/os/UserHandle;

    move-result-object v4

    filled-new-array {v3, v4}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4f
    .catchall {:try_start_24 .. :try_end_4f} :catchall_50

    .line 368
    :cond_4f
    goto :goto_51

    .line 367
    :catchall_50
    move-exception v0

    .line 369
    :goto_51
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoleListener:Ljava/lang/Object;

    .line 371
    :cond_53
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_62

    .line 373
    :try_start_57
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    sget-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_5e
    .catchall {:try_start_57 .. :try_end_5e} :catchall_5f

    .line 375
    goto :goto_60

    .line 374
    :catchall_5f
    move-exception v0

    .line 376
    :goto_60
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    .line 378
    :cond_62
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    .line 379
    return-void

    .line 345
    :cond_65
    :goto_65
    sput-boolean v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sWatching:Z

    .line 346
    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sButton:Landroid/widget/ImageView;

    .line 347
    return-void
.end method

.method private static unflatten(Ljava/lang/String;)Landroid/content/ComponentName;
    .registers 2

    .line 638
    if-eqz p0, :cond_e

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_9

    goto :goto_e

    .line 641
    :cond_9
    invoke-static {p0}, Landroid/content/ComponentName;->unflattenFromString(Ljava/lang/String;)Landroid/content/ComponentName;

    move-result-object p0

    return-object p0

    .line 639
    :cond_e
    :goto_e
    const/4 p0, 0x0

    return-object p0
.end method

.method private static userHandle(I)Landroid/os/UserHandle;
    .registers 4

    .line 658
    :try_start_0
    const-class v0, Landroid/os/UserHandle;

    const-string v1, "of"

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 659
    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 660
    instance-of v0, p0, Landroid/os/UserHandle;

    if-eqz v0, :cond_22

    .line 661
    check-cast p0, Landroid/os/UserHandle;
    :try_end_21
    .catchall {:try_start_0 .. :try_end_21} :catchall_23

    return-object p0

    .line 664
    :cond_22
    goto :goto_24

    .line 663
    :catchall_23
    move-exception p0

    .line 665
    :goto_24
    invoke-static {}, Landroid/os/Process;->myUserHandle()Landroid/os/UserHandle;

    move-result-object p0

    return-object p0
.end method

.method private static userHandleAll()Landroid/os/UserHandle;
    .registers 2

    .line 670
    :try_start_0
    const-class v0, Landroid/os/UserHandle;

    const-string v1, "ALL"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 671
    instance-of v1, v0, Landroid/os/UserHandle;

    if-eqz v1, :cond_14

    .line 672
    check-cast v0, Landroid/os/UserHandle;
    :try_end_13
    .catchall {:try_start_0 .. :try_end_13} :catchall_15

    return-object v0

    .line 675
    :cond_14
    goto :goto_16

    .line 674
    :catchall_15
    move-exception v0

    .line 676
    :goto_16
    const/4 v0, -0x1

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandle(I)Landroid/os/UserHandle;

    move-result-object v0

    return-object v0
.end method

.method private static watch()V
    .registers 15

    .line 199
    const-string v1, "AssistantDockIcon"

    sget-boolean v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sWatching:Z

    if-nez v0, :cond_12f

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    if-nez v0, :cond_c

    goto/16 :goto_12f

    .line 202
    :cond_c
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sWatching:Z

    .line 203
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 204
    new-instance v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$3;

    invoke-direct {v2, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$3;-><init>(Landroid/os/Handler;)V

    sput-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    .line 211
    :try_start_1f
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v2, "registerContentObserver"

    const-class v3, Landroid/net/Uri;

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-class v5, Landroid/database/ContentObserver;

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v3, v4, v5, v6}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 214
    sget-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string/jumbo v3, "voice_interaction_service"

    .line 215
    invoke-static {v3}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    sget-object v4, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    sget-object v5, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    .line 216
    const/4 v6, -0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    filled-new-array {v3, v4, v5, v7}, [Ljava/lang/Object;

    move-result-object v3

    .line 214
    invoke-virtual {v0, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 217
    sget-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "assistant"

    .line 218
    invoke-static {v3}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    sget-object v4, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    sget-object v5, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sObserver:Landroid/database/ContentObserver;

    .line 219
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array {v3, v4, v5, v6}, [Ljava/lang/Object;

    move-result-object v3

    .line 217
    invoke-virtual {v0, v2, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_73
    .catchall {:try_start_1f .. :try_end_73} :catchall_74

    .line 222
    goto :goto_7a

    .line 220
    :catchall_74
    move-exception v0

    .line 221
    const-string v2, "assistant settings watch failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 224
    :goto_7a
    :try_start_7a
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    const-string v2, "role"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 225
    if-eqz v0, :cond_c1

    .line 226
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->roleListenerClass()Ljava/lang/Class;

    move-result-object v2

    .line 227
    nop

    .line 228
    invoke-virtual {v2}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v4

    new-instance v5, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$$ExternalSyntheticLambda0;

    invoke-direct {v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$$ExternalSyntheticLambda0;-><init>()V

    .line 227
    invoke-static {v3, v4, v5}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v3

    sput-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoleListener:Ljava/lang/Object;

    .line 248
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v4, "addOnRoleHoldersChangedListenerAsUser"

    const-class v5, Ljava/util/concurrent/Executor;

    const-class v6, Landroid/os/UserHandle;

    filled-new-array {v5, v2, v6}, [Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v3, v4, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 253
    sget-object v3, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getMainExecutor()Ljava/util/concurrent/Executor;

    move-result-object v3

    sget-object v4, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sRoleListener:Ljava/lang/Object;

    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandleAll()Landroid/os/UserHandle;

    move-result-object v5

    filled-new-array {v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_c1
    .catchall {:try_start_7a .. :try_end_c1} :catchall_c2

    .line 257
    :cond_c1
    goto :goto_c8

    .line 255
    :catchall_c2
    move-exception v0

    .line 256
    const-string v2, "assistant role watch failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 258
    :goto_c8
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$4;

    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon$4;-><init>()V

    sput-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    .line 266
    new-instance v4, Landroid/content/IntentFilter;

    invoke-direct {v4}, Landroid/content/IntentFilter;-><init>()V

    .line 267
    const-string v0, "android.intent.action.USER_SWITCHED"

    invoke-virtual {v4, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 268
    const-string v0, "android.intent.action.USER_UNLOCKED"

    invoke-virtual {v4, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 270
    const/4 v8, 0x2

    :try_start_df
    const-class v0, Landroid/content/Context;

    const-string v2, "registerReceiverAsUser"

    const-class v9, Landroid/content/BroadcastReceiver;

    const-class v10, Landroid/os/UserHandle;

    const-class v11, Landroid/content/IntentFilter;

    const-class v12, Ljava/lang/String;

    const-class v13, Landroid/os/Handler;

    sget-object v14, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array/range {v9 .. v14}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 278
    sget-object v9, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    sget-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->userHandleAll()Landroid/os/UserHandle;

    move-result-object v3

    sget-object v6, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sMain:Landroid/os/Handler;

    .line 279
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const/4 v5, 0x0

    filled-new-array/range {v2 .. v7}, [Ljava/lang/Object;

    move-result-object v2

    .line 278
    invoke-virtual {v0, v9, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_10d
    .catchall {:try_start_df .. :try_end_10d} :catchall_10e

    .line 291
    goto :goto_12b

    .line 280
    :catchall_10e
    move-exception v0

    .line 281
    const-string v2, "assistant user watch as user failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 283
    :try_start_114
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    sget-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v2, v4, v8}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;
    :try_end_11b
    .catchall {:try_start_114 .. :try_end_11b} :catchall_11c

    .line 290
    goto :goto_12b

    .line 284
    :catchall_11c
    move-exception v0

    .line 286
    :try_start_11d
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sContext:Landroid/content/Context;

    sget-object v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->sUserReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v2, v4}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_124
    .catchall {:try_start_11d .. :try_end_124} :catchall_125

    .line 289
    goto :goto_12b

    .line 287
    :catchall_125
    move-exception v0

    .line 288
    const-string v2, "assistant user watch failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 292
    :goto_12b
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/AssistantDockIcon;->schedulePoll()V

    .line 293
    return-void

    .line 200
    :cond_12f
    :goto_12f
    return-void
.end method
