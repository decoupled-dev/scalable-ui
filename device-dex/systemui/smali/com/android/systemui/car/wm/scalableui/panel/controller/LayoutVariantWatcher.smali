.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;
.super Landroid/database/ContentObserver;
.source "LayoutVariantWatcher.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field public static final SETTING:Ljava/lang/String; = "scalable_ui_layout_variant"

.field private static final TAG:Ljava/lang/String; = "LayoutVariant"

.field public static final VARIANT_COUNT:I = 0x4

.field private static final VARIANT_DOCK_LEFT:I = 0x1

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


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mDockTries:I

.field private final mHandler:Landroid/os/Handler;

.field private mReady:Z


# direct methods
.method private constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .registers 3

    .line 70
    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    .line 71
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    .line 72
    iput-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    .line 73
    return-void
.end method

.method private applyDockOrientation()V
    .registers 5

    .line 151
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_d

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    goto :goto_e

    :cond_d
    const/4 v0, 0x0

    .line 152
    :goto_e
    if-nez v0, :cond_24

    .line 153
    invoke-static {}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDock()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 154
    if-eqz v0, :cond_24

    .line 155
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 156
    const-string v1, "LayoutVariant"

    const-string v2, "found dock"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 159
    :cond_24
    if-nez v0, :cond_3a

    .line 160
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    const/16 v1, 0x8

    if-ge v0, v1, :cond_39

    .line 161
    iget v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mDockTries:I

    .line 162
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;

    const-wide/16 v1, 0x3e8

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 164
    :cond_39
    return-void

    .line 168
    :cond_3a
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    .line 169
    if-eqz v1, :cond_4e

    invoke-virtual {v1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v3

    if-eq v2, v3, :cond_4e

    .line 170
    invoke-virtual {v1, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 171
    return-void

    .line 173
    :cond_4e
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 174
    return-void
.end method

.method private static applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V
    .registers 4

    .line 262
    if-eqz p0, :cond_28

    if-nez p1, :cond_5

    goto :goto_28

    .line 265
    :cond_5
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    .line 266
    invoke-static {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p0

    .line 268
    const/4 v1, 0x1

    if-eqz v0, :cond_15

    if-eq v0, v1, :cond_15

    if-nez p0, :cond_15

    .line 269
    return-void

    .line 271
    :cond_15
    if-ne v0, v1, :cond_1a

    if-nez p0, :cond_1a

    goto :goto_1b

    :cond_1a
    const/4 v1, 0x0

    .line 273
    :goto_1b
    :try_start_1b
    invoke-static {p1, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientationOnViewThread(Landroid/widget/LinearLayout;Z)V
    :try_end_1e
    .catchall {:try_start_1b .. :try_end_1e} :catchall_1f

    .line 276
    goto :goto_27

    .line 274
    :catchall_1f
    move-exception p0

    .line 275
    const-string p1, "LayoutVariant"

    const-string v0, "dock orientation failed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 277
    :goto_27
    return-void

    .line 263
    :cond_28
    :goto_28
    return-void
.end method

.method private static applyDockOrientationOnViewThread(Landroid/widget/LinearLayout;Z)V
    .registers 11

    .line 280
    invoke-virtual {p0, p1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 281
    const/4 v0, 0x0

    move v1, v0

    :goto_5
    invoke-virtual {p0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_62

    .line 282
    invoke-virtual {p0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 283
    instance-of v3, v2, Landroid/widget/ImageButton;

    if-eqz v3, :cond_14

    .line 284
    goto :goto_5f

    .line 286
    :cond_14
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    instance-of v3, v3, Landroid/widget/LinearLayout$LayoutParams;

    if-nez v3, :cond_1d

    .line 287
    goto :goto_5f

    .line 289
    :cond_1d
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/widget/LinearLayout$LayoutParams;

    .line 290
    invoke-static {v2, v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dividerSpec(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I

    move-result-object v4

    .line 291
    if-nez v4, :cond_2a

    .line 292
    goto :goto_5f

    .line 294
    :cond_2a
    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    if-eqz p1, :cond_46

    .line 295
    aget v7, v4, v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 296
    aget v7, v4, v0

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 297
    aget v6, v4, v6

    iput v6, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 298
    aget v4, v4, v5

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 299
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 300
    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    goto :goto_5c

    .line 302
    :cond_46
    aget v8, v4, v0

    iput v8, v3, Landroid/widget/LinearLayout$LayoutParams;->width:I

    .line 303
    aget v7, v4, v7

    iput v7, v3, Landroid/widget/LinearLayout$LayoutParams;->height:I

    .line 304
    iput v0, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 305
    iput v0, v3, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 306
    aget v6, v4, v6

    invoke-virtual {v3, v6}, Landroid/widget/LinearLayout$LayoutParams;->setMarginStart(I)V

    .line 307
    aget v4, v4, v5

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout$LayoutParams;->setMarginEnd(I)V

    .line 309
    :goto_5c
    invoke-virtual {v2, v3}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 281
    :goto_5f
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 311
    :cond_62
    return-void
.end method

.method public static attachDock(Landroid/view/View;)V
    .registers 3

    .line 127
    instance-of v0, p0, Landroid/widget/LinearLayout;

    if-nez v0, :cond_5

    .line 128
    return-void

    .line 130
    :cond_5
    move-object v0, p0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 131
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, v0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    .line 132
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 133
    return-void
.end method

.method private dispatch(Ljava/lang/String;)V
    .registers 9

    .line 356
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 357
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

    .line 358
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getScalableUIEventDispatcher"

    new-array v4, v3, [Ljava/lang/Class;

    .line 359
    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 360
    new-instance v1, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v1, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v1

    .line 361
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v4, "executeEvent"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const-class v6, Lcom/android/car/scalableui/model/Event;

    aput-object v6, v5, v3

    .line 362
    invoke-virtual {v2, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    .line 363
    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4c
    .catchall {:try_start_0 .. :try_end_4c} :catchall_4d

    .line 382
    goto :goto_b7

    .line 364
    :catchall_4d
    move-exception v0

    .line 365
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

    .line 367
    :try_start_6c
    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v0, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    .line 370
    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    .line 368
    invoke-static {v0}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    move-result-object v0

    .line 371
    if-eqz v0, :cond_9f

    .line 373
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

    .line 374
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_9e

    .line 375
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/animation/Animator;

    invoke-virtual {v1}, Landroid/animation/Animator;->start()V
    :try_end_9e
    .catchall {:try_start_6c .. :try_end_9e} :catchall_a0

    .line 377
    :cond_9e
    goto :goto_83

    .line 381
    :cond_9f
    goto :goto_b7

    .line 379
    :catchall_a0
    move-exception v0

    .line 380
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

    .line 383
    :goto_b7
    return-void
.end method

.method private static dividerSpec(Landroid/view/View;Landroid/widget/LinearLayout$LayoutParams;)[I
    .registers 5

    .line 315
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    .line 316
    instance-of v1, v0, [I

    if-eqz v1, :cond_11

    .line 317
    check-cast v0, [I

    check-cast v0, [I

    .line 318
    array-length v1, v0

    const/4 v2, 0x4

    if-ne v1, v2, :cond_11

    .line 319
    return-object v0

    .line 322
    :cond_11
    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    if-lez v0, :cond_2e

    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->height:I

    if-gtz v0, :cond_1a

    goto :goto_2e

    .line 325
    :cond_1a
    iget v0, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    iget v1, p1, Landroid/widget/LinearLayout$LayoutParams;->height:I

    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginStart()I

    move-result v2

    invoke-virtual {p1}, Landroid/widget/LinearLayout$LayoutParams;->getMarginEnd()I

    move-result p1

    filled-new-array {v0, v1, v2, p1}, [I

    move-result-object p1

    .line 326
    invoke-virtual {p0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    .line 327
    return-object p1

    .line 323
    :cond_2e
    :goto_2e
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findDock()Landroid/widget/LinearLayout;
    .registers 8

    .line 179
    const-string v0, "LayoutVariant"

    const/4 v1, 0x0

    :try_start_3
    const-string v2, "android.view.WindowManagerGlobal"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 180
    const-string v3, "getInstance"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    new-array v5, v4, [Ljava/lang/Object;

    invoke-virtual {v3, v1, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 181
    const-string v5, "mViews"

    invoke-static {v3, v2, v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockInList(Ljava/lang/Object;Ljava/lang/Class;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v5

    .line 182
    if-eqz v5, :cond_21

    .line 183
    return-object v5

    .line 185
    :cond_21
    const-string v5, "mWindowlessRoots"

    invoke-virtual {v2, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 186
    const/4 v5, 0x1

    invoke-virtual {v2, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 187
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 188
    instance-of v3, v2, Ljava/util/List;

    if-nez v3, :cond_34

    .line 189
    return-object v1

    .line 191
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

    .line 192
    if-nez v3, :cond_47

    .line 193
    goto :goto_3a

    .line 195
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

    .line 196
    instance-of v5, v3, Landroid/view/View;

    if-eqz v5, :cond_66

    .line 197
    check-cast v3, Landroid/view/View;

    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object v3

    .line 198
    if-eqz v3, :cond_66

    .line 199
    return-object v3

    .line 202
    :cond_66
    goto :goto_3a

    .line 203
    :cond_67
    const-string v2, "dock not found"

    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6c
    .catchall {:try_start_3 .. :try_end_6c} :catchall_6d

    .line 206
    goto :goto_73

    .line 204
    :catchall_6d
    move-exception v2

    .line 205
    const-string v3, "dock search failed"

    invoke-static {v0, v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 207
    :goto_73
    return-object v1
.end method

.method private static findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;
    .registers 8

    .line 230
    instance-of v0, p0, Landroid/widget/LinearLayout;

    const/4 v1, 0x0

    if-eqz v0, :cond_36

    .line 231
    move-object v0, p0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 232
    nop

    .line 233
    nop

    .line 234
    move v2, v1

    move v3, v2

    move v4, v3

    :goto_d
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v5

    if-ge v2, v5, :cond_30

    .line 235
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    .line 236
    instance-of v6, v5, Landroid/widget/ImageButton;

    if-nez v6, :cond_1c

    .line 237
    goto :goto_2d

    .line 239
    :cond_1c
    add-int/lit8 v4, v4, 0x1

    .line 240
    invoke-virtual {v5}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v5

    .line 241
    if-eqz v5, :cond_2d

    const-string v6, "Home"

    invoke-virtual {v6, v5}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_2d

    .line 242
    const/4 v3, 0x1

    .line 234
    :cond_2d
    :goto_2d
    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    .line 245
    :cond_30
    if-eqz v3, :cond_36

    const/4 v2, 0x5

    if-lt v4, v2, :cond_36

    .line 246
    return-object v0

    .line 249
    :cond_36
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_51

    .line 250
    check-cast p0, Landroid/view/ViewGroup;

    .line 251
    nop

    :goto_3d
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v1, v0, :cond_51

    .line 252
    invoke-virtual {p0, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object v0

    .line 253
    if-eqz v0, :cond_4e

    .line 254
    return-object v0

    .line 251
    :cond_4e
    add-int/lit8 v1, v1, 0x1

    goto :goto_3d

    .line 258
    :cond_51
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

    .line 212
    invoke-virtual {p1, p2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    .line 213
    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 214
    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 215
    instance-of p1, p0, Ljava/util/List;

    const/4 p2, 0x0

    if-nez p1, :cond_12

    .line 216
    return-object p2

    .line 218
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

    .line 219
    instance-of v0, p1, Landroid/view/View;

    if-eqz v0, :cond_2f

    .line 220
    check-cast p1, Landroid/view/View;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->findDockIn(Landroid/view/View;)Landroid/widget/LinearLayout;

    move-result-object p1

    .line 221
    if-eqz p1, :cond_2f

    .line 222
    return-object p1

    .line 225
    :cond_2f
    goto :goto_18

    .line 226
    :cond_30
    return-object p2
.end method

.method static getVariant(Landroid/content/Context;)I
    .registers 3

    .line 331
    const/4 v0, 0x0

    if-nez p0, :cond_4

    .line 332
    return v0

    .line 334
    :cond_4
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "scalable_ui_layout_variant"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0

    .line 335
    if-ltz p0, :cond_15

    const/4 v1, 0x4

    if-lt p0, v1, :cond_14

    goto :goto_15

    .line 338
    :cond_14
    return p0

    .line 336
    :cond_15
    :goto_15
    return v0
.end method

.method private static isPortrait(Landroid/content/Context;)Z
    .registers 4

    .line 342
    const-class v0, Landroid/hardware/display/DisplayManager;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/hardware/display/DisplayManager;

    .line 343
    const/4 v0, 0x1

    if-nez p0, :cond_c

    .line 344
    return v0

    .line 346
    :cond_c
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object p0

    .line 347
    if-nez p0, :cond_14

    .line 348
    return v0

    .line 350
    :cond_14
    invoke-virtual {p0}, Landroid/view/Display;->getRotation()I

    move-result p0

    .line 351
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

.method public static onOrientationApplied(Z)V
    .registers 3

    .line 114
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    .line 115
    if-nez v0, :cond_5

    .line 116
    return-void

    .line 118
    :cond_5
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReady:Z

    .line 119
    if-nez p0, :cond_d

    .line 120
    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->postCurrent()V

    .line 122
    :cond_d
    invoke-direct {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 123
    return-void
.end method

.method private postCurrent()V
    .registers 4

    .line 144
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    .line 145
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "layout_variant_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 146
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "event="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "LayoutVariant"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 147
    invoke-direct {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V

    .line 148
    return-void
.end method

.method public static start(Landroid/content/Context;)V
    .registers 6

    .line 77
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    if-nez v0, :cond_4f

    if-nez p0, :cond_7

    goto :goto_4f

    .line 80
    :cond_7
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 81
    if-nez v0, :cond_e

    .line 82
    goto :goto_f

    .line 81
    :cond_e
    move-object p0, v0

    .line 84
    :goto_f
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 85
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-direct {v1, p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    .line 86
    sput-object v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sInstance:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    .line 87
    const-string v2, "scalable_ui_layout_variant"

    invoke-static {v2}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 88
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v2, v4, v1}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 89
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

    .line 90
    const-wide/16 v2, 0x7d0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 91
    return-void

    .line 78
    :cond_4f
    :goto_4f
    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .registers 2

    .line 137
    iget-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mReady:Z

    if-eqz p1, :cond_f

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_f

    .line 138
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->postCurrent()V

    .line 140
    :cond_f
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 141
    return-void
.end method

.method public run()V
    .registers 4

    .line 99
    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_d

    sget-object v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->sDock:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    goto :goto_e

    :cond_d
    const/4 v0, 0x0

    .line 100
    :goto_e
    if-eqz v0, :cond_2a

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    if-eqz v1, :cond_2a

    .line 101
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v2

    if-ne v1, v2, :cond_2a

    .line 102
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation(Landroid/content/Context;Landroid/widget/LinearLayout;)V

    .line 103
    return-void

    .line 105
    :cond_2a
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->applyDockOrientation()V

    .line 106
    return-void
.end method
